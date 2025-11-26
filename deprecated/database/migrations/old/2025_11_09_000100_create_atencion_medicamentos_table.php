<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('atencion_medicamentos', function (Blueprint $table) {
            $table->id();
            $table->foreignId('atencion_id')->constrained('atenciones')->cascadeOnDelete();
            $table->string('nombre_generico', 255);
            $table->string('presentacion', 150)->nullable();
            $table->string('posologia', 255)->nullable();
            $table->string('frecuencia', 150)->nullable();
            $table->string('duracion', 150)->nullable();
            $table->unsignedSmallInteger('orden')->default(0);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('atencion_medicamentos');
    }
};
