<?php

namespace Database\Seeders;

use App\Models\Especialidad;
use Illuminate\Database\Seeder;
use Illuminate\Support\Str;

class EspecialidadSeeder extends Seeder
{
    public function run(): void
    {
        $especialidades = [
            'Anestesiología',
            'Cardiología',
            'Cirugía',
            'Dermatología',
            'Ecografía',
            'Enfermería',
            'Fisioterapia',
            'Fisitría',
            'Gastrología',
            'Ginecología',
            'Laboratorio',
            'Medicina Interna',
            'Nefrología',
            'Neumología',
            'Neurología',
            'Nutrición',
            'Odontología',
            'Oftalmología',
            'Oncología',
            'Ortodoncia',
            'Otorrinología',
            'Pediatría',
            'Psicología',
            'Psiquiatría',
            'Quirofano',
            'Traumatología',
            'Urología',
            'Medicina General',
        ];

        $nombres = collect($especialidades);

        Especialidad::whereNotIn('nombre', $nombres->all())->delete();

        $nombres->each(function (string $nombre) {
            Especialidad::updateOrCreate(
                ['slug' => Str::slug($nombre)],
                [
                    'nombre' => $nombre,
                    'descripcion' => null,
                ]
            );
        });
    }
}
