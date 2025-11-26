<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\User;
use App\Models\Clinica;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB;

class ResetSystemSeeder extends Seeder
{
    /**
     * Resetea completamente el sistema eliminando todos los datos de usuarios,
     * citas, atenciones, suscripciones y todo lo relacionado.
     * Deja solo la configuración básica (roles, especialidades, clínica).
     */
    public function run(): void
    {
        $this->command->info('🔄 Iniciando reseteo completo del sistema...');
        $this->command->info('');

        // Desactivar verificación de claves foráneas temporalmente
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        $this->command->info('🗑️  Limpiando todas las tablas principales y relaciones...');

        // Truncar todas las tablas relevantes
        $tablas = [
            // Usuarios y relaciones
            'model_has_roles',
            'model_has_permissions',
            'usuarios',
            'especialidad_usuario',
            'especialidades',
            // Clínicas
            'clinicas',
            // Citas y relaciones
            'citas',
            'cita_medicamentos',
            'cita_adjuntos',
            // Atenciones y relaciones
            'atenciones',
            'atencion_medicamentos',
            'atencion_adjuntos',
            // Laboratorio
            'lab_orders',
            'lab_order_details',
            'lab_results',
            'lab_exams',
            'lab_exam_items',
            'lab_categories',
            'lab_reference_groups',
            'lab_reference_ranges',
            // Inventario
            'materiales',
            'solicitudes_inventario',
            'items_solicitud_inventario',
            // Suscripciones y pagos
            'pagos_reportados',
            'suscripciones',
            // Disponibilidad
            'disponibilidades',
            // Configuración y otros
            'settings',
            'exchange_rates',
        ];

        foreach ($tablas as $tabla) {
            if (DB::getSchemaBuilder()->hasTable($tabla)) {
                DB::table($tabla)->truncate();
                $this->command->info('   ✅ Tabla limpiada: ' . $tabla);
            }
        }

        // Reactivar verificación de claves foráneas
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        $this->command->info('');
        $this->command->info('✅ Sistema limpiado completamente');
        $this->command->info('');

        // ==========================================
        // CREAR DATOS BÁSICOS
        // ==========================================

        $this->command->info('🏗️  Creando configuración básica...');
        $this->command->info('');

        // Verificar/Crear clínica por defecto
        $clinica = Clinica::firstOrCreate(
            ['nombre' => 'SaludSonrisa'],
            [
                'direccion' => 'Caracas, Venezuela',
                'telefono' => '+58-212-1234567',
                'email' => 'info@saludsonrisa.com'
            ]
        );

        $this->command->info('   ✅ Clínica: ' . $clinica->nombre);

        // Crear usuario super admin
        $admin = User::create([
            'name' => 'Super Administrador',
            'email' => 'admin@saludsonrisa.com',
            'cedula' => 'V-12345678',
            'password' => Hash::make('admin123'),
            'clinica_id' => $clinica->id,
            'email_verified_at' => now(),
        ]);

        // Asignar rol de super-admin
        if (method_exists($admin, 'assignRole')) {
            $admin->assignRole('super-admin');
        }

        $this->command->info('   ✅ Super Admin creado');
        $this->command->info('');

        // ==========================================
        // MOSTRAR RESUMEN
        // ==========================================

        $this->command->info('═══════════════════════════════════════════════════════');
        $this->command->info('🎉 SISTEMA RESETEADO EXITOSAMENTE');
        $this->command->info('═══════════════════════════════════════════════════════');
        $this->command->info('');
        $this->command->info('📊 TABLAS LIMPIADAS:');
        $this->command->info('   ✅ usuarios');
        $this->command->info('   ✅ citas + cita_adjuntos + cita_medicamentos');
        $this->command->info('   ✅ atenciones + atencion_adjuntos + atencion_medicamentos');
        $this->command->info('   ✅ suscripciones + pagos_reportados');
        $this->command->info('   ✅ disponibilidades');
        $this->command->info('   ✅ resultados_laboratorio');
        $this->command->info('   ✅ especialidad_usuario');
        $this->command->info('   ✅ model_has_roles + model_has_permissions');
        $this->command->info('');
        $this->command->info('🏗️  DATOS PRESERVADOS:');
        $this->command->info('   ✅ Roles (super-admin, admin_clinica, especialista, etc.)');
        $this->command->info('   ✅ Especialidades (Cardiología, Pediatría, etc.)');
        $this->command->info('   ✅ Clínicas');
        $this->command->info('   ✅ Configuraciones del sistema');
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
        $this->command->info('💡 Puedes iniciar sesión con:');
        $this->command->info('   • Cédula: V-12345678');
        $this->command->info('   • Email: admin@saludsonrisa.com');
        $this->command->info('   • Contraseña: admin123');
        $this->command->info('');
        $this->command->info('🚀 El sistema está listo para comenzar de nuevo!');
        $this->command->info('');
    }
}
