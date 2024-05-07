<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Carbon\Carbon;

class DashboardController extends Controller
{
    //store
    public function store(Request $request)
    {
        $request->validate([
            'transaction_time' => 'required|date',
            'kasir_id' => 'required|exists:users,id',
            'total_price' => 'required|numeric',
            'total_item' => 'required|numeric',
            'Dashboard_items' => 'required|array'
        ]);

        $transactionTime = Carbon::parse($request->transaction_time)->format('Y-m-d H:i:s');

        //create Dashboard
        $dashboard = \App\Models\Dashboard::create([
            'transaction_time' => $transactionTime,
            'kasir_id' => $request->kasir_id,
            'total_price' => $request->total_price,
            'total_item' => $request->total_item,
            'payment_method' => $request->payment_method,
        ]);

        //create Dashboard item
        foreach ($request->Dashboard_items as $item) {
            \App\Models\DashboardItem::create([
                'dashboard_id' => $dashboard->id,
                'product_id' => $item['product_id'],
                'quantity' => $item['quantity'],
                'total_price' => $item['total_price'],
            ]);

            //TODO: Update stock product - quantity
            $product = \App\Models\Product::find($item['product_id']);
            $product->stock = $product->stock - $item['quantity'];
            $product->save();
        }

        //response
        return response()->json([
            'success' => true,
            'message' => 'Dashboard Created',
        ], 201);
    }

    public function report(Request $request)
    {
        //TODO: Mendapatkan tanggal hari ini
        $today = now()->toDateString();

        // Mendapatkan semua produk dari database
        $products = \App\Models\Product::all();

        // Mendapatkan sum Dashboard quantity untuk setiap produk hari ini
        $reportData = [];
        foreach ($products as $product) {
            $totalDashboardQuantity = \App\Models\DashboardItem::whereHas('dashboard', function ($query) use ($today) {
                $query->whereDate('transaction_time', $today);
            })->where('product_id', $product->id)->sum('quantity');

            // Menambahkan data produk ke laporan
            $reportData[] = [
                'product_id' => $product->id,
                'product_name' => $product->name,
                'total_Dashboard_quantity' => $totalDashboardQuantity,
            ];
        }

        // Mengurutkan laporan berdasarkan total Dashboard quantity secara descending
        $reportData = collect($reportData)->sortByDesc('total_dashboard_quantity')->values()->all();

        // Respons dengan data laporan
        return response()->json([
            'success' => true,
            'message' => 'Product Report for Today',
            'data' => $reportData,
        ], 200);
    }
}

