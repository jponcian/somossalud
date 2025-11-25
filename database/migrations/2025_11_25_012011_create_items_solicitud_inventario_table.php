<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('items_solicitud_inventario', function (Blueprint $table) {
            $table->id();
            $table->foreignId('solicitud_id')->constrained('solicitudes_inventario')->cascadeOnDelete();
            
            // Relación opcional con el catálogo
            $table->foreignId('material_id')->nullable()->constrained('materiales')->nullOnDelete();
            
            $table->string('nombre_item', 200); // Nombre del material (copiado del catálogo o libre)
            $table->text('descripcion')->nullable();
            $table->string('unidad_medida', 50)->nullable(); 
            $table->integer('cantidad_solicitada');
            $table->integer('cantidad_aprobada')->nullable();
            $table->integer('cantidad_despachada')->nullable();
            $table->text('observaciones')->nullable();
            $table->timestamps();
            
            $table->index(['solicitud_id']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('items_solicitud_inventario');
    }
};
