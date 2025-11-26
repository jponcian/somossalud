<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Clinica;
use App\Models\ResultadoLaboratorio;
use Spatie\Permission\Models\Role;

class LaboratorioSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Crear rol de laboratorio si no existe
        $rolLaboratorio = Role::firstOrCreate(['name' => 'laboratorio']);

        // Obtener o crear una clínica
        $clinica = Clinica::first();
        if (!$clinica) {
            $clinica = Clinica::create([
                'nombre' => 'Clínica Principal',
                'direccion' => 'Av. Principal, Caracas',
                'telefono' => '0212-1234567',
            ]);
        }

        // Crear usuario de laboratorio si no existe
        $laboratorista = User::where('email', 'laboratorio@somossalud.com')->first();
        if (!$laboratorista) {
            $laboratorista = User::create([
                'name' => 'Usuario Laboratorio',
                'email' => 'laboratorio@somossalud.com',
                'password' => bcrypt('password'),
                'cedula' => 'V-12345678',
                'clinica_id' => $clinica->id,
            ]);
            $laboratorista->assignRole($rolLaboratorio);
        }

        // Crear un paciente de prueba si no existe
        $rolPaciente = Role::firstOrCreate(['name' => 'paciente']);
        $paciente = User::where('email', 'paciente@test.com')->first();
        if (!$paciente) {
            $paciente = User::create([
                'name' => 'Juan Pérez',
                'email' => 'paciente@test.com',
                'password' => bcrypt('password'),
                'cedula' => 'V-98765432',
                'clinica_id' => $clinica->id,
            ]);
            $paciente->assignRole($rolPaciente);
        }

        // Crear resultado de ejemplo 1: Hemograma
        ResultadoLaboratorio::create([
            'paciente_id' => $paciente->id,
            'clinica_id' => $clinica->id,
            'tipo_examen' => 'Hematología',
            'nombre_examen' => 'Hemograma Completo',
            'fecha_muestra' => now()->subDays(2),
            'fecha_resultado' => now()->subDay(),
            'resultados_json' => [
                [
                    'parametro' => 'Hemoglobina',
                    'valor' => '14.5',
                    'unidad' => 'g/dL',
                    'rango_referencia' => '12-16 g/dL',
                ],
                [
                    'parametro' => 'Hematocrito',
                    'valor' => '42',
                    'unidad' => '%',
                    'rango_referencia' => '37-47%',
                ],
                [
                    'parametro' => 'Leucocitos',
                    'valor' => '7500',
                    'unidad' => '/mm³',
                    'rango_referencia' => '4000-11000/mm³',
                ],
                [
                    'parametro' => 'Plaquetas',
                    'valor' => '250000',
                    'unidad' => '/mm³',
                    'rango_referencia' => '150000-400000/mm³',
                ],
            ],
            'observaciones' => 'Valores dentro de los rangos normales.',
            'codigo_verificacion' => ResultadoLaboratorio::generarCodigoVerificacion(),
            'registrado_por' => $laboratorista->id,
        ]);

        // Crear resultado de ejemplo 2: Química Sanguínea
        ResultadoLaboratorio::create([
            'paciente_id' => $paciente->id,
            'clinica_id' => $clinica->id,
            'tipo_examen' => 'Química Sanguínea',
            'nombre_examen' => 'Perfil Lipídico',
            'fecha_muestra' => now()->subDays(5),
            'fecha_resultado' => now()->subDays(3),
            'resultados_json' => [
                [
                    'parametro' => 'Colesterol Total',
                    'valor' => '180',
                    'unidad' => 'mg/dL',
                    'rango_referencia' => '<200 mg/dL',
                ],
                [
                    'parametro' => 'HDL Colesterol',
                    'valor' => '55',
                    'unidad' => 'mg/dL',
                    'rango_referencia' => '>40 mg/dL',
                ],
                [
                    'parametro' => 'LDL Colesterol',
                    'valor' => '110',
                    'unidad' => 'mg/dL',
                    'rango_referencia' => '<130 mg/dL',
                ],
                [
                    'parametro' => 'Triglicéridos',
                    'valor' => '120',
                    'unidad' => 'mg/dL',
                    'rango_referencia' => '<150 mg/dL',
                ],
            ],
            'observaciones' => 'Perfil lipídico normal. Mantener hábitos saludables.',
            'codigo_verificacion' => ResultadoLaboratorio::generarCodigoVerificacion(),
            'registrado_por' => $laboratorista->id,
        ]);

        // Crear resultado de ejemplo 3: Glicemia
        ResultadoLaboratorio::create([
            'paciente_id' => $paciente->id,
            'clinica_id' => $clinica->id,
            'tipo_examen' => 'Química Sanguínea',
            'nombre_examen' => 'Glicemia en Ayunas',
            'fecha_muestra' => now()->subWeek(),
            'fecha_resultado' => now()->subDays(6),
            'resultados_json' => [
                [
                    'parametro' => 'Glucosa',
                    'valor' => '95',
                    'unidad' => 'mg/dL',
                    'rango_referencia' => '70-100 mg/dL',
                ],
            ],
            'observaciones' => 'Glicemia normal.',
            'codigo_verificacion' => ResultadoLaboratorio::generarCodigoVerificacion(),
            'registrado_por' => $laboratorista->id,
        ]);

        $this->command->info('✓ Datos de laboratorio creados exitosamente');
        $this->command->info('  Usuario laboratorio: laboratorio@somossalud.com / password');
        $this->command->info('  Paciente de prueba: paciente@test.com / password');
        $this->command->info('  Resultados de ejemplo: 3 creados');
    }
}
