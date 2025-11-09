<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title', 'SomosSalud | Panel administrativo')</title>

    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Source+Sans+Pro:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@5.15.4/css/all.min.css"
        crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/css/adminlte.min.css"
        crossorigin="anonymous">
    <link rel="icon" type="image/png" href="{{ asset('images/logo.png') }}">

    <style>
        /* Separación superior del contenido cuando no hay content-header */
        .content-wrapper > .content { padding-top: .75rem; }
        @media (min-width: 768px) {
            .content-wrapper > .content { padding-top: 1rem; }
        }
    </style>

    @stack('styles')
</head>

<body class="hold-transition sidebar-mini layout-fixed">
    <div class="wrapper">
        <!-- Navbar -->
        <nav class="main-header navbar navbar-expand navbar-white navbar-light border-bottom">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" data-widget="pushmenu" href="#" role="button"><i class="fas fa-bars"></i></a>
                </li>
                <li class="nav-item d-none d-sm-inline-block">
                    <a href="{{ route('panel.clinica') }}" class="nav-link">Inicio</a>
                </li>
            </ul>

            <ul class="navbar-nav ml-auto">
                <li class="nav-item dropdown">
                    <a class="nav-link" data-toggle="dropdown" href="#" aria-expanded="false">
                        <i class="far fa-user"></i>
                        <span class="ml-2">{{ auth()->user()->name ?? 'Usuario' }}</span>
                    </a>
                    <div class="dropdown-menu dropdown-menu-right">
                        <a href="{{ route('profile.edit') }}" class="dropdown-item">
                            <i class="fas fa-user-cog mr-2"></i> Perfil
                        </a>
                        <div class="dropdown-divider"></div>
                        <form action="{{ route('logout') }}" method="POST" class="d-inline">
                            @csrf
                            <button type="submit" class="dropdown-item text-danger">
                                <i class="fas fa-sign-out-alt mr-2"></i> Cerrar sesión
                            </button>
                        </form>
                    </div>
                </li>
            </ul>
        </nav>
        <!-- /.navbar -->

        <!-- Main Sidebar Container -->
        <aside class="main-sidebar sidebar-dark-primary elevation-4">
            <a href="{{ route('panel.clinica') }}" class="brand-link d-flex align-items-center justify-content-center" style="min-height:58px;">
                <img src="{{ asset('images/logo.png') }}" alt="SomosSalud" class="brand-image" style="max-height:38px; width:auto; object-fit:contain; opacity:1;">
            </a>

            <div class="sidebar">
                @hasSection('sidebar')
                    @yield('sidebar')
                @else
                    @include('panel.partials.sidebar')
                @endif
            </div>
        </aside>

        <!-- Content Wrapper. Contains page content -->
        <div class="content-wrapper">
            @hasSection('content-header')
                <div class="content-header">
                    <div class="container-fluid">
                        @yield('content-header')
                    </div>
                </div>
            @endif

            <section class="content">
                <div class="container-fluid">
                    @yield('content')
                </div>
            </section>
        </div>

        @php
            $__rateAdmin = optional(\App\Models\ExchangeRate::latestEffective()->first());
        @endphp
        <footer class="main-footer text-sm d-flex justify-content-between align-items-center flex-wrap">
            <div>
                <strong>© {{ date('Y') }} SomosSalud.</strong>
                <span class="d-none d-sm-inline-block"> Gestión interna.</span>
            </div>
            <div class="text-muted small my-1">
                @if($__rateAdmin && $__rateAdmin->rate)
                    Tasa BCV: <strong>{{ number_format((float)$__rateAdmin->rate, 2, ',', '.') }} Bs</strong> • {{ $__rateAdmin->date?->format('d/m/Y') }}
                @else
                    Tasa no disponible
                @endif
            </div>
            <div class="float-right d-none d-sm-inline">Versión 1.0.0</div>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/admin-lte@3.2/dist/js/adminlte.min.js" crossorigin="anonymous"></script>

    @stack('scripts')
</body>

</html>