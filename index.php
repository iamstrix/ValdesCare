<?php
/**
 * index.php — ValdesCare Home Dashboard
 * Quick stats and navigation hub.
 */
define('ROOT', __DIR__);
require_once ROOT . '/db_connect.php';

$pageTitle = 'Dashboard';
$activeNav = 'home';
require_once ROOT . '/includes/header.php';

// ── Summary statistics ─────────────────────────────────────
$stats = [];

$stats['total_patients']       = $pdo->query("SELECT COUNT(*) FROM patient")->fetchColumn();
$stats['total_households']     = $pdo->query("SELECT COUNT(DISTINCT household_no) FROM patient")->fetchColumn();
$stats['consultations_today']  = $pdo->query("SELECT COUNT(*) FROM consultation WHERE visit_date = CURDATE()")->fetchColumn();
$stats['consultations_month']  = $pdo->query("SELECT COUNT(*) FROM consultation WHERE YEAR(visit_date)=YEAR(CURDATE()) AND MONTH(visit_date)=MONTH(CURDATE())")->fetchColumn();
$stats['ip_households']        = $pdo->query("SELECT COUNT(DISTINCT household_no) FROM patient WHERE is_ip='Yes'")->fetchColumn();
$stats['nhts_households']      = $pdo->query("SELECT COUNT(DISTINCT household_no) FROM patient WHERE nhts_status='NHTS'")->fetchColumn();

// ── Recent consultations ───────────────────────────────────
$recentConsults = $pdo->query(
    "SELECT c.consultation_id, c.visit_date, c.chief_complaint, c.diagnosis,
            CONCAT(p.last_name, ', ', p.first_name) AS patient_name
     FROM consultation c
     JOIN patient p ON c.patient_id = p.patient_id
     ORDER BY c.visit_date DESC, c.consultation_id DESC
     LIMIT 8"
)->fetchAll();
?>

<!-- ── Stat tiles ── -->
<div class="stat-grid">
  <div class="stat-tile">
    <div class="label">Total Patients</div>
    <div class="value"><?= number_format($stats['total_patients']) ?></div>
  </div>
  <div class="stat-tile accent">
    <div class="label">Households</div>
    <div class="value"><?= number_format($stats['total_households']) ?></div>
  </div>
  <div class="stat-tile success">
    <div class="label">Consults Today</div>
    <div class="value"><?= number_format($stats['consultations_today']) ?></div>
  </div>
  <div class="stat-tile info">
    <div class="label">Consults This Month</div>
    <div class="value"><?= number_format($stats['consultations_month']) ?></div>
  </div>
  <div class="stat-tile">
    <div class="label">IP Households</div>
    <div class="value"><?= number_format($stats['ip_households']) ?></div>
  </div>
  <div class="stat-tile accent">
    <div class="label">NHTS Households</div>
    <div class="value"><?= number_format($stats['nhts_households']) ?></div>
  </div>
</div>

<!-- ── Quick actions ── -->
<div class="card">
  <div class="card-title">Quick Actions</div>
  <div class="flex gap-4" style="flex-wrap:wrap;">
    <a href="patients/register.php" class="btn btn-primary">Register Patient</a>
    <a href="consultations/new.php" class="btn btn-accent">New Encounter</a>
    <a href="patients/list.php"     class="btn btn-outline">View Patients</a>
    <a href="dashboard/index.php"   class="btn btn-outline">Analytics</a>
    <a href="exports/report.php"    class="btn btn-outline">Print Report</a>
  </div>
</div>

<!-- ── Recent encounters ── -->
<div class="card">
  <div class="card-title">Recent Encounters</div>
  <?php if (empty($recentConsults)): ?>
    <p class="text-muted">No encounters recorded yet. <a href="consultations/new.php">Add the first one</a>.</p>
  <?php else: ?>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>Patient</th>
          <th>Chief Complaint</th>
          <th>Diagnosis</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($recentConsults as $r): ?>
        <tr>
          <td><?= htmlspecialchars($r['visit_date']) ?></td>
          <td><?= htmlspecialchars($r['patient_name']) ?></td>
          <td><?= htmlspecialchars(mb_strimwidth($r['chief_complaint'] ?? '—', 0, 30, '…')) ?></td>
          <td><span class="badge badge-blue"><?= htmlspecialchars(mb_strimwidth($r['diagnosis'] ?? '—', 0, 40, '…')) ?></span></td>
          <td>
            <a class="btn btn-sm btn-outline"
               href="consultations/view.php?id=<?= $r['consultation_id'] ?>">View</a>
          </td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <div class="mt-1 text-right">
    <a href="consultations/list.php" class="text-muted">View all encounters &rarr;</a>
  </div>
  <?php endif; ?>
</div>

<?php require_once ROOT . '/includes/footer.php'; ?>
