<?php
/**
 * dashboard/index.php — Analytics Dashboard
 * ------------------------------------------
 * Analytics mapped to the modified schema.
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle = 'Analytics Dashboard';
$activeNav = 'home';

$timeFilter = $_GET['time_filter'] ?? 'all';
$startDate = $_GET['start_date'] ?? '';
$endDate = $_GET['end_date'] ?? '';

$params = [];
$visitCond = "";

if ($timeFilter === 'today') {
    $visitCond = " AND visit_date = CURDATE()";
} elseif ($timeFilter === '7days') {
    $visitCond = " AND visit_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
} elseif ($timeFilter === '30days') {
    $visitCond = " AND visit_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)";
} elseif ($timeFilter === '6months') {
    $visitCond = " AND visit_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)";
} elseif ($timeFilter === 'custom' && $startDate && $endDate) {
    $visitCond = " AND visit_date >= :start_date AND visit_date <= :end_date";
    $params[':start_date'] = $startDate;
    $params[':end_date'] = $endDate;
}

$cVisitCond = str_replace('visit_date', 'c.visit_date', $visitCond);
$patientWhere = $visitCond ? "WHERE EXISTS (SELECT 1 FROM consultation c WHERE c.patient_id = patient.patient_id {$cVisitCond})" : "";
$hhWhere = $visitCond ? "WHERE EXISTS (SELECT 1 FROM consultation c WHERE c.patient_id = p.patient_id {$cVisitCond})" : "";

// Helper to execute prepared queries with shared params
function execQuery($pdo, $sql, $params) {
    $stmt = $pdo->prepare($sql);
    $stmt->execute($params);
    return $stmt;
}

// ── 1. Top diagnoses ──────────────────────────────────────
$topDxSql = "SELECT diagnosis, COUNT(*) AS cnt
             FROM consultation
             WHERE diagnosis IS NOT NULL AND diagnosis <> '' {$visitCond}
             GROUP BY diagnosis
             ORDER BY cnt DESC
             LIMIT 10";
$topDx = execQuery($pdo, $topDxSql, $params)->fetchAll();

// ── 2. Time-Trend Tracking (Gap-filling logic) ────────────
$chartLineTitle = "Monthly Visits (Last 12 Months)";
$trendData = []; // Will hold final {ym, label, cnt} objects

// Define range based on filter
$now = new DateTime();
$start = null;
$end = clone $now;
$interval = null;
$formatLabel = "";
$formatYM = "";
$periodCount = 0;

if ($timeFilter === 'today') {
    // Fetch dynamic settings
    $settings = $pdo->query("SELECT setting_key, setting_value FROM settings")->fetchAll(PDO::FETCH_KEY_PAIR);
    $clinicOpen = $settings['clinic_open'] ?? '08:30';
    $clinicClose = $settings['clinic_close'] ?? '12:00';

    $openDT = new DateTime($clinicOpen);
    $closeDT = new DateTime($clinicClose);
    $startDT = (clone $openDT)->modify('-30 minutes');
    $endDT = (clone $closeDT)->modify('+30 minutes');

    $startHour = (int)$startDT->format('G');
    $endHour = (int)$endDT->format('G');
    // If closing buffer ends on a partial hour (e.g. 12:30), round up to show the full hour block
    if ((int)$endDT->format('i') > 0) $endHour++;

    $start = (clone $now)->setTime($startHour, 0);
    $end = (clone $now)->setTime($endHour, 0);
    
    $interval = new DateInterval('PT1H');
    $formatLabel = "h:00 A";
    $formatYM = "G"; // 0-23
    $periodCount = ($endHour - $startHour) + 1;
    $chartLineTitle = "Hourly Visits (Today)";
} elseif ($timeFilter === '7days') {
    $start = (clone $now)->modify('-6 days');
    $interval = new DateInterval('P1D');
    $formatLabel = "M d";
    $formatYM = "Y-m-d";
    $periodCount = 7;
    $chartLineTitle = "Daily Visits (Last 7 Days)";
} elseif ($timeFilter === '30days') {
    $start = (clone $now)->modify('-29 days');
    $interval = new DateInterval('P1D');
    $formatLabel = "M d";
    $formatYM = "Y-m-d";
    $periodCount = 30;
    $chartLineTitle = "Daily Visits (Last 30 Days)";
} elseif ($timeFilter === '6months') {
    $start = (clone $now)->modify('-5 months')->modify('first day of this month');
    $interval = new DateInterval('P1M');
    $formatLabel = "M Y";
    $formatYM = "Y-m";
    $periodCount = 6;
    $chartLineTitle = "Monthly Visits (Last 6 Months)";
} elseif ($timeFilter === 'custom' && $startDate && $endDate) {
    $start = new DateTime($startDate);
    $end = new DateTime($endDate);
    $interval = new DateInterval('P1D');
    $formatLabel = "M d, Y";
    $formatYM = "Y-m-d";
    $periodCount = $start->diff($end)->days + 1;
    $chartLineTitle = "Daily Visits (Custom Range)";
} else {
    $start = (clone $now)->modify('-11 months')->modify('first day of this month');
    $interval = new DateInterval('P1M');
    $formatLabel = "M Y";
    $formatYM = "Y-m";
    $periodCount = 12;
    if ($timeFilter === 'all') $chartLineTitle = "Service Volume (All Time)";
}

// 1. Generate all labels for the period
$labels = [];
$timeline = new DatePeriod($start, $interval, $periodCount - 1);
foreach ($timeline as $dt) {
    $labels[$dt->format($formatYM)] = [
        'ym' => $dt->format($formatYM),
        'label' => $dt->format($formatLabel),
        'cnt' => 0
    ];
}
// Add the end point explicitly to handle edge cases/DST
$labels[$end->format($formatYM)] = [
    'ym' => $end->format($formatYM),
    'label' => $end->format($formatLabel),
    'cnt' => 0
];

// 2. Fetch actual counts
if ($timeFilter === 'today') {
    $sql = "SELECT HOUR(IFNULL(created_at, CONCAT(visit_date, ' 08:00:00'))) AS key_val, COUNT(*) AS cnt 
            FROM consultation WHERE visit_date = CURDATE() GROUP BY key_val";
    $dbData = $pdo->query($sql)->fetchAll(PDO::FETCH_KEY_PAIR);
} elseif (in_array($timeFilter, ['7days', '30days', 'custom'])) {
    $c = $visitCond ?: " AND visit_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)";
    $sql = "SELECT DATE(visit_date) AS key_val, COUNT(*) AS cnt FROM consultation WHERE 1=1 {$c} GROUP BY key_val";
    $dbData = execQuery($pdo, $sql, $params)->fetchAll(PDO::FETCH_KEY_PAIR);
} else {
    $c = $visitCond ?: " AND visit_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)";
    $sql = "SELECT DATE_FORMAT(visit_date, '%Y-%m') AS key_val, COUNT(*) AS cnt FROM consultation WHERE 1=1 {$c} GROUP BY key_val";
    $dbData = execQuery($pdo, $sql, $params)->fetchAll(PDO::FETCH_KEY_PAIR);
}

// 3. Merge DB data into labels
foreach ($dbData as $k => $v) {
    if (isset($labels[$k])) $labels[$k]['cnt'] = (int)$v;
}
$visitsByMonth = array_values($labels);

// ── 3. Sex breakdown ─────────────────────────────────────
$sexSql = "SELECT sex, COUNT(*) AS cnt FROM patient {$patientWhere} GROUP BY sex";
$sexBreakdown = execQuery($pdo, $sexSql, $params)->fetchAll();

// ── 4. Age groups (Patient Categories) ─────────────────────
$ageSql = "SELECT age_group, COUNT(*) AS cnt
           FROM patient {$patientWhere}
           GROUP BY age_group
           ORDER BY FIELD(age_group, 'Pediatric', 'Adult', 'Geriatric')";
$ageGroups = execQuery($pdo, $ageSql, $params)->fetchAll();

// ── 5. Demographics (Replaces Category) ────────────────────
$demogSql = "SELECT
               SUM(is_ip='Yes' AND nhts_status='NON-NHTS')  AS ip_only,
               SUM(nhts_status='NHTS' AND is_ip='No')  AS nhts_only,
               SUM(is_ip='Yes' AND nhts_status='NHTS')  AS ip_and_nhts,
               SUM(is_ip='No' AND nhts_status='NON-NHTS')  AS regular
             FROM patient p {$hhWhere}";
$demog = execQuery($pdo, $demogSql, $params)->fetch();

// ── Summary stats ─────────────────────────────────────────
$totPat  = execQuery($pdo, "SELECT COUNT(*) FROM patient {$patientWhere}", $params)->fetchColumn();
$totHH   = execQuery($pdo, "SELECT COUNT(DISTINCT household_no) FROM patient p {$hhWhere}", $params)->fetchColumn();
$totCons = execQuery($pdo, "SELECT COUNT(*) FROM consultation WHERE 1=1 {$visitCond}", $params)->fetchColumn();

// ── PHP → JS helpers ──────────────────────────────────────
function jsArray(array $data, string $key): string {
    return json_encode(array_column($data, $key));
}
function palette(int $n): string {
    $colors = ['#004d9e','#dfc14f','#0284c7','#dc2626','#16a34a','#7c3aed','#db2777','#ea580c','#65a30d','#0891b2'];
    $out = [];
    for ($i=0; $i<$n; $i++) $out[] = $colors[$i % count($colors)];
    return json_encode($out);
}

require_once ROOT . '/includes/header.php';
?>

<!-- Page Header -->
<div class="page-header">
  <div class="page-header-title">
    <h1>Analytics Dashboard</h1>
    <p class="text-muted">Clinical data overview and service performance metrics.</p>
  </div>
  <div class="page-header-actions no-print">
    <a href="../index.php" class="btn btn-back-hub">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
      Back to Dashboard
    </a>
    <button onclick="window.print()" class="btn btn-outline">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 9V2h12v7M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2m-10 0v5h8v-5m-9-5h.01"></path></svg>
      Print Report
    </button>
    <button onclick="saveDashboardPdf()" class="btn btn-primary">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
      Save as PDF
    </button>
  </div>
</div>

<script>
function saveDashboardPdf() {
    const originalTitle = document.title;
    document.title = "Clinic_Analytics_Dashboard_<?= date('Y-m-d') ?>";
    window.print();
    document.title = originalTitle;
}
</script>

<style media="print">
  .sidebar, .topbar, form, .no-print, .btn, [title="Click to expand"] small { display: none !important; }
  .main-wrap { margin-left: 0 !important; padding: 0 !important; width: 100% !important; }
  .page-body { padding: 0 !important; }
  .stat-grid, .chart-grid { display: flex !important; flex-direction: column !important; gap: 1.5rem !important; }
  .stat-tile, .card { 
      break-inside: avoid; 
      border: 1px solid #e5e7eb !important; 
      margin-bottom: 1.5rem !important;
      width: 100% !important;
      box-shadow: none !important;
  }
  .chart-box { height: 400px !important; min-height: 400px !important; }
  body { background: white !important; font-size: 11pt; color: black !important; }
  .card-title { border-bottom: 1px solid #eee; padding-bottom: 0.5rem; margin-bottom: 1rem; }
</style>

<!-- Time Filter -->
<form method="GET" class="card" style="margin-bottom: 1.4rem; display: flex; gap: 1rem; align-items: flex-end; flex-wrap: wrap;">
  <div class="form-group" style="flex: 1; min-width: 150px; max-width: 250px;">
    <label>Time Filter</label>
    <select name="time_filter" onchange="toggleCustomDates(this.value)">
      <option value="today" <?= $timeFilter==='today'?'selected':'' ?>>Today</option>
      <option value="7days" <?= $timeFilter==='7days'?'selected':'' ?>>Last 7 Days</option>
      <option value="30days" <?= $timeFilter==='30days'?'selected':'' ?>>Last 30 Days</option>
      <option value="6months" <?= $timeFilter==='6months'?'selected':'' ?>>Last 6 Months</option>
      <option value="all" <?= $timeFilter==='all'?'selected':'' ?>>All Time</option>
      <option value="custom" <?= $timeFilter==='custom'?'selected':'' ?>>Custom Range</option>
    </select>
  </div>
  <div class="form-group custom-date" style="display: <?= $timeFilter==='custom'?'block':'none' ?>;">
    <label>Start Date</label>
    <input type="date" name="start_date" value="<?= htmlspecialchars($startDate) ?>">
  </div>
  <div class="form-group custom-date" style="display: <?= $timeFilter==='custom'?'block':'none' ?>;">
    <label>End Date</label>
    <input type="date" name="end_date" value="<?= htmlspecialchars($endDate) ?>">
  </div>
  <button type="submit" class="btn btn-primary" style="height: 38px;">Apply Filter</button>
</form>

<script>
function toggleCustomDates(val) {
    document.querySelectorAll('.custom-date').forEach(el => el.style.display = (val === 'custom') ? 'block' : 'none');
}
function toggleExpandCard(el) {
    el.classList.toggle('expanded-card');
    let overlay = document.getElementById('card-overlay');
    if (el.classList.contains('expanded-card')) {
        if (!overlay) {
            overlay = document.createElement('div');
            overlay.id = 'card-overlay';
            overlay.style.cssText = 'position:fixed;top:0;left:0;width:100vw;height:100vh;background:rgba(0,0,0,0.5);z-index:999;';
            overlay.onclick = () => toggleExpandCard(el);
            document.body.appendChild(overlay);
        }
    } else {
        if (overlay) overlay.remove();
    }
}
</script>
<style>
.expanded-card {
  position: fixed !important;
  top: 50% !important;
  left: 50% !important;
  transform: translate(-50%, -50%) !important;
  width: 90vw !important;
  height: 85vh !important;
  z-index: 1000 !important;
  margin: 0 !important;
  max-width: 1400px;
  display: flex !important;
  flex-direction: column;
}
.expanded-card .chart-box {
  flex: 1;
  height: auto !important;
  min-height: 0;
}
</style>

<!-- Stat tiles -->
<div class="stat-grid">
  <div class="stat-tile">
    <div class="label">Total Patients</div>
    <div class="value"><?= number_format($totPat) ?></div>
  </div>
  <div class="stat-tile accent">
    <div class="label">Unique Households</div>
    <div class="value"><?= number_format($totHH) ?></div>
  </div>
  <div class="stat-tile success">
    <div class="label">Total Encounters</div>
    <div class="value"><?= number_format($totCons) ?></div>
  </div>
</div>

<!-- Row 1: Top diagnoses + Monthly visits -->
<div class="chart-grid">
  <div class="card">
    <div class="card-title">Top 10 Diagnoses</div>
    <div class="chart-box"><canvas id="chartDx"></canvas></div>
  </div>
  <div class="card" onclick="toggleExpandCard(this)" style="cursor: pointer; position: relative; transition: all 0.3s ease;" title="Click to expand">
    <div class="card-title"><?= htmlspecialchars($chartLineTitle) ?> <small style="font-weight:normal; font-size: 0.75rem; color:var(--clr-text-muted); margin-left: auto;">(Click to expand)</small></div>
    <div class="chart-box"><canvas id="chartMonthly"></canvas></div>
  </div>
</div>

<!-- Row 2: Demographics, Sex, Age -->
<div class="chart-grid" style="grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));">
  <div class="card">
    <div class="card-title">Patient Demographics</div>
    <div class="chart-box" style="height:240px;"><canvas id="chartDemog"></canvas></div>
  </div>
  <div class="card">
    <div class="card-title">Sex Breakdown</div>
    <div class="chart-box" style="height:240px;"><canvas id="chartSex"></canvas></div>
  </div>
  <div class="card">
    <div class="card-title">Age Groups</div>
    <div class="chart-box" style="height:240px;"><canvas id="chartAge"></canvas></div>
  </div>
</div>

<!-- Row 3: Table -->
<div class="chart-grid" style="grid-template-columns: 1fr;">
  <div class="card" style="margin-bottom: 0;">
    <div class="card-title">Diagnosis/Symptom Frequency Table</div>
    <div class="table-wrap">
      <table>
        <thead><tr><th>Rank</th><th>Diagnosis / Symptoms</th><th>Encounter Count</th></tr></thead>
        <tbody>
          <?php if (empty($topDx)): ?>
            <tr><td colspan="3" class="text-muted">No diagnoses recorded yet.</td></tr>
          <?php else: ?>
            <?php foreach ($topDx as $rank => $row): ?>
            <tr>
              <td><?= $rank+1 ?></td>
              <td><?= htmlspecialchars($row['diagnosis']) ?></td>
              <td><strong><?= $row['cnt'] ?></strong></td>
            </tr>
            <?php endforeach; ?>
          <?php endif; ?>
        </tbody>
      </table>
    </div>
  </div>
</div>

<!-- Chart.js — loaded locally -->
<script src="<?= str_repeat('../',1) ?>assets/js/chart.min.js"></script>
<script>
Chart.defaults.font.family = "'Inter', 'Segoe UI', Arial, sans-serif";
Chart.defaults.plugins.legend.position = 'bottom';

const PRIMARY = '#004d9e';
const AMBER  = '#dfc14f';
const MUTED  = '#6b7280';

/* ── 1. Top Diagnoses Bar ── */
new Chart(document.getElementById('chartDx'), {
  type: 'bar',
  data: {
    labels : <?= jsArray($topDx, 'diagnosis') ?>,
    datasets: [{
      label: 'Encounters',
      data : <?= jsArray($topDx, 'cnt') ?>,
      backgroundColor: <?= palette(count($topDx)) ?>,
      borderRadius: 6
    }]
  },
  options: {
    responsive: true, maintainAspectRatio: false,
    plugins: { legend: { display: false } },
    scales: {
      x: { ticks: { maxRotation: 30, font: { size: 11 } } },
      y: { beginAtZero: true, ticks: { precision: 0 } }
    }
  }
});

/* ── 2. Monthly Line ── */
new Chart(document.getElementById('chartMonthly'), {
  type: 'line',
  data: {
    labels : <?= jsArray($visitsByMonth, 'label') ?>,
    datasets: [{
      label: 'Visits',
      data : <?= jsArray($visitsByMonth, 'cnt') ?>,
      borderColor: PRIMARY,
      backgroundColor: 'rgba(0,77,158,.12)',
      fill: true,
      tension: 0.4,
      pointBackgroundColor: PRIMARY,
      pointRadius: 5
    }]
  },
  options: {
    responsive: true, maintainAspectRatio: false,
    plugins: { legend: { display: false } },
    scales: { y: { beginAtZero: true, ticks: { precision: 0 } } }
  }
});

/* ── 3. Sex Pie ── */
new Chart(document.getElementById('chartSex'), {
  type: 'pie',
  data: {
    labels : <?= jsArray($sexBreakdown, 'sex') ?>,
    datasets: [{ data: <?= jsArray($sexBreakdown, 'cnt') ?>, backgroundColor: <?= palette(count($sexBreakdown)) ?> }]
  },
  options: { responsive: true, maintainAspectRatio: false }
});

/* ── 4. Age Groups Doughnut ── */
new Chart(document.getElementById('chartAge'), {
  type: 'doughnut',
  data: {
    labels : <?= jsArray($ageGroups, 'age_group') ?>,
    datasets: [{ data: <?= jsArray($ageGroups, 'cnt') ?>, backgroundColor: <?= palette(count($ageGroups)) ?> }]
  },
  options: { responsive: true, maintainAspectRatio: false }
});

/* ── 5. Demographics Bar ── */
new Chart(document.getElementById('chartDemog'), {
  type: 'bar',
  data: {
    labels: ['IP Only','NHTS Only','IP + NHTS','Regular'],
    datasets: [{
      data: [
        <?= (int)$demog['ip_only'] ?>,
        <?= (int)$demog['nhts_only'] ?>,
        <?= (int)$demog['ip_and_nhts'] ?>,
        <?= (int)$demog['regular'] ?>
      ],
      backgroundColor: ['#7c3aed','#dfc14f','#dc2626','#004d9e'],
      borderRadius: 6
    }]
  },
  options: {
    indexAxis: 'y',
    responsive: true, maintainAspectRatio: false,
    plugins: { legend: { display: false } },
    scales: { x: { beginAtZero: true, ticks: { precision: 0 } } }
  }
});
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
