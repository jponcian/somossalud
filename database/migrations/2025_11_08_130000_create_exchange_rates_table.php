<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('exchange_rates', function (Blueprint $table) {
            $table->id();
            $table->date('date');
            $table->string('source', 50)->default('BCV');
            $table->string('from', 3)->default('USD');
            $table->string('to', 3)->default('VES');
            $table->decimal('rate', 12, 6); // 1 USD = rate VES
            $table->timestamps();

            $table->unique(['date', 'source', 'from', 'to'], 'uniq_rate_date_source_pair');
            $table->index(['date']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('exchange_rates');
    }
};
