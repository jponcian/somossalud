<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::create('resultados_laboratorio', function (Blueprint $table) {
            $table->id();
            $table->foreignId('paciente_id')->constrained('usuarios')->cascadeOnDelete();
            $table->foreignId('clinica_id')->constrained('clinicas')->cascadeOnDelete();
            $table->string('tipo_examen'); // hematología, química sanguínea, urianálisis, etc.
            $table->string('nombre_examen'); // nombre específico del examen
            $table->date('fecha_muestra'); // fecha de toma de muestra
            $table->date('fecha_resultado'); // fecha del resultado
            $table->json('resultados_json')->nullable(); // resultados estructurados
            $table->text('observaciones')->nullable();
            $table->string('archivo_path')->nullable(); // PDF del resultado
            $table->string('codigo_verificacion', 12)->unique(); // código para QR
            $table->foreignId('registrado_por')->nullable()->constrained('usuarios')->nullOnDelete();
            $table->timestamps();
            
            $table->index('codigo_verificacion');
        });
    }

    public function down()
    {
        Schema::dropIfExists('resultados_laboratorio');
    }
};
