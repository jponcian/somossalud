<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('atenciones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('paciente_id')->constrained('usuarios')->cascadeOnDelete();
            $table->foreignId('clinica_id')->constrained('clinicas')->cascadeOnDelete();
            $table->foreignId('recepcionista_id')->nullable()->constrained('usuarios')->nullOnDelete();
            $table->foreignId('medico_id')->nullable()->constrained('usuarios')->nullOnDelete();
            $table->foreignId('especialidad_id')->nullable()->constrained('especialidades')->nullOnDelete();
            // Datos del seguro validado
            $table->string('aseguradora', 150)->nullable();
            $table->string('poliza', 150)->nullable();
            $table->string('numero_seguro', 150)->nullable();
            $table->boolean('seguro_validado')->default(false);
            $table->timestamp('validado_at')->nullable();
            $table->foreignId('validado_por')->nullable()->constrained('usuarios')->nullOnDelete();
            // Flujo
            $table->string('estado', 40)->default('validado'); // validado, en_consulta, cerrado, cancelado
            $table->timestamp('iniciada_at')->nullable();
            $table->timestamp('atendida_at')->nullable();
            $table->timestamp('cerrada_at')->nullable();
            // Clínica
            $table->text('diagnostico')->nullable();
            $table->text('observaciones')->nullable();
            $table->timestamps();
            $table->index(['estado','medico_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('atenciones');
    }
};
