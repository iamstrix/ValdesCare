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
        // Check for existing physician (including deleted ones) to prevent duplicates and "ghost" records
        $check = $pdo->prepare("SELECT physician_id, is_deleted FROM physician WHERE first_name = ? AND last_name = ?");
        $check->execute([$first, $last]);
        $existing = $check->fetch();

        if ($existing) {
            if ($existing['is_deleted']) {
                // Restore the old record instead of creating a new ID
                $stmt = $pdo->prepare("UPDATE physician SET is_deleted = 0, specialty = ?, license_no = ?, is_active = 1 WHERE physician_id = ?");
                $stmt->execute([$spec, $license, $existing['physician_id']]);
                $success = "Dr. $last, $first was previously in the system and has been restored.";
            } else {
                $errors[] = "A physician with the name Dr. $last, $first already exists in the directory.";
            }
        } else {
            $stmt = $pdo->prepare("INSERT INTO physician (first_name,last_name,specialty,license_no) VALUES(?,?,?,?)");
            $stmt->execute([$first, $last, $spec, $license]);
            $success = "Dr. $last, $first added successfully.";
        }
    }
}

// Handle toggle active
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['action']) && $_POST['action'] === 'toggle') {
    $pid = (int)$_POST['pid'];
    $pdo->prepare("UPDATE physician SET is_active = 1 - is_active WHERE physician_id=?")->execute([$pid]);
    header('Location: manage.php'); exit;
}

$physicians = $pdo->query("SELECT * FROM physician WHERE is_deleted = 0 ORDER BY last_name, first_name")->fetchAll();

require_once ROOT . '/includes/header.php';
?>

<?php if ($errors): ?>
  <div class="alert alert-error"><?= implode('<br>', array_map('htmlspecialchars', $errors)) ?></div>
<?php endif; ?>
<?php if ($success): ?>
  <div class="alert alert-success"><?= htmlspecialchars($success) ?></div>
<?php endif; ?>

<div id="physicianContainer">
<div class="card read-mode-only">
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
  <div class="card-title" style="justify-content:space-between; display:flex; align-items:center; flex-wrap:wrap; gap:.5rem;">
    <span>Physician Directory</span>
    <button type="button" class="btn btn-sm btn-outline btn-toggle-edit" id="toggleEditMode">
      <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
      Manage
    </button>
  </div>
  <?php if (empty($physicians)): ?>
    <p class="text-muted">No physicians recorded yet.</p>
  <?php else: ?>
  <div class="table-wrap">
    <table>
      <thead>
        <tr><th>Name</th><th>Specialty</th><th>License #</th><th>Status</th><th>Action</th></tr>
      </thead>
      <tbody>
        <?php foreach ($physicians as $ph): ?>
        <tr>
          <td class="bold">Dr. <?= htmlspecialchars($ph['last_name'].', '.$ph['first_name']) ?></td>
          <td><?= htmlspecialchars($ph['specialty'] ?? '—') ?></td>
          <td><?= htmlspecialchars($ph['license_no'] ?? '—') ?></td>
          <td>
            <span class="badge <?= $ph['is_active'] ? 'badge-green' : 'badge-gray' ?>">
              <?= $ph['is_active'] ? 'Active' : 'Inactive' ?>
            </span>
          </td>
          <td style="display: flex; gap: 0.4rem; flex-wrap: wrap;">
            <form method="POST" style="display:inline;" class="read-mode-only">
              <input type="hidden" name="action" value="toggle">
              <input type="hidden" name="pid" value="<?= $ph['physician_id'] ?>">
              <button type="submit" class="btn btn-sm btn-outline">
                <?= $ph['is_active'] ? 'Deactivate' : 'Activate' ?>
              </button>
            </form>
            <a href="edit.php?id=<?= $ph['physician_id'] ?>" class="btn btn-outline btn-icon edit-mode-only" title="Edit Physician">
              <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
            </a>
            <a href="delete.php?id=<?= $ph['physician_id'] ?>" class="btn btn-danger btn-icon edit-mode-only" title="Delete Physician" onclick="return confirm('Are you sure you want to delete this physician?');">
              <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16"></path></svg>
            </a>
          </td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <?php endif; ?>
</div>
</div>

<script>
document.getElementById('toggleEditMode').addEventListener('click', function() {
    const container = document.getElementById('physicianContainer');
    container.classList.toggle('edit-mode-active');
    
    if (container.classList.contains('edit-mode-active')) {
        this.innerHTML = '<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M6 18L18 6M6 6l12 12"></path></svg> Exit Edit';
    } else {
        this.innerHTML = '<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg> Manage';
    }
});
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
