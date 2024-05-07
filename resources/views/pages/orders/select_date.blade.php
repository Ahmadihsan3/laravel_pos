@extends('layouts.app')

@section('title', 'Pilih Tanggal')

@push('style')
    <!-- CSS Libraries -->
    <link rel="stylesheet" href="{{ asset('library/selectric/public/selectric.css') }}">
@endpush

@section('main')
    <div class="main-content">
        <section class="section">
            <div class="section-header">
                <h1>Pilih Tanggal</h1>
            </div>
            <div class="section-body">
                <form action="{{ route('export') }}" method="GET">
                    <div class="form-group">
                        <label for="start_date">Tanggal Mulai:</label>
                        <input type="date" id="start_date" name="start_date" class="form-control">
                    </div>
                    <div class="form-group">
                        <label for="end_date">Tanggal Akhir:</label>
                        <input type="date" id="end_date" name="end_date" class="form-control">
                    </div>
                    <button type="submit" class="btn btn-primary">Export Data</button>
                </form>
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
