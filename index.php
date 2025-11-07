<?php
// Redirige a la carpeta public para servir Laravel correctamente
$base = rtrim(dirname($_SERVER['SCRIPT_NAME'] ?? ''), '/\\');
$target = $base . '/public/';

// Evita bucles si ya estamos bajo /public
if (isset($_SERVER['REQUEST_URI']) && strpos($_SERVER['REQUEST_URI'], '/public/') === 0) {
    require __DIR__ . '/public/index.php';
    exit;
}

header('Location: ' . $target, true, 302);
exit;
