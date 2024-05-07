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
        Schema::create('orders', function (Blueprint $table) {
            $table->id();
            // Definisikan kolom 'total_price' dan 'total_item' terlebih dahulu
            $table->integer('total_price');
            $table->integer('total_item');
            // Kemudian definisikan kolom 'transaction_time' dengan tipe 'datetime' atau 'timestamp'
            $table->datetime('transaction_time')->default(now());
            // Definisikan kolom 'kasir_id' dan 'payment_method'
            $table->foreignId('kasir_id')->constrained('users');
            $table->enum('payment_method', ['TUNAI', 'QRIS']);
            // Hapus deklarasi kolom timestamps() yang kedua
            $table->timestamps();

        });
    }


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('orders');
    }
};
