<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Clinica;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class FreshAdminSeeder extends Seeder
{
    /**
     * Limpia la tabla de usuarios y crea un super admin con el nuevo formato de cédula.
     */
    public function run(): void
    {
        // Desactivar verificación de claves foráneas temporalmente
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        // Limpiar tablas relacionadas
        DB::table('model_has_roles')->truncate();
        DB::table('model_has_permissions')->truncate();
        
        // Limpiar tabla de usuarios
        DB::table('usuarios')->truncate();

        // Reactivar verificación de claves foráneas
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        $this->command->info('✅ Tabla de usuarios limpiada correctamente');

        // Obtener la clínica por defecto (o crear una si no existe)
        $clinica = Clinica::firstOrCreate(
            ['nombre' => 'SaludSonrisa'],
            [
                'direccion' => 'Caracas, Venezuela',
                'telefono' => '+58-212-1234567',
                'email' => 'info@saludsonrisa.com'
            ]
        );

        $this->command->info('✅ Clínica verificada: ' . $clinica->nombre);

        // Crear usuario super admin con el nuevo formato de cédula
        $admin = User::create([
            'name' => 'Super Administrador',
            'email' => 'admin@saludsonrisa.com',
            'cedula' => 'V-12345678', // Formato nuevo con letra al inicio
            'password' => Hash::make('admin123'), // Contraseña: admin123
            'clinica_id' => $clinica->id,
            'email_verified_at' => now(),
        ]);

        // Asignar rol de super-admin
        if (method_exists($admin, 'assignRole')) {
            $admin->assignRole('super-admin');
        }

        $this->command->info('✅ Super Admin creado exitosamente');
        $this->command->info('');
        $this->command->info('═══════════════════════════════════════════════════════');
        $this->command->info('📋 CREDENCIALES DEL SUPER ADMINISTRADOR');
        $this->command->info('═══════════════════════════════════════════════════════');
        $this->command->info('👤 Nombre:      ' . $admin->name);
        $this->command->info('📧 Email:       ' . $admin->email);
        $this->command->info('🆔 Cédula:      ' . $admin->cedula);
        $this->command->info('🔑 Contraseña:  admin123');
        $this->command->info('🏥 Clínica:     ' . $clinica->nombre);
        $this->command->info('═══════════════════════════════════════════════════════');
        $this->command->info('');
        $this->command->info('💡 Puedes iniciar sesión con la cédula: V-12345678');
        $this->command->info('💡 O con el email: admin@saludsonrisa.com');
        $this->command->info('');
    }
}
