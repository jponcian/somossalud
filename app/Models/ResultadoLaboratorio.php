<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ResultadoLaboratorio extends Model
{
    use HasFactory;

    protected $table = 'resultados_laboratorio';

    protected $fillable = [
        'paciente_id',
        'clinica_id',
        'tipo_examen',
        'nombre_examen',
        'fecha_muestra',
        'fecha_resultado',
        'resultados_json',
        'observaciones',
        'archivo_path',
        'codigo_verificacion',
        'registrado_por',
    ];

    protected $casts = [
        'fecha_muestra' => 'date',
        'fecha_resultado' => 'date',
        'resultados_json' => 'array',
    ];

    /**
     * Relación con el paciente
     */
    public function paciente()
    {
        return $this->belongsTo(User::class, 'paciente_id');
    }

    /**
     * Relación con la clínica
     */
    public function clinica()
    {
        return $this->belongsTo(Clinica::class, 'clinica_id');
    }

    /**
     * Relación con el usuario que registró el resultado
     */
    public function registradoPor()
    {
        return $this->belongsTo(User::class, 'registrado_por');
    }

    /**
     * Generar código único de verificación
     */
    public static function generarCodigoVerificacion()
    {
        do {
            $codigo = strtoupper(substr(md5(uniqid(rand(), true)), 0, 12));
        } while (self::where('codigo_verificacion', $codigo)->exists());

        return $codigo;
    }

    /**
     * Obtener URL de verificación pública
     */
    public function getUrlVerificacionAttribute()
    {
        return route('laboratorio.verificar', $this->codigo_verificacion);
    }
}
