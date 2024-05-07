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
        Schema::create('dashboard_items', function (Blueprint $table) {
            $table->id();
            //dashboard id
            $table->foreignId('dashboard_id')->constrained('dashboard');
            //product id
            $table->foreignId('product_id')->constrained('products');
            //quantity
            $table->integer('quantity');
            //total price
            $table->integer('total_price');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('dashboard_items');
    }
};
