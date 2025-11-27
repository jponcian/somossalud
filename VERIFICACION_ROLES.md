# Script de Verificación - Roles Granulares
# Clínica SaludSonrisa

## ✅ Verificaciones Completadas

### 1. Roles Creados
- [x] laboratorio-resul
- [x] almacen-jefe

### 2. Rutas Configuradas
- [x] Laboratorio - acceso diferenciado
- [x] Almacén - permisos por rol

### 3. Controlador Actualizado
- [x] Filtrado de órdenes para laboratorio-resul
- [x] Validación de 2 días para modificación
- [x] Preservación de fecha original

### 4. Menú Lateral
- [x] Sección laboratorio adaptativa
- [x] Sección inventario con permisos

---

## 🧪 Pruebas Recomendadas

### Prueba 1: Rol laboratorio-resul
1. Crear un usuario de prueba con rol `laboratorio-resul`
2. Iniciar sesión
3. Verificar que:
   - Solo ve "Resultados Pendientes" en el menú
   - No puede acceder a "Crear Orden"
   - Puede cargar resultados a órdenes pendientes
   - Puede modificar resultados recién cargados
   - NO puede modificar resultados de hace más de 2 días

### Prueba 2: Rol almacen
1. Crear un usuario de prueba con rol `almacen`
2. Iniciar sesión
3. Verificar que:
   - Ve "Nueva Solicitud" y "Solicitudes"
   - NO ve "Ingresos" ni "Gestión de Materiales"
   - Puede crear solicitudes
   - Puede ver solicitudes
   - NO puede aprobar/rechazar solicitudes

### Prueba 3: Rol almacen-jefe
1. Crear un usuario de prueba con rol `almacen-jefe`
2. Iniciar sesión
3. Verificar que:
   - Ve todas las opciones del menú de inventario
   - Puede crear solicitudes
   - Puede aprobar/rechazar solicitudes
   - Puede acceder a gestión de materiales
   - Puede registrar ingresos

---

## 🔍 Comandos de Verificación

```bash
# Verificar que los roles existen
php artisan tinker
>>> \Spatie\Permission\Models\Role::pluck('name');

# Verificar usuarios con nuevos roles
>>> \App\Models\User::role('laboratorio-resul')->get(['name', 'email']);
>>> \App\Models\User::role('almacen-jefe')->get(['name', 'email']);

# Limpiar caché de permisos
php artisan permission:cache-reset
```

---

## 📊 Casos de Uso

### Caso 1: Técnico de Laboratorio (laboratorio-resul)
**Escenario:** María es técnica de laboratorio y solo debe cargar resultados

**Flujo:**
1. María inicia sesión
2. Ve "Resultados Pendientes" en el menú
3. Selecciona una orden pendiente
4. Carga los resultados del examen
5. Guarda los resultados
6. Si necesita corregir algo, tiene 2 días para hacerlo

**Restricción:** Después de 2 días, no puede modificar los resultados

### Caso 2: Auxiliar de Almacén (almacen)
**Escenario:** Juan es auxiliar y solo debe crear solicitudes

**Flujo:**
1. Juan inicia sesión
2. Ve "Nueva Solicitud" y "Solicitudes"
3. Crea una solicitud de materiales
4. Puede ver el estado de sus solicitudes
5. NO puede aprobarlas (debe esperar al jefe)

### Caso 3: Jefe de Almacén (almacen-jefe)
**Escenario:** Ana es jefa de almacén y gestiona todo el inventario

**Flujo:**
1. Ana inicia sesión
2. Ve todas las opciones de inventario
3. Revisa solicitudes pendientes
4. Aprueba o rechaza solicitudes
5. Despacha materiales aprobados
6. Gestiona el catálogo de materiales
7. Registra ingresos de inventario

---

## ⚠️ Problemas Conocidos y Soluciones

### Problema 1: Usuario no ve las opciones correctas
**Solución:**
```bash
php artisan permission:cache-reset
php artisan cache:clear
```

### Problema 2: Error 403 al acceder a una ruta
**Causa:** El usuario no tiene el rol correcto
**Solución:** Verificar y asignar el rol apropiado

### Problema 3: Modificación de resultados después de 2 días
**Comportamiento esperado:** El sistema debe mostrar error
**Si permite modificar:** Verificar que el usuario no tenga rol `laboratorio` o `admin_clinica`

---

## 📝 Checklist de Implementación

- [x] Crear seeder de roles
- [x] Ejecutar seeder
- [x] Actualizar rutas de laboratorio
- [x] Actualizar rutas de almacén
- [x] Modificar controlador de laboratorio
- [x] Actualizar menú lateral
- [x] Documentar cambios
- [ ] Asignar roles a usuarios existentes
- [ ] Realizar pruebas con usuarios reales
- [ ] Capacitar al personal

---

## 🎓 Capacitación Sugerida

### Para Técnicos de Laboratorio (laboratorio-resul)
1. Explicar la restricción de 2 días
2. Mostrar cómo cargar resultados
3. Enfatizar la importancia de revisar antes de guardar

### Para Personal de Almacén (almacen)
1. Explicar el proceso de solicitudes
2. Mostrar cómo crear solicitudes correctamente
3. Aclarar que no pueden aprobar sus propias solicitudes

### Para Jefes de Almacén (almacen-jefe)
1. Mostrar todas las funcionalidades disponibles
2. Explicar el flujo de aprobación de solicitudes
3. Capacitar en gestión de materiales e ingresos

---

**Estado:** ✅ IMPLEMENTACIÓN COMPLETADA
**Fecha:** 27 de noviembre de 2025
