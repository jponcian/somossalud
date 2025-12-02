# Configuración de WhatsApp para SomosSalud

## Variables de entorno a agregar en .env

Agrega las siguientes líneas al final de tu archivo `.env`:

```env
# WhatsApp API (UltraMsg)
WHATSAPP_ENABLED=true
WHATSAPP_INSTANCE_ID=instance152977
WHATSAPP_TOKEN=35uuhzm4pkblah6q
WHATSAPP_API_URL=https://api.ultramsg.com
```

## Verificar

1. Abre tu archivo `.env` en el proyecto
2. Agrega las líneas de arriba al final del archivo
3. Guarda el archivo
4. Limpia la caché de configuración ejecutando:
   ```bash
   php artisan config:clear
   ```

## Probar

1. Ve a http://localhost/somossalud/public/admin/users
2. Verás un botón verde de WhatsApp en cada usuario
3. Haz clic en cualquier botón
4. El sistema enviará un mensaje de prueba al número +584144679693
5. Recibirás una alerta de éxito o error

## Nota

Por ahora, todos los mensajes se envían al número de prueba +584144679693, independientemente del usuario que selecciones. Esto es solo para probar que la integración funciona correctamente.
