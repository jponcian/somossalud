-- ============================================================================
-- SCRIPT DE MIGRACIÓN DE ROLES - CLÍNICA SALUDSSONRISA
-- Fecha: 27 de noviembre de 2025
-- Descripción: Migración de roles antiguos a nuevos roles estandarizados
-- ============================================================================

-- IMPORTANTE: Hacer backup de la base de datos antes de ejecutar este script
-- Comando: mysqldump -u usuario -p nombre_base_datos > backup_antes_migracion.sql

-- ============================================================================
-- PASO 1: CREAR NUEVOS ROLES (si no existen)
-- ============================================================================

-- Crear rol laboratorio-resul (ID 10)
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`)
SELECT 10, 'laboratorio-resul', 'web', NOW(), NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM `roles` WHERE `name` = 'laboratorio-resul'
);

-- Crear rol almacen-jefe (ID 11)
INSERT INTO `roles` (`id`, `name`, `guard_name`, `created_at`, `updated_at`)
SELECT 11, 'almacen-jefe', 'web', NOW(), NOW()
WHERE NOT EXISTS (
    SELECT 1 FROM `roles` WHERE `name` = 'almacen-jefe'
);

-- ============================================================================
-- PASO 2: MIGRAR USUARIOS DE ROLES ANTIGUOS A NUEVOS
-- ============================================================================

-- Migrar usuarios de 'lab-resultados' (ID 9) a 'laboratorio-resul' (ID 10)
-- Solo migrar si el usuario NO tiene ya el nuevo rol
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`)
SELECT 10, `model_type`, `model_id`
FROM `model_has_roles`
WHERE `role_id` = 9
AND NOT EXISTS (
    SELECT 1 FROM `model_has_roles` AS mhr2
    WHERE mhr2.`role_id` = 10
    AND mhr2.`model_type` = `model_has_roles`.`model_type`
    AND mhr2.`model_id` = `model_has_roles`.`model_id`
);

-- Migrar usuarios de 'jefe-almacen' (ID 8) a 'almacen-jefe' (ID 11)
-- Solo migrar si el usuario NO tiene ya el nuevo rol
INSERT INTO `model_has_roles` (`role_id`, `model_type`, `model_id`)
SELECT 11, `model_type`, `model_id`
FROM `model_has_roles`
WHERE `role_id` = 8
AND NOT EXISTS (
    SELECT 1 FROM `model_has_roles` AS mhr2
    WHERE mhr2.`role_id` = 11
    AND mhr2.`model_type` = `model_has_roles`.`model_type`
    AND mhr2.`model_id` = `model_has_roles`.`model_id`
);

-- ============================================================================
-- PASO 3: ELIMINAR ASIGNACIONES DE ROLES ANTIGUOS
-- ============================================================================

-- Eliminar asignaciones del rol 'lab-resultados' (ID 9)
DELETE FROM `model_has_roles` WHERE `role_id` = 9;

-- Eliminar asignaciones del rol 'jefe-almacen' (ID 8)
DELETE FROM `model_has_roles` WHERE `role_id` = 8;

-- ============================================================================
-- PASO 4: ELIMINAR ROLES ANTIGUOS
-- ============================================================================

-- Eliminar rol 'lab-resultados' (ID 9)
DELETE FROM `roles` WHERE `id` = 9 AND `name` = 'lab-resultados';

-- Eliminar rol 'jefe-almacen' (ID 8)
DELETE FROM `roles` WHERE `id` = 8 AND `name` = 'jefe-almacen';

-- ============================================================================
-- PASO 5: VERIFICACIÓN (CONSULTAS DE VERIFICACIÓN)
-- ============================================================================

-- Verificar que los nuevos roles existen
SELECT 'Verificando nuevos roles...' AS 'PASO 5: VERIFICACIÓN';
SELECT `id`, `name`, `guard_name`, `created_at` 
FROM `roles` 
WHERE `name` IN ('laboratorio-resul', 'almacen-jefe')
ORDER BY `id`;

-- Verificar que los roles antiguos fueron eliminados
SELECT 'Verificando que roles antiguos fueron eliminados...' AS '';
SELECT COUNT(*) AS 'Roles antiguos restantes (debe ser 0)' 
FROM `roles` 
WHERE `name` IN ('lab-resultados', 'jefe-almacen');

-- Verificar usuarios con nuevos roles
SELECT 'Usuarios con rol laboratorio-resul:' AS '';
SELECT u.`id`, u.`name`, u.`email`, r.`name` AS 'rol'
FROM `usuarios` u
INNER JOIN `model_has_roles` mhr ON u.`id` = mhr.`model_id` AND mhr.`model_type` = 'App\\Models\\User'
INNER JOIN `roles` r ON mhr.`role_id` = r.`id`
WHERE r.`name` = 'laboratorio-resul'
ORDER BY u.`id`;

SELECT 'Usuarios con rol almacen-jefe:' AS '';
SELECT u.`id`, u.`name`, u.`email`, r.`name` AS 'rol'
FROM `usuarios` u
INNER JOIN `model_has_roles` mhr ON u.`id` = mhr.`model_id` AND mhr.`model_type` = 'App\\Models\\User'
INNER JOIN `roles` r ON mhr.`role_id` = r.`id`
WHERE r.`name` = 'almacen-jefe'
ORDER BY u.`id`;

-- Verificar que no hay asignaciones huérfanas
SELECT 'Verificando asignaciones huérfanas (debe ser 0):' AS '';
SELECT COUNT(*) AS 'Asignaciones con roles inexistentes'
FROM `model_has_roles` mhr
LEFT JOIN `roles` r ON mhr.`role_id` = r.`id`
WHERE r.`id` IS NULL;

-- ============================================================================
-- RESUMEN DE CAMBIOS
-- ============================================================================

SELECT '============================================' AS '';
SELECT 'RESUMEN DE MIGRACIÓN' AS '';
SELECT '============================================' AS '';
SELECT 'Roles creados:' AS '';
SELECT '  - laboratorio-resul (ID 10)' AS '';
SELECT '  - almacen-jefe (ID 11)' AS '';
SELECT '' AS '';
SELECT 'Roles eliminados:' AS '';
SELECT '  - lab-resultados (ID 9)' AS '';
SELECT '  - jefe-almacen (ID 8)' AS '';
SELECT '' AS '';
SELECT 'Usuarios migrados:' AS '';
SELECT CONCAT('  - ', COUNT(DISTINCT model_id), ' usuarios migrados a laboratorio-resul') AS ''
FROM `model_has_roles` WHERE `role_id` = 10;
SELECT CONCAT('  - ', COUNT(DISTINCT model_id), ' usuarios migrados a almacen-jefe') AS ''
FROM `model_has_roles` WHERE `role_id` = 11;
SELECT '============================================' AS '';

-- ============================================================================
-- NOTAS IMPORTANTES
-- ============================================================================

/*
NOTAS PARA PRODUCCIÓN:

1. BACKUP: Asegúrate de tener un backup completo antes de ejecutar este script
   
2. EJECUCIÓN: Ejecuta este script en el siguiente orden:
   - Conecta a la base de datos de producción
   - Ejecuta el script completo
   - Revisa los resultados de verificación

3. DESPUÉS DE EJECUTAR:
   - Limpiar caché de Laravel: php artisan cache:clear
   - Limpiar caché de permisos: php artisan permission:cache-reset
   - Verificar que los usuarios puedan iniciar sesión

4. USUARIOS AFECTADOS:
   - Los usuarios con rol 'lab-resultados' ahora tendrán 'laboratorio-resul'
   - Los usuarios con rol 'jefe-almacen' ahora tendrán 'almacen-jefe'
   - NO se pierden permisos, solo cambia el nombre del rol

5. ROLLBACK (si algo sale mal):
   - Restaurar el backup: mysql -u usuario -p nombre_base_datos < backup_antes_migracion.sql
   - Contactar al equipo de desarrollo

6. VERIFICACIÓN POST-MIGRACIÓN:
   - Probar login con usuarios afectados
   - Verificar accesos al módulo de laboratorio
   - Verificar accesos al módulo de almacén
   - Confirmar que el menú lateral muestra las opciones correctas

USUARIOS ESPECÍFICOS AFECTADOS (según base de datos actual):
   - Usuario ID 16: lab-resultados → laboratorio-resul
   - Usuario ID 21: lab-resultados + jefe-almacen → laboratorio-resul + almacen-jefe
   - Usuario ID 23: lab-resultados → laboratorio-resul

CONTACTO EN CASO DE PROBLEMAS:
   - Equipo de desarrollo
   - Tener a mano el backup para restauración rápida
*/

-- ============================================================================
-- FIN DEL SCRIPT
-- ============================================================================
