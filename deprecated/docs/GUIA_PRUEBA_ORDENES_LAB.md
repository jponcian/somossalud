# Guía Rápida de Prueba - Sistema de Órdenes de Laboratorio

## Credenciales de Acceso

### Usuario de Laboratorio
- **Email**: laboratorio@somossalud.com
- **Contraseña**: password
- **Rol**: laboratorio

### Usuario Administrador
- **Email**: admin@somossalud.com
- **Contraseña**: password
- **Rol**: super-admin

---

## Pasos para Probar el Sistema

### 1. Acceder al Sistema

1. Ir a: `http://localhost/login`
2. Iniciar sesión con usuario de laboratorio o admin
3. Ir al panel de clínica
4. Buscar opción "Laboratorio" en el menú o ir a: `/lab/orders`

---

### 2. Ver Listado de Órdenes

**URL:** `/lab/orders`

**Qué verás:**
- Tabla con todas las órdenes
- Filtro por estado (Todos, Pendientes, En Proceso, Completados, Cancelados)
- Columnas: Nº Orden, Fecha, Paciente, Médico, Exámenes, Estado, Total, Acciones
- Botón "Nueva Orden"

---

### 3. Crear Nueva Orden

**Paso a paso:**

1. Click en "Nueva Orden"
2. **Seleccionar Paciente:**
   - Elegir de la lista desplegable
   - Buscar por nombre o cédula

3. **Seleccionar Médico Solicitante** (opcional):
   - Elegir de la lista

4. **Seleccionar Clínica:**
   - Se preselecciona la clínica del usuario

5. **Fecha de Orden:**
   - Se preselecciona la fecha actual

6. **Seleccionar Exámenes:**
   - Marcar checkboxes de los exámenes deseados
   - Organizados por categoría
   - El total se calcula automáticamente

7. **Observaciones** (opcional):
   - Agregar notas adicionales

8. Click en "Crear Orden"

**Resultado:**
- Se crea la orden con número único (ej: LAB-2025-000001)
- Redirige a la vista de detalle
- Estado: Pendiente

---

### 4. Ver Detalle de la Orden

**Qué muestra:**
- Información del paciente
- Datos de la orden
- Lista de exámenes solicitados
- Estado actual
- Botón "Cargar Resultados" (si está pendiente)

---

### 5. Cargar Resultados

**Paso a paso:**

1. Desde el detalle de la orden, click en "Cargar Resultados"
2. **Ingresar Fechas:**
   - Fecha de Toma de Muestra
   - Fecha de Resultados

3. **Ingresar Valores:**
   - Para cada examen, se muestra una tabla con sus ítems
   - Ingresar el valor en cada campo
   - Las unidades y rangos de referencia se muestran automáticamente
   - Agregar observaciones específicas si es necesario

4. Click en "Guardar Resultados"

**Resultado:**
- Los resultados se guardan
- Estado cambia a "Completado"
- Se genera código de verificación único
- Ahora se puede descargar el PDF

---

### 6. Descargar PDF

**Desde la vista de detalle:**
1. Click en "Descargar PDF"
2. Se descarga un PDF profesional que incluye:
   - Encabezado de la clínica
   - Código QR en esquina superior derecha
   - Información completa de la orden
   - Todos los resultados en tablas
   - Código de verificación
   - Instrucciones de verificación

---

### 7. Verificar Resultados (Público)

**Opción A: Escanear QR**
1. Abrir el PDF descargado
2. Escanear el QR con un celular
3. Se abre la página de verificación

**Opción B: URL Directa**
1. Copiar el código de verificación del PDF
2. Ir a: `http://localhost/verificar-orden-laboratorio/{CODIGO}`
3. Se muestra la página de verificación

**Página de Verificación Muestra:**
- Badge verde "RESULTADO VERIFICADO Y AUTÉNTICO"
- Código de verificación destacado
- Información completa de la orden
- Datos del paciente
- Todos los resultados
- Aviso de seguridad
- **NO requiere login**

---

## Casos de Prueba Sugeridos

### Caso 1: Orden Simple (Glicemia)

1. Crear orden con un solo examen: Glicemia en Ayunas
2. Cargar resultado: Glucosa = 95 mg/dL
3. Descargar PDF
4. Verificar con QR

**Tiempo estimado:** 3 minutos

---

### Caso 2: Orden Completa (Hemograma)

1. Crear orden con: Hemograma Completo
2. Cargar todos los resultados:
   - Hemoglobina: 14.5 g/dL
   - Hematocrito: 42%
   - Leucocitos: 7500 /mm³
   - Plaquetas: 250000 /mm³
   - Neutrófilos: 60%
   - Linfocitos: 30%
3. Agregar observación: "Valores dentro de rangos normales"
4. Descargar PDF
5. Verificar autenticidad

**Tiempo estimado:** 5 minutos

---

### Caso 3: Orden Múltiple (Perfil Completo)

1. Crear orden con varios exámenes:
   - Hemograma Completo
   - Glicemia en Ayunas
   - Perfil Lipídico
   - Creatinina
2. Cargar resultados para todos
3. Descargar PDF
4. Verificar que todos los exámenes aparezcan

**Tiempo estimado:** 10 minutos

---

## Exámenes Disponibles (Datos de Ejemplo)

### Hematología
- **Hemograma Completo** - $25.00
  - 6 parámetros

### Química Sanguínea
- **Glicemia en Ayunas** - $8.00
  - 1 parámetro
- **Perfil Lipídico** - $35.00
  - 4 parámetros
- **Creatinina** - $10.00
  - 1 parámetro

### Urianálisis
- **Examen General de Orina** - $12.00
  - 6 parámetros

### Inmunología
- **Proteína C Reactiva** - $15.00
  - 1 parámetro

### Hormonas
- **TSH** - $20.00
  - 1 parámetro

---

## Filtros y Búsquedas

### Filtrar Órdenes por Estado
En el listado principal:
- Todos
- Pendientes (sin resultados)
- En Proceso
- Completados (con resultados)
- Cancelados

### Buscar Pacientes
Al crear orden, el select de pacientes permite buscar por:
- Nombre
- Cédula
- Email

---

## Validaciones Implementadas

### Al Crear Orden:
- ✅ Paciente es requerido
- ✅ Clínica es requerida
- ✅ Fecha de orden es requerida
- ✅ Debe seleccionar al menos 1 examen
- ✅ El total se calcula automáticamente

### Al Cargar Resultados:
- ✅ Fecha de muestra es requerida
- ✅ Fecha de resultados es requerida
- ✅ Fecha de resultados debe ser igual o posterior a fecha de muestra
- ✅ Los valores se pueden dejar vacíos (opcional)

---

## Troubleshooting

### Si no aparece la opción de Laboratorio:
1. Verificar que el usuario tenga rol `laboratorio`, `admin_clinica` o `super-admin`
2. Ir directamente a `/lab/orders`

### Si no se genera el PDF:
1. Verificar que la orden esté en estado "Completado"
2. Verificar que DomPDF esté instalado: `composer require barryvdh/laravel-dompdf`

### Si no se muestra el QR:
1. Verificar que SimpleSoftwareIO esté instalado: `composer require simplesoftwareio/simple-qrcode`
2. Limpiar caché: `php artisan view:clear`

### Si no hay exámenes disponibles:
1. Ejecutar el seeder: `php artisan db:seed --class=LabDataSeeder`

---

## URLs Importantes

- Login: `/login`
- Listado de Órdenes: `/lab/orders`
- Nueva Orden: `/lab/orders/create`
- Verificación Pública: `/verificar-orden-laboratorio/{codigo}`

---

## Notas para Demostración

### Preparar antes:
1. Tener el sistema corriendo
2. Tener las credenciales a mano
3. Tener un celular para escanear QR
4. Tener al menos un paciente registrado

### Demostrar en orden:
1. Crear una orden nueva
2. Mostrar el listado con filtros
3. Cargar resultados a la orden
4. Descargar el PDF
5. Escanear el QR con celular
6. Mostrar la verificación pública

### Destacar:
- Facilidad de uso
- Organización por categorías
- Cálculo automático de total
- Generación automática de código QR
- Verificación pública sin login
- PDF profesional listo para imprimir
- Seguridad anti-falsificación

---

## Comandos Útiles

```bash
# Ver datos de ejemplo
php artisan db:seed --class=LabDataSeeder

# Limpiar caché
php artisan cache:clear
php artisan view:clear

# Ver rutas
php artisan route:list --name=lab
```

---

**¡Listo para probar!** 🎉

El sistema está completamente funcional y listo para usar.
