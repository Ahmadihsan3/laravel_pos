@extends('layouts.app')

@section('title', 'Monthly Report')

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
                <h1>Laporan Bulanan</h1>
                <div class="section-header-breadcrumb">
                    <div class="breadcrumb-item active"><a href="#">Dashboard</a></div>
                    <div class="breadcrumb-item"><a href="#">Laporan Bulanan</a></div>
                    <div class="breadcrumb-item">Laporan Bulanan</div>
                </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <form action="{{ route('laporanbulanan.index') }}" method="GET">
                        <div class="form-group">
                            <label for="month">Bulan:</label>
                            <select name="month" id="month" class="form-control">
                                @for ($i = 1; $i <= 12; $i++)
                                    <option value="{{ $i }}" {{ $i == $month ? 'selected' : '' }}>{{ Carbon\Carbon::createFromDate(null, $i)->format('F') }}</option>
                                @endfor
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="year">Tahun:</label>
                            <input type="number" name="year" id="year" class="form-control" value="{{ $year }}">
                        </div>
                        <button type="submit" class="btn btn-primary">Tampilkan Laporan</button>
                    </form>
                </div>
                <div class="col-12 mt-4">
                    <div class="date-box">
                        <h3>Laporan Bulanan: {{ $monthName }} {{ $year }}</h3>
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
        </section>
    </div>
@endsection

@push('scripts')
    <!-- JS Libraries -->
    <script src="{{ asset('library/selectric/public/jquery.selectric.min.js') }}"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script> <!-- Memuat Chart.js -->

    <!-- Page Specific JS File -->
    <script>
        // Mengambil data yang dikirim dari controller
        var chartData = {!! json_encode($chartData) !!};

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
    </script>
@endpush
