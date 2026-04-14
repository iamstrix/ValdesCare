<?php
/**
 * consultations/list.php — Encounter log with filters
 */
define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

$pageTitle = 'Encounter Log';
$activeNav = 'consult-list';

$search  = trim($_GET['q']       ?? '');
$dateFrom= trim($_GET['date_from']?? '');
$dateTo  = trim($_GET['date_to'] ?? '');
$catId   = (int)($_GET['cat']    ?? 0);

$params = [];
$where  = ['1=1'];

if ($search) {
    $like = "%$search%";
    $where[] = "(p.first_name LIKE ? OR p.last_name LIKE ? OR c.diagnosis LIKE ? OR c.chief_complaint LIKE ?)";
    $params  = array_merge($params, [$like,$like,$like,$like]);
}
if ($dateFrom) { $where[] = "c.visit_date >= ?"; $params[] = $dateFrom; }
if ($dateTo)   { $where[] = "c.visit_date <= ?"; $params[] = $dateTo;   }
if ($catId)    { $where[] = "c.category_id = ?"; $params[] = $catId;    }

$sql = "SELECT c.consultation_id, c.visit_date, c.chief_complaint, c.diagnosis, c.is_referred,
               CONCAT(p.last_name,', ',p.first_name) AS patient_name, p.patient_id,
               cat.name AS category,
               CONCAT(ph.last_name,', ',ph.first_name) AS physician
        FROM consultation c
        JOIN patient p ON c.patient_id = p.patient_id
        LEFT JOIN category cat ON c.category_id = cat.category_id
        LEFT JOIN physician ph  ON c.physician_id = ph.physician_id
        WHERE " . implode(' AND ', $where) . "
        ORDER BY c.visit_date DESC, c.visit_time DESC, c.consultation_id DESC
        LIMIT 500";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$rows = $stmt->fetchAll();

$categories = $pdo->query("SELECT category_id, name FROM category ORDER BY name")->fetchAll();

require_once ROOT . '/includes/header.php';
?>

<div class="card" style="margin-bottom:1rem;">
  <form method="GET">
    <div style="display:flex; gap:.75rem; flex-wrap:wrap; align-items:flex-end;">
      <div class="form-group" style="flex:1; min-width:180px;">
        <label for="q">Search patient / diagnosis</label>
        <input type="text" name="q" id="q" value="<?= htmlspecialchars($search) ?>" placeholder="e.g. Fever, Santos…">
      </div>
      <div class="form-group">
        <label for="cat">Category</label>
        <select name="cat" id="cat">
          <option value="">All</option>
          <?php foreach ($categories as $cat): ?>
            <option value="<?= $cat['category_id'] ?>" <?= $catId==$cat['category_id'] ? 'selected':'' ?>><?= htmlspecialchars($cat['name']) ?></option>
          <?php endforeach; ?>
        </select>
      </div>
      <div class="form-group">
        <label for="date_from">From</label>
        <input type="date" name="date_from" id="date_from" value="<?= htmlspecialchars($dateFrom) ?>">
      </div>
      <div class="form-group">
        <label for="date_to">To</label>
        <input type="date" name="date_to" id="date_to" value="<?= htmlspecialchars($dateTo) ?>">
      </div>
      <button type="submit" class="btn btn-primary btn-sm">&#128269; Filter</button>
      <a href="list.php" class="btn btn-outline btn-sm">Reset</a>
    </div>
  </form>
</div>

<div class="card">
  <div class="card-title" style="justify-content:space-between; display:flex; flex-wrap:wrap; gap:.5rem;">
    <span>Encounters <span style="font-weight:400;color:var(--clr-text-muted);font-size:.85rem;">(<?= count($rows) ?>)</span></span>
    <a href="new.php" class="btn btn-primary btn-sm">&#10133; New Encounter</a>
  </div>

  <?php if (empty($rows)): ?>
    <p class="text-muted">No encounters match your filters.</p>
  <?php else: ?>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>#</th>
          <th>Date</th>
          <th>Patient</th>
          <th>Category</th>
          <th>Physician</th>
          <th>Chief Complaint</th>
          <th>Diagnosis</th>
          <th>Ref?</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($rows as $r): ?>
        <tr>
          <td><?= $r['consultation_id'] ?></td>
          <td style="white-space:nowrap;"><?= htmlspecialchars($r['visit_date']) ?></td>
          <td><a href="../patients/view.php?id=<?= $r['patient_id'] ?>"><?= htmlspecialchars($r['patient_name']) ?></a></td>
          <td>
            <?php if ($r['category']): ?>
              <span class="badge badge-green"><?= htmlspecialchars($r['category']) ?></span>
            <?php else: ?><span class="badge badge-gray">—</span><?php endif; ?>
          </td>
          <td><?= htmlspecialchars($r['physician'] ?? '—') ?></td>
          <td><?= htmlspecialchars(mb_strimwidth($r['chief_complaint'],0,45,'…')) ?></td>
          <td><?= htmlspecialchars(mb_strimwidth($r['diagnosis'] ?? '—',0,45,'…')) ?></td>
          <td><?= $r['is_referred'] ? '<span class="badge badge-red">Yes</span>' : '' ?></td>
          <td><a href="view.php?id=<?= $r['consultation_id'] ?>" class="btn btn-sm btn-outline">View</a></td>
        </tr>
        <?php endforeach; ?>
      </tbody>
    </table>
  </div>
  <?php endif; ?>
</div>

<?php require_once ROOT . '/includes/footer.php'; ?>
