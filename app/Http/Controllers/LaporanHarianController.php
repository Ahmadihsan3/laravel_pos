<?php

namespace App\Http\Controllers;

use App\Models\OrderItem;
use App\Models\Product;
use Carbon\Carbon;
use Illuminate\Http\Request;

class LaporanHarianController extends Controller
{
    public function index(Request $request)
    {
        // Mendapatkan tanggal dari permintaan pengguna atau menggunakan tanggal hari ini
        $date = $request->input('date', Carbon::now()->toDateString());

        // Mendapatkan semua produk dari database
        $products = Product::all();

        // Mendapatkan sum order quantity untuk setiap produk pada tanggal yang dipilih
        $reportData = [];
        foreach ($products as $product) {
            $totalOrderQuantity = OrderItem::whereHas('order', function ($query) use ($date) {
                $query->whereDate('transaction_time', $date);
            })->where('product_id', $product->id)->sum('quantity');

            // Menambahkan data produk ke laporan
            $reportData[] = [
                'product_name' => $product->name,
                'total_order_quantity' => $totalOrderQuantity,
            ];
        }

        // Mengurutkan laporan berdasarkan total order quantity secara descending
        usort($reportData, function ($a, $b) {
            return $b['total_order_quantity'] - $a['total_order_quantity'];
        });

        // Memisahkan data untuk sumbu X dan sumbu Y
        $labels = array_column($reportData, 'product_name');
        $data = array_column($reportData, 'total_order_quantity');

        // Data untuk grafik Chart.js
        $chartData = [
            'labels' => $labels,
            'datasets' => [
                [
                    'label' => 'Jumlah Order',
                    'data' => $data,
                    'backgroundColor' => 'rgba(75, 192, 192, 0.2)',
                    'borderColor' => 'rgba(75, 192, 192, 1)',
                    'borderWidth' => 1
                ]
            ]
        ];

        // Pass the $chartData variable to the view
        return view('pages.laporan_harian.index', compact('chartData', 'date'));
    }
}
