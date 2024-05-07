@extends('layouts.app')

@section('title', 'Order Detail')

@push('style')
    <!-- CSS Libraries -->
    <link rel="stylesheet" href="{{ asset('library/selectric/public/selectric.css') }}">
@endpush

@section('main')
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>Order Detail</h1>

                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item active"><a href="#">Dashboard</a></div>
                    <div class="breadcrumb-item"><a href="#">Order</a></div>
                    <div class="breadcrumb-item">All Order</div>
                </div>
            </div>
            <div class="section-body">
                <div class="row">
                    <div class="col-12">
                        @include('layouts.alert')
                    </div>
                </div>
                <h2 class="section-title">Order Detail</h2>
                <p class="section-lead">
                    <div>Total Price: {{ $order->total_price }}</div>
                    <div>Total Item: {{ $order->total_item }}</div>
                    <div>Transaction Time: {{ \Carbon\Carbon::createFromFormat('Y-m-d H:i:s', $order->created_at)->format('d-m-Y H:i:s') }}</div>
                </p>
                {{-- <a href="{{ route('export') }}" class="btn btn-primary">Export Data</a> --}}
                <a href="{{ route('select-date') }}" class="btn btn-primary">Select Date Range</a>
                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4>All Products</h4>
                            </div>
                            <div class="card-body">

                                <div class="clearfix mb-3"></div>

                                <div class="table-responsive">
                                    <table class="table-striped table">
                                        <tr>
                                            <th class="text-center">Product Name</th>
                                            <th class="text-center">Price</th>
                                            <th class="text-center">Quantity</th>
                                            <th class="text-center">Total Product Price</th>
                                        </tr>
                                        @foreach ($orderItems as $item)
                                            <tr>
                                                <td class="text-center">
                                                    {{ $item->product->name }}
                                                </td>
                                                <td class="text-center">
                                                    {{ $item->product->price }}
                                                </td>
                                                <td class="text-center">
                                                    {{ $item->quantity }}
                                                </td>
                                                <td class="text-center">
                                                    {{ $item->quantity * $item->product->price }}
                                                </td>
                                            </tr>
                                        @endforeach

                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
@endsection

@push('scripts')
    <!-- JS Libraries -->
    <script src="{{ asset('library/selectric/public/jquery.selectric.min.js') }}"></script>

    <!-- Page Specific JS File -->
    <script src="{{ asset('js/page/features-posts.js') }}"></script>
@endpush
