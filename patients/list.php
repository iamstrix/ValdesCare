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
$where  = ['1=1'];

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
    <a href="register.php" class="btn btn-primary btn-sm">Register New</a>
  </div>

  <?php if (empty($patients)): ?>
    <p class="text-muted">No patients match your search.</p>
  <?php else: ?>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>ID</th>
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
          <td><?= $p['patient_id'] ?></td>
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
          <td>
            <a href="view.php?id=<?= $p['patient_id'] ?>" class="btn btn-sm btn-outline">View</a>
            <a href="../consultations/new.php?patient_id=<?= $p['patient_id'] ?>" class="btn btn-sm btn-primary">+ Consult</a>
          </td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <?php endif; ?>
</div>

<?php require_once ROOT . '/includes/footer.php'; ?>
