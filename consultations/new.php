<?php
/**
 * consultations/new.php
 * ---------------------
 * New Consultation Form
 * Merged fields strictly match the Patient Information Record Table format.
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle    = 'New Encounter';
$activeNav    = 'consult-new';

$errors       = [];
$success      = '';
$prefillPat   = (int)($_GET['patient_id'] ?? 0);

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $patId      = (int)($_POST['patient_id']   ?? 0);
    $physId     = ($_POST['physician_id'] !== '') ? (int)$_POST['physician_id'] : null;
    $visitDate  = $_POST['visit_date']           ?? date('Y-m-d');
    
    $nullify = fn($v) => ($v === '' ? null : $v);
    
    // Clinical
    $chiefComplaint   = $nullify(trim($_POST['chief_complaint'] ?? ''));
    $complaintDetails = $nullify(trim($_POST['complaint_details'] ?? ''));
    $diagnosis        = $nullify(trim($_POST['diagnosis'] ?? ''));
    $treatment         = $nullify(trim($_POST['treatment']  ?? ''));
    $remarks           = $nullify(trim($_POST['remarks']    ?? ''));

    if (!$patId)    $errors[] = 'Please select a patient.';
    if (!$chiefComplaint) $errors[] = 'Chief Complaint is required.';
    if (!$diagnosis) $errors[] = 'Diagnosis is required.';
    
    if ($visitDate > date('Y-m-d')) {
        $errors[] = 'Encounter date cannot be in the future.';
    }

    if (empty($errors)) {
        $stmt = $pdo->prepare(
            "INSERT INTO consultation
               (patient_id, physician_id, visit_date, chief_complaint, complaint_details, diagnosis, treatment, remarks)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
        );
        $stmt->execute([
            $patId, $physId, $visitDate, $chiefComplaint, $complaintDetails, $diagnosis, $treatment, $remarks
        ]);
        $newId = $pdo->lastInsertId();
        $success = "Encounter saved! <a href='view.php?id=$newId'>View encounter #$newId</a> · <a href='new.php'>New encounter</a>";
    }
}

// Lookup data
$patients   = $pdo->query("SELECT patient_id, patient_name AS name FROM patient ORDER BY patient_name")->fetchAll();
$physicians = $pdo->query("SELECT physician_id, CONCAT(last_name,', ',first_name,' — ',IFNULL(specialty,'General')) AS name FROM physician WHERE is_active=1 ORDER BY last_name")->fetchAll();

require_once ROOT . '/includes/header.php';
?>

<?php if ($errors): ?>
  <div class="alert alert-error"><?= implode('<br>', array_map('htmlspecialchars', $errors)) ?></div>
<?php endif; ?>
<?php if ($success): ?>
  <div class="alert alert-success"><?= $success ?></div>
<?php endif; ?>

<div style="margin-bottom: 1.2rem;" class="no-print">
  <a href="../index.php" class="btn btn-sm btn-outline">
    <svg width="16" height="16" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
    Back to Dashboard
  </a>
</div>

<form method="POST" action="">
  <!-- SECTION: Encounter Info -->
  <div class="card">
    <div class="card-title">Encounter Information</div>
    <div class="form-grid">
      <!-- ── SECTION: ADMINISTRATIVE ── -->
      <div class="form-section">Administrative Details</div>

      <div class="form-group" style="grid-column: span 2;">
        <label for="patient_id">Patient *</label>
        <select name="patient_id" id="patient_id" required>
          <option value="">— Select patient —</option>
          <?php foreach ($patients as $p): ?>
            <option value="<?= $p['patient_id'] ?>"
              <?= ((int)($_POST['patient_id'] ?? $prefillPat) === (int)$p['patient_id']) ? 'selected' : '' ?>>
              #<?= $p['patient_id'] ?> — <?= htmlspecialchars($p['name']) ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <div class="form-group">
        <label for="visit_date">Visit Date *</label>
        <input type="date" name="visit_date" id="visit_date"
               value="<?= htmlspecialchars($_POST['visit_date'] ?? date('Y-m-d')) ?>" 
               max="<?= date('Y-m-d') ?>" required>
      </div>

      <div class="form-group">
        <label for="physician_id">Attending Physician</label>
        <select name="physician_id" id="physician_id">
          <option value="">— Unassigned —</option>
          <?php foreach ($physicians as $ph): ?>
            <option value="<?= $ph['physician_id'] ?>"
              <?= (($_POST['physician_id'] ?? '') == $ph['physician_id']) ? 'selected' : '' ?>>
              <?= htmlspecialchars($ph['name']) ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <!-- ── SECTION: CLINICAL ── -->
      <div class="form-section">Clinical Assessment</div>

      <div class="form-group" style="grid-column: span 2;">
        <label for="chief_complaint">Chief Complaint *</label>
        <input type="text" name="chief_complaint" id="chief_complaint" list="complaint_tags" required
               placeholder="e.g. Fever, Cough, Headache" value="<?= htmlspecialchars($_POST['chief_complaint'] ?? '') ?>">
        <datalist id="complaint_tags">
          <option value="Fever">
          <option value="Cough">
          <option value="Headache">
          <option value="Stomach ache">
          <option value="Body pain">
          <option value="Dizziness">
          <option value="Skin Rash">
        </datalist>
      </div>

      <div class="form-group" style="grid-column: span 2;">
        <label for="diagnosis">Initial Diagnosis *</label>
        <input type="text" name="diagnosis" id="diagnosis" list="diagnosis_tags" required
               placeholder="e.g. Acute Respiratory Infection, Hypertension" value="<?= htmlspecialchars($_POST['diagnosis'] ?? '') ?>">
        <datalist id="diagnosis_tags">
          <option value="Acute Respiratory Infection">
          <option value="Hypertension">
          <option value="Common Cold">
          <option value="Acid Reflux (GERD)">
          <option value="Skin Infection (Tinea)">
          <option value="Type 2 Diabetes">
          <option value="Allergic Rhinitis">
        </datalist>
      </div>

      <div class="form-group" style="grid-column: span 2;">
        <label for="complaint_details">Clinical Observations / Details</label>
        <textarea name="complaint_details" id="complaint_details" rows="2"
                  placeholder="Additional symptoms, duration, etc."><?= htmlspecialchars($_POST['complaint_details'] ?? '') ?></textarea>
      </div>

      <!-- ── SECTION: TREATMENT ── -->
      <div class="form-section">Treatment Plan & Remarks</div>
      
      <div class="form-group" style="grid-column: span 2;">
        <label for="treatment">Prescribed Treatment / Medication</label>
        <textarea name="treatment" id="treatment" rows="3" placeholder="Dosage, instructions, etc."><?= htmlspecialchars($_POST['treatment'] ?? '') ?></textarea>
      </div>
      
      <div class="form-group" style="grid-column: span 2;">
        <label for="remarks">Follow-up / Other Remarks</label>
        <textarea name="remarks" id="remarks" rows="2"><?= htmlspecialchars($_POST['remarks'] ?? '') ?></textarea>
      </div>

      <div class="form-actions">
        <button type="submit" class="btn btn-primary">Save Encounter Record</button>
        <a href="../patients/list.php" class="btn btn-outline">Cancel</a>
      </div>
    </div>
  </div>
</form>

<?php require_once ROOT . '/includes/footer.php'; ?>
