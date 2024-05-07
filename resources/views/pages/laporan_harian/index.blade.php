@extends('layouts.app')

@section('title', 'Daily Report')

@push('style')
    <!-- CSS Libraries -->
    <link rel="stylesheet" href="{{ asset('library/selectric/public/selectric.css') }}">
    <style>
        .chart-container {
            position: relative;
        }

        .date-box {
            position: static;
            top: 0px; /* Sesuaikan jarak dari atas */
            right: 15px; /* Sesuaikan jarak dari kanan */
            background-color: #ffffff;
            border: 1px solid #dddddd;
            padding: 10px;
            border-radius: 5px;
        }
        .date-box > h3 {
            text-align: center;
        }
    </style>
@endpush

@section('main')
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>Laporan Harian</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item active"><a href="{{ route('order.index') }}">Dashboard</a></div>
                    <div class="breadcrumb-item"><a href="{{ route('laporan_harian.index') }}">Laporan Harian</a></div>
                    <div class="breadcrumb-item">Laporan Harian</div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <form action="{{ route('laporan_harian.index') }}" method="GET">
                        <div class="form-group">
                            <label for="date">Tanggal:</label>
                            <input type="date" name="date" id="date" class="form-control" value="{{ $date }}">
                        </div>
                        <button type="submit" class="btn btn-primary">Tampilkan Laporan</button>
                    </form>
                </div>
                <div class="col-12 mt-4">
                    <div class="date-box">
                        <h3>Laporan Harian: {{ \Carbon\Carbon::parse($date)->format('d F Y') }}</h3>
                    </div>
                </div>
            </div>
            <div class="section-body">
                <div class="card">
                    <div class="chart-container">
                        <canvas id="barChart"></canvas>
                    </div>
                </div>
            </div>
            <div class="total-box">
                <h3>Total: <span id="totalValue"></span></h3>
            </div>
        </section>
    </div>
@endsection

@push('scripts')
    <!-- JS Libraries -->
    <script src="{{ asset('library/selectric/public/jquery.selectric.min.js') }}"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script> <!-- Memuat Chart.js -->

    <!-- Page Specific JS File -->
    <script src="{{ asset('js/page/features-posts.js') }}"></script>
    <script>
        function formatRupiah(angka) {
            var reverse = angka.toString().split('').reverse().join('');
            var ribuan = reverse.match(/\d{1,3}/g);
            ribuan = ribuan.join('.').split('').reverse().join('');
            var formatter = new Intl.NumberFormat('id-ID', {
                style: 'currency',
                currency: 'IDR',
                minimumFractionDigits: 0,
                maximumFractionDigits: 0
            });
            return formatter.format(angka).replace(/^(\D+)/, '$1 ');
        }

// Mengambil data yang dikirim dari controller
var chartData = {!! json_encode($chartData) !!};

// Mendapatkan total keseluruhan dari data grafik
var totalOrders = chartData.datasets[0].data.reduce((total, currentValue) => total + currentValue, 0);

// Membuat grafik menggunakan Chart.js
var ctx = document.getElementById('barChart').getContext('2d');
var myChart = new Chart(ctx, {
    type: 'bar',
    data: chartData,
    options: {
        scales: {
            y: {
                beginAtZero: true
            }
        },
        plugins: {
            tooltip: {
                callbacks: {
                    label: function(context) {
                        var label = context.dataset.label || '';

                        if (label) {
                            label += ': ';
                        }
                        label += context.parsed.y.toLocaleString(); // Format angka tanpa koma
                        return label;
                    }
                }
            }
        }
    }
});

// Menampilkan total keseluruhan dalam format rupiah
document.getElementById('totalValue').textContent = formatRupiah(totalOrders);


    </script>
@endpush
