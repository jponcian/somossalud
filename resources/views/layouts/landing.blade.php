<!doctype html>
<html lang="es">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>@yield('title', config('app.name', 'SomosSalud'))</title>
    <meta name="description" content="@yield('description', 'SomosSalud - reservas y resultados')">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        crossorigin="anonymous">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <style>
        /* pequeño reset para evitar choques con estilos globales */
        body {
            -webkit-font-smoothing: antialiased;
            -moz-osx-font-smoothing: grayscale;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: #333;
        }

        /* Tema azul para clínica médica */
        .navbar {
            background-color: #ffffff !important;
            border-bottom: 1px solid #e9ecef;
        }

        .hero {
            background: linear-gradient(135deg, #00b5e2 0%, #0059a7 100%);
            color: white;
            padding: 80px 0;
        }

        .feature-icon {
            width: 64px;
            height: 64px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background: #007bff;
            color: white;
            font-size: 24px;
        }

        .btn-primary {
            background-color: #007bff;
            border-color: #007bff;
        }

        .btn-primary:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }

        .btn-success:hover {
            background-color: #218838;
            border-color: #218838;
        }

        footer {
            background-color: #f8f9fa;
            color: #6c757d;
        }
    </style>

    @stack('head')
</head>

<body>
    @yield('content')

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>

    @php
        $__server_ts = now()->timestamp;
        $__server_tz = config('app.timezone') ?? date_default_timezone_get();
    @endphp

    <!-- Badge con la hora del servidor (actualiza cada segundo en el cliente) -->
    <div id="server-time-badge" style="position:fixed;bottom:12px;right:12px;z-index:9999;background:#0d6efd;color:#fff;padding:6px 10px;border-radius:6px;font-size:14px;box-shadow:0 2px 6px rgba(0,0,0,0.15);">
        Servidor: <span id="server-time-text">{{ now()->format('H:i:s') }}</span>
        <small style="opacity:.85;margin-left:6px;font-size:12px;vertical-align:middle">({{ $__server_tz }})</small>
    </div>

    <script>
        (function(){
            // timestamp del servidor en ms
            let serverTs = {{ $__server_ts }} * 1000;

            function pad(n){ return n.toString().padStart(2,'0'); }

            function updateServerTime(){
                serverTs += 1000; // avanzamos 1s
                const d = new Date(serverTs);
                const h = pad(d.getHours());
                const m = pad(d.getMinutes());
                const s = pad(d.getSeconds());
                const el = document.getElementById('server-time-text');
                if(el) el.textContent = `${h}:${m}:${s}`;
            }

            // Actualizar cada segundo; el texto inicial se renderizó desde el servidor
            setInterval(updateServerTime, 1000);
        })();
    </script>
    @stack('scripts')
</body>

</html>