<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('materiales', function (Blueprint $table) {
            $table->id();
            $table->foreignId('clinica_id')->constrained('clinicas')->cascadeOnDelete();
            $table->string('codigo', 50)->nullable(); // Código interno opcional
            $table->string('nombre', 200);
            $table->text('descripcion')->nullable();
            $table->string('unidad_medida_default', 50)->nullable(); // Unidad sugerida
            $table->enum('categoria_default', ['ENFERMERIA', 'QUIROFANO', 'UCI', 'OFICINA'])->nullable();
            $table->integer('stock_minimo')->default(0)->nullable(); // Solo referencial
            $table->boolean('activo')->default(true);
            $table->timestamps();
            $table->softDeletes();
            
            $table->index(['clinica_id', 'nombre']);
            $table->index(['clinica_id', 'categoria_default']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('materiales');
    }
};
