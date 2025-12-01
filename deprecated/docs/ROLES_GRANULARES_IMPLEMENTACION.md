````markdown
# Sistema de Roles Granulares - Laboratorio y Almacén
## Clínica SaludSonrisa

### 📋 Resumen de Implementación

Se ha implementado un sistema de roles más granular para los módulos de **Laboratorio** y **Almacén**, permitiendo un control de acceso más específico según las responsabilidades de cada usuario.

---

## 🔐 Nuevos Roles Creados

### Laboratorio
1. **`laboratorio`** (existente - ampliado)
   - Acceso completo al módulo de laboratorio
   - Crear órdenes de exámenes
   - Cargar y modificar resultados sin restricción de tiempo
   - Imprimir resultados
   - Ver todas las órdenes

2. **`laboratorio-resul`** (NUEVO)
   - Solo puede cargar y modificar resultados
   - **Restricción temporal**: Solo puede modificar resultados hasta 2 días después de haberlos cargado
   - No puede crear nuevas órdenes
   - Solo ve órdenes pendientes de resultados y órdenes completadas hace menos de 2 días

### Almacén
1. **`almacen`** (existente - modificado)
   - Crear solicitudes de materiales
   - Ver listado de solicitudes
   - Ver detalle de solicitudes
   - **NO** tiene acceso a:
     - Aprobar/rechazar solicitudes
     - Despachar solicitudes
     - Gestión de materiales
     - Ingresos de inventario

2. **`almacen-jefe`** (NUEVO)
   - Acceso completo a todas las funcionalidades de inventario:
     - Crear, ver, editar solicitudes
     - Aprobar y despachar solicitudes
     - Gestión de materiales
     - Registrar ingresos de inventario

---

## 🛠️ Cambios Implementados

### 1. Base de Datos
- **Archivo**: `database/seeders/NewRolesSeeder.php`
- Crea los nuevos roles `laboratorio-resul` y `almacen-jefe`

### 2. Rutas (routes/web.php)

#### Laboratorio
```php
// Acceso general al módulo (todos los roles de laboratorio)
Route::middleware(['auth', 'verified', 'role:laboratorio|laboratorio-resul|admin_clinica|super-admin|recepcionista'])

// Crear órdenes (solo laboratorio completo)
Route::get('/create')->middleware('role:laboratorio|admin_clinica|super-admin|recepcionista')

// Cargar resultados (ambos roles)
Route::get('/{id}/load-results')
Route::post('/{id}/results')
```

#### Almacén
```php
// Solicitudes - ambos roles pueden crear y ver
Route::middleware('role:super-admin|admin_clinica|almacen|almacen-jefe')

// Aprobar/Despachar - solo almacen-jefe
Route::middleware('role:super-admin|admin_clinica|almacen-jefe')

// Materiales e Ingresos - solo almacen-jefe
Route::middleware('role:super-admin|admin_clinica|almacen-jefe')
```

### 3. Controlador de Laboratorio (LabOrderController.php)

#### Método `index()`
- Filtra las órdenes para `laboratorio-resul`:
  - Solo muestra órdenes pendientes
  - Órdenes completadas hace menos de 2 días

#### Método `loadResults()` y `storeResults()`
- Valida que `laboratorio-resul` solo pueda modificar resultados dentro de 2 días
- Muestra mensaje de error si intenta modificar después del período permitido
- Preserva la fecha original de resultados al modificar

### 4. Menú Lateral (sidebar.blade.php)

#### Sección Laboratorio
```blade
@hasanyrole('super-admin|admin_clinica|laboratorio|laboratorio-resul|recepcionista')
    <li class="nav-header">LABORATORIO</li>
    <li class="nav-item">
        <a href="{{ route('lab.orders.index') }}">
            <p>
                @hasanyrole('laboratorio|admin_clinica|super-admin|recepcionista')
                    Exámenes
                @else
                    Resultados Pendientes
                @endhasanyrole
            </p>
        </a>
    </li>
@endhasanyrole
```

#### Sección Inventario
```blade
@hasanyrole('super-admin|admin_clinica|almacen|almacen-jefe')
    <li class="nav-header">INVENTARIO</li>
    <!-- Nueva Solicitud y Solicitudes: visible para ambos roles -->
    
    @hasanyrole('super-admin|admin_clinica|almacen-jefe')
        <!-- Ingresos y Gestión de Materiales: solo almacen-jefe -->
    @endhasanyrole
@endhasanyrole
```

---

## 🎯 Funcionalidades por Rol

### Comparativa Laboratorio

| Funcionalidad | laboratorio | laboratorio-resul |
|--------------|-------------|-------------------|
| Ver todas las órdenes | ✅ | ❌ (solo pendientes y recientes) |
| Crear órdenes | ✅ | ❌ |
| Cargar resultados | ✅ | ✅ |
| Modificar resultados | ✅ (sin límite) | ✅ (hasta 2 días) |
| Imprimir resultados | ✅ | ✅ |
| Buscar pacientes | ✅ | ❌ |
| Eliminar ítems de examen | ✅ | ❌ |

### Comparativa Almacén

| Funcionalidad | almacen | almacen-jefe |
|--------------|---------|--------------|
| Crear solicitudes | ✅ | ✅ |
| Ver solicitudes | ✅ | ✅ |
| Ver detalle de solicitud | ✅ | ✅ |
| Editar solicitud | ❌ | ✅ |
| Aprobar/Rechazar solicitud | ❌ | ✅ |
| Despachar solicitud | ❌ | ✅ |
| Gestión de materiales | ❌ | ✅ |
| Registrar ingresos | ❌ | ✅ |

---

## 📝 Instrucciones de Uso

### Para Administradores

1. **Crear usuarios con nuevos roles:**
   - Ir a "Gestión de usuarios"
   - Al crear/editar un usuario, seleccionar el rol apropiado:
     - `laboratorio-resul` para personal que solo carga resultados
     - `almacen-jefe` para jefes de almacén

2. **Asignar roles existentes:**
   - Los usuarios con rol `laboratorio` mantienen acceso completo
   - Los usuarios con rol `almacen` ahora tienen acceso limitado

### Para Usuarios

#### Rol laboratorio-resul
- Al iniciar sesión, verá "Resultados Pendientes" en el menú
- Solo podrá ver y cargar resultados de órdenes pendientes
- Tendrá 2 días para modificar resultados después de cargarlos
- Después de 2 días, los resultados quedan bloqueados

#### Rol almacen-jefe
- Verá todas las opciones del menú de inventario
- Podrá aprobar/rechazar solicitudes de materiales
- Podrá gestionar el catálogo de materiales
- Podrá registrar ingresos de inventario

---

## ⚠️ Validaciones Implementadas

### Laboratorio
1. **Restricción temporal de 2 días:**
   - Se calcula desde `result_date`
   - Validación en `loadResults()` y `storeResults()`
   - Mensaje de error claro al usuario

2. **Filtrado de órdenes:**
   - `laboratorio-resul` solo ve órdenes relevantes
   - Optimiza la interfaz y evita confusión

### Almacén
1. **Control de acceso por ruta:**
   - Middleware valida permisos antes de acceder
   - Retorna 403 si no tiene permisos

2. **Menú adaptativo:**
   - Solo muestra opciones permitidas
   - Evita intentos de acceso no autorizado

---

## 🔧 Archivos Modificados

1. `database/seeders/NewRolesSeeder.php` (nuevo)
2. `routes/web.php`
3. `app/Http/Controllers/LabOrderController.php`
4. `resources/views/panel/partials/sidebar.blade.php`

---

## 📌 Notas Importantes

1. Los roles `super-admin` y `admin_clinica` mantienen acceso completo a todo
2. El rol `recepcionista` mantiene acceso completo al laboratorio
3. La restricción de 2 días NO aplica a roles administrativos
4. Los usuarios pueden tener múltiples roles (el sistema verifica jerarquía)

---

## ✅ Próximos Pasos

1. Ejecutar el seeder: `php artisan db:seed --class=NewRolesSeeder`
2. Asignar los nuevos roles a los usuarios correspondientes
3. Probar el acceso con cada rol para verificar permisos
4. Capacitar al personal sobre las nuevas restricciones

---

**Fecha de implementación:** 27 de noviembre de 2025
**Desarrollado para:** Clínica SaludSonrisa

````