<?php

namespace App\Http\Controllers;

use App\Models\OrderItem;
use App\Models\Product;
use Carbon\Carbon;
use Illuminate\Http\Request;

class LaporanBulananController extends Controller
{
    public function index(Request $request)
    {
        // Mendapatkan bulan dan tahun dari permintaan pengguna
        $month = $request->input('month', Carbon::now()->format('m'));
        $year = $request->input('year', Carbon::now()->format('Y'));

        // Mendapatkan nama bulan
        $monthName = Carbon::createFromDate($year, $month)->format('F');

        // Mendapatkan semua produk dari database
        $products = Product::all();

        // Mendapatkan sum order quantity untuk setiap produk dalam bulan dan tahun yang dipilih
        $reportData = [];
        foreach ($products as $product) {
            $totalOrderQuantity = OrderItem::whereHas('order', function ($query) use ($month, $year) {
                $query->whereYear('transaction_time', $year)
                      ->whereMonth('transaction_time', $month);
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
        return view('pages.laporan_bulanan.index', compact('chartData', 'month', 'year', 'monthName'));
    }
}
