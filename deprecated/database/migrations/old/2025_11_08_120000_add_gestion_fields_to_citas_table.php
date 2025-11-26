<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('citas', function (Blueprint $table) {
            $table->text('diagnostico')->nullable();
            $table->text('tratamiento')->nullable();
            $table->text('medicamentos_texto')->nullable(); // respaldo libre opcional
            $table->text('observaciones')->nullable();
            $table->timestamp('concluida_at')->nullable();
        });
    }

    public function down(): void
    {
        Schema::table('citas', function (Blueprint $table) {
            $table->dropColumn(['diagnostico','tratamiento','medicamentos_texto','observaciones','concluida_at']);
        });
    }
};
