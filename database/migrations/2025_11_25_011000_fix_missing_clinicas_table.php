<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        if (!Schema::hasTable('clinicas')) {
            Schema::create('clinicas', function (Blueprint $table) {
                $table->id();
                $table->string('nombre');
                $table->string('direccion')->nullable();
                $table->string('telefono')->nullable();
                $table->unsignedInteger('descuento')->default(0)->comment('Porcentaje de descuento para afiliados');
                $table->timestamps();
            });
        }
    }

    public function down()
    {
        // No hacemos nada en down para no borrar datos si se revierte
    }
};
