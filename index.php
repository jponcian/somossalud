<?php
// index.php en la raíz del proyecto

// Usa ruta relativa para que funcione tanto en VirtualHost como bajo /somossalud/
$public_dir = 'public/';

// Envía la cabecera de redirección
header('Location: ' . $public_dir);

// Asegura que el script se detenga inmediatamente después de la redirección
exit;
