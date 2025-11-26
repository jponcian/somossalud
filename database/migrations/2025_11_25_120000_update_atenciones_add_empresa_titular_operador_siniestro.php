<?php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::table('atenciones', function (Blueprint $table) {
            $table->string('empresa', 150)->nullable()->after('clinica_id');
            $table->foreignId('titular_id')->nullable()->after('paciente_id')->constrained('usuarios')->nullOnDelete();
            $table->string('titular_nombre', 150)->nullable()->after('titular_id');
            $table->string('titular_cedula', 30)->nullable()->after('titular_nombre');
            $table->string('titular_telefono', 30)->nullable()->after('titular_cedula');
            $table->string('nombre_operador', 150)->nullable()->after('recepcionista_id');
            $table->string('numero_siniestro', 150)->nullable()->after('aseguradora');
            // Eliminar campos antiguos
            $table->dropColumn(['poliza','numero_seguro']);
        });
        // Opcional: eliminar médico si ya no se usa
        Schema::table('atenciones', function (Blueprint $table) {
            if (Schema::hasColumn('atenciones', 'medico_id')) {
                $table->dropForeign(['medico_id']);
                $table->dropColumn('medico_id');
            }
        });
    }

    public function down(): void
    {
        Schema::table('atenciones', function (Blueprint $table) {
            $table->dropColumn(['empresa','titular_id','titular_nombre','titular_cedula','titular_telefono','nombre_operador','numero_siniestro']);
            $table->string('poliza', 150)->nullable();
            $table->string('numero_seguro', 150)->nullable();
            $table->foreignId('medico_id')->nullable()->constrained('usuarios')->nullOnDelete();
        });
    }
};
