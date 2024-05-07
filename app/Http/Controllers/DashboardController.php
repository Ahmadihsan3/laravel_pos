<?php

namespace App\Http\Controllers;

// use Illuminate\Http\Request;
use Maatwebsite\Excel\Facades\Excel;
use App\Http\Controllers\Controller;
use App\Exports\DashboardItemsExport;// Add this line if not already imported
use App\Models\DashboardItem;
use Illuminate\Http\Request;

class DashboardController extends Controller
{
    //index
    public function index()
    {
        $orders = \App\Models\Dashboard::with('kasir')->dashboardBy('created_at', 'desc')->paginate(10);

        return view('pages.dashboard.index', compact('dashboard'));
    }

    //view
    public function show($id)
    {
        $dashboard = \App\Models\Dashboard::with('kasir')->findOrFail($id);

        //get Dashboard items by Dashboard id
        $dashboardItems = \App\Models\DashboardItem::with('product')->where('dashboard_id', $id)->get();

        return view('pages.dashboard.view', compact('dashboard', 'dashboardItems'));
    }

    public function export(Request $request)
    {
        $startDate = $request->input('start_date');
        $endDate = $request->input('end_date');

        // Fetch the Dashboard items based on the selected date range
        $dashboardItems = DashboardItem::whereBetween('created_at', [$startDate, $endDate])->get();

        return Excel::download(new DashboardItemsExport($dashboardItems), 'dashboard_items.xlsx');
    }


    public function selectDate()
    {
        return view('pages.dashboard.select_date');
    }
}
