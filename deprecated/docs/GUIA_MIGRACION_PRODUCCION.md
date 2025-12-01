````markdown
# Guía de Ejecución - Migración de Roles en Producción
## Clínica SaludSonrisa

---

## ⚠️ IMPORTANTE - LEER ANTES DE EJECUTAR

Esta guía te ayudará a aplicar la migración de roles en el servidor de producción de forma segura.

---

## 📋 Pre-requisitos

- [ ] Acceso SSH al servidor de producción
- [ ] Acceso a la base de datos MySQL/MariaDB
- [ ] Permisos de administrador
- [ ] Tiempo estimado: 10-15 minutos
- [ ] Ventana de mantenimiento programada (opcional pero recomendado)

---

## 🔒 PASO 1: BACKUP (CRÍTICO)

### Opción A: Backup completo de la base de datos

```bash
# Conectar al servidor de producción
ssh usuario@servidor-produccion

# Navegar al directorio de backups
cd /ruta/backups

# Crear backup con fecha
mysqldump -u usuario_db -p nombre_base_datos > backup_migracion_roles_$(date +%Y%m%d_%H%M%S).sql

# Verificar que el backup se creó correctamente
ls -lh backup_migracion_roles_*.sql
```

### Opción B: Backup solo de tablas afectadas

```bash
mysqldump -u usuario_db -p nombre_base_datos roles model_has_roles > backup_roles_$(date +%Y%m%d_%H%M%S).sql
```

### ✅ Verificación del Backup

```bash
# Verificar que el archivo no está vacío
wc -l backup_*.sql

# Debe mostrar varias líneas (no 0)
```

---

## 📁 PASO 2: SUBIR EL SCRIPT SQL

### Opción A: Usando SCP (desde tu computadora local)

```bash
# Desde tu máquina local
scp c:\wamp64\www\somossalud\database\migracion_roles_produccion.sql usuario@servidor:/ruta/temporal/
```

### Opción B: Copiar y pegar

1. Abrir el archivo `migracion_roles_produccion.sql`
2. Copiar todo el contenido
3. En el servidor, crear el archivo:

```bash
nano /ruta/temporal/migracion_roles_produccion.sql
# Pegar el contenido
# Guardar: Ctrl+O, Enter, Ctrl+X
```

---

## 🚀 PASO 3: EJECUTAR LA MIGRACIÓN

### Método 1: Desde línea de comandos (Recomendado)

```bash
# Conectar a MySQL
mysql -u usuario_db -p nombre_base_datos

# Dentro de MySQL, ejecutar el script
source /ruta/temporal/migracion_roles_produccion.sql;

# O en una sola línea desde bash:
mysql -u usuario_db -p nombre_base_datos < /ruta/temporal/migracion_roles_produccion.sql
```

### Método 2: Usando phpMyAdmin

1. Acceder a phpMyAdmin
2. Seleccionar la base de datos
3. Ir a la pestaña "SQL"
4. Pegar el contenido del archivo `migracion_roles_produccion.sql`
5. Click en "Continuar"

---

## ✅ PASO 4: VERIFICAR LOS RESULTADOS

El script incluye verificaciones automáticas. Revisa la salida y confirma:

### Verificación 1: Nuevos roles creados
```
Debe mostrar:
- laboratorio-resul (ID 10)
- almacen-jefe (ID 11)
```

### Verificación 2: Roles antiguos eliminados
```
Debe mostrar: 0 roles antiguos restantes
```

### Verificación 3: Usuarios migrados
```
Debe mostrar los usuarios con sus nuevos roles:
- Usuario ID 16: laboratorio-resul
- Usuario ID 21: laboratorio-resul + almacen-jefe
- Usuario ID 23: laboratorio-resul
```

### Verificación 4: Sin asignaciones huérfanas
```
Debe mostrar: 0 asignaciones con roles inexistentes
```

---

## 🔧 PASO 5: LIMPIAR CACHÉ DE LARAVEL

```bash
# Navegar al directorio de la aplicación
cd /ruta/aplicacion

# Limpiar caché general
php artisan cache:clear

# Limpiar caché de configuración
php artisan config:clear

# Limpiar caché de permisos (IMPORTANTE)
php artisan permission:cache-reset

# Limpiar caché de vistas
php artisan view:clear

# Opcional: Optimizar
php artisan optimize
```

---

## 🧪 PASO 6: PRUEBAS POST-MIGRACIÓN

### Prueba 1: Login de usuarios afectados

Probar login con los usuarios:
- Usuario ID 16
- Usuario ID 21
- Usuario ID 23

### Prueba 2: Verificar accesos

**Para usuarios con rol `laboratorio-resul`:**
- [ ] Pueden acceder a "Resultados Pendientes"
- [ ] Pueden cargar resultados
- [ ] NO pueden crear órdenes nuevas
- [ ] Solo ven órdenes pendientes o recientes (últimos 2 días)

**Para usuarios con rol `almacen-jefe`:**
- [ ] Ven todas las opciones del menú de inventario
- [ ] Pueden crear solicitudes
- [ ] Pueden aprobar/rechazar solicitudes
- [ ] Pueden acceder a gestión de materiales
- [ ] Pueden registrar ingresos

### Prueba 3: Verificar menú lateral

- [ ] El menú muestra las opciones correctas según el rol
- [ ] No hay errores 403 al acceder a las opciones

---

## 🔄 PASO 7: ROLLBACK (Solo si hay problemas)

Si algo sale mal, restaurar el backup:

```bash
# Detener la aplicación (opcional)
# systemctl stop nombre-servicio

# Restaurar backup
mysql -u usuario_db -p nombre_base_datos < backup_migracion_roles_YYYYMMDD_HHMMSS.sql

# Limpiar caché
cd /ruta/aplicacion
php artisan cache:clear
php artisan permission:cache-reset

# Reiniciar aplicación (si se detuvo)
# systemctl start nombre-servicio
```

---

## 📊 CHECKLIST DE EJECUCIÓN

### Antes de ejecutar:
- [ ] Backup completo creado
- [ ] Backup verificado (archivo no vacío)
- [ ] Script SQL subido al servidor
- [ ] Usuarios notificados (opcional)
- [ ] Ventana de mantenimiento programada (opcional)

### Durante la ejecución:
- [ ] Script ejecutado sin errores
- [ ] Verificaciones automáticas revisadas
- [ ] Resultados correctos confirmados

### Después de ejecutar:
- [ ] Caché de Laravel limpiado
- [ ] Caché de permisos limpiado
- [ ] Pruebas de login realizadas
- [ ] Accesos verificados
- [ ] Menú lateral verificado
- [ ] Usuarios notificados del cambio

---

## 📞 CONTACTO EN CASO DE PROBLEMAS

Si encuentras algún problema durante la migración:

1. **NO ENTRES EN PÁNICO** - Tienes el backup
2. Documenta el error exacto
3. Restaura el backup si es necesario
4. Contacta al equipo de desarrollo

---

## 📝 REGISTRO DE EJECUCIÓN

Completa esta sección después de ejecutar:

```
Fecha de ejecución: _____________________
Hora de inicio: _____________________
Hora de fin: _____________________
Ejecutado por: _____________________

Resultados:
[ ] Exitoso
[ ] Con errores (especificar): _____________________

Usuarios afectados notificados: [ ] Sí [ ] No

Observaciones:
_____________________
_____________________
_____________________
```

---

## ✅ RESUMEN DE CAMBIOS APLICADOS

Una vez completada la migración, estos serán los cambios en producción:

### Roles Creados:
- ✅ `laboratorio-resul` (ID 10)
- ✅ `almacen-jefe` (ID 11)

### Roles Eliminados:
- ❌ `lab-resultados` (ID 9)
- ❌ `jefe-almacen` (ID 8)

### Usuarios Migrados:
- Usuario ID 16: `lab-resultados` → `laboratorio-resul`
- Usuario ID 21: `lab-resultados` + `jefe-almacen` → `laboratorio-resul` + `almacen-jefe`
- Usuario ID 23: `lab-resultados` → `laboratorio-resul`

### Archivos de Código Actualizados:
- `routes/web.php` - Rutas actualizadas
- `app/Http/Controllers/LabOrderController.php` - Lógica de restricción de 2 días
- `resources/views/panel/partials/sidebar.blade.php` - Menú adaptativo

---

**¡Buena suerte con la migración!** 🚀

````