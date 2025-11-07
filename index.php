<?php
// Redirige únicamente cuando entran a la raíz del proyecto
$scriptDir = rtrim(dirname($_SERVER['SCRIPT_NAME'] ?? ''), '/\\');
$baseUri = $scriptDir === '/' ? '' : $scriptDir; // p.ej. "/somossalud"
$uri = $_SERVER['REQUEST_URI'] ?? '/';

// Normaliza para comparar contra la raíz del proyecto
$atRoot = ($uri === $baseUri) || ($uri === $baseUri . '/') || ($uri === $baseUri . '/index.php');

if ($atRoot) {
    $isHttps = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') || (($_SERVER['SERVER_PORT'] ?? '') === '443');
    $scheme = $isHttps ? 'https' : 'http';
    $host = $_SERVER['HTTP_HOST'] ?? 'localhost';
    $target = rtrim($baseUri, '/') . '/public/';
    header('Location: ' . $scheme . '://' . $host . $target, true, 302);
    exit;
}

// Si no es la raíz, no hacemos nada; Apache/Nginx resolverá la ruta.
