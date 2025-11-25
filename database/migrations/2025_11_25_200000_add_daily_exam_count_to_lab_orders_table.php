<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up()
    {
        Schema::table('lab_orders', function (Blueprint $table) {
            $table->unsignedInteger('daily_exam_count')->default(0)->after('status');
        });
    }

    public function down()
    {
        Schema::table('lab_orders', function (Blueprint $table) {
            $table->dropColumn('daily_exam_count');
        });
    }
};
