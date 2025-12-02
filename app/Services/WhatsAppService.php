<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class WhatsAppService
{
    protected $instanceId;
    protected $token;
    protected $apiUrl;

    public function __construct()
    {
        $this->instanceId = config('whatsapp.instance_id');
        $this->token = config('whatsapp.token');
        $this->apiUrl = config('whatsapp.api_url');
    }

    /**
     * Enviar mensaje de texto simple
     * 
     * @param string $to Número de teléfono en formato internacional (+584144679693)
     * @param string $message Mensaje a enviar
     * @param int $priority Prioridad (1=alta, 5=media, 10=baja)
     * @return array
     */
    public function sendMessage($to, $message, $priority = 10)
    {
        try {
            $url = "{$this->apiUrl}/{$this->instanceId}/messages/chat";
            
            $response = Http::asForm()->post($url, [
                'token' => $this->token,
                'to' => $to,
                'body' => $message,
                'priority' => $priority
            ]);

            $result = $response->json();

            // Log para debugging
            Log::info('WhatsApp message sent', [
                'to' => $to,
                'response' => $result
            ]);

            return [
                'success' => $response->successful(),
                'data' => $result
            ];

        } catch (\Exception $e) {
            Log::error('WhatsApp send error', [
                'to' => $to,
                'error' => $e->getMessage()
            ]);

            return [
                'success' => false,
                'error' => $e->getMessage()
            ];
        }
    }

    /**
     * Verificar si el servicio está habilitado
     * 
     * @return bool
     */
    public function isEnabled()
    {
        return config('whatsapp.enabled', false) && 
               !empty($this->instanceId) && 
               !empty($this->token);
    }
}
