<?php
/**
 * patients/view.php — Patient detail + consultation history
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$id = (int)($_GET['id'] ?? 0);
if (!$id) { header('Location: list.php'); exit; }

$stmt = $pdo->prepare(
    "SELECT p.*,
            TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) AS age
     FROM patient p
     WHERE p.patient_id = ?"
);
$stmt->execute([$id]);
$patient = $stmt->fetch();
if (!$patient) { header('Location: list.php'); exit; }

// Filtering logic
$timeFilter = $_GET['time_filter'] ?? 'all';
$startDate  = $_GET['start_date'] ?? '';
$endDate    = $_GET['end_date'] ?? '';
$monthYear  = $_GET['month_year'] ?? ''; // For chart clicks

$params = [$id];
$visitCond = "";

if ($monthYear) {
    $dt = DateTime::createFromFormat('M Y', $monthYear);
    if ($dt) {
        $visitCond = " AND DATE_FORMAT(c.visit_date, '%Y-%m') = ?";
        $params[] = $dt->format('Y-m');
    }
} elseif ($timeFilter === 'today') {
    $visitCond = " AND c.visit_date = CURDATE()";
} elseif ($timeFilter === '7days') {
    $visitCond = " AND c.visit_date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)";
} elseif ($timeFilter === '30days') {
    $visitCond = " AND c.visit_date >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)";
} elseif ($timeFilter === '6months') {
    $visitCond = " AND c.visit_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)";
} elseif ($timeFilter === 'custom' && $startDate && $endDate) {
    $visitCond = " AND c.visit_date >= ? AND c.visit_date <= ?";
    $params[] = $startDate;
    $params[] = $endDate;
}

// Consultation history
$history = $pdo->prepare(
    "SELECT c.consultation_id, c.visit_date, c.chief_complaint, c.diagnosis,
            c.treatment, c.remarks,
            CONCAT(ph.last_name,', ',ph.first_name) AS physician
     FROM consultation c
     LEFT JOIN physician ph  ON c.physician_id = ph.physician_id
     WHERE c.patient_id = ? $visitCond
     ORDER BY c.visit_date DESC"
);
$history->execute($params);
$consults = $history->fetchAll();

$pageTitle = htmlspecialchars($patient['patient_name']);
$activeNav = 'patients';

// ── Unified Chart Filter Logic ──────────────────────────────
$cNow = new DateTime();
$cStart = null;
$cEnd = clone $cNow;
$cInterval = null;
$cFormatLabel = "";
$cFormatYM = "";
$cPeriodCount = 0;
$chartTitleText = "Visit History";

// Logic adapted to unified $timeFilter
if ($timeFilter === 'today') {
    $cStart = (clone $cNow)->setTime(0, 0);
    $cEnd = (clone $cNow)->setTime(23, 59);
    $cInterval = new DateInterval('PT1H');
    $cFormatLabel = "h:00 A";
    $cFormatYM = "G"; 
    $cPeriodCount = 24;
    $chartTitleText = "Hourly Visits (Today)";
} elseif ($timeFilter === '7days') {
    $cStart = (clone $cNow)->modify('-6 days');
    $cInterval = new DateInterval('P1D');
    $cFormatLabel = "M d";
    $cFormatYM = "Y-m-d";
    $cPeriodCount = 7;
    $chartTitleText = "Daily Visits (Last 7 Days)";
} elseif ($timeFilter === '30days') {
    $cStart = (clone $cNow)->modify('-29 days');
    $cInterval = new DateInterval('P1D');
    $cFormatLabel = "M d";
    $cFormatYM = "Y-m-d";
    $cPeriodCount = 30;
    $chartTitleText = "Daily Visits (Last 30 Days)";
} elseif ($timeFilter === '6months') {
    $cStart = (clone $cNow)->modify('-5 months')->modify('first day of this month');
    $cInterval = new DateInterval('P1M');
    $cFormatLabel = "M Y";
    $cFormatYM = "Y-m";
    $cPeriodCount = 6;
    $chartTitleText = "Monthly Visits (Last 6 Months)";
} elseif ($timeFilter === 'custom' && $startDate && $endDate) {
    $cStart = new DateTime($startDate);
    $cEnd = new DateTime($endDate);
    $cInterval = new DateInterval('P1D');
    $cFormatLabel = "M d, Y";
    $cFormatYM = "Y-m-d";
    $cPeriodCount = $cStart->diff($cEnd)->days + 1;
    $chartTitleText = "Daily Visits (Custom)";
} else {
    // All Time (showing last 12 months for trend)
    $cStart = (clone $cNow)->modify('-11 months')->modify('first day of this month');
    $cInterval = new DateInterval('P1M');
    $cFormatLabel = "M Y";
    $cFormatYM = "Y-m";
    $cPeriodCount = 12;
    $chartTitleText = "Service Volume (All Time)";
}

// 1. Generate Timeline
$cLabels = [];
$cTimeline = new DatePeriod($cStart, $cInterval, max(0, $cPeriodCount - 1));
foreach ($cTimeline as $dt) {
    $cLabels[$dt->format($cFormatYM)] = [
        'ym' => $dt->format($cFormatYM),
        'label' => $dt->format($cFormatLabel),
        'cnt' => 0
    ];
}
$cLabels[$cEnd->format($cFormatYM)] = ['ym' => $cEnd->format($cFormatYM), 'label' => $cEnd->format($cFormatLabel), 'cnt' => 0];

// 2. Fetch Data for Graph
$cParams = [$id];
if ($timeFilter === 'today') {
    $sql = "SELECT HOUR(IFNULL(created_at, CONCAT(visit_date, ' 08:00:00'))) AS key_val, COUNT(*) AS cnt 
            FROM consultation WHERE patient_id = ? AND visit_date = CURDATE() GROUP BY key_val";
} elseif (in_array($timeFilter, ['7days', '30days', 'custom'])) {
    $sql = "SELECT DATE(visit_date) AS key_val, COUNT(*) AS cnt FROM consultation WHERE patient_id = ? AND visit_date BETWEEN ? AND ? GROUP BY key_val";
    $cParams[] = $cStart->format('Y-m-d');
    $cParams[] = $cEnd->format('Y-m-d');
} else {
    $sql = "SELECT DATE_FORMAT(visit_date, '%Y-%m') AS key_val, COUNT(*) AS cnt FROM consultation WHERE patient_id = ? AND visit_date >= ? GROUP BY key_val";
    $cParams[] = $cStart->format('Y-m-d');
}
$cStmt = $pdo->prepare($sql);
$cStmt->execute($cParams);
$cDbData = $cStmt->fetchAll(PDO::FETCH_KEY_PAIR);

// 3. Merge
foreach ($cDbData as $k => $v) {
    if (isset($cLabels[$k])) $cLabels[$k]['cnt'] = (int)$v;
}
$visitsByPeriod = array_values($cLabels);

$chartLabels = json_encode(array_column($visitsByPeriod, 'label'));
$chartValues = json_encode(array_column($visitsByPeriod, 'cnt'));

require_once ROOT . '/includes/header.php';
?>

<!-- Header block -->
<div class="card">
  <div style="display:flex; justify-content:space-between; align-items:flex-start; flex-wrap:wrap; gap:1rem;">
    <div>
      <h2 style="font-size:1.4rem; font-weight:800; color:var(--clr-primary-dk);">
        <?= htmlspecialchars($patient['patient_name']) ?>
      </h2>
      <p class="text-muted" style="margin-top:.25rem;">
        Household #<?= htmlspecialchars($patient['household_no']) ?>
        &bull; <?= $patient['age'] ?> years old &bull; <?= htmlspecialchars($patient['sex']) ?>
        &bull; <span class="badge badge-blue"><?= htmlspecialchars($patient['age_group']) ?></span>
      </p>
    </div>
    <div class="flex gap-2" style="flex-wrap:wrap;">
      <?php if ($patient['is_ip'] === 'Yes'): ?>   <span class="badge badge-purple">IP</span>   <?php endif; ?>
      <?php if ($patient['nhts_status'] === 'NHTS'): ?> <span class="badge badge-amber">NHTS</span>  <?php endif; ?>
      <span class="badge badge-<?= $patient['school_status']==='In-School' ? 'green' : ($patient['school_status']==='Out of School Youth' ? 'amber' : 'gray') ?>">
        <?= htmlspecialchars($patient['school_status']) ?>
      </span>
    </div>
  </div>

  <div class="form-grid" style="margin-top:1.2rem;">
    <div class="form-group">
      <label>Date of Birth</label>
      <div><?= htmlspecialchars($patient['dob']) ?></div>
    </div>
    <div class="form-group">
      <label>PhilHealth # / Category</label>
      <div><?= htmlspecialchars(($patient['philhealth_no'] ?: '—') . ($patient['philhealth_category'] ? ' ('.$patient['philhealth_category'].')' : '')) ?></div>
    </div>
    <div class="form-group">
      <label>Address</label>
      <div><?= htmlspecialchars($patient['address']) ?></div>
    </div>
    <div class="form-group">
      <label>Contact Number</label>
      <div><?= htmlspecialchars($patient['mobile_no'] ?: '—') ?></div>
    </div>
    <div class="form-group">
      <label>Mother's Maiden Name</label>
      <div><?= htmlspecialchars($patient['mothers_maiden_name'] ?: '—') ?></div>
    </div>
    <div class="form-group">
      <label>Total Visits</label>
      <div class="bold" style="font-size:1.5rem; color:var(--clr-primary);"><?= count($consults) ?></div>
    </div>
  </div>

  <div class="form-actions" style="margin-top:.8rem;">
    <a href="../consultations/new.php?patient_id=<?= $id ?>" class="btn btn-primary no-print">New Encounter</a>
    <a href="list.php" class="btn btn-outline no-print">Back to List</a>
    <button onclick="window.print()" class="btn btn-outline no-print">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M6 9V2h12v7M6 18H4a2 2 0 01-2-2v-5a2 2 0 012-2h16a2 2 0 012 2v5a2 2 0 01-2 2h-2m-10 0v5h8v-5m-9-5h.01"></path></svg>
      Print Record
    </button>
    <button onclick="saveRecordPdf()" class="btn btn-primary no-print">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M12 10v6m0 0l-3-3m3 3l3-3m2 8H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z"></path></svg>
      Save as PDF
    </button>
  </div>
</div>

<script>
function saveRecordPdf() {
    const originalTitle = document.title;
    // Set a clean filename for PDF saving
    document.title = "PatientRecord_<?= str_replace(' ', '_', $patient['patient_name']) ?>_<?= date('Y-m-d') ?>";
    window.print();
    document.title = originalTitle;
}
</script>

<style media="print">
  .sidebar, .topbar, form, .no-print, .btn:not(button) { display: none !important; }
  .main-wrap { margin-left: 0 !important; padding: 0 !important; width: 100% !important; }
  .page-body { padding: 0 !important; }
  .card { 
      break-inside: avoid; 
      border: 1px solid #eee !important; 
      box-shadow: none !important;
      margin-bottom: 1.5rem !important;
      padding: 1rem !important;
  }
  .form-grid { display: grid !important; grid-template-columns: 1fr 1fr 1fr !important; gap: 1rem !important; }
  .chart-box { height: 300px !important; }
  body { background: white !important; font-size: 10pt; color: black !important; }
  th:last-child, td:last-child { display: none !important; } /* Hide Action column */
  .badge { border: 1px solid #ccc !important; color: black !important; background: transparent !important; }
</style>

<!-- Global Filter Card -->
<div class="card no-print">
  <form method="GET" action="?id=<?= $id ?>#graph-section" class="flex gap-4" style="align-items:flex-end; flex-wrap:wrap;">
    <input type="hidden" name="id" value="<?= $id ?>">
    
    <div class="form-group" style="flex: 1; min-width: 200px; max-width: 300px;">
      <label style="font-size: 0.75rem;">Time Range Filter</label>
      <select name="time_filter" onchange="toggleCustomDates(this.value)">
        <option value="all"      <?= $timeFilter==='all'     ? 'selected':'' ?>>All Time</option>
        <option value="today"    <?= $timeFilter==='today'   ? 'selected':'' ?>>Today</option>
        <option value="7days"    <?= $timeFilter==='7days'   ? 'selected':'' ?>>Last 7 Days</option>
        <option value="30days"   <?= $timeFilter==='30days'  ? 'selected':'' ?>>Last 30 Days</option>
        <option value="6months"  <?= $timeFilter==='6months' ? 'selected':'' ?>>Last 6 Months</option>
        <option value="custom"   <?= $timeFilter==='custom'  ? 'selected':'' ?>>Custom Range</option>
      </select>
    </div>

    <div class="custom-date flex gap-2" style="display: <?= $timeFilter==='custom'?'flex':'none' ?>; align-items:center;">
      <div class="form-group">
        <label style="font-size: 0.7rem;">Start Date</label>
        <input type="date" name="start_date" value="<?= htmlspecialchars($startDate) ?>" style="padding: 0.4rem; font-size: 0.85rem; border:1px solid var(--clr-border); border-radius:4px;">
      </div>
      <span class="text-muted" style="margin-top: 1.5rem;">to</span>
      <div class="form-group">
        <label style="font-size: 0.7rem;">End Date</label>
        <input type="date" name="end_date" value="<?= htmlspecialchars($endDate) ?>" style="padding: 0.4rem; font-size: 0.85rem; border:1px solid var(--clr-border); border-radius:4px;">
      </div>
    </div>

    <div class="flex gap-2">
      <button type="submit" class="btn btn-primary" style="height: 38px;">Apply Filter</button>
      <button type="button" onclick="resetWithScroll('graph-section')" class="btn btn-outline" style="height: 38px;">Reset</button>
    </div>
  </form>
</div>

<!-- Visit Trend Visualization -->
<div class="card" id="graph-section">
  <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:1rem; margin-bottom:1.2rem;">
    <div class="card-title" style="margin:0;"><?= $chartTitleText ?></div>
  </div>
  <div class="chart-box" style="height: 220px; margin-top: 1rem;">
    <canvas id="visitChart"></canvas>
  </div>
</div>

<!-- Consultation history -->
<div class="card" id="history-section">
  <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:1rem; margin-bottom:1.2rem;">
    <div class="card-title" style="margin:0;">Consultation History</div>
  </div>

  <?php if ($monthYear): ?>
    <div class="badge badge-blue" style="margin-bottom:1rem; display:inline-block;">
      Filtering by: <strong><?= htmlspecialchars($monthYear) ?></strong>
    </div>
  <?php endif; ?>

  <?php if (empty($consults)): ?>
    <p class="text-muted">No consultations found for the selected criteria. <a href="?id=<?= $id ?>">Clear filters</a>.</p>
  <?php else: ?>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>Chief Complaint</th>
          <th>Diagnosis</th>
          <th>Treatment</th>
          <th>Remarks</th>
          <th>Attending Physician</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($consults as $c): ?>
        <tr>
          <td style="white-space:nowrap;"><?= htmlspecialchars($c['visit_date']) ?></td>
          <td><?= htmlspecialchars(mb_strimwidth($c['chief_complaint'] ?? '—', 0, 30, '…')) ?></td>
          <td><span class="badge badge-blue"><?= htmlspecialchars(mb_strimwidth($c['diagnosis'] ?? '—', 0, 30, '…')) ?></span></td>
          <td><?= htmlspecialchars(mb_strimwidth($c['treatment'] ?? '—', 0, 50, '…')) ?></td>
          <td><?= htmlspecialchars(mb_strimwidth($c['remarks'] ?? '—', 0, 50, '…')) ?></td>
          <td><?= htmlspecialchars($c['physician'] ?? '—') ?></td>
          <td>
            <a href="../consultations/view.php?id=<?= $c['consultation_id'] ?>" class="btn btn-sm btn-outline">View</a>
          </td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
<?php endif; ?>
</div>

<!-- Chart.js and Initialization -->
<script src="../assets/js/chart.min.js"></script>
<script>
function toggleCustomDates(val) {
    document.querySelectorAll('.custom-date').forEach(el => el.style.display = (val === 'custom') ? 'flex' : 'none');
}

document.addEventListener('DOMContentLoaded', function() {
    const ctx = document.getElementById('visitChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: <?= $chartLabels ?>,
            datasets: [{
                label: 'Number of Visits',
                data: <?= $chartValues ?>,
                borderColor: '#004d9e',
                backgroundColor: 'rgba(0, 77, 158, 0.1)',
                borderWidth: 3,
                tension: 0.3,
                fill: true,
                pointBackgroundColor: '#004d9e',
                pointRadius: 6, // Slightly larger for better clickability
                pointHoverRadius: 8,
                pointHitRadius: 10
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            onClick: (e, activeEls) => {
                if (activeEls.length > 0) {
                    const index = activeEls[0].index;
                    // Labels are in context of this chart (last 12 months)
                    const label = ctx.canvas.chart.data.labels[index];
                    
                    const url = new URL(window.location.href);
                    url.searchParams.set('month_year', label);
                    url.searchParams.delete('time_filter');
                    url.searchParams.delete('start_date');
                    url.searchParams.delete('end_date');
                    url.hash = 'history-section';
                    window.location.href = url.toString();
                }
            },
            plugins: {
                legend: { display: false },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.raw + ' visit' + (context.raw !== 1 ? 's' : '') + ' (Click to filter list)';
                        }
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1,
                        precision: 0
                    },
                    grid: { color: '#f3f4f6' }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });
    
    // Store chart instance on the canvas for the onClick handler to access labels easily
    const chartInstance = Chart.getChart(ctx.canvas);
    ctx.canvas.chart = chartInstance;

    // Capture scroll on form submit
    document.querySelectorAll('form').forEach(f => {
        f.addEventListener('submit', function() {
            const scrollPos = window.scrollY;
            const input = document.createElement('input');
            input.type = 'hidden';
            input.name = 'spos';
            input.value = scrollPos;
            this.appendChild(input);
        });
    });
});

function resetWithScroll(sectionId) {
    const scrollPos = window.scrollY;
    window.location.href = "?id=<?= $id ?>&spos=" + scrollPos + "#" + sectionId;
}

// Pixel-perfect scroll restoration
(function() {
    const urlParams = new URLSearchParams(window.location.search);
    const spos = urlParams.get('spos');
    if (spos) {
        if ('scrollRestoration' in history) {
            history.scrollRestoration = 'manual';
        }
        window.scrollTo(0, parseInt(spos));
    }
})();
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
