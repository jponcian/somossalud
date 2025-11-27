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
        Schema::table('usuarios', function (Blueprint $table) {
            // Eliminar el índice único del email para permitir que padres e hijos compartan email
            $table->dropUnique(['email']);
            
            // Agregar campo para vincular dependientes con su representante
            $table->foreignId('representante_id')->nullable()->after('id')->constrained('usuarios')->onDelete('cascade');
            
            // Índice compuesto para email + representante_id (permite emails duplicados si son de diferentes familias)
            $table->index(['email', 'representante_id']);
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('usuarios', function (Blueprint $table) {
            $table->dropForeign(['representante_id']);
            $table->dropColumn('representante_id');
            $table->dropIndex(['email', 'representante_id']);
            $table->unique('email');
        });
    }
};
