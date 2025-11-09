<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <title>{{ config('app.name', 'SomosSalud') }} — Acceso</title>
    <link rel="preconnect" href="https://fonts.bunny.net">
    <link href="https://fonts.bunny.net/css?family=figtree:400,500,600&display=swap" rel="stylesheet" />
    @vite(['resources/css/app.css', 'resources/js/app.js'])
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.5.2/css/all.min.css" crossorigin="anonymous">
    <style>
        body{font-family:'Figtree', system-ui, -apple-system, Segoe UI, Roboto, 'Helvetica Neue', Arial, 'Noto Sans', 'Liberation Sans', sans-serif;}
        .auth-brand{background: linear-gradient(135deg,#0ea5e9 0%, #4f46e5 60%, #0ea5e9 100%);}
        .glass{background: rgba(255,255,255,.86); backdrop-filter: blur(6px);}
        .form-control:focus{box-shadow: 0 0 0 .2rem rgba(13,110,253,.15);}        
    </style>
    @yield('head')
    @stack('head')
</head>
<body class="bg-light">
<div class="container-fluid min-vh-100 p-0">
    <div class="row g-0 min-vh-100">
        <!-- Lado marca -->
        <div class="col-lg-6 d-none d-lg-flex flex-column text-white auth-brand">
            <div class="d-flex flex-column align-items-start justify-content-center flex-grow-1 p-5">
                <div class="mb-4">
                    <img src="{{ asset('images/logo.png') }}" alt="SomosSalud" style="height:84px;width:auto;" class="img-fluid">
                </div>
                <h1 class="display-6 fw-semibold mb-3">Bienvenido</h1>
                <p class="lead mb-4">Gestiona tus citas, suscripción y resultados de forma rápida y segura.</p>
                <ul class="list-unstyled small mb-0">
                    <li class="mb-2"><i class="fa-solid fa-shield-heart me-2"></i> Seguridad y privacidad</li>
                    <li class="mb-2"><i class="fa-solid fa-bolt me-2"></i> Acceso rápido</li>
                    <li class="mb-2"><i class="fa-solid fa-mobile-screen me-2"></i> Diseño adaptable</li>
                </ul>
            </div>
            <div class="p-4 small text-white-50">© {{ date('Y') }} SomosSalud</div>
        </div>
        <!-- Lado formulario -->
        <div class="col-lg-6 d-flex align-items-center justify-content-center p-3 p-sm-4 p-md-5">
            <div class="w-100" style="max-width: 420px;">
                <div class="text-center mb-3 d-lg-none">
                    <img src="{{ asset('images/logo.png') }}" alt="SomosSalud" style="height:72px;width:auto;" class="img-fluid">
                </div>
                @yield('content')
            </div>
        </div>
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
@stack('scripts')
</body>
</html>
