<?php
/**
 * includes/header.php — ValdesCare Shared Header
 * -----------------------------------------------
 * Accepts $pageTitle and $activeNav from the including script.
 * Usage:
 *   $pageTitle = 'Patient Registration';
 *   $activeNav = 'patients';
 *   require_once ROOT . '/includes/header.php';
 */
if (!isset($pageTitle)) $pageTitle = 'AUF Valdes Medical Clinic';

// Compute root-relative base path for assets using ROOT constant
// ROOT is defined in every calling script as the project root dir.
// Depth = number of directory separators between ROOT and the calling script's dir.
$callerDir = realpath(dirname($_SERVER['SCRIPT_FILENAME']));
$rootDir   = defined('ROOT') ? realpath(ROOT) : realpath(__DIR__ . '/..');
$depth     = ($rootDir === $callerDir) ? 0
           : substr_count(str_replace($rootDir, '', $callerDir), DIRECTORY_SEPARATOR);
$base      = $depth > 0 ? str_repeat('../', $depth) : '';
?>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= htmlspecialchars($pageTitle) ?> — Don Emiliano J. Valdes Medical Clinic</title>
  <meta name="description" content="Angeles University Foundation Don Emiliano J. Valdes Medical Clinic — Offline Clinical Decision Support">
  <link rel="stylesheet" href="<?= $base ?>assets/css/style.css?v=<?= time() ?>">
</head>
<body>

<!-- ═══════════ SIDEBAR ═══════════ -->
<aside class="sidebar">
  <div class="sidebar-brand">
    <h1 style="font-size: 1rem; line-height: 1.2;">AUF — Don Emiliano J.<br><span>Valdes Medical Clinic</span></h1>
    <small>University Community Health Program</small>
  </div>


  <nav class="sidebar-nav">
    <div class="nav-section">Overview</div>
    <a href="<?= $base ?>index.php"                class="<?= $activeNav==='home'      ? 'active':'' ?>">Dashboard</a>

    <div class="nav-section">Patients</div>
    <a href="<?= $base ?>patients/list.php"        class="<?= $activeNav==='patients'  ? 'active':'' ?>">Patient List</a>
    <a href="<?= $base ?>patients/register.php"    class="<?= $activeNav==='register'  ? 'active':'' ?>">Register Patient</a>

    <div class="nav-section">Consultations</div>
    <a href="<?= $base ?>consultations/new.php"    class="<?= $activeNav==='consult-new' ? 'active':'' ?>">New Encounter</a>
    <a href="<?= $base ?>consultations/list.php"   class="<?= $activeNav==='consult-list'? 'active':'' ?>">Encounter Log</a>

    <div class="nav-section">Administration</div>
    <a href="<?= $base ?>physicians/manage.php"    class="<?= $activeNav==='physicians' ? 'active':'' ?>">Physicians</a>
    <a href="<?= $base ?>exports/report.php"       class="<?= $activeNav==='reports'    ? 'active':'' ?>">Reports / Print</a>

    <div class="nav-section">System</div>
    <a href="<?= $base ?>settings/index.php"       class="<?= $activeNav==='settings'   ? 'active':'' ?>">
      <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path><path d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>
      Settings
    </a>
  </nav>

  <div class="sidebar-footer">
    &copy; <?= date('Y') ?> AUF Don Emiliano J. Valdes Medical Clinic
  </div>
</aside>

<!-- ═══════════ MAIN WRAP ═══════════ -->
<div class="main-wrap">
  <div class="topbar">
    <h2><?= htmlspecialchars($pageTitle) ?></h2>
    <span class="topbar-meta">
      <?= date('l, F j, Y · g:i A') ?>
    </span>
  </div>
  <div class="page-body">
