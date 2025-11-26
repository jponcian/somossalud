<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('pagos_reportados', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
            $table->string('cedula_pagador', 50);
            $table->string('telefono_pagador', 30);
            $table->date('fecha_pago');
            $table->string('referencia', 100);
            $table->decimal('monto', 10, 2);
            $table->string('estado')->default('pendiente'); // pendiente, aprobado, rechazado
            $table->text('observaciones')->nullable();
            $table->foreignId('reviewed_by')->nullable()->constrained('usuarios')->nullOnDelete();
            $table->timestamp('reviewed_at')->nullable();
            $table->timestamps();

            $table->unique(['referencia', 'monto', 'fecha_pago'], 'pago_unico_ref_monto_fecha');
            $table->index(['estado']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('pagos_reportados');
    }
};
