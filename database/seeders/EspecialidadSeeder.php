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
            ['nombre' => 'Medicina General', 'descripcion' => 'Atención primaria y seguimiento de pacientes.'],
            ['nombre' => 'Pediatría', 'descripcion' => 'Salud integral para niños y adolescentes.'],
            ['nombre' => 'Odontología', 'descripcion' => 'Prevención y tratamiento de salud bucal.'],
            ['nombre' => 'Ginecología', 'descripcion' => 'Salud sexual y reproductiva de la mujer.'],
            ['nombre' => 'Cardiología', 'descripcion' => 'Diagnóstico y manejo de enfermedades cardiovasculares.'],
        ];

        foreach ($especialidades as $especialidad) {
            Especialidad::updateOrCreate(
                ['slug' => Str::slug($especialidad['nombre'])],
                [
                    'nombre' => $especialidad['nombre'],
                    'descripcion' => $especialidad['descripcion'],
                ]
            );
        }
    }
}
