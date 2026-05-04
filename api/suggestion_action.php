<?php
header('Content-Type: application/json');
error_reporting(0);

define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

// Decode the JSON sent by Javascript fetch()
$data = json_decode(file_get_contents("php://input"), true);

$action = $data['action'] ?? '';
$type   = $data['type']   ?? '';
$id     = $data['id']     ?? null;
$name   = $data['name']   ?? '';

$table    = ($type === 'diagnosis') ? 'diagnoses' : 'chief_complaints';
$response = ['success' => false];

try {
    if ($action === 'add' && !empty($name)) {
        // If a soft-deleted record with the same name exists, restore it
        $check = $pdo->prepare("SELECT id, is_deleted FROM $table WHERE name = ? LIMIT 1");
        $check->execute([$name]);
        $existing = $check->fetch(PDO::FETCH_ASSOC);

        if ($existing && $existing['is_deleted']) {
            $stmt = $pdo->prepare("UPDATE $table SET is_deleted = 0 WHERE id = ?");
            $stmt->execute([$existing['id']]);
        } else {
            $stmt = $pdo->prepare("INSERT IGNORE INTO $table (name) VALUES (?)");
            $stmt->execute([$name]);
        }
        $response['success'] = true;

    } elseif ($action === 'edit' && $id && !empty($name)) {
        $stmt = $pdo->prepare("UPDATE $table SET name = ? WHERE id = ? AND is_deleted = 0");
        $stmt->execute([$name, $id]);
        $response['success'] = true;

    } elseif ($action === 'delete' && $id) {
        // Soft-delete: mark as deleted, do not physically remove the row
        // so that existing consultation records referencing this name are preserved.
        $stmt = $pdo->prepare("UPDATE $table SET is_deleted = 1 WHERE id = ?");
        $stmt->execute([$id]);
        $response['success'] = true;
    }
} catch (Exception $e) {
    $response['error'] = 'Database error: ' . $e->getMessage();
}

echo json_encode($response);
exit();
?>