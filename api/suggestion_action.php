<?php
header('Content-Type: application/json');
error_reporting(0);

define('ROOT', dirname(__DIR__));
require_once ROOT . '/db_connect.php';

// Decode the JSON sent by Javascript fetch()
$data = json_decode(file_get_contents("php://input"), true);

$action = $data['action'] ?? '';
$type   = $data['type'] ?? '';
$id     = $data['id'] ?? null;
$name   = $data['name'] ?? '';

$table = ($type === 'diagnosis') ? 'diagnoses' : 'chief_complaints';
$response = ['success' => false];

try {
    if ($action === 'add' && !empty($name)) {
        $stmt = $pdo->prepare("INSERT IGNORE INTO $table (name) VALUES (?)");
        $stmt->execute([$name]);
        $response['success'] = true;
    } 
    elseif ($action === 'edit' && $id && !empty($name)) {
        $stmt = $pdo->prepare("UPDATE $table SET name = ? WHERE id = ?");
        $stmt->execute([$name, $id]);
        $response['success'] = true;
    } 
    elseif ($action === 'delete' && $id) {
        $stmt = $pdo->prepare("DELETE FROM $table WHERE id = ?");
        $stmt->execute([$id]);
        $response['success'] = true;
    }
} catch (Exception $e) {
    $response['error'] = 'Database error';
}

echo json_encode($response);
exit();
?>