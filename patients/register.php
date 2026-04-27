<?php
/**
 * patients/register.php
 * ---------------------
 * Patient Registration Form (Single Page)
 * Strictly adheres to the PATIENT INFORMATION RECORD layout
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle = 'Register Patient';
$activeNav = 'register';

$errors   = [];
$success  = '';
$formData = $_POST ?? [];

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $householdNo        = trim($_POST['household_no'] ?? '');
    $patientName        = trim($_POST['patient_name'] ?? '');
    $dob                = $_POST['dob'] ?? '';
    $ageGroup           = $_POST['age_group'] ?? 'Adult';
    $sex                = $_POST['sex'] ?? '';
    $address            = trim($_POST['address'] ?? '');
    $mobileNo           = trim($_POST['mobile_no'] ?? '');
    $mothersMaidenName  = trim($_POST['mothers_maiden_name'] ?? '') ?: null;
    $relationship       = trim($_POST['relationship_to_head'] ?? '');
    $isIp               = $_POST['is_ip'] ?? 'No';
    $nhtsStatus         = $_POST['nhts_status'] ?? 'NON-NHTS';
    $isPhilhealth       = $_POST['is_philhealth_member'] ?? 'No';
    $philhealthNo       = trim($_POST['philhealth_no'] ?? '') ?: null;
    $philhealthCat      = trim($_POST['philhealth_category'] ?? '') ?: null;
    $schoolStatus       = $_POST['school_status'] ?? 'Not in School';

    if (!$householdNo) $errors[] = 'Household number is required.';
    if (!$patientName) $errors[] = 'Patient Name is required.';
    if (!$dob) $errors[] = 'Date of birth is required.';
    if (!in_array($sex, ['Male','Female'])) $errors[] = 'Please select a valid sex.';
    if (!$address) $errors[] = 'Address is required.';
    if (!$mobileNo) $errors[] = 'Mobile number is required.';
    if (!$relationship) $errors[] = 'Relationship to Household Head is required.';
    
    if ($dob > date('Y-m-d')) {
        $errors[] = 'Date of birth cannot be in the future.';
    }

    if (empty($errors)) {
        $stmt = $pdo->prepare(
            "INSERT INTO patient
               (household_no, patient_name, dob, age_group, sex, address, mobile_no, mothers_maiden_name, relationship_to_head, is_ip, nhts_status, is_philhealth_member, philhealth_no, philhealth_category, school_status)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        $stmt->execute([
            $householdNo, $patientName, $dob, $ageGroup, $sex, $address, $mobileNo, $mothersMaidenName, $relationship, $isIp, $nhtsStatus, $isPhilhealth, $philhealthNo, $philhealthCat, $schoolStatus
        ]);
        $newId = $pdo->lastInsertId();
        $success = "Patient registered successfully! ID: <strong>#$newId</strong> &mdash; <a href='view.php?id=$newId'>View record</a>.";
        $formData = []; // clear form
    }
}

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
  <div class="card">
    <div class="card-title">PATIENT INFORMATION RECORD</div>

    <div class="form-grid">
      <div class="form-group">
        <label for="household_no">Household no.</label>
        <input type="text" name="household_no" id="household_no" maxlength="50"
               value="<?= htmlspecialchars($formData['household_no'] ?? '') ?>" required>
      </div>
      <div class="form-group">
        <label for="dob">Date of Birth</label>
        <input type="date" name="dob" id="dob" max="<?= date('Y-m-d') ?>"
               value="<?= htmlspecialchars($formData['dob'] ?? '') ?>" required>
      </div>
      
      <div class="form-group">
        <label>Category (Age Group)</label>
        <div class="flex gap-4">
          <label class="form-check">
            <input type="radio" name="age_group" value="Pediatric" <?= (($formData['age_group'] ?? '') === 'Pediatric') ? 'checked' : '' ?> required> Pediatric
          </label>
          <label class="form-check">
            <input type="radio" name="age_group" value="Adult" <?= (($formData['age_group'] ?? 'Adult') === 'Adult') ? 'checked' : '' ?> required> Adult
          </label>
          <label class="form-check">
            <input type="radio" name="age_group" value="Geriatric" <?= (($formData['age_group'] ?? '') === 'Geriatric') ? 'checked' : '' ?> required> Geriatric
          </label>
        </div>
      </div>
      
      <div class="form-group">
        <label for="patient_name">Patient Name</label>
        <input type="text" name="patient_name" id="patient_name" maxlength="150"
               value="<?= htmlspecialchars($formData['patient_name'] ?? '') ?>" required>
      </div>
      <div class="form-group">
        <label>Sex</label>
        <div class="flex gap-4">
          <label class="form-check">
            <input type="radio" name="sex" value="Male" <?= (($formData['sex'] ?? '') === 'Male') ? 'checked' : '' ?> required> Male
          </label>
          <label class="form-check">
            <input type="radio" name="sex" value="Female" <?= (($formData['sex'] ?? '') === 'Female') ? 'checked' : '' ?> required> Female
          </label>
        </div>
      </div>

      <div class="form-group">
        <label for="address">Address</label>
        <input type="text" name="address" id="address" maxlength="255"
               value="<?= htmlspecialchars($formData['address'] ?? '') ?>" required>
      </div>
      <div class="form-group">
        <label for="mobile_no">Mobile no.</label>
        <input type="text" name="mobile_no" id="mobile_no" maxlength="50"
               value="<?= htmlspecialchars($formData['mobile_no'] ?? '') ?>" required>
      </div>

      <div class="form-group">
        <label for="mothers_maiden_name">Mother's Maiden Name (Optional)</label>
        <input type="text" name="mothers_maiden_name" id="mothers_maiden_name" maxlength="150"
               value="<?= htmlspecialchars($formData['mothers_maiden_name'] ?? '') ?>">
      </div>
      <div class="form-group">
        <label for="relationship_to_head">Relationship to Household Head</label>
        <input type="text" name="relationship_to_head" id="relationship_to_head" maxlength="50"
               value="<?= htmlspecialchars($formData['relationship_to_head'] ?? '') ?>" required>
      </div>

      <div class="form-group">
        <label>Indigenous People (IP) Household</label>
        <div class="flex gap-4">
          <label class="form-check">
            <input type="radio" name="is_ip" value="Yes" <?= (($formData['is_ip'] ?? '') === 'Yes') ? 'checked' : '' ?>> Yes
          </label>
          <label class="form-check">
            <input type="radio" name="is_ip" value="No" <?= (($formData['is_ip'] ?? 'No') === 'No') ? 'checked' : '' ?>> No
          </label>
        </div>
      </div>
      
      <div class="form-group">
        <label>National Household Targeting System (NHTS) Household</label>
        <div class="flex gap-4">
          <label class="form-check">
            <input type="radio" name="nhts_status" value="NHTS" <?= (($formData['nhts_status'] ?? '') === 'NHTS') ? 'checked' : '' ?>> NHTS
          </label>
          <label class="form-check">
            <input type="radio" name="nhts_status" value="NON-NHTS" <?= (($formData['nhts_status'] ?? 'NON-NHTS') === 'NON-NHTS') ? 'checked' : '' ?>> NON-NHTS
          </label>
        </div>
      </div>

      <div class="form-group" style="grid-column: 1 / -1;">
        <label>Philhealth Member</label>
        <div class="flex gap-4" style="align-items: center; flex-wrap: wrap;">
          <label class="form-check">
            <input type="radio" name="is_philhealth_member" value="Yes" <?= (($formData['is_philhealth_member'] ?? '') === 'Yes') ? 'checked' : '' ?>> Yes
          </label>
          <label class="form-check">
            <input type="radio" name="is_philhealth_member" value="No" <?= (($formData['is_philhealth_member'] ?? 'No') === 'No') ? 'checked' : '' ?>> No
          </label>
          
          <div style="margin-left: 1rem; display: flex; gap: 1rem; align-items: center;">
            <label for="philhealth_no">Philhealth No.:</label>
            <input type="text" name="philhealth_no" id="philhealth_no" maxlength="50" style="width: 150px;"
                   value="<?= htmlspecialchars($formData['philhealth_no'] ?? '') ?>">
            
            <label for="philhealth_category">Category:</label>
            <input type="text" name="philhealth_category" id="philhealth_category" maxlength="100" style="width: 150px;"
                   value="<?= htmlspecialchars($formData['philhealth_category'] ?? '') ?>">
          </div>
        </div>
      </div>

      <div class="form-group" style="grid-column: 1 / -1;">
        <label>School Status (for Ages 19 and below)</label>
        <div class="flex gap-4">
          <label class="form-check">
            <input type="radio" name="school_status" value="In-School" <?= (($formData['school_status'] ?? '') === 'In-School') ? 'checked' : '' ?>> In-School
          </label>
          <label class="form-check">
            <input type="radio" name="school_status" value="Out of School Youth" <?= (($formData['school_status'] ?? '') === 'Out of School Youth') ? 'checked' : '' ?>> Out of School Youth
          </label>
          <label class="form-check">
            <input type="radio" name="school_status" value="Not in School" <?= (($formData['school_status'] ?? 'Not in School') === 'Not in School') ? 'checked' : '' ?>> Not in School
          </label>
        </div>
      </div>

      <div class="form-actions" style="margin-top: 1.5rem; grid-column: 1 / -1;">
        <button type="submit" class="btn btn-primary">Save Patient</button>
        <a href="list.php" class="btn btn-outline">Cancel</a>
      </div>
    </div>
  </div>
</form>

<?php require_once ROOT . '/includes/footer.php'; ?>
