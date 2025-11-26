# 📦 Plan de Acción: Sistema de Inventario Completo
## Clínica SaludSonrisa - Módulo de Inventario, Cirugía y Hospitalización

**Fecha de creación:** 24 de noviembre de 2025  
**Desarrollador:** Javier Ponciano  
**Estado:** Planificación

---

## 🎯 Objetivo General

Implementar un sistema integral de gestión de inventario que cubra:
- Control de materiales consumibles
- Gestión de equipos médicos
- Módulo de cirugías
- Módulo de hospitalización
- Control de instrumental quirúrgico
- Trazabilidad y esterilización

---

## 📋 Alcance del Proyecto

### Áreas de la Clínica a Cubrir:

1. **Consulta Externa** - Materiales básicos de consulta
2. **Laboratorio** - Reactivos y material de laboratorio
3. **Cirugía** - Instrumental, materiales quirúrgicos, equipos
4. **Hospitalización** - Materiales de cuidado, medicamentos, equipos
5. **Almacén Central** - Control de stock general
6. **Farmacia** - Medicamentos controlados y no controlados

---

## 🏗️ Estructura de Base de Datos

### 1. Categorías de Inventario

```sql
CREATE TABLE categorias_inventario (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    tipo ENUM('consumible', 'equipo', 'medicamento', 'instrumental') NOT NULL,
    requiere_lote BOOLEAN DEFAULT FALSE,
    requiere_vencimiento BOOLEAN DEFAULT FALSE,
    requiere_esterilizacion BOOLEAN DEFAULT FALSE,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL
);
```

**Categorías Principales:**
- Consumibles Médicos
- Material de Curación
- Material de Laboratorio
- Medicamentos
- Material Quirúrgico
- Instrumental Quirúrgico
- Equipos Médicos
- Material de Hospitalización
- Material de Oficina

---

### 2. Materiales/Productos

```sql
CREATE TABLE materiales (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    categoria_id BIGINT UNSIGNED NOT NULL,
    codigo_interno VARCHAR(50) UNIQUE NOT NULL,
    codigo_barras VARCHAR(100),
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    tipo ENUM('consumible', 'reutilizable', 'medicamento') NOT NULL,
    unidad_medida VARCHAR(50) NOT NULL, -- unidad, caja, paquete, ml, mg, etc.
    stock_actual DECIMAL(10,2) DEFAULT 0,
    stock_minimo DECIMAL(10,2) DEFAULT 0,
    stock_maximo DECIMAL(10,2),
    precio_unitario DECIMAL(10,2),
    precio_promedio DECIMAL(10,2), -- Para valorización
    ubicacion_principal_id BIGINT UNSIGNED,
    requiere_receta BOOLEAN DEFAULT FALSE, -- Para medicamentos controlados
    es_critico BOOLEAN DEFAULT FALSE, -- Para alertas prioritarias
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (categoria_id) REFERENCES categorias_inventario(id) ON DELETE RESTRICT
);
```

**Tipos de Materiales:**

#### Consulta Externa:
- Jeringas (1ml, 3ml, 5ml, 10ml, 20ml)
- Agujas (diferentes calibres)
- Gasas estériles
- Algodón
- Vendas
- Guantes (látex, nitrilo)
- Mascarillas
- Batas desechables
- Alcohol
- Yodo
- Esparadrapo

#### Cirugía:
- Campos quirúrgicos estériles
- Batas quirúrgicas
- Guantes quirúrgicos estériles
- Suturas (diferentes tipos: seda, nylon, catgut, etc.)
- Bisturís desechables
- Compresas
- Drenajes quirúrgicos
- Mallas quirúrgicas
- Material de osteosíntesis

#### Hospitalización:
- Sábanas
- Fundas
- Batas de paciente
- Pañales para adultos
- Equipos de venoclisis
- Sondas (nasogástrica, vesical)
- Bolsas de drenaje
- Nutrición parenteral
- Oxígeno medicinal

#### Laboratorio:
- Tubos de ensayo
- Lancetas
- Reactivos
- Portaobjetos
- Cubreobjetos
- Pipetas

---

### 3. Lotes de Materiales

```sql
CREATE TABLE lotes_materiales (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    material_id BIGINT UNSIGNED NOT NULL,
    numero_lote VARCHAR(100) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    fecha_vencimiento DATE,
    cantidad_inicial DECIMAL(10,2) NOT NULL,
    cantidad_actual DECIMAL(10,2) NOT NULL,
    proveedor VARCHAR(255),
    numero_factura VARCHAR(100),
    costo_unitario DECIMAL(10,2),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (material_id) REFERENCES materiales(id) ON DELETE CASCADE,
    INDEX idx_vencimiento (fecha_vencimiento),
    INDEX idx_material_lote (material_id, numero_lote)
);
```

---

### 4. Ubicaciones/Almacenes

```sql
CREATE TABLE ubicaciones_inventario (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    tipo ENUM('almacen', 'consultorio', 'quirofano', 'piso_hospitalizacion', 'farmacia', 'laboratorio') NOT NULL,
    piso VARCHAR(50),
    descripcion TEXT,
    responsable_id BIGINT UNSIGNED,
    activo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (responsable_id) REFERENCES usuarios(id) ON DELETE SET NULL
);
```

**Ubicaciones Típicas:**
- Almacén Central
- Farmacia
- Quirófano 1, 2, 3...
- Piso 1 - Hospitalización
- Piso 2 - Hospitalización
- Consultorio 1, 2, 3...
- Laboratorio
- Emergencias

---

### 5. Stock por Ubicación

```sql
CREATE TABLE stock_ubicaciones (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    material_id BIGINT UNSIGNED NOT NULL,
    ubicacion_id BIGINT UNSIGNED NOT NULL,
    lote_id BIGINT UNSIGNED,
    cantidad DECIMAL(10,2) NOT NULL DEFAULT 0,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (material_id) REFERENCES materiales(id) ON DELETE CASCADE,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones_inventario(id) ON DELETE CASCADE,
    FOREIGN KEY (lote_id) REFERENCES lotes_materiales(id) ON DELETE SET NULL,
    UNIQUE KEY unique_stock (material_id, ubicacion_id, lote_id)
);
```

---

### 6. Movimientos de Inventario

```sql
CREATE TABLE movimientos_inventario (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    material_id BIGINT UNSIGNED NOT NULL,
    lote_id BIGINT UNSIGNED,
    ubicacion_origen_id BIGINT UNSIGNED,
    ubicacion_destino_id BIGINT UNSIGNED,
    tipo ENUM('entrada', 'salida', 'transferencia', 'ajuste', 'merma', 'vencimiento') NOT NULL,
    cantidad DECIMAL(10,2) NOT NULL,
    stock_anterior DECIMAL(10,2),
    stock_nuevo DECIMAL(10,2),
    motivo VARCHAR(255),
    referencia_tipo VARCHAR(50), -- Compra, Cita, Atencion, Cirugia, Hospitalizacion
    referencia_id BIGINT UNSIGNED,
    usuario_id BIGINT UNSIGNED NOT NULL,
    costo_unitario DECIMAL(10,2),
    observaciones TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (material_id) REFERENCES materiales(id) ON DELETE RESTRICT,
    FOREIGN KEY (lote_id) REFERENCES lotes_materiales(id) ON DELETE SET NULL,
    FOREIGN KEY (ubicacion_origen_id) REFERENCES ubicaciones_inventario(id) ON DELETE SET NULL,
    FOREIGN KEY (ubicacion_destino_id) REFERENCES ubicaciones_inventario(id) ON DELETE SET NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    INDEX idx_fecha (created_at),
    INDEX idx_material (material_id),
    INDEX idx_tipo (tipo)
);
```

**Tipos de Movimientos:**
- **Entrada:** Compras, donaciones, devoluciones
- **Salida:** Consumo en consultas/cirugías/hospitalización, mermas
- **Transferencia:** Entre ubicaciones (ej: Almacén → Quirófano)
- **Ajuste:** Inventario físico, correcciones
- **Merma:** Pérdidas, robos, daños
- **Vencimiento:** Eliminación por fecha vencida

---

### 7. Equipos Médicos (Activos Fijos)

```sql
CREATE TABLE equipos_medicos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo_activo VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    descripcion TEXT,
    marca VARCHAR(100),
    modelo VARCHAR(100),
    numero_serie VARCHAR(100),
    ubicacion_id BIGINT UNSIGNED,
    estado ENUM('operativo', 'mantenimiento', 'fuera_servicio', 'baja') NOT NULL DEFAULT 'operativo',
    fecha_adquisicion DATE,
    valor_adquisicion DECIMAL(12,2),
    vida_util_anos INT,
    responsable_id BIGINT UNSIGNED,
    observaciones TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones_inventario(id) ON DELETE SET NULL,
    FOREIGN KEY (responsable_id) REFERENCES usuarios(id) ON DELETE SET NULL
);
```

**Ejemplos de Equipos:**
- Monitores de signos vitales
- Ventiladores mecánicos
- Desfibriladores
- Bombas de infusión
- Camas hospitalarias
- Mesas quirúrgicas
- Lámparas quirúrgicas
- Electrocardiógrafos
- Ultrasonidos

---

### 8. Mantenimientos de Equipos

```sql
CREATE TABLE mantenimientos_equipos (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    equipo_id BIGINT UNSIGNED NOT NULL,
    tipo ENUM('preventivo', 'correctivo', 'calibracion') NOT NULL,
    fecha_programada DATE NOT NULL,
    fecha_realizada DATE,
    tecnico VARCHAR(255),
    empresa_servicio VARCHAR(255),
    descripcion TEXT,
    observaciones TEXT,
    costo DECIMAL(10,2),
    proximo_mantenimiento DATE,
    realizado BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (equipo_id) REFERENCES equipos_medicos(id) ON DELETE CASCADE,
    INDEX idx_programado (fecha_programada),
    INDEX idx_equipo (equipo_id)
);
```

---

### 9. Instrumental Quirúrgico (Reutilizable)

```sql
CREATE TABLE instrumental_quirurgico (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(50) UNIQUE NOT NULL,
    nombre VARCHAR(255) NOT NULL,
    tipo VARCHAR(100), -- pinza, tijera, bisturí, separador, etc.
    descripcion TEXT,
    ubicacion_id BIGINT UNSIGNED,
    estado ENUM('disponible', 'en_uso', 'esterilizacion', 'mantenimiento', 'baja') NOT NULL DEFAULT 'disponible',
    ciclos_esterilizacion INT DEFAULT 0,
    vida_util_ciclos INT,
    fecha_adquisicion DATE,
    observaciones TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones_inventario(id) ON DELETE SET NULL
);
```

**Tipos de Instrumental:**
- Pinzas (Kelly, Kocher, Allis, etc.)
- Tijeras (Mayo, Metzenbaum, etc.)
- Portaagujas
- Separadores
- Bisturís reutilizables
- Pinzas de campo
- Clamps vasculares

---

### 10. Control de Esterilización

```sql
CREATE TABLE esterilizaciones (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha DATE NOT NULL,
    hora TIME NOT NULL,
    metodo ENUM('autoclave', 'oxido_etileno', 'plasma', 'calor_seco') NOT NULL,
    lote_esterilizacion VARCHAR(100) NOT NULL,
    responsable_id BIGINT UNSIGNED NOT NULL,
    temperatura DECIMAL(5,2),
    presion DECIMAL(5,2),
    tiempo_minutos INT,
    resultado ENUM('exitoso', 'fallido') NOT NULL,
    observaciones TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (responsable_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    INDEX idx_fecha (fecha)
);
```

---

### 11. Instrumental en Esterilización

```sql
CREATE TABLE instrumental_esterilizado (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    esterilizacion_id BIGINT UNSIGNED NOT NULL,
    instrumental_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (esterilizacion_id) REFERENCES esterilizaciones(id) ON DELETE CASCADE,
    FOREIGN KEY (instrumental_id) REFERENCES instrumental_quirurgico(id) ON DELETE CASCADE
);
```

---

## 🏥 Módulo de Cirugía

### 12. Cirugías

```sql
CREATE TABLE cirugias (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    paciente_id BIGINT UNSIGNED NOT NULL,
    cirujano_id BIGINT UNSIGNED NOT NULL,
    anestesiologo_id BIGINT UNSIGNED,
    tipo_cirugia VARCHAR(255) NOT NULL,
    descripcion TEXT,
    fecha_programada DATETIME NOT NULL,
    fecha_realizada DATETIME,
    quirofano_id BIGINT UNSIGNED,
    duracion_minutos INT,
    diagnostico_preoperatorio TEXT,
    diagnostico_postoperatorio TEXT,
    observaciones TEXT,
    estado ENUM('programada', 'en_curso', 'finalizada', 'cancelada') NOT NULL DEFAULT 'programada',
    motivo_cancelacion TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (paciente_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    FOREIGN KEY (cirujano_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    FOREIGN KEY (anestesiologo_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    FOREIGN KEY (quirofano_id) REFERENCES ubicaciones_inventario(id) ON DELETE SET NULL,
    INDEX idx_fecha (fecha_programada),
    INDEX idx_estado (estado)
);
```

---

### 13. Materiales Usados en Cirugía

```sql
CREATE TABLE materiales_cirugia (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cirugia_id BIGINT UNSIGNED NOT NULL,
    material_id BIGINT UNSIGNED NOT NULL,
    lote_id BIGINT UNSIGNED,
    cantidad DECIMAL(10,2) NOT NULL,
    costo_unitario DECIMAL(10,2),
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (cirugia_id) REFERENCES cirugias(id) ON DELETE CASCADE,
    FOREIGN KEY (material_id) REFERENCES materiales(id) ON DELETE RESTRICT,
    FOREIGN KEY (lote_id) REFERENCES lotes_materiales(id) ON DELETE SET NULL
);
```

---

### 14. Instrumental Usado en Cirugía

```sql
CREATE TABLE instrumental_cirugia (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    cirugia_id BIGINT UNSIGNED NOT NULL,
    instrumental_id BIGINT UNSIGNED NOT NULL,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (cirugia_id) REFERENCES cirugias(id) ON DELETE CASCADE,
    FOREIGN KEY (instrumental_id) REFERENCES instrumental_quirurgico(id) ON DELETE RESTRICT
);
```

---

## 🛏️ Módulo de Hospitalización

### 15. Habitaciones/Camas

```sql
CREATE TABLE habitaciones (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    numero VARCHAR(50) NOT NULL,
    piso VARCHAR(50),
    tipo ENUM('individual', 'doble', 'triple', 'uci', 'ucin') NOT NULL,
    ubicacion_id BIGINT UNSIGNED,
    estado ENUM('disponible', 'ocupada', 'mantenimiento', 'limpieza') NOT NULL DEFAULT 'disponible',
    precio_dia DECIMAL(10,2),
    observaciones TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (ubicacion_id) REFERENCES ubicaciones_inventario(id) ON DELETE SET NULL
);
```

---

### 16. Hospitalizaciones

```sql
CREATE TABLE hospitalizaciones (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    paciente_id BIGINT UNSIGNED NOT NULL,
    medico_responsable_id BIGINT UNSIGNED NOT NULL,
    habitacion_id BIGINT UNSIGNED,
    fecha_ingreso DATETIME NOT NULL,
    fecha_egreso DATETIME,
    motivo_ingreso TEXT NOT NULL,
    diagnostico_ingreso TEXT,
    diagnostico_egreso TEXT,
    estado ENUM('activa', 'egresado', 'fallecido', 'transferido') NOT NULL DEFAULT 'activa',
    observaciones TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (paciente_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    FOREIGN KEY (medico_responsable_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    FOREIGN KEY (habitacion_id) REFERENCES habitaciones(id) ON DELETE SET NULL,
    INDEX idx_estado (estado),
    INDEX idx_paciente (paciente_id)
);
```

---

### 17. Materiales Usados en Hospitalización

```sql
CREATE TABLE materiales_hospitalizacion (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    hospitalizacion_id BIGINT UNSIGNED NOT NULL,
    material_id BIGINT UNSIGNED NOT NULL,
    lote_id BIGINT UNSIGNED,
    cantidad DECIMAL(10,2) NOT NULL,
    fecha_consumo DATETIME NOT NULL,
    registrado_por_id BIGINT UNSIGNED NOT NULL,
    costo_unitario DECIMAL(10,2),
    observaciones TEXT,
    created_at TIMESTAMP NULL,
    updated_at TIMESTAMP NULL,
    FOREIGN KEY (hospitalizacion_id) REFERENCES hospitalizaciones(id) ON DELETE CASCADE,
    FOREIGN KEY (material_id) REFERENCES materiales(id) ON DELETE RESTRICT,
    FOREIGN KEY (lote_id) REFERENCES lotes_materiales(id) ON DELETE SET NULL,
    FOREIGN KEY (registrado_por_id) REFERENCES usuarios(id) ON DELETE RESTRICT,
    INDEX idx_fecha (fecha_consumo)
);
```

---

## 📊 Funcionalidades del Sistema

### 1. Gestión de Inventario

#### Dashboard Principal:
- **Alertas Críticas:**
  - Materiales bajo stock mínimo
  - Materiales próximos a vencer (30, 15, 7 días)
  - Equipos con mantenimiento vencido
  - Instrumental con ciclos de vida agotados

- **Indicadores:**
  - Valor total del inventario
  - Rotación de inventario
  - Consumo mensual por categoría
  - Top 10 materiales más consumidos

#### CRUD de Materiales:
- Crear/Editar/Eliminar materiales
- Asignación de categorías
- Configuración de stock mínimo/máximo
- Carga masiva por CSV/Excel

#### Control de Lotes:
- Registro de lotes por compra
- Seguimiento de vencimientos
- Sistema FIFO/PEPS automático
- Alertas de vencimiento

#### Movimientos:
- **Entradas:**
  - Compras (con factura)
  - Donaciones
  - Devoluciones

- **Salidas:**
  - Consumo en consultas
  - Consumo en cirugías
  - Consumo en hospitalización
  - Mermas
  - Vencimientos

- **Transferencias:**
  - Entre ubicaciones
  - Requisiciones de materiales

- **Ajustes:**
  - Inventario físico
  - Correcciones

#### Ubicaciones:
- Gestión de almacenes
- Stock por ubicación
- Responsables por ubicación
- Transferencias entre ubicaciones

---

### 2. Módulo de Cirugía

#### Programación de Cirugías:
- Calendario de quirófanos
- Asignación de equipo médico
- Verificación de disponibilidad de materiales
- Checklist pre-quirúrgico

#### Durante la Cirugía:
- Registro de materiales consumidos
- Registro de instrumental utilizado
- Tiempo de duración
- Incidencias

#### Post-Cirugía:
- Diagnóstico final
- Observaciones
- Costeo automático
- Generación de reporte

---

### 3. Módulo de Hospitalización

#### Gestión de Camas:
- Censo diario
- Disponibilidad en tiempo real
- Asignación de habitaciones
- Control de limpieza

#### Durante Hospitalización:
- Registro diario de materiales consumidos
- Medicamentos administrados
- Evolución del paciente
- Órdenes médicas

#### Egreso:
- Resumen de estancia
- Consumo total de materiales
- Facturación
- Epicrisis

---

### 4. Control de Equipos

#### Inventario de Equipos:
- Registro de activos fijos
- Ubicación actual
- Estado operativo
- Valor contable

#### Mantenimientos:
- Calendario de mantenimientos preventivos
- Registro de mantenimientos correctivos
- Historial completo
- Alertas de vencimiento

---

### 5. Control de Instrumental Quirúrgico

#### Gestión de Instrumental:
- Inventario completo
- Ubicación actual
- Estado (disponible, en uso, esterilización)
- Ciclos de vida

#### Esterilización:
- Registro de lotes de esterilización
- Control de parámetros (temperatura, presión, tiempo)
- Trazabilidad completa
- Indicadores biológicos

#### Mantenimiento:
- Afilado de instrumental
- Reparaciones
- Reemplazo por desgaste

---

## 📈 Reportes y Estadísticas

### Reportes de Inventario:
1. **Stock Actual:**
   - Por categoría
   - Por ubicación
   - Valorización

2. **Movimientos:**
   - Por período
   - Por tipo de movimiento
   - Por usuario

3. **Consumo:**
   - Por servicio (consulta, cirugía, hospitalización)
   - Por especialista
   - Por paciente
   - Tendencias

4. **Vencimientos:**
   - Próximos a vencer
   - Vencidos
   - Valor de pérdidas

5. **Alertas:**
   - Stock bajo
   - Stock crítico
   - Sin stock

### Reportes de Cirugía:
1. Cirugías realizadas por período
2. Cirugías por cirujano
3. Consumo de materiales por cirugía
4. Costos por cirugía
5. Tiempos quirúrgicos

### Reportes de Hospitalización:
1. Censo diario
2. Ocupación de camas
3. Estancia promedio
4. Consumo por paciente
5. Costos de hospitalización

### Reportes de Equipos:
1. Inventario de equipos
2. Mantenimientos realizados
3. Mantenimientos pendientes
4. Costos de mantenimiento
5. Depreciación

---

## 🎨 Interfaz de Usuario

### Dashboard Principal:
- Tarjetas con indicadores clave
- Gráficas de consumo
- Alertas visuales
- Accesos rápidos

### Módulo de Inventario:
- Listado con filtros avanzados
- Búsqueda rápida
- Exportación a Excel/PDF
- Código de barras

### Módulo de Cirugía:
- Calendario visual
- Formulario de programación
- Vista de quirófano en tiempo real
- Checklist interactivo

### Módulo de Hospitalización:
- Mapa de camas
- Censo visual
- Registro de enfermería
- Evolución médica

---

## 🔐 Seguridad y Permisos

### Roles y Permisos:

#### Super Admin:
- Acceso total al sistema

#### Admin Clínica:
- Gestión completa de inventario
- Reportes completos
- Configuraciones

#### Almacenista:
- Gestión de entradas
- Transferencias
- Inventario físico

#### Personal de Quirófano:
- Registro de consumo en cirugías
- Solicitud de materiales

#### Enfermería:
- Registro de consumo en hospitalización
- Solicitud de materiales

#### Médicos:
- Consulta de disponibilidad
- Solicitud de materiales

---

## 📅 Plan de Implementación por Fases

### Fase 1: Inventario Básico (2-3 semanas)
**Prioridad: Alta**

**Entregables:**
- ✅ Migraciones de base de datos (categorías, materiales, lotes, ubicaciones)
- ✅ Modelos Eloquent
- ✅ CRUD de categorías
- ✅ CRUD de materiales
- ✅ CRUD de ubicaciones
- ✅ Sistema de movimientos básico (entrada/salida)
- ✅ Dashboard con alertas de stock
- ✅ Reportes básicos

**Tareas:**
1. Crear migraciones
2. Crear modelos
3. Crear controladores
4. Crear vistas (AdminLTE)
5. Implementar validaciones
6. Pruebas

---

### Fase 2: Control de Lotes y Vencimientos (1-2 semanas)
**Prioridad: Alta**

**Entregables:**
- ✅ Gestión de lotes
- ✅ Control de vencimientos
- ✅ Sistema FIFO/PEPS
- ✅ Alertas de vencimiento
- ✅ Reportes de vencimientos

---

### Fase 3: Módulo de Cirugía (2-3 semanas)
**Prioridad: Media-Alta**

**Entregables:**
- ✅ Tabla de cirugías
- ✅ Programación de cirugías
- ✅ Asignación de quirófanos
- ✅ Registro de consumo de materiales
- ✅ Costeo de cirugías
- ✅ Reportes de cirugía

---

### Fase 4: Módulo de Hospitalización (2-3 semanas)
**Prioridad: Media**

**Entregables:**
- ✅ Gestión de habitaciones/camas
- ✅ Registro de hospitalizaciones
- ✅ Censo diario
- ✅ Registro de consumo
- ✅ Reportes de hospitalización

---

### Fase 5: Control de Equipos (1-2 semanas)
**Prioridad: Media**

**Entregables:**
- ✅ Inventario de equipos
- ✅ Programación de mantenimientos
- ✅ Registro de mantenimientos
- ✅ Alertas de mantenimiento
- ✅ Reportes de equipos

---

### Fase 6: Instrumental Quirúrgico y Esterilización (2 semanas)
**Prioridad: Media-Baja**

**Entregables:**
- ✅ Inventario de instrumental
- ✅ Control de esterilización
- ✅ Trazabilidad
- ✅ Ciclos de vida
- ✅ Reportes de esterilización

---

### Fase 7: Integración y Optimización (1-2 semanas)
**Prioridad: Baja**

**Entregables:**
- ✅ Integración con módulo de citas
- ✅ Integración con módulo de atenciones
- ✅ Optimización de consultas
- ✅ Mejoras de UX
- ✅ Documentación completa

---

## 🛠️ Stack Tecnológico

- **Backend:** Laravel 11.x
- **Frontend:** Blade + AdminLTE + Bootstrap
- **Base de datos:** MySQL
- **Gráficas:** Chart.js
- **Exportación:** Laravel Excel, DomPDF
- **Código de barras:** Milon/Barcode (opcional)

---

## 📝 Consideraciones Técnicas

### Valorización de Inventario:
- Método PEPS (Primero en Entrar, Primero en Salir)
- Cálculo automático de precio promedio
- Actualización en cada movimiento

### Trazabilidad:
- Registro completo de movimientos
- Usuario responsable
- Fecha y hora
- Motivo y observaciones

### Alertas Automáticas:
- Stock mínimo alcanzado
- Vencimientos próximos (30, 15, 7 días)
- Mantenimientos vencidos
- Instrumental con ciclos agotados

### Auditoría:
- Log de todos los movimientos
- Cambios en configuraciones
- Accesos al sistema

---

## 🎯 Métricas de Éxito

1. **Reducción de pérdidas por vencimiento:** Meta 50%
2. **Reducción de desabastecimiento:** Meta 80%
3. **Tiempo de búsqueda de materiales:** Reducción 70%
4. **Precisión de inventario:** Meta 95%
5. **Cumplimiento de mantenimientos:** Meta 100%

---

## 📞 Próximos Pasos

1. ✅ **Aprobación del plan** por parte del cliente
2. ✅ **Definir prioridades** de implementación
3. ✅ **Iniciar Fase 1** - Inventario Básico
4. ✅ **Reuniones de seguimiento** semanales
5. ✅ **Capacitación** del personal

---

## 📄 Anexos

### A. Listado de Materiales Sugeridos (Catálogo Inicial)

**Consumibles Médicos:**
- Jeringas 1ml (caja x100)
- Jeringas 3ml (caja x100)
- Jeringas 5ml (caja x100)
- Jeringas 10ml (caja x100)
- Jeringas 20ml (caja x100)
- Agujas 21G (caja x100)
- Agujas 23G (caja x100)
- Agujas 25G (caja x100)
- Gasas estériles 10x10 (paquete x100)
- Algodón (rollo 500g)
- Vendas elásticas 2" (unidad)
- Vendas elásticas 3" (unidad)
- Vendas elásticas 4" (unidad)
- Guantes látex S (caja x100)
- Guantes látex M (caja x100)
- Guantes látex L (caja x100)
- Guantes nitrilo S (caja x100)
- Guantes nitrilo M (caja x100)
- Guantes nitrilo L (caja x100)
- Mascarillas quirúrgicas (caja x50)
- Batas desechables (paquete x10)

**Material de Curación:**
- Alcohol 70% (litro)
- Yodo (litro)
- Agua oxigenada (litro)
- Esparadrapo 1" (rollo)
- Esparadrapo 2" (rollo)
- Apósitos adhesivos (caja x100)
- Micropore 1" (rollo)
- Micropore 2" (rollo)

**Material Quirúrgico:**
- Campos quirúrgicos estériles (unidad)
- Batas quirúrgicas estériles (unidad)
- Guantes quirúrgicos 6.5 (par)
- Guantes quirúrgicos 7.0 (par)
- Guantes quirúrgicos 7.5 (par)
- Guantes quirúrgicos 8.0 (par)
- Suturas seda 2-0 (unidad)
- Suturas seda 3-0 (unidad)
- Suturas nylon 2-0 (unidad)
- Suturas nylon 3-0 (unidad)
- Suturas catgut 2-0 (unidad)
- Suturas catgut 3-0 (unidad)
- Bisturí #10 (caja x100)
- Bisturí #11 (caja x100)
- Bisturí #15 (caja x100)
- Compresas quirúrgicas (paquete x10)

---

**Documento generado:** 24 de noviembre de 2025  
**Versión:** 1.0  
**Estado:** Planificación aprobada  
**Próxima revisión:** Al finalizar Fase 1
