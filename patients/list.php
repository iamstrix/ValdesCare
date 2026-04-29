<?php
/**
 * patients/list.php — Searchable patient list
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle = 'Patient List';
$activeNav = 'patients';

$search = trim($_GET['q'] ?? '');
$sex    = $_GET['sex'] ?? '';
$ip     = $_GET['is_ip'] ?? '';
$nhts   = $_GET['nhts_status'] ?? '';

$params = [];
$where  = ['p.is_deleted = 0'];

if ($search) {
    $where[]  = "(p.patient_name LIKE ? OR p.philhealth_no LIKE ?)";
    $like = "%$search%";
    $params = array_merge($params, [$like, $like]);
}
if ($sex) {
    $where[]  = "p.sex = ?";
    $params[] = $sex;
}
if ($ip !== '') {
    $where[]  = "p.is_ip = ?";
    $params[] = $ip;
}
if ($nhts !== '') {
    $where[]  = "p.nhts_status = ?";
    $params[] = $nhts;
}

$sql = "SELECT p.patient_id,
               p.patient_name AS full_name,
               TIMESTAMPDIFF(YEAR, p.dob, CURDATE()) AS age,
               p.sex, p.school_status, p.philhealth_no,
               p.address, p.is_ip, p.nhts_status, p.age_group,
               (SELECT COUNT(*) FROM consultation c WHERE c.patient_id = p.patient_id) AS visit_count
        FROM patient p
        WHERE " . implode(' AND ', $where) . "
        ORDER BY p.patient_name";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$patients = $stmt->fetchAll();

require_once ROOT . '/includes/header.php';
?>

<!-- Page Header -->
<div class="page-header">
  <div class="page-header-title">
    <h1>Patient Directory</h1>
    <p class="text-muted">Search and manage electronic health records.</p>
  </div>
  <div class="page-header-actions no-print">
    <a href="../index.php" class="btn btn-back-hub">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
      Back to Dashboard
    </a>
  </div>
</div>

<!-- Filters -->
<div class="card" style="margin-bottom:1rem;">
  <form method="GET" action="">
    <div style="display:flex; gap:.75rem; flex-wrap:wrap; align-items:flex-end;">
      <div class="form-group" style="flex:1; min-width:200px;">
        <label for="q">Search name / PhilHealth</label>
        <input type="text" name="q" id="q" placeholder="e.g. Santos, Dela Cruz…"
               value="<?= htmlspecialchars($search) ?>">
      </div>
      <div class="form-group">
        <label for="sex">Sex</label>
        <select name="sex" id="sex">
          <option value="">All</option>
          <option value="Male"   <?= $sex==='Male'   ? 'selected':'' ?>>Male</option>
          <option value="Female" <?= $sex==='Female' ? 'selected':'' ?>>Female</option>
        </select>
      </div>
      <div class="form-group">
        <label for="is_ip">IP</label>
        <select name="is_ip" id="is_ip">
          <option value="">All</option>
          <option value="Yes" <?= $ip==='Yes' ? 'selected':'' ?>>Yes</option>
          <option value="No" <?= $ip==='No' ? 'selected':'' ?>>No</option>
        </select>
      </div>
      <div class="form-group">
        <label for="nhts_status">NHTS</label>
        <select name="nhts_status" id="nhts_status">
          <option value="">All</option>
          <option value="NHTS" <?= $nhts==='NHTS' ? 'selected':'' ?>>NHTS</option>
          <option value="NON-NHTS" <?= $nhts==='NON-NHTS' ? 'selected':'' ?>>NON-NHTS</option>
        </select>
      </div>
      <button type="submit" class="btn btn-primary btn-sm">Filter</button>
      <a href="list.php" class="btn btn-outline btn-sm">Reset</a>
    </div>
  </form>
</div>

<div class="card">
  <div class="card-title" style="justify-content:space-between; display:flex; align-items:center; flex-wrap:wrap; gap:.5rem;">
    <span>Patients <span style="font-weight:400;color:var(--clr-text-muted);font-size:.85rem;">(<?= count($patients) ?> found)</span></span>
    <div style="display:flex; gap:.5rem; align-items:center;">
      <button type="button" class="btn btn-sm btn-outline btn-toggle-edit" id="toggleEditMode">
        <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
        Manage
      </button>
      <a href="register.php" class="btn btn-primary btn-sm read-mode-only">Register New</a>
    </div>
  </div>

  <?php if (empty($patients)): ?>
    <p class="text-muted">No patients match your search.</p>
  <?php else: ?>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Name</th>
          <th>Age</th>
          <th>Sex</th>
          <th>Address</th>
          <th>Tags</th>
          <th>Category</th>
          <th>School</th>
          <th>Visits</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($patients as $p): ?>
        <tr>
          <td class="bold"><?= htmlspecialchars($p['full_name']) ?></td>
          <td><?= $p['age'] ?></td>
          <td><?= htmlspecialchars($p['sex']) ?></td>
          <td><?= htmlspecialchars($p['address']) ?></td>
          <td style="white-space:nowrap;">
            <?php if ($p['is_ip'] === 'Yes'): ?>   <span class="badge badge-purple">IP</span>   <?php endif; ?>
            <?php if ($p['nhts_status'] === 'NHTS'): ?> <span class="badge badge-amber">NHTS</span>  <?php endif; ?>
            <?php if ($p['is_ip'] === 'No' && $p['nhts_status'] === 'NON-NHTS'): ?> <span class="badge badge-gray">—</span> <?php endif; ?>
          </td>
          <td>
             <span class="badge badge-blue"><?= htmlspecialchars($p['age_group']) ?></span>
          </td>
          <td>
            <span class="badge <?= $p['school_status']==='In-School' ? 'badge-green' : ($p['school_status']==='Out of School Youth' ? 'badge-red' : 'badge-gray') ?>">
              <?= htmlspecialchars($p['school_status']) ?>
            </span>
          </td>
          <td style="text-align:center;"><?= $p['visit_count'] ?></td>
          <td style="display: flex; gap: 0.4rem; flex-wrap: wrap;">
            <a href="view.php?id=<?= $p['patient_id'] ?>" class="btn btn-sm btn-outline read-mode-only">View</a>
            <a href="../consultations/new.php?patient_id=<?= $p['patient_id'] ?>" class="btn btn-sm btn-primary read-mode-only">+ Consult</a>
            <a href="edit.php?id=<?= $p['patient_id'] ?>" class="btn btn-outline btn-icon edit-mode-only" title="Edit Patient">
              <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
            </a>
            <a href="delete.php?id=<?= $p['patient_id'] ?>" class="btn btn-danger btn-icon edit-mode-only" title="Delete Patient" onclick="return confirm('Are you sure you want to delete this patient?');">
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

<script>
document.getElementById('toggleEditMode').addEventListener('click', function() {
    const card = this.closest('.card');
    card.classList.toggle('edit-mode-active');
    
    // Optional: Change text based on state
    if (card.classList.contains('edit-mode-active')) {
        this.innerHTML = '<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M6 18L18 6M6 6l12 12"></path></svg> Exit Edit';
    } else {
        this.innerHTML = '<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg> Manage';
    }
});
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
