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
    $visitCond = " AND visit_date >= " . $pdo->quote($startDate) . " AND visit_date <= " . $pdo->quote($endDate);
}

$cVisitCond = str_replace('visit_date', 'c.visit_date', $visitCond);
$patientWhere = $visitCond ? "WHERE EXISTS (SELECT 1 FROM consultation c WHERE c.patient_id = patient.patient_id {$cVisitCond})" : "";
$hhWhere = $visitCond ? "WHERE EXISTS (SELECT 1 FROM consultation c WHERE c.patient_id = p.patient_id {$cVisitCond})" : "";

// ── 1. Top diagnoses ──────────────────────────────────────
$topDx = $pdo->query(
    "SELECT symptoms_diagnosis AS diagnosis, COUNT(*) AS cnt
     FROM consultation
     WHERE symptoms_diagnosis IS NOT NULL AND symptoms_diagnosis <> '' {$visitCond}
     GROUP BY symptoms_diagnosis
     ORDER BY cnt DESC
     LIMIT 10"
)->fetchAll();

// ── 2. Time-Trend Tracking ────────────────────────
$chartLineTitle = "Monthly Visits (Last 12 Months)";

if ($timeFilter === 'today') {
    $trendQuery = "SELECT HOUR(IFNULL(created_at,'08:00:00')) AS ym,
                          DATE_FORMAT(IFNULL(created_at,'08:00:00'), '%h:00 %p') AS label,
                          COUNT(*) AS cnt
                   FROM consultation
                   WHERE visit_date = CURDATE()
                   GROUP BY ym, label
                   ORDER BY ym";
    $chartLineTitle = "Hourly Visits (Today)";
} elseif ($timeFilter === '7days') {
    $trendQuery = "SELECT DATE(visit_date) AS ym,
                          DATE_FORMAT(visit_date, '%b %d') AS label,
                          COUNT(*) AS cnt
                   FROM consultation
                   WHERE visit_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
                   GROUP BY ym, label
                   ORDER BY ym";
    $chartLineTitle = "Daily Visits (Last 7 Days)";
} elseif ($timeFilter === '30days') {
    $trendQuery = "SELECT DATE(visit_date) AS ym,
                          DATE_FORMAT(visit_date, '%b %d') AS label,
                          COUNT(*) AS cnt
                   FROM consultation
                   WHERE visit_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
                   GROUP BY ym, label
                   ORDER BY ym";
    $chartLineTitle = "Daily Visits (Last 30 Days)";
} elseif ($timeFilter === '6months') {
    $trendQuery = "SELECT DATE_FORMAT(visit_date,'%Y-%m') AS ym,
                          DATE_FORMAT(visit_date,'%b %Y') AS label,
                          COUNT(*) AS cnt
                   FROM consultation
                   WHERE visit_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
                   GROUP BY ym, label
                   ORDER BY ym";
    $chartLineTitle = "Monthly Visits (Last 6 Months)";
} elseif ($timeFilter === 'custom' && $startDate && $endDate) {
    $trendQuery = "SELECT DATE(visit_date) AS ym,
                          DATE_FORMAT(visit_date, '%b %d, %Y') AS label,
                          COUNT(*) AS cnt
                   FROM consultation
                   WHERE visit_date >= " . $pdo->quote($startDate) . " AND visit_date <= " . $pdo->quote($endDate) . "
                   GROUP BY ym, label
                   ORDER BY ym";
    $chartLineTitle = "Daily Visits (Custom Range)";
} else {
    $trendCond = $visitCond ?: " AND visit_date >= DATE_SUB(CURDATE(), INTERVAL 12 MONTH)";
    $trendQuery = "SELECT DATE_FORMAT(visit_date,'%Y-%m') AS ym,
                          DATE_FORMAT(visit_date,'%b %Y') AS label,
                          COUNT(*) AS cnt
                   FROM consultation
                   WHERE 1=1 {$trendCond}
                   GROUP BY ym, label
                   ORDER BY ym";
    if ($timeFilter === 'all') {
        $chartLineTitle = "All Time Visits";
    }
}
$visitsByMonth = $pdo->query($trendQuery)->fetchAll();

// ── 3. Sex breakdown ─────────────────────────────────────
$sexBreakdown = $pdo->query(
    "SELECT sex, COUNT(*) AS cnt FROM patient {$patientWhere} GROUP BY sex"
)->fetchAll();

// ── 4. Age groups (Patient Categories) ─────────────────────
$ageGroups = $pdo->query(
    "SELECT age_group, COUNT(*) AS cnt
     FROM patient {$patientWhere}
     GROUP BY age_group
     ORDER BY FIELD(age_group, 'Pediatric', 'Adult', 'Geriatric')"
)->fetchAll();

// ── 5. Demographics (Replaces Category) ────────────────────
$demog = $pdo->query(
    "SELECT
       SUM(is_ip='Yes' AND nhts_status='NON-NHTS')  AS ip_only,
       SUM(nhts_status='NHTS' AND is_ip='No')  AS nhts_only,
       SUM(is_ip='Yes' AND nhts_status='NHTS')  AS ip_and_nhts,
       SUM(is_ip='No' AND nhts_status='NON-NHTS')  AS regular
     FROM patient p {$hhWhere}"
)->fetch();

// ── Summary stats ─────────────────────────────────────────
$totPat  = $pdo->query("SELECT COUNT(*) FROM patient {$patientWhere}")->fetchColumn();
$totCons = $pdo->query("SELECT COUNT(*) FROM consultation WHERE 1=1 {$visitCond}")->fetchColumn();
$totHH   = $pdo->query("SELECT COUNT(DISTINCT household_no) FROM patient p {$hhWhere}")->fetchColumn();
$thisMonth = $pdo->query("SELECT COUNT(*) FROM consultation WHERE MONTH(visit_date)=MONTH(CURDATE()) AND YEAR(visit_date)=YEAR(CURDATE()) {$visitCond}")->fetchColumn();

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
  <div class="stat-tile info">
    <div class="label">This Month</div>
    <div class="value"><?= number_format($thisMonth) ?></div>
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

<!-- Row 2: Pie / doughnut charts -->
<div class="chart-grid" style="grid-template-columns:repeat(auto-fill,minmax(280px,1fr));">
  <div class="card">
    <div class="card-title">Sex Breakdown</div>
    <div class="chart-box" style="height:240px;"><canvas id="chartSex"></canvas></div>
  </div>
  <div class="card">
    <div class="card-title">Age Groups</div>
    <div class="chart-box" style="height:240px;"><canvas id="chartAge"></canvas></div>
  </div>
  <div class="card" style="grid-column: span 2;">
    <div class="card-title">Patient Demographics</div>
    <div class="chart-box" style="height:240px;"><canvas id="chartDemog"></canvas></div>
  </div>
</div>

<!-- Top diagnoses table -->
<div class="card">
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

<!-- Chart.js — loaded locally -->
<script src="<?= str_repeat('../',1) ?>assets/js/chart.min.js"></script>
<script>
Chart.defaults.font.family = "'Segoe UI', Arial, sans-serif";
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
    responsive: true, maintainAspectRatio: false,
    plugins: { legend: { display: false } },
    scales: { y: { beginAtZero: true, ticks: { precision: 0 } } }
  }
});
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
