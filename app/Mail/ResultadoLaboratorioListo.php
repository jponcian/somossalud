<?php

namespace App\Mail;

use App\Models\ResultadoLaboratorio;
use App\Models\User;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class ResultadoLaboratorioListo extends Mailable
{
    use Queueable, SerializesModels;

    public $resultado;
    public $paciente;
    public $tieneEmailTemporal;

    /**
     * Create a new message instance.
     */
    public function __construct(ResultadoLaboratorio $resultado, User $paciente)
    {
        $this->resultado = $resultado;
        $this->paciente = $paciente;
        $this->tieneEmailTemporal = str_ends_with($paciente->email, '@paciente.temp');
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Tus Resultados de Laboratorio Están Listos 🔬',
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            view: 'emails.resultado-listo',
        );
    }

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}
