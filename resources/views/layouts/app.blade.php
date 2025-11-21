<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'SomosSalud') }}</title>

    <!-- Fonts -->
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />

    <!-- Scripts & estilos principales -->
    @vite(['resources/css/app.css', 'resources/js/app.js'])

    <!-- Bootstrap 5 (preferido en todo el proyecto) -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">

    <!-- Font Awesome 6 (iconos) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.2/css/all.min.css" crossorigin="anonymous">

    @stack('head')
</head>

<body class="font-sans antialiased">
    <div class="min-h-screen bg-gray-100 d-flex flex-column">
        @include('layouts.navigation')

        <!-- Page Heading -->
        @isset($header)
            <header class="bg-white shadow">
                <div class="max-w-7xl mx-auto py-6 px-4 sm:px-6 lg:px-8">
                    {{ $header }}
                </div>
            </header>
        @endisset

        <!-- Page Content -->
        <main class="flex-grow-1">
            {{ $slot ?? '' }}
        </main>

        @php
            $__rate = optional(\App\Models\ExchangeRate::latestEffective()->first());
        @endphp
    <footer class="main-footer border-top bg-white small d-flex justify-content-between align-items-center flex-wrap py-2 px-3 mt-auto" style="min-height:auto;">
            <div class="text-muted my-1">
                <strong>© {{ date('Y') }} SomosSalud.</strong>
                <span class="d-none d-sm-inline"> Plataforma de pacientes.</span>
            </div>
            <div class="text-muted my-1">
                @if($__rate && $__rate->rate)
                    Tasa BCV: <strong>{{ number_format((float)$__rate->rate, 2, ',', '.') }} Bs</strong> • {{ $__rate->date?->format('d/m/Y') }}
                @else
                    Tasa no disponible
                @endif
            </div>
            <div class="text-muted my-1">
                <span class="d-none d-sm-inline">Versión 1.0.0</span>
            </div>
        </footer>
    </div>

    <!-- Bootstrap JS bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

    @stack('scripts')
</body>

</html>