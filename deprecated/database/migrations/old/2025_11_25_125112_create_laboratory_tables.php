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
        if (!Schema::hasTable('lab_categories')) {
            Schema::create('lab_categories', function (Blueprint $table) {
                $table->id();
                $table->string('code')->unique();
                $table->string('name');
                $table->boolean('active')->default(true);
                $table->timestamps();
            });
        }

        if (!Schema::hasTable('lab_exams')) {
            Schema::create('lab_exams', function (Blueprint $table) {
                $table->id();
                $table->string('code')->unique();
                $table->foreignId('lab_category_id')->nullable()->constrained('lab_categories')->onDelete('set null');
                $table->string('name');
                $table->string('abbreviation')->nullable();
                $table->decimal('price', 10, 2)->default(0);
                $table->boolean('active')->default(true);
                $table->timestamps();
            });
        }

        if (!Schema::hasTable('lab_exam_items')) {
            Schema::create('lab_exam_items', function (Blueprint $table) {
                $table->id();
                $table->foreignId('lab_exam_id')->constrained('lab_exams')->onDelete('cascade');
                $table->string('code');
                $table->string('name');
                $table->string('unit')->nullable();
                $table->string('reference_value')->nullable();
                $table->string('type')->nullable();
                $table->integer('order')->default(0);
                $table->timestamps();
            });
        }

        // las demás tablas (lab_orders, lab_order_details, lab_results) ya están en su propia migración
    }

    public function down(): void
    {
        Schema::dropIfExists('lab_results');
        Schema::dropIfExists('lab_order_details');
        Schema::dropIfExists('lab_orders');
        Schema::dropIfExists('lab_exam_items');
        Schema::dropIfExists('lab_exams');
        Schema::dropIfExists('lab_categories');
    }
};
