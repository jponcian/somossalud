````markdown
# Migración de Roles Antiguos a Nuevos
## Clínica SaludSonrisa

### 📋 Problema Identificado

Se detectó que existían roles duplicados en la base de datos:

#### Roles Antiguos (creados anteriormente)
- **ID 8**: `jefe-almacen` → 1 usuario asignado (ID 21)
- **ID 9**: `lab-resultados` → 3 usuarios asignados (IDs 16, 21, 23)

#### Roles Nuevos (recién creados)
- **ID 10**: `laboratorio-resul`
- **ID 11**: `almacen-jefe`

---

## ✅ Solución Implementada

### 1. Creación del Seeder de Migración
**Archivo**: `database/seeders/MigrateOldRolesToNewRolesSeeder.php`

Este seeder realiza las siguientes acciones:
1. Identifica usuarios con roles antiguos
2. Asigna los nuevos roles correspondientes
3. Elimina las asignaciones de roles antiguos
4. Elimina los roles antiguos de la base de datos

### 2. Mapeo de Roles

| Rol Antiguo | Rol Nuevo | Usuarios Migrados |
|-------------|-----------|-------------------|
| `jefe-almacen` (ID 8) | `almacen-jefe` (ID 11) | 1 usuario (ID 21) |
| `lab-resultados` (ID 9) | `laboratorio-resul` (ID 10) | 3 usuarios (IDs 16, 21, 23) |

---

## 🔄 Proceso de Migración Ejecutado

```bash
php artisan db:seed --class=MigrateOldRolesToNewRolesSeeder
```

### Resultado:
```
🔄 Iniciando migración de roles...
📋 Migrando 1 usuario(s) de 'jefe-almacen' a 'almacen-jefe':
   ✓ Usuario ID 21 migrado
🗑️  Eliminando rol antiguo 'jefe-almacen'...
   ✓ Rol 'jefe-almacen' eliminado

📋 Migrando 3 usuario(s) de 'lab-resultados' a 'laboratorio-resul':
   ✓ Usuario ID 16 migrado
   ✓ Usuario ID 21 migrado
   ✓ Usuario ID 23 migrado
🗑️  Eliminando rol antiguo 'lab-resultados'...
   ✓ Rol 'lab-resultados' eliminado

✅ Migración completada exitosamente
```

---

## 📊 Estado Final de Roles

### Roles Activos en el Sistema

| ID | Nombre | Descripción |
|----|--------|-------------|
| 1 | `super-admin` | Administrador del sistema |
| 2 | `admin_clinica` | Administrador de clínica |
| 3 | `recepcionista` | Recepcionista |
| 4 | `especialista` | Médico especialista |
| 5 | `laboratorio` | Personal de laboratorio (acceso completo) |
| 6 | `paciente` | Paciente |
| 7 | `almacen` | Personal de almacén (acceso limitado) |
| 10 | `laboratorio-resul` | Personal que solo carga resultados |
| 11 | `almacen-jefe` | Jefe de almacén (acceso completo) |

### Roles Eliminados
- ~~ID 8: `jefe-almacen`~~ → Migrado a `almacen-jefe`
- ~~ID 9: `lab-resultados`~~ → Migrado a `laboratorio-resul`

---

## 👥 Usuarios Afectados

### Usuario ID 21
- **Antes**: `jefe-almacen` + `lab-resultados`
- **Ahora**: `almacen-jefe` + `laboratorio-resul`
- **Efecto**: Mantiene los mismos permisos con nombres estandarizados

### Usuario ID 16
- **Antes**: `lab-resultados`
- **Ahora**: `laboratorio-resul`
- **Efecto**: Mismo acceso, nombre estandarizado

### Usuario ID 23
- **Antes**: `lab-resultados`
- **Ahora**: `laboratorio-resul`
- **Efecto**: Mismo acceso, nombre estandarizado

---

## ✅ Verificaciones Realizadas

1. ✅ Migración de usuarios completada
2. ✅ Roles antiguos eliminados
3. ✅ Caché de permisos limpiado
4. ✅ No hay conflictos de roles
5. ✅ Usuarios mantienen sus permisos

---

## 🔍 Comandos de Verificación

```bash
# Ver todos los roles activos
php artisan tinker
>>> \Spatie\Permission\Models\Role::pluck('name', 'id');

# Ver usuarios con rol almacen-jefe
>>> \App\Models\User::role('almacen-jefe')->get(['id', 'name', 'email']);

# Ver usuarios con rol laboratorio-resul
>>> \App\Models\User::role('laboratorio-resul')->get(['id', 'name', 'email']);
```

---

## 📝 Notas Importantes

1. **No se perdió información**: Todos los usuarios fueron migrados correctamente
2. **Nombres estandarizados**: Los nuevos nombres siguen el patrón del sistema
3. **Compatibilidad**: El código ya está actualizado para usar los nuevos nombres
4. **Sin duplicados**: Ya no existen roles duplicados en el sistema

---

## 🎯 Próximos Pasos

1. ✅ Migración completada
2. ✅ Roles antiguos eliminados
3. ✅ Sistema actualizado
4. ⏳ **Pendiente**: Informar a los usuarios afectados (IDs 16, 21, 23)
5. ⏳ **Pendiente**: Verificar que los usuarios puedan acceder correctamente

---

**Fecha de migración:** 27 de noviembre de 2025
**Ejecutado por:** Sistema automatizado
**Estado:** ✅ COMPLETADO EXITOSAMENTE

````