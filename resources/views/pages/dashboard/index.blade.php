@extends('layouts.app')

@section('title', 'Orders')

@push('style')
    <!-- CSS Libraries -->
    <link rel="stylesheet" href="{{ asset('library/selectric/public/selectric.css') }}">
@endpush

@section('main')
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>Orders</h1>

                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item active"><a href="#">Dashboard</a></div>
                    <div class="breadcrumb-item"><a href="#">Orders</a></div>
                    <div class="breadcrumb-item">All Orders</div>
                </div>
            </div>
            <div class="section-body">
                <div class="row">
                    <div class="col-12">
                        @include('layouts.alert')
                    </div>
                </div>
                <h2 class="section-title">Orders</h2>

                <div class="row mt-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <h4>All Orders</h4>
                            </div>
                                <div class="table-responsive">
                                    <table class="table-striped table">
                                        <tr>
                                            <th class="text-center">Kasir</th>
                                            <th class="text-center">Total Price</th>
                                            <th class="text-center">Total Item</th>
                                            <th class="text-center">Transaction Time</th>
                                            <th class="text-center">Payment Method</th>
                                        </tr>
                                        @foreach ($dashboard as $dashboard)
                                        <tr>
                                            <td class="text-center">
                                                {{ $dashboard->kasir->name }}
                                            </td>
                                            <td class="text-center">
                                                {{ $dashboard->total_price }}
                                            </td>
                                            <td class="text-center">
                                                {{ $dashboard->total_item }}
                                            </td>
                                            <td class="text-center">
                                                <a href="{{ route('order.show', $dashboard->id) }}">
                                                    {{ \Carbon\Carbon::parse($order->created_at)->format('d-m-Y H:i:s') }}
                                                </a>
                                            </td>
                                            <td class="text-center">
                                                {{ $dashboard->payment_method }}
                                            </td>
                                        </tr>
                                    @endforeach
                                    </table>
                                </div>
                                <div class="float-right">
                                    {{ $orders->withQueryString()->links() }}
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
