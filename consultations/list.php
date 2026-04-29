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

$params = [];
$where  = ['c.is_deleted = 0'];

if ($search) {
    $like = "%$search%";
    $where[] = "(p.first_name LIKE ? OR p.last_name LIKE ? OR c.chief_complaint LIKE ? OR c.diagnosis LIKE ?)";
    $params  = array_merge($params, [$like,$like,$like,$like]);
}
if ($dateFrom) { $where[] = "c.visit_date >= ?"; $params[] = $dateFrom; }
if ($dateTo)   { $where[] = "c.visit_date <= ?"; $params[] = $dateTo;   }

$sql = "SELECT c.consultation_id, c.visit_date, c.chief_complaint, c.diagnosis,
               CONCAT(p.last_name, ', ', p.first_name) AS patient_name, p.patient_id,
               CONCAT(ph.last_name,', ',ph.first_name) AS physician
        FROM consultation c
        JOIN patient p ON c.patient_id = p.patient_id
        LEFT JOIN physician ph  ON c.physician_id = ph.physician_id
        WHERE " . implode(' AND ', $where) . "
        ORDER BY c.visit_date DESC, c.consultation_id DESC
        LIMIT 500";

$stmt = $pdo->prepare($sql);
$stmt->execute($params);
$rows = $stmt->fetchAll();

require_once ROOT . '/includes/header.php';
?>

<!-- Page Header -->
<div class="page-header">
  <div class="page-header-title">
    <h1>Clinical Encounter Log</h1>
    <p class="text-muted">History of patient consultations and treatments.</p>
  </div>
  <div class="page-header-actions no-print">
    <a href="../index.php" class="btn btn-back-hub">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10 19l-7-7m0 0l7-7m-7 7h18"></path></svg>
      Back to Dashboard
    </a>
  </div>
</div>

<div class="card" style="margin-bottom:1rem;">
  <form method="GET">
    <div style="display:flex; gap:.75rem; flex-wrap:wrap; align-items:flex-end;">
      <div class="form-group" style="flex:1; min-width:180px;">
        <label for="q">Search patient / diagnosis</label>
        <input type="text" name="q" id="q" value="<?= htmlspecialchars($search) ?>" placeholder="e.g. Fever, Santos…">
      </div>
      <div class="form-group">
        <label for="date_from">From</label>
        <input type="date" name="date_from" id="date_from" value="<?= htmlspecialchars($dateFrom) ?>">
      </div>
      <div class="form-group">
        <label for="date_to">To</label>
        <input type="date" name="date_to" id="date_to" value="<?= htmlspecialchars($dateTo) ?>">
      </div>
      <button type="submit" class="btn btn-primary btn-sm">Filter</button>
      <a href="list.php" class="btn btn-outline btn-sm">Reset</a>
    </div>
  </form>
</div>

<div class="card">
  <div class="card-title" style="justify-content:space-between; display:flex; flex-wrap:wrap; gap:.5rem;">
    <span>Encounters <span style="font-weight:400;color:var(--clr-text-muted);font-size:.85rem;">(<?= count($rows) ?>)</span></span>
    <div style="display:flex; gap:.5rem; align-items:center;">
      <button type="button" class="btn btn-sm btn-outline btn-toggle-edit" id="toggleEditMode">
        <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg>
        Manage
      </button>
      <a href="new.php" class="btn btn-primary btn-sm read-mode-only">New Encounter</a>
    </div>
  </div>

  <?php if (empty($rows)): ?>
    <p class="text-muted">No encounters match your filters.</p>
  <?php else: ?>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>Date</th>
          <th>Patient</th>
          <th>Chief Complaint</th>
          <th>Diagnosis</th>
          <th>Physician</th>
          <th>Action</th>
        </tr>
      </thead>
      <tbody>
        <?php foreach ($rows as $r): ?>
        <tr>
          <td style="white-space:nowrap;"><?= htmlspecialchars($r['visit_date']) ?></td>
          <td><a href="../patients/view.php?id=<?= $r['patient_id'] ?>"><?= htmlspecialchars($r['patient_name']) ?></a></td>
          <td><?= htmlspecialchars(mb_strimwidth($r['chief_complaint'] ?? '—', 0, 40, '…')) ?></td>
          <td><span class="badge badge-blue"><?= htmlspecialchars(mb_strimwidth($r['diagnosis'] ?? '—', 0, 40, '…')) ?></span></td>
          <td><?= htmlspecialchars($r['physician'] ?? '—') ?></td>
          <td style="display: flex; gap: 0.4rem; flex-wrap: wrap;">
            <a href="view.php?id=<?= $r['consultation_id'] ?>" class="btn btn-sm btn-outline read-mode-only">View</a>
            <a href="edit.php?id=<?= $r['consultation_id'] ?>" class="btn btn-outline btn-icon edit-mode-only" title="Edit Consultation">
              <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path></svg>
            </a>
            <a href="delete.php?id=<?= $r['consultation_id'] ?>" class="btn btn-danger btn-icon edit-mode-only" title="Delete Consultation" onclick="return confirm('Are you sure you want to delete this consultation record?');">
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
    
    if (card.classList.contains('edit-mode-active')) {
        this.innerHTML = '<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M6 18L18 6M6 6l12 12"></path></svg> Exit Edit';
    } else {
        this.innerHTML = '<svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" style="margin-right:2px;"><path d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z"></path></svg> Manage';
    }
});
</script>

<?php require_once ROOT . '/includes/footer.php'; ?>
