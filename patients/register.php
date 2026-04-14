<?php
/**
 * patients/register.php
 * ---------------------
 * Two-section form:
 *   1. Household (new or existing)
 *   2. Patient demographics
 * Handles GET (display) and POST (INSERT to DB).
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle = 'Register Patient';
$activeNav = 'register';

$errors   = [];
$success  = '';
$formData = $_POST ?? [];

// ── POST handler ────────────────────────────────────────────
if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    // --- Household ---
    $useExisting = !empty($_POST['existing_household_id']);
    $householdId = null;

    if ($useExisting) {
        $householdId = (int)$_POST['existing_household_id'];
        // verify it exists
        $check = $pdo->prepare("SELECT household_id FROM household WHERE household_id=?");
        $check->execute([$householdId]);
        if (!$check->fetch()) {
            $errors[] = 'Selected household does not exist.';
            $householdId = null;
        }
    } else {
        $barangay = trim($_POST['barangay'] ?? '');
        $street   = trim($_POST['street_address'] ?? '');
        $muni     = trim($_POST['municipality'] ?? 'Valdes City');
        $isIp     = isset($_POST['is_ip'])   ? 1 : 0;
        $isNhts   = isset($_POST['is_nhts']) ? 1 : 0;

        if (!$barangay) $errors[] = 'Barangay is required.';
        if (!$street)   $errors[] = 'Street address is required.';

        if (empty($errors)) {
            $stmt = $pdo->prepare(
                "INSERT INTO household (barangay, street_address, municipality, is_ip, is_nhts)
                 VALUES (?, ?, ?, ?, ?)"
            );
            $stmt->execute([$barangay, $street, $muni, $isIp, $isNhts]);
            $householdId = $pdo->lastInsertId();
        }
    }

    // --- Patient ---
    if ($householdId && empty($errors)) {
        $firstName   = trim($_POST['first_name']   ?? '');
        $middleName  = trim($_POST['middle_name']  ?? '') ?: null;
        $lastName    = trim($_POST['last_name']    ?? '');
        $dob         = $_POST['dob']               ?? '';
        $sex         = $_POST['sex']               ?? '';
        $schoolStat  = $_POST['school_status']     ?? 'Not Applicable';
        $philhealth  = trim($_POST['philhealth_no']?? '') ?: null;

        if (!$firstName)  $errors[] = 'First name is required.';
        if (!$lastName)   $errors[] = 'Last name is required.';
        if (!$dob)        $errors[] = 'Date of birth is required.';
        if (!in_array($sex, ['Male','Female','Prefer not to say'])) $errors[] = 'Please select a valid sex.';

        if (empty($errors)) {
            $stmt = $pdo->prepare(
                "INSERT INTO patient
                   (household_id, first_name, middle_name, last_name, dob, sex, school_status, philhealth_no)
                 VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
            );
            $stmt->execute([$householdId, $firstName, $middleName, $lastName, $dob, $sex, $schoolStat, $philhealth]);
            $newId = $pdo->lastInsertId();
            $success = "Patient registered successfully! ID: <strong>#$newId</strong> &mdash; <a href='view.php?id=$newId'>View record</a>.";
            $formData = []; // clear form
        }
    }
}

// Fetch existing households for the dropdown
$households = $pdo->query(
    "SELECT household_id,
            CONCAT('#', household_id, ' — ', street_address, ', ', barangay) AS label
     FROM household ORDER BY household_id DESC LIMIT 200"
)->fetchAll();

require_once ROOT . '/includes/header.php';
?>

<?php if ($errors): ?>
  <div class="alert alert-error">
    <strong>Please fix the following:</strong><br>
    <?= implode('<br>', array_map('htmlspecialchars', $errors)) ?>
  </div>
<?php endif; ?>

<?php if ($success): ?>
  <div class="alert alert-success"><?= $success ?></div>
<?php endif; ?>

<form method="POST" action="">
  <!-- ═══ SECTION 1 — HOUSEHOLD ═══ -->
  <div class="card">
    <div class="card-title">1. Household Information</div>

    <div class="form-grid">
      <!-- Toggle: existing vs new -->
      <div class="form-group" style="grid-column:1/-1;">
        <label>Household</label>
        <div class="flex gap-4" style="flex-wrap:wrap; align-items:center;">
          <label class="form-check" style="font-weight:normal;font-size:.9rem;">
            <input type="radio" name="household_mode" value="new" id="hh-new"
              <?= empty($formData['existing_household_id']) ? 'checked' : '' ?>> Create new household
          </label>
          <label class="form-check" style="font-weight:normal;font-size:.9rem;">
            <input type="radio" name="household_mode" value="existing" id="hh-existing"
              <?= !empty($formData['existing_household_id']) ? 'checked' : '' ?>> Link to existing household
          </label>
        </div>
      </div>

      <!-- Existing household selector -->
      <div class="form-group" id="existing-hh-wrap" style="display:none; grid-column:1/-1;">
        <label for="existing_household_id">Existing Household</label>
        <select name="existing_household_id" id="existing_household_id">
          <option value="">— Select household —</option>
          <?php foreach ($households as $hh): ?>
            <option value="<?= $hh['household_id'] ?>"
              <?= (($formData['existing_household_id'] ?? '') == $hh['household_id']) ? 'selected' : '' ?>>
              <?= htmlspecialchars($hh['label']) ?>
            </option>
          <?php endforeach; ?>
        </select>
      </div>

      <!-- New household fields -->
      <div id="new-hh-wrap" style="display:contents;">
        <div class="form-group">
          <label for="barangay">Barangay *</label>
          <input type="text" name="barangay" id="barangay" maxlength="100"
                 value="<?= htmlspecialchars($formData['barangay'] ?? '') ?>" required>
        </div>
        <div class="form-group">
          <label for="street_address">Street / Purok *</label>
          <input type="text" name="street_address" id="street_address" maxlength="255"
                 value="<?= htmlspecialchars($formData['street_address'] ?? '') ?>" required>
        </div>
        <div class="form-group">
          <label for="municipality">Municipality</label>
          <input type="text" name="municipality" id="municipality" maxlength="100"
                 value="<?= htmlspecialchars($formData['municipality'] ?? 'Valdes City') ?>">
        </div>
        <div class="form-group" style="justify-content:flex-end; gap:.7rem; flex-direction:row; align-items:center; flex-wrap:wrap;">
          <label class="form-check">
            <input type="checkbox" name="is_ip" id="is_ip"
              <?= !empty($formData['is_ip']) ? 'checked' : '' ?>>
            Indigenous People (IP)
          </label>
          <label class="form-check">
            <input type="checkbox" name="is_nhts" id="is_nhts"
              <?= !empty($formData['is_nhts']) ? 'checked' : '' ?>>
            NHTS
          </label>
        </div>
      </div>
    </div>
  </div>

  <!-- ═══ SECTION 2 — PATIENT ═══ -->
  <div class="card">
    <div class="card-title">2. Patient Demographics</div>

    <div class="form-grid">
      <div class="form-group">
        <label for="last_name">Last Name *</label>
        <input type="text" name="last_name" id="last_name" maxlength="80"
               value="<?= htmlspecialchars($formData['last_name'] ?? '') ?>" required>
      </div>
      <div class="form-group">
        <label for="first_name">First Name *</label>
        <input type="text" name="first_name" id="first_name" maxlength="80"
               value="<?= htmlspecialchars($formData['first_name'] ?? '') ?>" required>
      </div>
      <div class="form-group">
        <label for="middle_name">Middle Name</label>
        <input type="text" name="middle_name" id="middle_name" maxlength="80"
               value="<?= htmlspecialchars($formData['middle_name'] ?? '') ?>">
      </div>
      <div class="form-group">
        <label for="dob">Date of Birth *</label>
        <input type="date" name="dob" id="dob"
               max="<?= date('Y-m-d') ?>"
               value="<?= htmlspecialchars($formData['dob'] ?? '') ?>" required>
      </div>
      <div class="form-group">
        <label for="sex">Sex *</label>
        <select name="sex" id="sex" required>
          <option value="">— Select —</option>
          <?php foreach (['Male','Female','Prefer not to say'] as $s): ?>
            <option value="<?= $s ?>" <?= (($formData['sex'] ?? '') === $s) ? 'selected' : '' ?>><?= $s ?></option>
          <?php endforeach; ?>
        </select>
      </div>
      <div class="form-group">
        <label for="school_status">School Status</label>
        <select name="school_status" id="school_status">
          <?php foreach (['Not Applicable','Enrolled','Out of School'] as $ss): ?>
            <option value="<?= $ss ?>" <?= (($formData['school_status'] ?? 'Not Applicable') === $ss) ? 'selected' : '' ?>><?= $ss ?></option>
          <?php endforeach; ?>
        </select>
      </div>
      <div class="form-group">
        <label for="philhealth_no">PhilHealth No.</label>
        <input type="text" name="philhealth_no" id="philhealth_no" maxlength="20"
               placeholder="00-000000000-0"
               value="<?= htmlspecialchars($formData['philhealth_no'] ?? '') ?>">
      </div>

      <div class="form-actions">
        <button type="submit" class="btn btn-primary">&#128190; Save Patient</button>
        <a href="list.php" class="btn btn-outline">Cancel</a>
      </div>
    </div>
  </div>
</form>

<script>
// Toggle household mode
const radios   = document.querySelectorAll('input[name="household_mode"]');
const newWrap  = document.getElementById('new-hh-wrap');
const exisWrap = document.getElementById('existing-hh-wrap');
const exisSel  = document.getElementById('existing_household_id');
const newInputs = document.querySelectorAll('#new-hh-wrap input, #new-hh-wrap select');

function applyMode() {
  const mode = document.querySelector('input[name="household_mode"]:checked').value;
  if (mode === 'existing') {
    exisWrap.style.display = 'block';
    newWrap.style.display  = 'none';
    exisSel.setAttribute('required', '');
    newInputs.forEach(el => el.removeAttribute('required'));
  } else {
    exisWrap.style.display = 'none';
    newWrap.style.display  = 'contents';
    exisSel.removeAttribute('required');
    document.getElementById('barangay').setAttribute('required','');
    document.getElementById('street_address').setAttribute('required','');
  }
}

radios.forEach(r => r.addEventListener('change', applyMode));
applyMode();
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
