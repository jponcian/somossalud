# Guía Rápida de Prueba - Módulo de Laboratorio

## Credenciales de Acceso

### Usuario de Laboratorio
- **Email**: laboratorio@somossalud.com
- **Contraseña**: password
- **Rol**: laboratorio

### Paciente de Prueba
- **Email**: paciente@test.com
- **Contraseña**: password
- **Rol**: paciente

## Pasos para Probar el Módulo

### 1. Acceso como Personal de Laboratorio

1. Ir a: `http://localhost/login` (o tu URL local)
2. Iniciar sesión con: `laboratorio@somossalud.com` / `password`
3. Serás redirigido al panel de clínica
4. En el menú lateral, buscar la opción "Laboratorio" o ir directamente a: `/laboratorio`

### 2. Ver Resultados Existentes

- En `/laboratorio` verás 3 resultados de ejemplo ya creados:
  1. Hemograma Completo
  2. Perfil Lipídico
  3. Glicemia en Ayunas

- Cada resultado muestra:
  - Código de verificación
  - Datos del paciente
  - Tipo y nombre del examen
  - Fechas
  - Clínica
  - Botones de acción (Ver / Descargar PDF)

### 3. Crear un Nuevo Resultado

1. Click en "Nuevo Resultado"
2. Seleccionar paciente (buscar por nombre o cédula)
3. Seleccionar clínica
4. Elegir tipo de examen del dropdown
5. Ingresar nombre del examen
6. Seleccionar fechas
7. Agregar parámetros:
   - Click en "Agregar Parámetro" para más filas
   - Llenar: Parámetro, Valor, Unidad, Rango de Referencia
   - Click en X roja para eliminar un parámetro
8. Agregar observaciones (opcional)
9. Click en "Guardar Resultado"

### 4. Ver Detalle de un Resultado

1. En el listado, click en el botón azul (ojo) de "Ver detalle"
2. Se mostrará:
   - Información completa del paciente
   - Detalles del examen
   - Tabla con todos los resultados
   - Observaciones
   - **QR Code** en el panel derecho
   - Código de verificación
   - Botón para descargar PDF

### 5. Descargar PDF con QR

1. En la vista de detalle, click en "Descargar PDF con QR"
2. Se descargará un PDF profesional que incluye:
   - Encabezado de la clínica
   - QR en la esquina superior derecha
   - Toda la información del resultado
   - Código de verificación
   - Instrucciones de verificación

### 6. Verificar Resultado (Público)

**Opción A: Escanear QR**
1. Imprimir o mostrar el PDF
2. Escanear el QR con un celular
3. Se abrirá la página de verificación pública

**Opción B: URL Directa (Producción)**
1. Copiar el código de verificación (ej: A1B2C3D4E5F6)
2. Ir a: `https://clinicasaludsonrisa.com.ve/verificar-resultado/A1B2C3D4E5F6`
3. Se mostrará la página de verificación

**Página de Verificación Muestra:**
- Badge verde "RESULTADO VERIFICADO Y AUTÉNTICO"
- Código de verificación destacado
- Información del paciente
- Detalles del examen
- Tabla completa de resultados
- Observaciones
- Información de seguridad
- **NO requiere login**

### 7. Vista del Paciente

1. Cerrar sesión
2. Iniciar sesión con: `paciente@test.com` / `password`
3. En el dashboard, click en "Ver mis resultados" (tarjeta azul)
4. Se mostrarán todos los resultados del paciente
5. Cada resultado muestra:
   - Información del examen
   - Tabla de resultados
   - QR de verificación
   - Botón "Descargar PDF"
   - Botón "Verificar" (abre la verificación pública)

## Casos de Uso para Demostrar

### Caso 1: Registro de Resultado Completo
1. Login como laboratorio
2. Crear nuevo resultado de "Urianálisis"
3. Agregar múltiples parámetros (Color, Aspecto, pH, Densidad, etc.)
4. Guardar y mostrar el QR generado

### Caso 2: Verificación de Autenticidad
1. Descargar PDF de un resultado
2. Mostrar el QR en pantalla
3. Escanear con celular
4. Demostrar que se abre la verificación pública
5. Destacar que NO se puede falsificar

### Caso 3: Acceso del Paciente
1. Login como paciente
2. Mostrar todos sus resultados
3. Descargar un PDF
4. Verificar en línea

## Funcionalidades Clave a Destacar

### ✅ Seguridad
- Código único de 12 caracteres
- QR vinculado a URL de verificación
- Imposible de duplicar o falsificar
- Verificación pública sin login

### ✅ Usabilidad
- Formulario intuitivo
- Campos dinámicos (agregar/eliminar parámetros)
- Búsqueda de pacientes
- Tipos de examen predefinidos

### ✅ Diseño
- Interfaz moderna y profesional
- PDF listo para imprimir
- Responsive (funciona en móvil)
- Colores distintivos (morado/azul para laboratorio)

### ✅ Accesibilidad
- Pacientes pueden ver sus resultados 24/7
- Descarga de PDF en cualquier momento
- Verificación pública para terceros
- Historial completo

## Datos de Ejemplo Creados

### Resultado 1: Hemograma Completo
- Tipo: Hematología
- Parámetros: Hemoglobina, Hematocrito, Leucocitos, Plaquetas
- Estado: Valores normales

### Resultado 2: Perfil Lipídico
- Tipo: Química Sanguínea
- Parámetros: Colesterol Total, HDL, LDL, Triglicéridos
- Estado: Perfil normal

### Resultado 3: Glicemia en Ayunas
- Tipo: Química Sanguínea
- Parámetros: Glucosa
- Estado: Normal

## Troubleshooting

### Si no aparece la opción de Laboratorio en el menú:
1. Verificar que el usuario tenga el rol "laboratorio"
2. Ir directamente a `/laboratorio`

### Si el QR no se genera:
1. Verificar que esté instalado `simplesoftwareio/simple-qrcode`
2. Ejecutar: `composer dump-autoload`

### Si el PDF no se descarga:
1. Verificar que esté instalado `barryvdh/laravel-dompdf`
2. Verificar permisos de escritura en `storage/`

## URLs Importantes

- Login: `/login`
- Panel Laboratorio: `/laboratorio`
- Crear Resultado: `/laboratorio/crear`
- Resultados del Paciente: `/mis-resultados`
- Verificación Pública: `/verificar-resultado/{codigo}`

## Notas para la Presentación

1. **Preparar antes**:
   - Tener el sistema corriendo
   - Tener las credenciales a mano
   - Tener un celular para escanear QR

2. **Demostrar en orden**:
   - Primero: Carga de resultado (como laboratorio)
   - Segundo: Generación de PDF con QR
   - Tercero: Escaneo del QR (verificación)
   - Cuarto: Vista del paciente

3. **Destacar**:
   - Facilidad de uso
   - Seguridad (anti-falsificación)
   - Accesibilidad para pacientes
   - Profesionalismo del PDF

4. **Tener listo**:
   - Un resultado de ejemplo ya impreso
   - El QR visible para escanear
   - Navegador en modo presentación

---

**¡Listo para la presentación!** 🎉

Si necesitas crear más datos de prueba, ejecuta:
```bash
php artisan db:seed --class=LaboratorioSeeder
```
