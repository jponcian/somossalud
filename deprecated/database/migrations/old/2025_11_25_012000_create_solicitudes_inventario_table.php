<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        if (!Schema::hasTable('solicitudes_inventario')) {
            Schema::create('solicitudes_inventario', function (Blueprint $table) {
                $table->id();
                $table->string('numero_solicitud', 50)->unique(); // Ej: SOL-2025-0001
                $table->foreignId('solicitante_id')->constrained('usuarios')->cascadeOnDelete();
                $table->foreignId('clinica_id')->constrained('clinicas')->cascadeOnDelete();
                $table->enum('categoria', ['ENFERMERIA', 'QUIROFANO', 'UCI', 'OFICINA']);
                $table->enum('estado', ['pendiente', 'aprobada', 'rechazada', 'despachada'])->default('pendiente');
                $table->text('observaciones_solicitante')->nullable();
                $table->text('observaciones_aprobador')->nullable();
                $table->foreignId('aprobado_por')->nullable()->constrained('usuarios')->nullOnDelete();
                $table->timestamp('fecha_aprobacion')->nullable();
                $table->foreignId('despachado_por')->nullable()->constrained('usuarios')->nullOnDelete();
                $table->timestamp('fecha_despacho')->nullable();
                $table->timestamps();
                
                $table->index(['clinica_id', 'estado', 'created_at']);
                $table->index(['categoria', 'estado']);
            });
        }
    }

    public function down()
    {
        Schema::dropIfExists('solicitudes_inventario');
    }
};
