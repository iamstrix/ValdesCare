<?php
/**
 * settings/index.php — System Settings
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle = 'System Settings';
$activeNav = 'settings';

$success = '';
$errors = [];

// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $clinicOpen = $_POST['clinic_open'] ?? '08:30';
    $clinicClose = $_POST['clinic_close'] ?? '12:00';

    if (!$clinicOpen || !$clinicClose) {
        $errors[] = "Both opening and closing times are required.";
    } else {
        $stmt = $pdo->prepare("INSERT INTO settings (setting_key, setting_value) VALUES ('clinic_open', ?), ('clinic_close', ?) ON DUPLICATE KEY UPDATE setting_value = VALUES(setting_value)");
        
        $pdo->prepare("UPDATE settings SET setting_value = ? WHERE setting_key = 'clinic_open'")->execute([$clinicOpen]);
        $pdo->prepare("UPDATE settings SET setting_value = ? WHERE setting_key = 'clinic_close'")->execute([$clinicClose]);
        
        $success = "Settings updated successfully.";
    }
}

// Fetch current settings
$settingsRaw = $pdo->query("SELECT setting_key, setting_value FROM settings")->fetchAll(PDO::FETCH_KEY_PAIR);
$clinicOpen = $settingsRaw['clinic_open'] ?? '08:30';
$clinicClose = $settingsRaw['clinic_close'] ?? '12:00';

require_once ROOT . '/includes/header.php';
?>

<div class="page-header">
  <div class="page-header-title">
    <h1>System Settings</h1>
    <p class="text-muted">Configure clinic operating hours and system-wide preferences.</p>
  </div>
</div>

<?php if ($success): ?>
  <div class="alert alert-success"><?= $success ?></div>
<?php endif; ?>

<?php if ($errors): ?>
  <div class="alert alert-error"><?= implode('<br>', $errors) ?></div>
<?php endif; ?>

<form method="POST" action="">
  <div class="card" style="max-width: 600px;">
    <div class="card-title">Clinic Operating Hours</div>
    <p class="text-muted" style="margin-bottom: 1.5rem;">These hours define the temporal scaling on the analytics dashboard (Today filter) with a 30-minute buffer.</p>
    
    <div class="form-grid" style="grid-template-columns: 1fr 1fr;">
      <div class="form-group">
        <label for="clinic_open">Clinic Opening Time</label>
        <input type="time" name="clinic_open" id="clinic_open" value="<?= htmlspecialchars($clinicOpen) ?>" required>
      </div>
      <div class="form-group">
        <label for="clinic_close">Clinic Closing Time</label>
        <input type="time" name="clinic_close" id="clinic_close" value="<?= htmlspecialchars($clinicClose) ?>" required>
      </div>
    </div>

    <div class="form-actions">
      <button type="submit" class="btn btn-primary">Save Settings</button>
    </div>
  </div>
</form>

<?php require_once ROOT . '/includes/footer.php'; ?>
