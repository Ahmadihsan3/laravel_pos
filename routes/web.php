<?php

use Illuminate\Support\Facades\Route;
// use App\Http\Controllers\OrderReportController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('pages.auth.login');
});

Route::middleware(['auth'])->group(function () {
    Route::get('/order', function () {
        return view('pages.dashboard');
    })->name('order');
    Route::get('/export', 'App\Http\Controllers\OrderController@export')->name('export');
    Route::get('/select-date', 'App\Http\Controllers\OrderController@selectDate')->name('select-date');
    Route::resource('users', \App\Http\Controllers\UserController::class);
    Route::resource('products', \App\Http\Controllers\ProductController::class);
    Route::resource('order', \App\Http\Controllers\OrderController::class);
    Route::resource('dashboard', \App\Http\Controllers\DashboardController::class);
    Route::resource('laporan_harian', \App\Http\Controllers\LaporanHarianController::class);
    Route::resource('laporanbulanan', \App\Http\Controllers\LaporanBulananController::class);
});
