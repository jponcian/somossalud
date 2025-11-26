# 🗑️ Limpieza del Sistema Antiguo de Resultados de Laboratorio en Producción

**Fecha:** 25 de Noviembre de 2025  
**Proyecto:** Clínica SaludSonrisa  
**Motivo:** Eliminación del sistema antiguo de "Resultados Anteriores" que fue reemplazado por el nuevo sistema de órdenes de laboratorio.

---

## ⚠️ IMPORTANTE - LEER ANTES DE PROCEDER

1. **Hacer backup completo de la base de datos** antes de eliminar las tablas
2. **Verificar que no hay datos importantes** en la tabla `resultados_laboratorio`
3. **Asegurarse de que el nuevo sistema de órdenes está funcionando correctamente**
4. Realizar estos cambios en un momento de bajo tráfico

---

## 📋 PASO 1: Eliminar Archivos del Servidor

### Backend (3 archivos)

```bash
# Desde la raíz del proyecto
rm app/Models/ResultadoLaboratorio.php
rm app/Http/Controllers/Laboratorio/ResultadoLaboratorioController.php
rm app/Mail/ResultadoLaboratorioListo.php
```

### Vistas (6 archivos)

```bash
# Eliminar carpeta completa de laboratorio
rm -rf resources/views/laboratorio/

# Eliminar email de notificación
rm resources/views/emails/resultado-listo.blade.php
```

**Archivos específicos a eliminar en `resources/views/laboratorio/`:**
- `create.blade.php`
- `index.blade.php`
- `show.blade.php`
- `pdf.blade.php`
- `verificar.blade.php`

### Base de Datos (2 archivos)

```bash
# Eliminar migración antigua
rm database/migrations/2025_11_04_000400_create_resultados_laboratorio_table.php

# Eliminar archivo SQL
rm database/resultados_laboratorio.sql
```

---

## 🗄️ PASO 2: Eliminar Tabla de la Base de Datos

### Opción A: Usando SQL Directo (Recomendado)

Conectarse a la base de datos y ejecutar:

```sql
-- Verificar si la tabla existe y cuántos registros tiene
SELECT COUNT(*) FROM resultados_laboratorio;

-- Si estás seguro, eliminar la tabla
DROP TABLE IF EXISTS resultados_laboratorio;
```

### Opción B: Usando Artisan (Alternativa)

Si prefieres usar Laravel:

```bash
# Subir la migración de eliminación al servidor
# Luego ejecutar:
php artisan migrate
```

**Nota:** La migración `2025_11_25_215435_drop_resultados_laboratorio_table.php` ya está creada en el proyecto local y debe subirse al servidor.

---

## 📝 PASO 3: Verificar Archivos Modificados

Estos archivos fueron **modificados** (no eliminados) y deben actualizarse en producción:

### Archivos a Actualizar:

1. **`routes/web.php`**
   - ✅ Eliminadas rutas del sistema antiguo
   - ✅ Actualizado para usar solo el nuevo sistema de órdenes

2. **`resources/views/paciente/resultados.blade.php`**
   - ✅ Eliminada sección de resultados antiguos
   - ✅ Ahora muestra solo nuevas órdenes

---

## 🔍 PASO 4: Verificación Post-Limpieza

Después de realizar la limpieza, verificar:

### 1. Verificar que no hay errores en logs:
```bash
tail -f storage/logs/laravel.log
```

### 2. Probar funcionalidades clave:
- ✅ Dashboard de pacientes carga correctamente
- ✅ Página "Mis Resultados" funciona sin errores
- ✅ Personal de laboratorio puede crear órdenes
- ✅ Personal de laboratorio puede cargar resultados a órdenes existentes

### 3. Verificar rutas eliminadas retornan 404:
- `/laboratorio` (antiguo índice)
- `/laboratorio/crear` (antiguo formulario)
- `/verificar-resultado/{codigo}` (antigua verificación)

### 4. Verificar nuevas rutas funcionan:
- ✅ `/lab/orders` (nuevo índice de órdenes)
- ✅ `/lab/orders/create` (crear nueva orden)
- ✅ `/lab/orders/{id}/load-results` (cargar resultados)
- ✅ `/verificar-orden-laboratorio/{code}` (nueva verificación)

---

## 📊 Resumen de Eliminación

### Archivos a Eliminar: **13 archivos**
- Backend: 3 archivos
- Vistas: 6 archivos
- Migraciones/SQL: 2 archivos
- Carpeta completa: `resources/views/laboratorio/`

### Tablas a Eliminar: **1 tabla**
- `resultados_laboratorio`

### Archivos a Actualizar: **2 archivos**
- `routes/web.php`
- `resources/views/paciente/resultados.blade.php`

---

## 🚀 Comandos Rápidos (Copiar y Pegar)

```bash
# PASO 1: Eliminar todos los archivos de una vez
cd /ruta/del/proyecto

# Backend
rm app/Models/ResultadoLaboratorio.php
rm app/Http/Controllers/Laboratorio/ResultadoLaboratorioController.php
rm app/Mail/ResultadoLaboratorioListo.php

# Vistas
rm -rf resources/views/laboratorio/
rm resources/views/emails/resultado-listo.blade.php

# Base de datos
rm database/migrations/2025_11_04_000400_create_resultados_laboratorio_table.php
rm database/resultados_laboratorio.sql

# PASO 2: Limpiar caché de Laravel
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

# PASO 3: Optimizar
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

---

## ⚡ Rollback (En caso de problemas)

Si algo sale mal, puedes restaurar desde el backup:

```sql
-- Restaurar tabla desde backup
-- (usar el archivo de backup que creaste antes)
mysql -u usuario -p nombre_base_datos < backup_antes_limpieza.sql
```

Y restaurar los archivos desde Git:

```bash
git checkout HEAD -- app/Models/ResultadoLaboratorio.php
git checkout HEAD -- app/Http/Controllers/Laboratorio/ResultadoLaboratorioController.php
# etc...
```

---

## ✅ Checklist Final

- [ ] Backup de base de datos creado
- [ ] Archivos backend eliminados (3 archivos)
- [ ] Vistas eliminadas (6 archivos)
- [ ] Archivos de base de datos eliminados (2 archivos)
- [ ] Tabla `resultados_laboratorio` eliminada
- [ ] Archivos modificados actualizados (2 archivos)
- [ ] Caché de Laravel limpiado
- [ ] Rutas y configuración optimizadas
- [ ] Verificación de funcionalidades realizada
- [ ] No hay errores en logs
- [ ] Sistema nuevo de órdenes funciona correctamente

---

**Documentado por:** Sistema de Limpieza Automática  
**Última actualización:** 25/11/2025
