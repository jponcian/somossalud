# Plan de acción (alto nivel y pasos concretos)

Este documento recoge el plan de acción acordado para el desarrollo inicial de la aplicación SomosSalud y sirve como referencia única en el workspace.

## Preparar el entorno local

Requisitos:

- PHP 8.1+
- Composer
- MySQL (WAMP ya instalado)
- Node.js (opcional para assets)
- Git

Acciones:

- Crear carpeta del proyecto y repositorio inicial.

## Inicializar proyecto Laravel (esqueleto)

Pasos:

- Crear proyecto Laravel.
- Configurar `.env` con la conexión a la base de datos local.
- Instalar y configurar Laravel Breeze (Blade) para autenticación mínima.
- Crear `README` con instrucciones de arranque (WAMP, .env, `composer install`, `php artisan migrate`, etc.).

## Modelos y migraciones iniciales

Tablas (nombres en español):

- `usuarios`
- `clinicas`
- `roles`/`permisos` (usar `spatie/laravel-permission`)
- `suscripciones`
- `citas`
- `resultados_laboratorio`

Campos mínimos para arrancar: ver sección "Lógica de suscripciones" y el esquema básico en el README.

Seeders iniciales:

- Crear clínica `SaludSonrisa`.
- Crear rol `paciente` y roles clínicos básicos (`super-admin`, `admin_clinica`, `recepcionista`, `especialista`, `laboratorio`).
- Crear usuario administrador de la clínica.

> Nota: usar nombres de tablas y campos en español siempre que sea posible.

## Lógica de suscripciones (MVP)

Tabla `suscripciones` (campos mínimos):

- `id`
- `usuario_id` (FK)
- `plan` (string)
- `precio` (decimal)
- `periodo_inicio` (date)
- `periodo_vencimiento` (date)
- `estado` (string: `activo`, `pendiente`, `expirado`)
- `metodo_pago` (string: `sandbox`/`manual`)
- `transaccion_id` (string|null)
- `created_at`, `updated_at`

Comportamiento:

- Middleware `verificar.suscripcion` que bloquea rutas de solicitud de citas y servicios si la suscripción no está activa.
- Ruta y vista para que el paciente vea el estado de su suscripción y "pague" en sandbox: al confirmar se marca la suscripción como `activo` y `periodo_vencimiento` = `periodo_inicio` + 1 año.
- Suscripción por defecto: anual, precio = $10 (según lo acordado).

## Roles y permisos

- Instalar `spatie/laravel-permission`.
- Seeder con roles: `super-admin`, `admin_clinica`, `recepcionista`, `especialista`, `laboratorio`, `paciente`.
- Asignar permisos básicos y proteger rutas con middleware `role`/`permission`.

## Pruebas y verificación local

- Ejecutar migraciones y seeders.
- Crear usuarios de prueba: paciente sin suscripción y paciente con suscripción activa.
- Verificar que el paciente registrado no puede solicitar citas hasta activar su suscripción; al activarla, puede acceder.

## Almacenamiento de archivos y seguridad básica

- Archivos (resultados, documentos) inicialmente en `storage/app/resultados`.
- Servir archivos mediante controlador que valide permisos, no mediante acceso público directo.
- Registrar auditoría de accesos a resultados (quién y cuándo los vio/descargó).

## Entrega: README y checklist para siguiente sprint

- Documentar cómo probar el flujo de suscripción en local (pasos rápidos).
- Próximos pasos: integrar pasarela de pago real, agenda de especialistas, subida de resultados, inventario.

---

> Información adicional de contexto:
>
> - Empresa: SomosSalud (aplicación)
> - Primer afiliado (cliente): SaludSonrisa (todos los registros de paciente se asignarán por defecto a esta clínica en el MVP)
> - Suscripción: anual, $10, bloqueo de funciones hasta que la suscripción esté activa

Si quieres, puedo además:

- Crear un `README.md` con los comandos de inicio y este resumen.
- Inicializar el proyecto Laravel en este workspace ahora (crear el esqueleto, migraciones y seeders básicos).

Dime qué prefieres y continúo.
