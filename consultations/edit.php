<?php
/**
 * consultations/edit.php
 * ---------------------
 * Edit Consultation Form
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle    = 'Edit Encounter';
$activeNav    = 'consultations';

$id = (int)($_GET['id'] ?? 0);
if (!$id) {
    die("Invalid consultation ID.");
}

$errors       = [];
$success      = '';

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
            "UPDATE consultation SET
               patient_id = ?, physician_id = ?, visit_date = ?, chief_complaint = ?, complaint_details = ?, diagnosis = ?, treatment = ?, remarks = ?
             WHERE consultation_id = ?"
        );
        $stmt->execute([
            $patId, $physId, $visitDate, $chiefComplaint, $complaintDetails, $diagnosis, $treatment, $remarks, $id
        ]);
        $success = "Encounter updated successfully! <a href='view.php?id=$id'>View encounter #$id</a>";
    }
}

$stmt = $pdo->prepare("SELECT * FROM consultation WHERE consultation_id = ?");
$stmt->execute([$id]);
$formData = $stmt->fetch();

if (!$formData) {
    die("Consultation not found.");
}

// Override with POST data if form was submitted but had errors
if ($_SERVER['REQUEST_METHOD'] === 'POST' && !empty($errors)) {
    $formData = array_merge($formData, $_POST);
}

// Lookup data
$patients   = $pdo->query("SELECT patient_id, CONCAT(last_name, ', ', first_name) AS name FROM patient ORDER BY last_name, first_name")->fetchAll();
$physicians = $pdo->query("SELECT physician_id, CONCAT(last_name,', ',first_name,' — ',IFNULL(specialty,'General')) AS name FROM physician WHERE is_active=1 ORDER BY last_name")->fetchAll();

require_once ROOT . '/includes/header.php';
?>

<?php if ($errors): ?>
  <div class="alert alert-error"><?= implode('<br>', array_map('htmlspecialchars', $errors)) ?></div>
<?php endif; ?>
<?php if ($success): ?>
  <div class="alert alert-success"><?= $success ?></div>
<?php endif; ?>

<!-- Page Header -->
<div class="page-header">
  <div class="page-header-title">
    <h1>Edit Clinical Encounter</h1>
    <p class="text-muted">Update consultation or treatment plan.</p>
  </div>
  <div class="page-header-actions no-print">
    <a href="list.php" class="btn btn-back-hub">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
      Back to List
    </a>
  </div>
</div>

<form method="POST" action="">
  <!-- SECTION: Encounter Info -->
  <div class="card">
    <div class="card-title">Encounter Information</div>
    <div class="form-grid">
      <!-- ── SECTION: ADMINISTRATIVE ── -->
      <div class="form-section">Administrative Details</div>

      <div class="form-group" style="grid-column: span 2; position: relative;">
        <label for="patient_search">Patient *</label>
        <?php
          $currentPatientName = '';
          $currentPatientId = (int)($formData['patient_id'] ?? 0);
          foreach ($patients as $p) {
              if ((int)$p['patient_id'] === $currentPatientId) {
                  $currentPatientName = $p['name'];
                  break;
              }
          }
        ?>
        <input type="text" id="patient_search" autocomplete="off" required
               placeholder="— Search and select patient —"
               value="<?= htmlspecialchars($currentPatientName) ?>"
               style="width: 100%; box-sizing: border-box;">
        <input type="hidden" name="patient_id" id="patient_id" value="<?= $currentPatientId ?: '' ?>" required>
        
        <div id="patient_dropdown" style="display: none; position: absolute; top: 100%; left: 0; right: 0; background: #fff; border: 1px solid #ccc; max-height: 200px; overflow-y: auto; z-index: 1000; box-shadow: 0 4px 6px rgba(0,0,0,0.1); border-radius: 4px; margin-top: 4px;"></div>
      </div>

      <div class="form-group">
        <label for="visit_date">Visit Date *</label>
        <input type="date" name="visit_date" id="visit_date"
               value="<?= htmlspecialchars($formData['visit_date'] ?? date('Y-m-d')) ?>" 
               max="<?= date('Y-m-d') ?>" required>
      </div>

      <div class="form-group">
        <label for="physician_id">Attending Physician</label>
        <select name="physician_id" id="physician_id">
          <option value="">— Unassigned —</option>
          <?php foreach ($physicians as $ph): ?>
            <option value="<?= $ph['physician_id'] ?>"
              <?= (($formData['physician_id'] ?? '') == $ph['physician_id']) ? 'selected' : '' ?>>
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
               placeholder="e.g. Fever, Cough, Headache" value="<?= htmlspecialchars($formData['chief_complaint'] ?? '') ?>">
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
               placeholder="e.g. Acute Respiratory Infection, Hypertension" value="<?= htmlspecialchars($formData['diagnosis'] ?? '') ?>">
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
                  placeholder="Additional symptoms, duration, etc."><?= htmlspecialchars($formData['complaint_details'] ?? '') ?></textarea>
      </div>

      <!-- ── SECTION: TREATMENT ── -->
      <div class="form-section">Treatment Plan & Remarks</div>
      
      <div class="form-group" style="grid-column: span 2;">
        <label for="treatment">Prescribed Treatment / Medication</label>
        <textarea name="treatment" id="treatment" rows="3" placeholder="Dosage, instructions, etc."><?= htmlspecialchars($formData['treatment'] ?? '') ?></textarea>
      </div>
      
      <div class="form-group" style="grid-column: span 2;">
        <label for="remarks">Follow-up / Other Remarks</label>
        <textarea name="remarks" id="remarks" rows="2"><?= htmlspecialchars($formData['remarks'] ?? '') ?></textarea>
      </div>

      <div class="form-actions">
        <button type="submit" class="btn btn-primary">Update Encounter Record</button>
        <a href="list.php" class="btn btn-outline">Cancel</a>
      </div>
    </div>
  </div>
</form>

<script>
const patientsData = <?= json_encode($patients) ?>;
const searchInput = document.getElementById('patient_search');
const hiddenId = document.getElementById('patient_id');
const dropdown = document.getElementById('patient_dropdown');

function renderOptions(filterText = '') {
    dropdown.innerHTML = '';
    const lowerFilter = filterText.toLowerCase();
    
    // Filter patients
    const filtered = patientsData.filter(p => p.name.toLowerCase().includes(lowerFilter));
    
    if (filtered.length === 0) {
        const noMatch = document.createElement('div');
        noMatch.textContent = 'No matching patients found';
        noMatch.style.padding = '8px 12px';
        noMatch.style.color = '#777';
        dropdown.appendChild(noMatch);
        return;
    }

    filtered.forEach(p => {
        const div = document.createElement('div');
        div.textContent = p.name;
        div.style.padding = '8px 12px';
        div.style.cursor = 'pointer';
        div.style.borderBottom = '1px solid #eee';
        
        div.addEventListener('mouseover', () => div.style.background = '#f0f4f8');
        div.addEventListener('mouseout', () => div.style.background = '#fff');
        
        div.addEventListener('mousedown', (e) => {
            e.preventDefault(); // Prevent input blur from firing before this
            searchInput.value = p.name;
            hiddenId.value = p.patient_id;
            dropdown.style.display = 'none';
        });
        
        dropdown.appendChild(div);
    });
}

searchInput.addEventListener('focus', () => {
    renderOptions(searchInput.value);
    dropdown.style.display = 'block';
});

searchInput.addEventListener('input', () => {
    hiddenId.value = ''; // clear hidden id when typing
    renderOptions(searchInput.value);
    dropdown.style.display = 'block';
});

searchInput.addEventListener('blur', () => {
    dropdown.style.display = 'none';
    // If hidden input is empty, clear the search field to enforce valid selection
    if (!hiddenId.value) {
        searchInput.value = '';
    }
});
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
