<?php
/**
 * db_connect.php — ValdesCare Database Connection
 * ------------------------------------------------
 * Returns a PDO instance connected to the valdescare MySQL database.
 * Include this file in every script that needs database access:
 *
 *   require_once __DIR__ . '/db_connect.php';
 *   // $pdo is now available
 *
 * OFFLINE / LOCAL ONLY — designed for XAMPP (localhost).
 */

// ── Configuration ────────────────────────────────────────────
date_default_timezone_set('Asia/Manila');

define('DB_HOST',    'localhost');
define('DB_PORT',    '3306');
define('DB_NAME',    'valdescare');
define('DB_USER',    'root');      // Change if you added a MySQL password
define('DB_PASS',    '');          // Default XAMPP root has no password
define('DB_CHARSET', 'utf8mb4');
// ─────────────────────────────────────────────────────────────

/**
 * Build the PDO Data Source Name string.
 */
$dsn = sprintf(
    'mysql:host=%s;port=%s;dbname=%s;charset=%s',
    DB_HOST,
    DB_PORT,
    DB_NAME,
    DB_CHARSET
);

/**
 * PDO options:
 *  - ERRMODE_EXCEPTION  → throws PDOException on any error (easy to catch).
 *  - DEFAULT_FETCH_MODE → returns rows as associative arrays by default.
 *  - EMULATE_PREPARES   → disabled for true prepared statements (SQL-injection safe).
 *  - PERSISTENT         → false; fresh connection per request (safe for XAMPP).
 */
$pdoOptions = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
    PDO::ATTR_EMULATE_PREPARES   => false,
    PDO::ATTR_PERSISTENT         => false,
];

try {
    $pdo = new PDO($dsn, DB_USER, DB_PASS, $pdoOptions);
    // Sync session timezone with Asia/Manila (UTC+8)
    $pdo->exec("SET time_zone = '+08:00'");
} catch (PDOException $e) {
    /*
     * On a connection failure, we stop execution and show a safe error.
     * Never expose $e->getMessage() to end-users in production;
     * here it is shown because this runs strictly on a local LAN.
     */
    http_response_code(500);
    exit(
        '<div style="font-family:sans-serif;padding:2rem;color:#b91c1c;">'
        . '<h2>&#x26A0; Database Connection Error</h2>'
        . '<p>Could not connect to <strong>' . DB_NAME . '</strong> on <strong>' . DB_HOST . '</strong>.</p>'
        . '<p><em>MySQL says:</em> ' . htmlspecialchars($e->getMessage(), ENT_QUOTES, 'UTF-8') . '</p>'
        . '<hr><p>Make sure XAMPP MySQL is running and the database <code>valdescare</code> has been created.</p>'
        . '</div>'
    );
}

/*
 * $pdo is now ready for use in any including script.
 * Example usage:
 *
 *   $stmt = $pdo->prepare("SELECT * FROM patient WHERE patient_id = :id");
 *   $stmt->execute([':id' => $patientId]);
 *   $patient = $stmt->fetch();
 */
