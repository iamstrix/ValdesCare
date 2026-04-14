<?php
/**
 * exports/report.php — Printable / exportable report
 * ---------------------------------------------------
 * Generates a print-ready page for:
 *  - A single patient record (pass ?patient_id=N)
 *  - A summary encounter report for a date range
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$patientId = (int)($_GET['patient_id'] ?? 0);
$dateFrom  = $_GET['date_from'] ?? date('Y-m-01');
$dateTo    = $_GET['date_to']   ?? date('Y-m-d');
$mode      = $patientId ? 'patient' : 'summary';

// ── Patient mode ──
$patient  = null;
$consults = [];
if ($mode === 'patient') {
    $s = $pdo->prepare(
        "SELECT p.*,
                TIMESTAMPDIFF(YEAR,p.dob,CURDATE()) AS age
         FROM patient p
         WHERE p.patient_id=?"
    );
    $s->execute([$patientId]);
    $patient = $s->fetch();

    $s2 = $pdo->prepare(
        "SELECT c.*, CONCAT(ph.last_name,', ',ph.first_name) AS physician
         FROM consultation c
         LEFT JOIN physician ph  ON c.physician_id=ph.physician_id
         WHERE c.patient_id=? ORDER BY c.visit_date DESC"
    );
    $s2->execute([$patientId]);
    $consults = $s2->fetchAll();
}

// ── Summary mode ──
$summaryRows = [];
if ($mode === 'summary') {
    $s = $pdo->prepare(
        "SELECT c.visit_date,
                p.patient_name,
                TIMESTAMPDIFF(YEAR,p.dob,c.visit_date) AS age, p.sex,
                p.address AS barangay, p.is_ip, p.nhts_status,
                c.symptoms_diagnosis,
                CONCAT(ph.last_name,', ',ph.first_name) AS physician
         FROM consultation c
         JOIN patient p ON c.patient_id=p.patient_id
         LEFT JOIN physician ph  ON c.physician_id=ph.physician_id
         WHERE c.visit_date BETWEEN ? AND ?
         ORDER BY c.visit_date DESC, c.consultation_id DESC"
    );
    $s->execute([$dateFrom, $dateTo]);
    $summaryRows = $s->fetchAll();
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>ValdesCare Report</title>
  <style>
    * { box-sizing: border-box; margin: 0; padding: 0; }
    body { font-family: 'Segoe UI', Arial, sans-serif; font-size: 12px; color: #111; background: #f0f0f0; }
    .report-page { background: #fff; max-width: 1000px; margin: 1.5rem auto; padding: 2rem; box-shadow: 0 0 16px rgba(0,0,0,.12); }
    .report-header { display:flex; justify-content:space-between; align-items:flex-start; border-bottom:3px solid #0f6b5c; padding-bottom:.8rem; margin-bottom:1rem; }
    .clinic-name { font-size:1.3rem; font-weight:800; color:#0f6b5c; }
    .clinic-sub  { font-size:.8rem; color:#555; }
    .report-meta { text-align:right; font-size:.78rem; color:#555; }
    h2 { font-size:1rem; margin-bottom:.5rem; color:#0f6b5c; }
    .info-grid { display:grid; grid-template-columns:repeat(3,1fr); gap:.5rem 1rem; margin-bottom:1rem; border:1px solid #ddd; padding:.8rem; border-radius:6px; }
    .info-item label { display:block; font-size:.7rem; font-weight:700; color:#888; text-transform:uppercase; }
    .info-item span  { font-size:.9rem; font-weight:600; }
    table { width:100%; border-collapse:collapse; margin-top:.5rem; font-size:.8rem; }
    th { background:#0f6b5c; color:#fff; padding:.4rem .5rem; text-align:left; }
    td { padding:.38rem .5rem; border-bottom:1px solid #eee; vertical-align:top; }
    tr:nth-child(even) td { background:#f9f9f9; }
    .badge { display:inline-block; padding:.1rem .4rem; border-radius:99px; font-size:.68rem; font-weight:700; }
    .badge-ip   { background:#ede9fe; color:#7c3aed; }
    .badge-nhts { background:#fef3c7; color:#b45309; }
    .no-print-bar { display:flex; gap:.5rem; justify-content:center; padding: .8rem; margin-bottom:.5rem; flex-wrap:wrap; }
    .btn { display:inline-block; padding:.4rem 1rem; border-radius:6px; font-size:.82rem; font-weight:600; cursor:pointer; border:none; }
    .btn-primary { background:#0f6b5c; color:#fff; }
    .btn-outline { background:#fff; border:1.5px solid #0f6b5c; color:#0f6b5c; }
    a.btn { text-decoration:none; }
    .filter-form { background:#fff; max-width:900px; margin: 0 auto 1rem; padding:1rem; border-radius:8px; box-shadow:0 2px 6px rgba(0,0,0,.1); display:flex; gap:.5rem; flex-wrap:wrap; align-items:flex-end; }
    .filter-form label { display:block; font-size:.75rem; font-weight:600; color:#555; }
    .filter-form input[type="date"] { padding:.3rem .5rem; border:1.5px solid #ccc; border-radius:5px; font-size:.82rem; }
    .section-title { font-size:.9rem; font-weight:700; background:#e8f5f3; padding:.4rem .7rem; border-left:4px solid #0f6b5c; margin:.8rem 0 .3rem; }
    @media print {
      .no-print-bar, .filter-form { display:none !important; }
      body { background:#fff; }
      .report-page { box-shadow:none; margin:0; max-width:100%; }
    }
  </style>
</head>
<body>

<!-- Controls (hidden on print) -->
<div class="no-print-bar">
  <button class="btn btn-primary" onclick="window.print()">&#128438; Print / Save as PDF</button>
  <?php if ($mode === 'patient'): ?>
    <a href="report.php" class="btn btn-outline">&#128196; Summary Report</a>
    <a href="../patients/view.php?id=<?= $patientId ?>" class="btn btn-outline">&#8592; Back to Patient</a>
  <?php else: ?>
    <a href="../index.php" class="btn btn-outline">&#8592; Back to Dashboard</a>
  <?php endif; ?>
</div>

<!-- Date filter form (summary mode only) -->
<?php if ($mode === 'summary'): ?>
<form class="filter-form" method="GET">
  <div>
    <label>From</label>
    <input type="date" name="date_from" value="<?= htmlspecialchars($dateFrom) ?>">
  </div>
  <div>
    <label>To</label>
    <input type="date" name="date_to" value="<?= htmlspecialchars($dateTo) ?>">
  </div>
  <button type="submit" class="btn btn-primary">&#128269; Filter</button>
</form>
<?php endif; ?>

<div class="report-page">
  <!-- Header -->
  <div class="report-header">
    <div>
      <div class="clinic-name">&#9877; ValdesCare Charity Clinic</div>
      <div class="clinic-sub">University-Based Community Health Program</div>
      <div class="clinic-sub">Offline Clinical Decision Support System</div>
    </div>
    <div class="report-meta">
      <div>Generated: <strong><?= date('F j, Y · g:i A') ?></strong></div>
      <?php if ($mode === 'summary'): ?>
        <div>Period: <strong><?= htmlspecialchars($dateFrom) ?> to <?= htmlspecialchars($dateTo) ?></strong></div>
      <?php endif; ?>
    </div>
  </div>

  <?php if ($mode === 'patient' && $patient): ?>
  <!-- ═══ PATIENT REPORT ═══ -->
  <h2>Patient Record</h2>
  <div class="info-grid">
    <div class="info-item">
      <label>Full Name</label>
      <span><?= htmlspecialchars($patient['patient_name']) ?></span>
    </div>
    <div class="info-item">
      <label>Patient ID / HH No.</label>
      <span>#<?= $patient['patient_id'] ?> / <?= htmlspecialchars($patient['household_no']) ?></span>
    </div>
    <div class="info-item">
      <label>Date of Birth</label>
      <span><?= htmlspecialchars($patient['dob']) ?> (<?= $patient['age'] ?> yrs)</span>
    </div>
    <div class="info-item">
      <label>Sex</label>
      <span><?= htmlspecialchars($patient['sex']) ?></span>
    </div>
    <div class="info-item">
      <label>PhilHealth #</label>
      <span><?= htmlspecialchars($patient['philhealth_no'] ?? '—') ?></span>
    </div>
    <div class="info-item">
      <label>School Status</label>
      <span><?= htmlspecialchars($patient['school_status']) ?></span>
    </div>
    <div class="info-item" style="grid-column:1/-1;">
      <label>Address</label>
      <span><?= htmlspecialchars($patient['address']) ?></span>
    </div>
    <div class="info-item">
      <label>Demographics</label>
      <span>
        <?= $patient['is_ip'] === 'Yes'   ? '<span class="badge badge-ip">IP</span> ' : '' ?>
        <?= $patient['nhts_status'] === 'NHTS' ? '<span class="badge badge-nhts">NHTS</span>' : '' ?>
        <?= ($patient['is_ip'] === 'No' && $patient['nhts_status'] === 'NON-NHTS') ? '—' : '' ?>
      </span>
    </div>
    <div class="info-item">
      <label>Total Visits</label>
      <span><?= count($consults) ?></span>
    </div>
  </div>

  <div class="section-title">Consultation History</div>
  <?php if (empty($consults)): ?>
    <p style="color:#888; font-style:italic;">No consultations recorded.</p>
  <?php else: ?>
  <table>
    <thead>
      <tr><th>Date</th><th>Physician</th><th>Symptoms / Diagnosis</th><th>Treatment</th><th>Remarks</th></tr>
    </thead>
    <tbody>
      <?php foreach ($consults as $c): ?>
      <tr>
        <td style="white-space:nowrap;"><?= htmlspecialchars($c['visit_date']) ?></td>
        <td><?= htmlspecialchars($c['physician'] ?? '—') ?></td>
        <td><?= htmlspecialchars($c['symptoms_diagnosis'] ?? '—') ?></td>
        <td><?= htmlspecialchars(mb_strimwidth($c['treatment'] ?? '—', 0, 80, '…')) ?></td>
        <td><?= htmlspecialchars(mb_strimwidth($c['remarks'] ?? '—', 0, 80, '…')) ?></td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
  <?php endif; ?>

  <?php else: ?>
  <!-- ═══ SUMMARY REPORT ═══ -->
  <h2>Encounter Summary Report</h2>
  <p style="margin-bottom:.8rem; color:#555;">
    Showing <strong><?= count($summaryRows) ?></strong> encounter(s) from
    <strong><?= htmlspecialchars($dateFrom) ?></strong> to
    <strong><?= htmlspecialchars($dateTo) ?></strong>.
  </p>

  <?php if (empty($summaryRows)): ?>
    <p style="color:#888; font-style:italic;">No encounters found for the selected period.</p>
  <?php else: ?>
  <table>
    <thead>
      <tr><th>Date</th><th>Patient</th><th>Age</th><th>Sex</th><th>Address</th><th>Tag</th><th>Symptoms/Diagnosis</th><th>Physician</th></tr>
    </thead>
    <tbody>
      <?php foreach ($summaryRows as $r): ?>
      <tr>
        <td style="white-space:nowrap;"><?= htmlspecialchars($r['visit_date']) ?></td>
        <td><?= htmlspecialchars($r['patient_name']) ?></td>
        <td><?= $r['age'] ?></td>
        <td><?= htmlspecialchars($r['sex']) ?></td>
        <td><?= htmlspecialchars(mb_strimwidth($r['barangay'] ?? '', 0, 20, '...')) ?></td>
        <td>
          <?= $r['is_ip'] === 'Yes'   ? '<span class="badge badge-ip">IP</span> ' : '' ?>
          <?= $r['nhts_status'] === 'NHTS' ? '<span class="badge badge-nhts">4Ps</span>' : '' ?>
        </td>
        <td><?= htmlspecialchars(mb_strimwidth($r['symptoms_diagnosis'] ?? '—',0,40,'…')) ?></td>
        <td><?= htmlspecialchars($r['physician'] ?? '—') ?></td>
      </tr>
      <?php endforeach; ?>
    </tbody>
  </table>
  <?php endif; ?>
  <?php endif; ?>

  <!-- Signature block -->
  <div style="margin-top:2.5rem; display:grid; grid-template-columns:1fr 1fr; gap:2rem;">
    <div style="border-top:1px solid #555; padding-top:.3rem; text-align:center;">
      <small>Prepared by / Signature over Printed Name</small>
    </div>
    <div style="border-top:1px solid #555; padding-top:.3rem; text-align:center;">
      <small>Noted by / Clinic Officer</small>
    </div>
  </div>
</div>

</body>
</html>
