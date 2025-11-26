<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Suscripcion;
use Illuminate\Support\Facades\Hash;

class TestUsersSeeder extends Seeder
{
    public function run()
    {
        // Obtener clínica por defecto
        $clinicaId = \App\Models\Clinica::first()?->id ?? null;

        // Paciente sin suscripción
        $sin = User::firstOrCreate([
            'cedula' => '20000000'
        ], [
            'name' => 'Paciente Sin Suscripcion',
            'password' => Hash::make('password'),
            'clinica_id' => $clinicaId,
        ]);
        if (method_exists($sin, 'assignRole')) {
            $sin->assignRole('paciente');
        }

        // Paciente con suscripción activa
        $con = User::firstOrCreate([
            'cedula' => '30000000'
        ], [
            'name' => 'Paciente Con Suscripcion',
            'password' => Hash::make('password'),
            'clinica_id' => $clinicaId,
        ]);
        if (method_exists($con, 'assignRole')) {
            $con->assignRole('paciente');
        }

        // Crear suscripción activa para $con si no existe
        $exists = Suscripcion::where('usuario_id', $con->id)->exists();
        if (!$exists) {
            $inicio = now()->toDateString();
            $vencimiento = now()->addYear()->toDateString();

            Suscripcion::create([
                'usuario_id' => $con->id,
                'plan' => 'anual',
                'precio' => 10.00,
                'periodo_inicio' => $inicio,
                'periodo_vencimiento' => $vencimiento,
                'estado' => 'activo',
                'metodo_pago' => 'sandbox',
                'transaccion_id' => 'sandbox-' . uniqid(),
            ]);
        }
    }
}
