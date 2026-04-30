<?php
header('Content-Type: application/json'); error_reporting(0);
require_once dirname(__DIR__) . '/db_connect.php';
$t = ($_GET['type'] ?? '') === 'diagnosis' ? 'diagnoses' : 'chief_complaints';
$q = $_GET['q'] ?? '';
$r = [];
if ($q) try {
    $s = $pdo->prepare("SELECT id, name FROM $t WHERE name LIKE ? ORDER BY name ASC LIMIT 10");
    $s->execute(["%$q%"]);
    $r = $s->fetchAll(PDO::FETCH_ASSOC);
} catch (Exception $e) {}
echo json_encode($r);