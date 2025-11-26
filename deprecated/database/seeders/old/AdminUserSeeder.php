<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

class AdminUserSeeder extends Seeder
{
    public function run()
    {
        $user = User::firstOrCreate(
            ['email' => 'admin@saludsonrisa.com'],
            [
                'name' => 'Super Administrador',
                'cedula' => 'V-12345678', // Formato actualizado con letra al inicio
                'password' => Hash::make('admin123'),
            ]
        );

        if (method_exists($user, 'assignRole')) {
            $user->assignRole('super-admin');
        }
    }
}
