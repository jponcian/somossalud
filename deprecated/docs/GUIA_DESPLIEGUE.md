# 🚀 Guía de Despliegue a Producción - Clínica SaludSonrisa
**Fecha:** 23 de Noviembre de 2025
**Versión:** Módulo Laboratorio + Ajustes Generales

---

## ⚠️ Antes de Empezar
1. **Haz un BACKUP** de la base de datos de producción actual.
2. **Haz un BACKUP** de los archivos del servidor (especialmente `.env` y carpeta `storage`).

---

## 📦 Paso 1: Subida de Archivos

Debes subir los cambios recientes. Si usas Git, haz `git pull`. Si subes por FTP/SFTP, asegúrate de actualizar:

1. **Carpetas Críticas:**
   - `app/` (Modelos y Controladores nuevos)
   - `resources/views/` (Nuevas vistas de laboratorio y panel paciente)
   - `routes/web.php` (Nuevas rutas)
   - `database/migrations/` (Nuevas migraciones)
   - `composer.json` y `composer.lock` (Nuevas dependencias)

2. **Carpeta Vendor (IMPORTANTE):**
   - Como instalamos `dompdf` y `simple-qrcode`, la carpeta `vendor` ha cambiado.
   - **Si tienes acceso SSH:** No subas `vendor`. Ejecuta `composer install` en el servidor (ver Paso 2).
   - **Si NO tienes acceso SSH (Hosting compartido):** Debes subir tu carpeta `vendor` local completa al servidor, reemplazando la existente.

---

## 🛠️ Paso 2: Comandos en el Servidor (SSH)

Si tienes acceso a terminal en el servidor, ejecuta estos comandos en la raíz del proyecto:

### 1. Instalar Dependencias
```bash
composer install --optimize-autoloader --no-dev
```

### 2. Ejecutar Migraciones
Esto creará la tabla `resultados_laboratorio` y actualizará las existentes.
```bash
php artisan migrate
```
*Nota: Si te pregunta confirmación por estar en producción, escribe `yes`.*

### 3. Limpiar Cachés (Vital para que aparezcan las nuevas rutas y vistas)
```bash
php artisan config:cache
php artisan route:cache
php artisan view:cache
```

### 4. Enlace Simbólico (Si no existe)
Para que se vean los PDFs y archivos públicos.
```bash
php artisan storage:link
```

---

## ⚙️ Paso 3: Configuración del Entorno (.env)

Edita el archivo `.env` en el servidor y asegúrate de tener estas configuraciones:

```env
APP_NAME=SomosSalud
APP_ENV=production
APP_KEY=base64:...(tu_key_actual)...
APP_DEBUG=false
APP_URL=https://clinicasaludsonrisa.com.ve

# Base de Datos (Tus credenciales de producción)
DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=...(tu_bd)...
DB_USERNAME=...(tu_usuario)...
DB_PASSWORD=...(tu_password)...
```

**IMPORTANTE:** La variable `APP_URL` debe ser exacta (`https://clinicasaludsonrisa.com.ve`) para que los códigos QR generados funcionen correctamente.

---

## 🧪 Paso 4: Verificación Post-Despliegue

1. **Verificar Login:** Intenta iniciar sesión.
2. **Verificar Módulo Laboratorio:**
   - Entra como administrador o laboratorio.
   - Ve a `/laboratorio` (o busca en el menú).
   - Intenta cargar un resultado de prueba.
3. **Verificar PDF y QR:**
   - Genera el PDF del resultado.
   - Escanea el QR con tu celular.
   - **Debe llevarte a:** `https://clinicasaludsonrisa.com.ve/verificar-resultado/...`
4. **Verificar Panel Paciente:**
   - Entra como el paciente del resultado.
   - Verifica que pueda ver y descargar su resultado.

---

## 🆘 Solución de Problemas Comunes

### Error 500 al entrar
- Revisa los permisos de las carpetas `storage` y `bootstrap/cache`. Deben tener permisos de escritura (775 o 777 según el hosting).
- Revisa los logs en `storage/logs/laravel.log`.

### "Class not found" (DomPDF o QrCode)
- Significa que la carpeta `vendor` no se actualizó bien.
- Ejecuta `composer install` de nuevo o vuelve a subir la carpeta `vendor` completa.

### El QR apunta a "localhost"
- No configuraste `APP_URL` en el `.env` de producción.
- Corrige el `.env` y ejecuta `php artisan config:cache`.

### Las imágenes del PDF no cargan
- Asegúrate de haber ejecutado `php artisan storage:link`.
- Verifica que `APP_URL` sea correcta (https vs http).

---

**¡Éxito con el despliegue!** 🚀
