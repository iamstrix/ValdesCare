<?php
/**
 * physicians/manage.php — Add and list physicians
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle = 'Physicians';
$activeNav = 'physicians';

$errors  = [];
$success = '';

// Handle add
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'add') {
    $first   = trim($_POST['first_name'] ?? '');
    $last    = trim($_POST['last_name']  ?? '');
    $spec    = trim($_POST['specialty']  ?? '') ?: null;
    $license = trim($_POST['license_no'] ?? '') ?: null;

    if (!$first) $errors[] = 'First name required.';
    if (!$last)  $errors[] = 'Last name required.';

    if (empty($errors)) {
        $stmt = $pdo->prepare("INSERT INTO physician (first_name,last_name,specialty,license_no) VALUES(?,?,?,?)");
        $stmt->execute([$first,$last,$spec,$license]);
        $success = "Dr. $last, $first added successfully.";
    }
}

// Handle toggle active
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'toggle') {
    $pid = (int)$_POST['pid'];
    $pdo->prepare("UPDATE physician SET is_active = 1 - is_active WHERE physician_id=?")->execute([$pid]);
    header('Location: manage.php'); exit;
}

$physicians = $pdo->query("SELECT * FROM physician ORDER BY last_name, first_name")->fetchAll();

require_once ROOT . '/includes/header.php';
?>

<?php if ($errors): ?>
  <div class="alert alert-error"><?= implode('<br>', array_map('htmlspecialchars', $errors)) ?></div>
<?php endif; ?>
<?php if ($success): ?>
  <div class="alert alert-success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<div class="card">
  <div class="card-title">Add Physician</div>
  <form method="POST">
    <input type="hidden" name="action" value="add">
    <div class="form-grid">
      <div class="form-group">
        <label for="last_name">Last Name *</label>
        <input type="text" name="last_name" id="last_name" maxlength="80" required>
      </div>
      <div class="form-group">
        <label for="first_name">First Name *</label>
        <input type="text" name="first_name" id="first_name" maxlength="80" required>
      </div>
      <div class="form-group">
        <label for="specialty">Specialty</label>
        <input type="text" name="specialty" id="specialty" maxlength="100" placeholder="e.g. Pediatrics">
      </div>
      <div class="form-group">
        <label for="license_no">PRC License No.</label>
        <input type="text" name="license_no" id="license_no" maxlength="30">
      </div>
      <div class="form-actions">
        <button type="submit" class="btn btn-primary">Add Physician</button>
      </div>
    </div>
  </form>
</div>

<div class="card">
  <div class="card-title">Physician Directory</div>
  <?php if (empty($physicians)): ?>
    <p class="text-muted">No physicians recorded yet.</p>
  <?php else: ?>
  <div class="table-wrap">
    <table>
      <thead>
        <tr><th>ID</th><th>Name</th><th>Specialty</th><th>License #</th><th>Status</th><th>Action</th></tr>
      </thead>
      <tbody>
        <?php foreach ($physicians as $ph): ?>
        <tr>
          <td><?= $ph['physician_id'] ?></td>
          <td class="bold">Dr. <?= htmlspecialchars($ph['last_name'].', '.$ph['first_name']) ?></td>
          <td><?= htmlspecialchars($ph['specialty'] ?? '—') ?></td>
          <td><?= htmlspecialchars($ph['license_no'] ?? '—') ?></td>
          <td>
            <span class="badge <?= $ph['is_active'] ? 'badge-green' : 'badge-gray' ?>">
              <?= $ph['is_active'] ? 'Active' : 'Inactive' ?>
            </span>
          </td>
          <td>
            <form method="POST" style="display:inline;">
              <input type="hidden" name="action" value="toggle">
              <input type="hidden" name="pid" value="<?= $ph['physician_id'] ?>">
              <button type="submit" class="btn btn-sm btn-outline">
                <?= $ph['is_active'] ? 'Deactivate' : 'Activate' ?>
              </button>
            </form>
          </td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <?php endif; ?>
</div>

<?php require_once ROOT . '/includes/footer.php'; ?>
