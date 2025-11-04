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
            ['email' => 'admin@saludsonrisa.test'],
            [
                'name' => 'Admin SaludSonrisa',
                'cedula' => '12345678',
                'password' => Hash::make('password'),
            ]
        );

        if (method_exists($user, 'assignRole')) {
            $user->assignRole('super-admin');
        }
    }
}
