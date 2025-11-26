<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        // Tabla de órdenes de laboratorio
        if (!Schema::hasTable('lab_orders')) {
            Schema::create('lab_orders', function (Blueprint $table) {
                $table->id();
                $table->string('order_number', 100)->unique(); // Número de orden único, longitud limitada
                $table->foreignId('patient_id')->constrained('usuarios')->onDelete('cascade');
                $table->foreignId('doctor_id')->nullable()->constrained('usuarios')->onDelete('set null');
                $table->foreignId('clinica_id')->nullable()->constrained('clinicas')->onDelete('set null');
                $table->date('order_date'); // Fecha de la orden
                $table->date('sample_date')->nullable(); // Fecha de toma de muestra
                $table->date('result_date')->nullable(); // Fecha de resultados
                $table->enum('status', ['pending', 'in_progress', 'completed', 'cancelled'])->default('pending');
                $table->decimal('total', 10, 2)->default(0);
                $table->text('observations')->nullable();
                $table->string('verification_code', 50)->unique()->nullable(); // Código QR, longitud limitada
                $table->foreignId('created_by')->nullable()->constrained('usuarios')->onDelete('set null');
                $table->timestamps();
            });
        }

        // Tabla de detalles de la orden (exámenes solicitados)
        if (!Schema::hasTable('lab_order_details')) {
            Schema::create('lab_order_details', function (Blueprint $table) {
                $table->id();
                $table->foreignId('lab_order_id')->constrained('lab_orders')->onDelete('cascade');
                $table->foreignId('lab_exam_id')->constrained('lab_exams')->onDelete('cascade');
                $table->decimal('price', 10, 2)->default(0);
                $table->enum('status', ['pending', 'completed'])->default('pending');
                $table->timestamps();
            });
        }

        // Tabla de resultados (valores de cada ítem del examen)
        if (!Schema::hasTable('lab_results')) {
            Schema::create('lab_results', function (Blueprint $table) {
                $table->id();
                $table->foreignId('lab_order_detail_id')->constrained('lab_order_details')->onDelete('cascade');
                $table->foreignId('lab_exam_item_id')->constrained('lab_exam_items')->onDelete('cascade');
                $table->string('value')->nullable(); // Valor del resultado
                $table->text('observation')->nullable(); // Observación específica del ítem
                $table->timestamps();
            });
        }
    }

    public function down(): void
    {
        Schema::dropIfExists('lab_results');
        Schema::dropIfExists('lab_order_details');
        Schema::dropIfExists('lab_orders');
    }
};
