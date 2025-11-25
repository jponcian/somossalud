# Módulo de Laboratorio - Sistema de Órdenes

## Resumen del Nuevo Flujo

El módulo de laboratorio ahora funciona con un flujo completo de órdenes:

1. **Creación de Orden** → Médico/Recepción solicita exámenes
2. **Carga de Resultados** → Personal de laboratorio ingresa los valores
3. **Generación de PDF** → Se crea documento con QR de verificación
4. **Verificación Pública** → Cualquiera puede verificar autenticidad

---

## Estructura de Base de Datos

### Tablas Principales

#### `lab_categories`
Categorías de exámenes (Hematología, Química Sanguínea, etc.)
- `id`, `code`, `name`, `active`

#### `lab_exams`
Exámenes disponibles (Hemograma, Glicemia, etc.)
- `id`, `code`, `lab_category_id`, `name`, `abbreviation`, `price`, `active`

#### `lab_exam_items`
Ítems/parámetros de cada examen (Hemoglobina, Glucosa, etc.)
- `id`, `lab_exam_id`, `code`, `name`, `unit`, `reference_value`, `type`, `order`

#### `lab_orders`
Órdenes de laboratorio
- `id`, `order_number`, `patient_id`, `doctor_id`, `clinica_id`
- `order_date`, `sample_date`, `result_date`
- `status` (pending, in_progress, completed, cancelled)
- `total`, `observations`, `verification_code`, `created_by`

#### `lab_order_details`
Exámenes solicitados en cada orden
- `id`, `lab_order_id`, `lab_exam_id`, `price`, `status`

#### `lab_results`
Resultados de cada ítem del examen
- `id`, `lab_order_detail_id`, `lab_exam_item_id`, `value`, `observation`

---

## Flujo de Trabajo

### 1. Crear Orden de Examen

**Quién:** Médico, Recepcionista, Admin

**Ruta:** `/lab/orders/create`

**Proceso:**
1. Seleccionar paciente
2. Seleccionar médico solicitante (opcional)
3. Seleccionar clínica
4. Elegir exámenes de la lista (organizados por categoría)
5. Agregar observaciones (opcional)
6. Guardar orden

**Resultado:**
- Se genera número de orden único (ej: LAB-2025-000001)
- Estado inicial: `pending`
- Se calcula el total según precios de exámenes

---

### 2. Cargar Resultados

**Quién:** Personal de Laboratorio, Admin

**Ruta:** `/lab/orders/{id}/load-results`

**Proceso:**
1. Ingresar fecha de toma de muestra
2. Ingresar fecha de resultados
3. Para cada examen de la orden:
   - Se muestran todos los ítems configurados
   - Ingresar valor para cada parámetro
   - Agregar observaciones específicas (opcional)
4. Guardar resultados

**Resultado:**
- Se guardan todos los valores en `lab_results`
- Estado cambia a: `completed`
- Se genera código de verificación único (12 caracteres)
- La orden queda lista para descargar PDF

---

### 3. Visualizar Orden

**Quién:** Personal autorizado

**Ruta:** `/lab/orders/{id}`

**Muestra:**
- Información del paciente
- Datos de la orden
- Lista de exámenes solicitados
- Resultados (si ya fueron cargados)
- Código QR (si está completada)
- Botones de acción

---

### 4. Descargar PDF

**Quién:** Personal autorizado

**Ruta:** `/lab/orders/{id}/pdf`

**Requisito:** La orden debe estar en estado `completed`

**Contenido del PDF:**
- Encabezado con datos de la clínica
- Código QR en esquina superior derecha
- Información de la orden
- Datos del paciente
- Resultados organizados por examen
- Código de verificación
- Instrucciones de verificación

---

### 5. Verificación Pública

**Quién:** Cualquier persona (sin login)

**Ruta:** `/verificar-orden-laboratorio/{codigo}`

**Acceso:**
- Escaneando el QR del PDF
- Ingresando el código manualmente

**Muestra:**
- Badge de "RESULTADO VERIFICADO Y AUTÉNTICO"
- Toda la información de la orden
- Todos los resultados
- Aviso de seguridad

---

## Rutas Disponibles

### Rutas Protegidas (requieren autenticación y rol)

**Roles autorizados:** `laboratorio`, `admin_clinica`, `super-admin`, `recepcionista`

```
GET  /lab/orders                    - Listado de órdenes
GET  /lab/orders/create             - Formulario nueva orden
POST /lab/orders                    - Guardar orden
GET  /lab/orders/{id}               - Ver detalle
GET  /lab/orders/{id}/load-results  - Formulario cargar resultados
POST /lab/orders/{id}/results       - Guardar resultados
GET  /lab/orders/{id}/pdf           - Descargar PDF
GET  /lab/orders/ajax/search-patients - Buscar pacientes (AJAX)
```

### Ruta Pública (sin autenticación)

```
GET  /verificar-orden-laboratorio/{code}  - Verificar autenticidad
```

---

## Modelos y Relaciones

### LabOrder
```php
// Relaciones
$order->patient      // Usuario paciente
$order->doctor       // Usuario médico
$order->clinica      // Clínica
$order->details      // Detalles de la orden
$order->createdBy    // Usuario que creó la orden

// Métodos útiles
$order->isPending()
$order->isCompleted()
$order->hasResults()
LabOrder::generateOrderNumber()
LabOrder::generateVerificationCode()
```

### LabExam
```php
// Relaciones
$exam->category  // Categoría
$exam->items     // Ítems del examen

// Scopes
LabExam::active()->get()
```

### LabOrderDetail
```php
// Relaciones
$detail->order    // Orden
$detail->exam     // Examen
$detail->results  // Resultados
```

---

## Datos de Ejemplo Incluidos

El seeder `LabDataSeeder` crea:

### Categorías (6):
1. Hematología (HEM)
2. Química Sanguínea (QUI)
3. Urianálisis (URI)
4. Inmunología (INM)
5. Hormonas (HOR)

### Exámenes (8):
1. **Hemograma Completo** - $25.00
   - Hemoglobina, Hematocrito, Leucocitos, Plaquetas, Neutrófilos, Linfocitos

2. **Glicemia en Ayunas** - $8.00
   - Glucosa

3. **Perfil Lipídico** - $35.00
   - Colesterol Total, HDL, LDL, Triglicéridos

4. **Creatinina** - $10.00
   - Creatinina

5. **Examen General de Orina** - $12.00
   - Color, Aspecto, pH, Densidad, Proteínas, Glucosa

6. **Proteína C Reactiva** - $15.00
   - PCR

7. **TSH** - $20.00
   - TSH

---

## Estados de la Orden

- **pending**: Orden creada, sin resultados
- **in_progress**: En proceso (opcional, para control interno)
- **completed**: Resultados cargados, PDF disponible
- **cancelled**: Orden cancelada

---

## Seguridad

### Código de Verificación
- 12 caracteres alfanuméricos
- Único en toda la base de datos
- Se genera al completar los resultados
- Permite verificación pública sin exponer datos sensibles

### QR Code
- Apunta a la URL de verificación pública
- Incluido en el PDF
- Tamaño: 150x150px en PDF, 200x200px en vista web

### Permisos
- Solo personal autorizado puede crear órdenes
- Solo personal de laboratorio puede cargar resultados
- Verificación pública no requiere login
- Filtrado por clínica para usuarios no super-admin

---

## Próximos Pasos Opcionales

1. **Notificaciones**
   - Email al paciente cuando los resultados estén listos
   - SMS con código de verificación

2. **Historial del Paciente**
   - Vista de todas las órdenes del paciente
   - Comparación de resultados históricos
   - Gráficas de evolución

3. **Firma Digital**
   - Firma del médico responsable
   - Firma del bioanalista

4. **Integración con Equipos**
   - Importación automática de resultados
   - Conexión con analizadores de laboratorio

5. **Rangos de Referencia Dinámicos**
   - Por edad y sexo del paciente
   - Tabla `lab_reference_groups` ya creada

---

## Comandos Útiles

```bash
# Ejecutar migraciones
php artisan migrate

# Cargar datos de ejemplo
php artisan db:seed --class=LabDataSeeder

# Limpiar caché
php artisan cache:clear
php artisan config:clear
php artisan view:clear
```

---

## Notas Importantes

1. El sistema antiguo de `ResultadoLaboratorio` sigue funcionando para compatibilidad
2. Las rutas antiguas de `/laboratorio` siguen activas
3. El nuevo sistema usa `/lab/orders` para evitar conflictos
4. Los pacientes pueden ver sus resultados en el dashboard
5. El PDF usa DomPDF para generación
6. El QR usa SimpleSoftwareIO/simple-qrcode

---

**Fecha de implementación:** 25 de noviembre de 2025  
**Estado:** ✅ Completado y funcional
