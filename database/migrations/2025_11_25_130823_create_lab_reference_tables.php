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
        Schema::create('lab_reference_groups', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique(); // COD_SEX
            $table->string('description'); // DESCRIP
            $table->unsignedTinyInteger('sex'); // 1=H,2=M,3=Todos
            $table->integer('age_start_day')->default(0);
            $table->integer('age_start_month')->default(0);
            $table->integer('age_start_year')->default(0);
            $table->integer('age_end_day')->default(0);
            $table->integer('age_end_month')->default(0);
            $table->integer('age_end_year')->default(0);
            $table->boolean('active')->default(true);
            $table->timestamps();
        });

        Schema::create('lab_reference_ranges', function (Blueprint $table) {
            $table->id();
            $table->foreignId('lab_exam_item_id')->constrained('lab_exam_items')->onDelete('cascade');
            $table->foreignId('lab_reference_group_id')->constrained('lab_reference_groups')->onDelete('cascade');
            $table->string('condition')->nullable(); // CONDICION
            $table->decimal('value_min', 10, 2)->nullable(); // VALOR_REFI
            $table->decimal('value_max', 10, 2)->nullable(); // VALOR_REFS
            $table->string('value_text')->nullable(); // VALOR_REF2
            $table->integer('order')->default(0);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lab_reference_ranges');
        Schema::dropIfExists('lab_reference_groups');
    }
};
