<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('disponibilidades', function (Blueprint $table) {
            $table->id();
            $table->foreignId('especialista_id')->constrained('usuarios')->cascadeOnDelete();
            $table->string('dia_semana', 16);
            $table->time('hora_inicio');
            $table->time('hora_fin');
            $table->timestamps();

            $table->unique(
                ['especialista_id', 'dia_semana', 'hora_inicio', 'hora_fin'],
                'disp_especialista_intervalo_unique'
            );
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('disponibilidades');
    }
};
