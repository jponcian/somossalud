<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ClinicaSeeder extends Seeder
{
    public function run()
    {
        DB::table('clinicas')->insert([
            'nombre' => 'SaludSonrisa',
            'direccion' => 'Calle Principal 123',
            'telefono' => '+57 300 0000000',
            'descuento' => 10,
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
