<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('cita_medicamentos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('cita_id')->constrained('citas')->cascadeOnDelete();
            $table->string('nombre_generico', 150);
            $table->string('presentacion', 150)->nullable(); // ej: 50 mg Comprimidos
            $table->string('posologia', 255)->nullable(); // Indicaciones al paciente
            $table->string('frecuencia', 150)->nullable(); // ej: Cada 24 horas
            $table->string('duracion', 150)->nullable(); // ej: 30 días / Crónico
            $table->unsignedSmallInteger('orden')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('cita_medicamentos');
    }
};
