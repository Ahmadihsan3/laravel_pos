<?php

namespace App\Http\Controllers;

// use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use App\Http\Controllers\Controller;
use App\Exports\OrderItemsExport;// Add this line if not already imported
use App\Models\OrderItem;
use Illuminate\Http\Request;


class OrderController extends Controller
{
    //index
    public function index()
    {
        $orders = \App\Models\Order::with('kasir')->orderBy('created_at', 'desc')->paginate(10);

        return view('pages.orders.index', compact('orders'));
    }

    //view
    public function show($id)
    {
        $order = \App\Models\Order::with('kasir')->findOrFail($id);

        //get order items by order id
        $orderItems = \App\Models\OrderItem::with('product')->where('order_id', $id)->get();

        return view('pages.orders.view', compact('order', 'orderItems'));
    }

    // public function export()
    // {
    //     // Fetch the order items here, assuming you already have logic to get them
    //     $orderItems = OrderItem::all(); // Adjust this according to your logic

    //     return Excel::download(new OrderItemsExport($orderItems), 'order_items.xlsx');
    // }

    public function export(Request $request)
    {
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');

        // Fetch the order items based on the selected date range
        $orderItems = OrderItem::whereBetween('created_at', [$startDate, $endDate])->get();

        return Excel::download(new OrderItemsExport($orderItems), 'order_items.xlsx');
    }


    public function selectDate()
    {
        return view('pages.orders.select_date');
    }

}
