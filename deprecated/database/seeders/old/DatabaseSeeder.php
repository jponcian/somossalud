<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    use WithoutModelEvents;

    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Seed básico: clínica, roles y admin
        $this->call([
            \Database\Seeders\ClinicaSeeder::class,
            \Database\Seeders\RolesSeeder::class,
            \Database\Seeders\EspecialidadSeeder::class,
            \Database\Seeders\AdminUserSeeder::class,
            \Database\Seeders\TestUsersSeeder::class,
            \Database\Seeders\MaterialesSeeder::class,
        ]);
    }
}
