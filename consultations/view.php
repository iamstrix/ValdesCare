<?php
/**
 * consultations/view.php — Single encounter detail
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$id = (int)($_GET['id'] ?? 0);
if (!$id) { header('Location: list.php'); exit; }

$stmt = $pdo->prepare(
    "SELECT c.*,
            CONCAT(p.last_name, ', ', p.first_name) AS patient_name, p.patient_id, p.address,
            TIMESTAMPDIFF(YEAR, p.dob, c.visit_date) AS age_at_visit,
            p.sex, p.dob,
            p.is_ip, p.nhts_status,
            CONCAT(ph.last_name,', ',ph.first_name) AS physician_name,
            ph.specialty
     FROM consultation c
     JOIN patient p ON c.patient_id = p.patient_id
     LEFT JOIN physician ph  ON c.physician_id = ph.physician_id
     WHERE c.consultation_id = ?"
);
$stmt->execute([$id]);
$c = $stmt->fetch();
if (!$c) { header('Location: list.php'); exit; }

$pageTitle = 'Encounter Details';
$activeNav = 'consult-list';
require_once ROOT . '/includes/header.php';
?>

<div class="no-print flex gap-2" style="margin-bottom:1rem; flex-wrap:wrap;">
  <a href="list.php" class="btn btn-outline btn-sm">Encounter Log</a>
  <a href="../patients/view.php?id=<?= $c['patient_id'] ?>" class="btn btn-outline btn-sm">Patient Record</a>
  <button onclick="window.print()" class="btn btn-outline btn-sm">Print</button>
</div>

<!-- Print header -->
<div style="display:none;" class="print-header">
  <h2 style="text-align:center; font-size:1rem;">AUF DON EMILIANO J. VALDES MEDICAL CLINIC</h2>
  <p style="text-align:center; font-size:.85rem;">Consultation Record · <?= htmlspecialchars($c['visit_date']) ?></p>
  <hr>
</div>

<div class="card">
  <div style="display:flex; justify-content:space-between; flex-wrap:wrap; gap:1rem;">
    <div>
      <h3 style="font-size:1.3rem; font-weight:800; color:var(--clr-primary-dk);">
        <?= htmlspecialchars($c['patient_name']) ?>
      </h3>
      <p class="text-muted">
        <?= $c['age_at_visit'] ?> years old · <?= htmlspecialchars($c['sex']) ?>
        &bull; <?= htmlspecialchars($c['address']) ?>
        <?php if ($c['is_ip'] === 'Yes'): ?>  · <span class="badge badge-purple">IP</span> <?php endif; ?>
        <?php if ($c['nhts_status'] === 'NHTS'): ?>· <span class="badge badge-amber">NHTS</span><?php endif; ?>
      </p>
    </div>
    <div style="text-align:right;">
      <div class="bold" style="font-size:1.1rem;"><?= htmlspecialchars($c['visit_date']) ?></div>
      <?php if ($c['physician_name']): ?>
        <div class="text-muted" style="margin-top:.3rem;">Dr. <?= htmlspecialchars($c['physician_name']) ?><?= $c['specialty'] ? ' — '.$c['specialty'] : '' ?></div>
      <?php endif; ?>
    </div>
  </div>
</div>

<!-- Clinical notes -->
<div class="card">
  <div class="card-title">Clinical Notes</div>
  <div class="form-grid">
    <div class="form-group" style="grid-column:1/-1;">
      <label>Chief Complaint</label>
      <div><span class="badge badge-amber"><?= htmlspecialchars($c['chief_complaint']) ?></span></div>
    </div>
    <?php if ($c['complaint_details']): ?>
    <div class="form-group" style="grid-column:1/-1;">
      <label>Complaint Details</label>
      <div><?= nl2br(htmlspecialchars($c['complaint_details'])) ?></div>
    </div>
    <?php endif; ?>
    <div class="form-group" style="grid-column:1/-1;">
      <label>Diagnosis</label>
      <div><span class="badge badge-blue"><?= htmlspecialchars($c['diagnosis']) ?></span></div>
    </div>
    <?php if ($c['treatment']): ?>
    <div class="form-group" style="grid-column:1/-1;">
      <label>Treatment</label>
      <div><?= nl2br(htmlspecialchars($c['treatment'])) ?></div>
    </div>
    <?php endif; ?>
    <?php if ($c['remarks']): ?>
    <div class="form-group" style="grid-column:1/-1;">
      <label>Remarks</label>
      <div><?= nl2br(htmlspecialchars($c['remarks'])) ?></div>
    </div>
    <?php endif; ?>
  </div>
</div>

<?php require_once ROOT . '/includes/footer.php'; ?>
