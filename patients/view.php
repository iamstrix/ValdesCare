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

// Consultation history
$history = $pdo->prepare(
    "SELECT c.consultation_id, c.visit_date, c.chief_complaint, c.diagnosis,
            c.treatment, c.remarks,
            CONCAT(ph.last_name,', ',ph.first_name) AS physician
     FROM consultation c
     LEFT JOIN physician ph  ON c.physician_id = ph.physician_id
     WHERE c.patient_id = ?
     ORDER BY c.visit_date DESC"
);
$history->execute([$id]);
$consults = $history->fetchAll();

$pageTitle = htmlspecialchars($patient['patient_name']);
$activeNav = 'patients';

// ── Visit trend data (Last 12 months) ──────────────────────
$trendSql = "
    SELECT DATE_FORMAT(visit_date, '%Y-%m') as ym, COUNT(*) as cnt
    FROM consultation
    WHERE patient_id = ? AND visit_date >= DATE_SUB(CURDATE(), INTERVAL 11 MONTH)
    GROUP BY ym
    ORDER BY ym ASC
";
$trendStmt = $pdo->prepare($trendSql);
$trendStmt->execute([$id]);
$trendRaw = $trendStmt->fetchAll(PDO::FETCH_KEY_PAIR);

// Gap-fill last 12 months to ensure a continuous line
$trendData = [];
for ($i = 11; $i >= 0; $i--) {
    $m = date('Y-m', strtotime("-$i months"));
    $label = date('M Y', strtotime("-$i months"));
    $trendData[] = [
        'label' => $label,
        'cnt' => (int)($trendRaw[$m] ?? 0)
    ];
}

$chartLabels = json_encode(array_column($trendData, 'label'));
$chartValues = json_encode(array_column($trendData, 'cnt'));

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
        Patient #<?= $patient['patient_id'] ?> &bull; Household #<?= htmlspecialchars($patient['household_no']) ?>
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
    <a href="../consultations/new.php?patient_id=<?= $id ?>" class="btn btn-primary">New Encounter</a>
    <a href="list.php" class="btn btn-outline">Back to List</a>
    <a href="../exports/report.php?patient_id=<?= $id ?>" class="btn btn-outline no-print">Print Record</a>
  </div>
</div>

<!-- Visit Trend Visualization -->
<div class="card">
  <div class="card-title">Visit Frequency (Last 12 Months)</div>
  <div class="chart-box" style="height: 220px; margin-top: 1rem;">
    <canvas id="visitChart"></canvas>
  </div>
</div>

<!-- Consultation history -->
<div class="card">
  <div class="card-title">Consultation History</div>
  <?php if (empty($consults)): ?>
    <p class="text-muted">No consultations yet. <a href="../consultations/new.php?patient_id=<?= $id ?>">Start one now</a>.</p>
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
                pointRadius: 4,
                pointHoverRadius: 6
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false },
                tooltip: {
                    callbacks: {
                        label: function(context) {
                            return context.raw + ' visit' + (context.raw !== 1 ? 's' : '');
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
});
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
