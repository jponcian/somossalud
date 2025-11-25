# 🏥 Proceso Actual de Atención por Seguro
## Clínica SaludSonrisa - Módulo de Atenciones

**Fecha de análisis:** 24 de noviembre de 2025  
**Estado:** Implementado y funcional

---

## 📋 Flujo Actual del Proceso

### 1. **Llegada del Paciente (Recepción)**

**Ubicación:** `/atenciones` (Vista de recepción)

**Pasos:**

1. El paciente llega a la clínica con su seguro
2. La recepcionista accede al módulo de atenciones
3. Completa el formulario de "Nueva atención":
   - **Paciente:** Búsqueda por nombre o correo (autocomplete)
   - **Aseguradora:** Nombre de la empresa de seguros (texto libre)
   - **Póliza / N° Seguro:** Número de póliza o identificación del seguro
   - **Asignar médico:** Opcional, puede asignar directamente o dejarlo para después
   - **Seguro validado:** Switch (marcado por defecto)

4. Al crear la atención, el sistema:
   - Registra la atención con estado `validado` (si no se asignó médico) o `en_consulta` (si ya se asignó)
   - Guarda quién validó el seguro y cuándo
   - Asigna automáticamente a la Clínica ID 1 (exclusividad de contrato)

---

### 2. **Asignación de Médico**

**Opciones:**

#### Opción A: Asignación Inmediata (en la creación)
- La recepcionista puede asignar el médico directamente al crear la atención
- El sistema cambia automáticamente el estado a `en_consulta`

#### Opción B: Asignación Posterior (desde el listado)
- En el listado de atenciones, las que no tienen médico muestran un campo de búsqueda
- La recepcionista busca y asigna el médico
- Al guardar, el estado cambia a `en_consulta`

**Búsqueda de médicos:**
- Autocomplete por nombre
- Filtra solo usuarios con rol `especialista`
- Opcional: puede filtrar por especialidad

---

### 3. **Atención Médica (Especialista)**

**Ubicación:** `/atenciones` (Vista de especialista) y `/atenciones/{id}/gestion`

**Pasos:**

1. El médico ve sus atenciones asignadas
2. Accede a la gestión de la atención
3. Completa:
   - **Diagnóstico:** Obligatorio
   - **Observaciones:** Opcional
   - **Medicamentos:** Lista dinámica con:
     - Nombre genérico (con auto-separación de presentación)
     - Posología
     - Frecuencia
     - Duración
   - **Adjuntos:** Hasta 6 archivos (imágenes o PDF)
   - **Concluir:** Checkbox para cerrar la atención

4. Al guardar:
   - Si marca "Concluir": Estado cambia a `cerrado` y se registra `cerrada_at`
   - Si no marca: La atención permanece `en_consulta` para seguimiento

---

### 4. **Cierre de Atención**

**Opciones de cierre:**

#### Opción A: Por el Médico (recomendado)
- Al finalizar la consulta, marca el checkbox "Concluir"
- El sistema cierra automáticamente la atención

#### Opción B: Por Recepción (administrativo)
- La recepcionista puede cerrar manualmente desde el listado
- Útil para casos administrativos o cancelaciones
- Requiere confirmación con SweetAlert2

**Reglas:**
- Una atención cerrada **NO puede modificarse**
- No se puede asignar médico a una atención cerrada
- No se puede gestionar una atención cerrada

---

## 🗂️ Estados de la Atención

| Estado | Descripción | Quién lo asigna | Siguiente paso |
|--------|-------------|-----------------|----------------|
| **validado** | Seguro validado, esperando asignación de médico | Recepción (automático) | Asignar médico |
| **en_consulta** | Médico asignado, atención en proceso | Sistema (al asignar médico) | Gestionar consulta |
| **cerrado** | Atención finalizada | Médico o Recepción | Ninguno (final) |

---

## 📊 Campos de la Tabla `atenciones`

```sql
CREATE TABLE atenciones (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    
    -- Relaciones
    paciente_id BIGINT UNSIGNED NOT NULL,
    clinica_id BIGINT UNSIGNED NOT NULL,
    recepcionista_id BIGINT UNSIGNED NOT NULL,
    medico_id BIGINT UNSIGNED,
    especialidad_id BIGINT UNSIGNED,
    
    -- Datos del Seguro
    aseguradora VARCHAR(150),              -- Nombre de la aseguradora
    poliza VARCHAR(150),                   -- Número de póliza (actualmente NULL)
    numero_seguro VARCHAR(150),            -- Número de seguro/afiliación
    seguro_validado BOOLEAN DEFAULT FALSE, -- Si el seguro fue validado
    validado_at TIMESTAMP,                 -- Cuándo se validó
    validado_por BIGINT UNSIGNED,          -- Quién validó (recepcionista)
    
    -- Estado y Gestión
    estado ENUM('validado', 'en_consulta', 'cerrado') NOT NULL,
    iniciada_at TIMESTAMP,                 -- Cuándo se creó la atención
    atendida_at TIMESTAMP,                 -- Cuándo el médico empezó (no usado actualmente)
    cerrada_at TIMESTAMP,                  -- Cuándo se cerró
    
    -- Datos Médicos
    diagnostico TEXT,                      -- Diagnóstico del médico
    observaciones TEXT,                    -- Observaciones adicionales
    
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    
    FOREIGN KEY (paciente_id) REFERENCES usuarios(id),
    FOREIGN KEY (clinica_id) REFERENCES clinicas(id),
    FOREIGN KEY (recepcionista_id) REFERENCES usuarios(id),
    FOREIGN KEY (medico_id) REFERENCES usuarios(id),
    FOREIGN KEY (especialidad_id) REFERENCES especialidades(id)
);
```

---

## 🔗 Relaciones

### Tablas Relacionadas:

1. **`atencion_medicamentos`**
   - Medicamentos recetados en la atención
   - Campos: nombre_generico, presentacion, posologia, frecuencia, duracion, orden

2. **`atencion_adjuntos`**
   - Archivos adjuntos (imágenes, PDFs)
   - Campos: ruta, nombre_original, mime, size

---

## 👥 Roles y Permisos

### Recepcionista:
- ✅ Crear atenciones
- ✅ Validar seguros
- ✅ Asignar médicos
- ✅ Cerrar atenciones (administrativo)
- ✅ Ver todas las atenciones
- ❌ Gestionar consulta médica

### Especialista:
- ✅ Ver sus atenciones asignadas
- ✅ Gestionar consulta (diagnóstico, medicamentos, adjuntos)
- ✅ Cerrar atención (al concluir)
- ❌ Crear atenciones
- ❌ Ver atenciones de otros médicos

### Paciente:
- ✅ Ver sus propias atenciones (historial)
- ✅ Ver receta de atención
- ❌ Modificar nada

### Admin Clínica / Super Admin:
- ✅ Acceso total
- ✅ Ver todas las atenciones
- ✅ Gestionar cualquier atención

---

## 🎨 Interfaz de Usuario

### Vista de Recepción (`/atenciones`)

**Layout:** Dividido en 2 columnas

#### Columna Izquierda (40%):
- Formulario de "Nueva atención"
- Campos con diseño moderno (gradientes azul-verde)
- Autocomplete para pacientes y médicos
- Switch para validación de seguro

#### Columna Derecha (60%):
- Listado de atenciones recientes
- Filtro por estado (dropdown)
- Tabla con:
  - ID de atención
  - Paciente (con avatar inicial)
  - Seguro (icono de validación + nombre aseguradora)
  - Estado (badge con colores)
  - Médico asignado
  - Acciones (asignar médico, cerrar)

**Características UX:**
- Autocomplete en tiempo real (AJAX)
- Confirmación con SweetAlert2 al cerrar
- Badges de colores por estado:
  - `validado` → Azul (info)
  - `en_consulta` → Amarillo (warning)
  - `cerrado` → Verde (success)

---

### Vista de Especialista (`/atenciones`)

**Layout:** Listado simple

- Muestra solo las atenciones asignadas al médico
- Filtro por estado
- Botón para gestionar cada atención
- Indicadores visuales de estado

---

### Vista de Gestión (`/atenciones/{id}/gestion`)

**Layout:** Formulario completo

**Secciones:**

1. **Información del Paciente:**
   - Nombre, cédula
   - Datos del seguro
   - Historial clínico (últimas 10 citas/atenciones)

2. **Diagnóstico y Observaciones:**
   - Textarea para diagnóstico (obligatorio)
   - Textarea para observaciones (opcional)

3. **Medicamentos:**
   - Lista dinámica (agregar/eliminar)
   - Campos por medicamento:
     - Nombre genérico
     - Posología
     - Frecuencia
     - Duración

4. **Adjuntos:**
   - Subida de archivos (imágenes, PDF)
   - Máximo 6 archivos
   - Tamaño máximo: 5MB por archivo

5. **Acciones:**
   - Checkbox "Concluir atención"
   - Botón "Guardar"

---

## 📈 Reportes y Estadísticas (Potenciales)

### Actualmente NO implementados, pero sugeridos:

1. **Atenciones por Aseguradora:**
   - Cantidad de atenciones por empresa de seguros
   - Gráfica de distribución

2. **Tiempos de Atención:**
   - Tiempo promedio desde validación hasta cierre
   - Tiempo promedio en consulta

3. **Médicos más Activos:**
   - Ranking de médicos por cantidad de atenciones
   - Promedio de atenciones por día

4. **Seguros Rechazados:**
   - Cantidad de seguros no validados
   - Motivos de rechazo

5. **Facturación por Seguro:**
   - Monto total por aseguradora
   - Pendientes de cobro

---

## ⚠️ Limitaciones Actuales

### 1. **Gestión de Aseguradoras:**
- ❌ No hay catálogo de aseguradoras (texto libre)
- ❌ No hay validación de números de póliza
- ❌ No hay integración con sistemas de seguros

### 2. **Procesos de Seguros:**
- ❌ No hay seguimiento de casos/procesos
- ❌ No hay estados de facturación
- ❌ No hay documentación asociada
- ❌ No hay control de pagos de seguros

### 3. **Validación de Seguros:**
- ❌ La validación es manual (checkbox)
- ❌ No hay verificación automática
- ❌ No hay registro de motivos de rechazo

### 4. **Reportes:**
- ❌ No hay reportes específicos de seguros
- ❌ No hay estadísticas de uso
- ❌ No hay facturación automática

---

## 🚀 Mejoras Propuestas

### Prioridad Alta:

1. **Catálogo de Aseguradoras:**
   - Tabla `empresas_seguros`
   - CRUD de aseguradoras
   - Selección desde dropdown en lugar de texto libre

2. **Validación Estructurada:**
   - Motivos de validación/rechazo
   - Registro de intentos de validación
   - Historial de validaciones

3. **Procesos de Seguros:**
   - Tabla `procesos_seguros`
   - Estados: abierto, en_proceso, aprobado, rechazado, pagado
   - Documentación asociada
   - Seguimiento de pagos

### Prioridad Media:

4. **Integración con Inventario:**
   - Registrar materiales usados en la atención
   - Costeo automático
   - Facturación detallada

5. **Reportes y Estadísticas:**
   - Dashboard de seguros
   - Reportes por aseguradora
   - Tiempos de atención
   - Facturación

6. **Notificaciones:**
   - Email al paciente cuando se cierra la atención
   - Recordatorios de seguimiento
   - Alertas de documentación pendiente

### Prioridad Baja:

7. **Firma Digital:**
   - Firma del médico en la atención
   - Firma del paciente (consentimiento)

8. **Plantillas de Diagnóstico:**
   - Diagnósticos predefinidos
   - Autocomplete de diagnósticos comunes

---

## 🔄 Integración con Otros Módulos

### Actualmente Integrado:

✅ **Módulo de Usuarios:**
- Pacientes, médicos, recepcionistas

✅ **Módulo de Especialidades:**
- Asignación automática de especialidad del médico

✅ **Módulo de Clínicas:**
- Asignación fija a Clínica ID 1

### Pendiente de Integración:

❌ **Módulo de Inventario:**
- Registrar materiales consumidos
- Costeo de la atención

❌ **Módulo de Facturación:**
- Generar factura para el seguro
- Control de pagos

❌ **Módulo de Citas:**
- Vincular atención con cita previa (si existe)

---

## 📝 Rutas del Módulo

```php
// Listado (rol específico)
GET  /atenciones                        → AtencionController@index

// Recepción
POST /atenciones                        → AtencionController@store
POST /atenciones/{id}/asignar           → AtencionController@asignarMedico
POST /atenciones/{id}/cerrar            → AtencionController@cerrar

// Especialista
GET  /atenciones/{id}/gestion           → Vista de gestión
POST /atenciones/{id}/gestion           → AtencionController@gestionar

// Paciente
GET  /atenciones/paciente/{id}          → AtencionController@showPaciente
GET  /atenciones/paciente/{id}/receta   → AtencionController@recetaPaciente

// AJAX (Recepción)
GET  /ajax/pacientes                    → AtencionController@buscarPacientes
GET  /ajax/clinicas                     → AtencionController@buscarClinicas
GET  /ajax/medicos                      → AtencionController@buscarMedicos
```

---

## 🎯 Casos de Uso

### Caso 1: Atención de Emergencia con Seguro

1. Paciente llega a emergencias
2. Recepcionista valida seguro
3. Crea atención con estado `validado`
4. Asigna médico de guardia
5. Médico atiende y gestiona
6. Médico cierra atención al concluir

### Caso 2: Atención Programada con Seguro

1. Paciente llega con cita previa
2. Recepcionista valida seguro
3. Crea atención y asigna médico directamente
4. Estado: `en_consulta`
5. Médico atiende
6. Médico cierra atención

### Caso 3: Seguro No Validado

1. Paciente llega con seguro
2. Recepcionista intenta validar
3. Seguro rechazado (vencido, sin cobertura, etc.)
4. Recepcionista desmarca "Seguro validado"
5. Crea atención como particular
6. Flujo normal continúa

---

## 📞 Conclusión

El módulo de atenciones por seguro está **funcional y operativo**, pero tiene oportunidades de mejora significativas, especialmente en:

1. Gestión estructurada de aseguradoras
2. Procesos de seguros con estados y documentación
3. Integración con inventario para costeo
4. Reportes y estadísticas
5. Facturación automática

El flujo actual es simple y efectivo para el día a día, pero para una gestión completa de seguros se recomienda implementar las mejoras propuestas en fases.

---

**Documento generado:** 24 de noviembre de 2025  
**Versión:** 1.0  
**Próxima revisión:** Al implementar mejoras de seguros
