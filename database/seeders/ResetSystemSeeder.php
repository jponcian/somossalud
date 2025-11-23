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

        // ==========================================
        // LIMPIAR TABLAS RELACIONADAS CON USUARIOS
        // ==========================================
        
        $this->command->info('🗑️  Limpiando datos de usuarios y relaciones...');
        
        // Roles y permisos de usuarios
        DB::table('model_has_roles')->truncate();
        DB::table('model_has_permissions')->truncate();
        
        // Usuarios
        DB::table('usuarios')->truncate();
        
        $this->command->info('   ✅ Usuarios eliminados');

        // ==========================================
        // LIMPIAR TABLAS DE CITAS
        // ==========================================
        
        $this->command->info('🗑️  Limpiando citas y datos relacionados...');
        
        // Adjuntos y medicamentos de citas
        DB::table('cita_adjuntos')->truncate();
        DB::table('cita_medicamentos')->truncate();
        
        // Citas
        DB::table('citas')->truncate();
        
        $this->command->info('   ✅ Citas eliminadas');

        // ==========================================
        // LIMPIAR TABLAS DE ATENCIONES
        // ==========================================
        
        $this->command->info('🗑️  Limpiando atenciones y datos relacionados...');
        
        // Adjuntos y medicamentos de atenciones
        DB::table('atencion_adjuntos')->truncate();
        DB::table('atencion_medicamentos')->truncate();
        
        // Atenciones
        DB::table('atenciones')->truncate();
        
        $this->command->info('   ✅ Atenciones eliminadas');

        // ==========================================
        // LIMPIAR TABLAS DE SUSCRIPCIONES Y PAGOS
        // ==========================================
        
        $this->command->info('🗑️  Limpiando suscripciones y pagos...');
        
        // Reportes de pago
        DB::table('pagos_reportados')->truncate();
        
        // Suscripciones
        DB::table('suscripciones')->truncate();
        
        $this->command->info('   ✅ Suscripciones y pagos eliminados');

        // ==========================================
        // LIMPIAR TABLAS DE DISPONIBILIDAD
        // ==========================================
        
        $this->command->info('🗑️  Limpiando horarios de disponibilidad...');
        
        DB::table('disponibilidades')->truncate();
        
        $this->command->info('   ✅ Disponibilidades eliminadas');

        // ==========================================
        // LIMPIAR TABLAS DE LABORATORIO
        // ==========================================
        
        $this->command->info('🗑️  Limpiando resultados de laboratorio...');
        
        if (DB::getSchemaBuilder()->hasTable('resultados_laboratorio')) {
            DB::table('resultados_laboratorio')->truncate();
            $this->command->info('   ✅ Resultados de laboratorio eliminados');
        }

        // ==========================================
        // LIMPIAR RELACIÓN ESPECIALIDADES-USUARIOS
        // ==========================================
        
        $this->command->info('🗑️  Limpiando relaciones de especialidades...');
        
        if (DB::getSchemaBuilder()->hasTable('especialidad_usuario')) {
            DB::table('especialidad_usuario')->truncate();
            $this->command->info('   ✅ Relaciones especialidad-usuario eliminadas');
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
