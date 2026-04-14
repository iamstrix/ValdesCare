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
    $symptomsDiagnosis = $nullify(trim($_POST['symptoms_diagnosis'] ?? ''));
    $treatment         = $nullify(trim($_POST['treatment']  ?? ''));
    $remarks           = $nullify(trim($_POST['remarks']    ?? ''));

    if (!$patId)    $errors[] = 'Please select a patient.';
    if (!$symptomsDiagnosis) $errors[] = 'Symptoms/Diagnosis is required.';

    if (empty($errors)) {
        $stmt = $pdo->prepare(
            "INSERT INTO consultation
               (patient_id, physician_id, visit_date, symptoms_diagnosis, treatment, remarks)
             VALUES (?, ?, ?, ?, ?, ?)"
        );
        $stmt->execute([
            $patId, $physId, $visitDate, $symptomsDiagnosis, $treatment, $remarks
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

<form method="POST" action="">
  <!-- SECTION: Encounter Info -->
  <div class="card">
    <div class="card-title">Encounter Information</div>
    <div class="form-grid">
      <div class="form-group" style="grid-column: 1 / -1;">
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
        <label for="visit_date">Date *</label>
        <input type="date" name="visit_date" id="visit_date"
               value="<?= htmlspecialchars($_POST['visit_date'] ?? date('Y-m-d')) ?>" required>
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

      <!-- SECTION: Clinical Details -->
      <div class="form-group" style="grid-column:1/-1;">
        <label for="symptoms_diagnosis">Symptoms / Diagnosis *</label>
        <textarea name="symptoms_diagnosis" id="symptoms_diagnosis" rows="3" required
                  placeholder="e.g. Fever for 3 days, Acute Gastroenteritis"><?= htmlspecialchars($_POST['symptoms_diagnosis'] ?? '') ?></textarea>
      </div>
      
      <div class="form-group" style="grid-column:1/-1;">
        <label for="treatment">Treatment</label>
        <textarea name="treatment" id="treatment" rows="3"><?= htmlspecialchars($_POST['treatment'] ?? '') ?></textarea>
      </div>
      
      <div class="form-group" style="grid-column:1/-1;">
        <label for="remarks">Remarks</label>
        <textarea name="remarks" id="remarks" rows="2"><?= htmlspecialchars($_POST['remarks'] ?? '') ?></textarea>
      </div>

      <div class="form-actions" style="grid-column:1/-1;">
        <button type="submit" class="btn btn-primary">&#128190; Save Encounter</button>
        <a href="../patients/list.php" class="btn btn-outline">Cancel</a>
      </div>
    </div>
  </div>
</form>

<?php require_once ROOT . '/includes/footer.php'; ?>
