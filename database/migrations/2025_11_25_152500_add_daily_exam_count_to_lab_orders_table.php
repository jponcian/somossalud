<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::table('lab_orders', function (Blueprint $table) {
            if (!Schema::hasColumn('lab_orders', 'daily_exam_count')) {
                $table->integer('daily_exam_count')->nullable()->after('order_number');
            }
        });
    }

    public function down()
    {
        Schema::table('lab_orders', function (Blueprint $table) {
            if (Schema::hasColumn('lab_orders', 'daily_exam_count')) {
                $table->dropColumn('daily_exam_count');
            }
        });
    }
};
