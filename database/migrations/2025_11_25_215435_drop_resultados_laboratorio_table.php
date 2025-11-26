<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::dropIfExists('resultados_laboratorio');
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Recrear la tabla si se hace rollback
        Schema::create('resultados_laboratorio', function (Blueprint $table) {
            $table->id();
            $table->foreignId('paciente_id')->constrained('usuarios')->cascadeOnDelete();
            $table->foreignId('clinica_id')->constrained('clinicas')->cascadeOnDelete();
            $table->string('tipo_examen');
            $table->string('nombre_examen');
            $table->date('fecha_muestra');
            $table->date('fecha_resultado');
            $table->json('resultados_json')->nullable();
            $table->text('observaciones')->nullable();
            $table->string('archivo_path')->nullable();
            $table->string('codigo_verificacion', 12)->unique();
            $table->foreignId('registrado_por')->nullable()->constrained('usuarios')->nullOnDelete();
            $table->timestamps();
            
            $table->index('codigo_verificacion');
        });
    }
};
