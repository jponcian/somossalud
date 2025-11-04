<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('suscripciones', function (Blueprint $table) {
            $table->id();
            $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete();
            $table->string('plan');
            $table->decimal('precio', 8, 2);
            $table->date('periodo_inicio');
            $table->date('periodo_vencimiento');
            $table->string('estado')->default('pendiente'); // activo, pendiente, expirado
            $table->string('metodo_pago')->default('manual'); // sandbox/manual
            $table->string('transaccion_id')->nullable();
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('suscripciones');
    }
};
