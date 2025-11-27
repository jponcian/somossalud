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
        Schema::create('movimiento_inventarios', function (Blueprint $table) {
            $table->id();
            $table->foreignId('material_id')->constrained('materiales')->onDelete('cascade');
            $table->foreignId('user_id')->constrained('users'); // Who made the movement
            $table->string('tipo'); // 'INGRESO', 'EGRESO', 'AJUSTE'
            $table->integer('cantidad');
            $table->integer('stock_anterior')->default(0);
            $table->integer('stock_nuevo')->default(0);
            $table->string('motivo')->nullable(); // 'COMPRA', 'SOLICITUD #123', 'VENCIMIENTO'
            $table->string('referencia')->nullable(); // Invoice number, etc.
            $table->timestamps();
        });
        
        // Add stock_actual to materiales if it doesn't exist (using a separate check or just assuming we need to handle it)
        // Since I can't easily modify the other migration, I'll add a check here or just hope it exists. 
        // Better practice: create a separate migration for adding column to existing table.
        // But for this task, I'll assume I can add it here if I modify the table 'materiales' too? No, that's messy.
        
        // I will create a separate migration for adding stock_actual to materiales.
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('movimiento_inventarios');
    }
};
