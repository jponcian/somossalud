<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verificación de Resultado - Clínica SaludSonrisa</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .verification-container {
            padding: 40px 0;
        }
        
        .verification-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.2);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .card-header-custom {
            background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .card-header-custom h1 {
            font-size: 28px;
            margin-bottom: 10px;
            font-weight: 600;
        }
        
        .card-header-custom p {
            margin: 0;
            opacity: 0.9;
        }
        
        .verified-badge {
            background: #28a745;
            color: white;
            padding: 15px 30px;
            border-radius: 50px;
            display: inline-block;
            margin: 20px 0;
            font-weight: 600;
            box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
        }
        
        .verified-badge i {
            margin-right: 10px;
            font-size: 20px;
        }
        
        .info-section {
            padding: 30px;
        }
        
        .info-section h3 {
            color: #0ea5e9;
            font-size: 20px;
            margin-bottom: 20px;
            font-weight: 600;
            border-bottom: 2px solid #0ea5e9;
            padding-bottom: 10px;
        }
        
        .info-row {
            display: flex;
            padding: 12px 0;
            border-bottom: 1px solid #f0f0f0;
        }
        
        .info-row:last-child {
            border-bottom: none;
        }
        
        .info-label {
            font-weight: 600;
            color: #666;
            width: 200px;
            flex-shrink: 0;
        }
        
        .info-value {
            color: #333;
            flex-grow: 1;
        }
        
        .results-table {
            width: 100%;
            margin-top: 20px;
        }
        
        .results-table th {
            background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%);
            color: white;
            padding: 12px;
            font-weight: 600;
        }
        
        .results-table td {
            padding: 12px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .results-table tbody tr:hover {
            background-color: #f8f9fa;
        }
        
        .observaciones-box {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 20px;
            margin-top: 20px;
            border-radius: 5px;
        }
        
        .observaciones-box h4 {
            color: #856404;
            font-size: 16px;
            margin-bottom: 10px;
        }
        
        .security-notice {
            background: #d1ecf1;
            border-left: 4px solid #0c5460;
            padding: 20px;
            margin-top: 30px;
            border-radius: 5px;
        }
        
        .security-notice h4 {
            color: #0c5460;
            font-size: 16px;
            margin-bottom: 10px;
        }
        
        .security-notice p {
            color: #0c5460;
            margin: 0;
            font-size: 14px;
        }
        
        .footer-custom {
            text-align: center;
            padding: 30px;
            background: #f8f9fa;
            color: #666;
        }
        
        .code-display {
            background: #f8f9fa;
            border: 2px dashed #0ea5e9;
            padding: 15px;
            border-radius: 10px;
            text-align: center;
            margin: 20px 0;
        }
        
        .code-display .code {
            font-size: 24px;
            font-weight: bold;
            color: #0ea5e9;
            letter-spacing: 2px;
            font-family: 'Courier New', monospace;
        }
        
        .badge-custom {
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }
    </style>
</head>
<body>
    <div class="verification-container">
        <div class="container">
            <div class="verification-card">
                <!-- Header -->
                <div class="card-header-custom">
                    <h1><i class="fas fa-shield-alt"></i> Verificación de Resultado de Laboratorio</h1>
                    <p>Clínica SaludSonrisa</p>
                </div>

                <div class="info-section">
                    <!-- Badge de verificación -->
                    <div class="text-center">
                        <div class="verified-badge">
                            <i class="fas fa-check-circle"></i>
                            RESULTADO VERIFICADO Y AUTÉNTICO
                        </div>
                    </div>

                    <!-- Código de verificación -->
                    <div class="code-display">
                        <div class="text-muted mb-2">Código de Verificación</div>
                        <div class="code">{{ $resultado->codigo_verificacion }}</div>
                    </div>

                    <!-- Información del Paciente -->
                    <h3><i class="fas fa-user"></i> Información del Paciente</h3>
                    <div class="info-row">
                        <div class="info-label">Nombre:</div>
                        <div class="info-value">{{ $resultado->paciente->name }}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Cédula:</div>
                        <div class="info-value">{{ $resultado->paciente->cedula }}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Fecha de Nacimiento:</div>
                        <div class="info-value">{{ $resultado->paciente->fecha_nacimiento ? \Carbon\Carbon::parse($resultado->paciente->fecha_nacimiento)->format('d/m/Y') : 'N/A' }}</div>
                    </div>

                    <!-- Información del Examen -->
                    <h3 class="mt-4"><i class="fas fa-flask"></i> Información del Examen</h3>
                    <div class="info-row">
                        <div class="info-label">Tipo de Examen:</div>
                        <div class="info-value">
                            <span class="badge badge-primary badge-custom">{{ $resultado->tipo_examen }}</span>
                        </div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Nombre del Examen:</div>
                        <div class="info-value"><strong>{{ $resultado->nombre_examen }}</strong></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Fecha de Muestra:</div>
                        <div class="info-value">{{ \Carbon\Carbon::parse($resultado->fecha_muestra)->format('d/m/Y') }}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Fecha de Resultado:</div>
                        <div class="info-value">{{ \Carbon\Carbon::parse($resultado->fecha_resultado)->format('d/m/Y') }}</div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">Clínica:</div>
                        <div class="info-value">{{ $resultado->clinica->nombre }}</div>
                    </div>

                    <!-- Resultados -->
                    <h3 class="mt-4"><i class="fas fa-list-alt"></i> Resultados</h3>
                    <table class="table table-bordered results-table">
                        <thead>
                            <tr>
                                <th>Parámetro</th>
                                <th>Valor</th>
                                <th>Unidad</th>
                                <th>Rango de Referencia</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($resultado->resultados_json as $item)
                            <tr>
                                <td><strong>{{ $item['parametro'] }}</strong></td>
                                <td>{{ $item['valor'] }}</td>
                                <td>{{ $item['unidad'] ?? '-' }}</td>
                                <td>{{ $item['rango_referencia'] ?? '-' }}</td>
                            </tr>
                            @endforeach
                        </tbody>
                    </table>

                    <!-- Observaciones -->
                    @if($resultado->observaciones)
                    <div class="observaciones-box">
                        <h4><i class="fas fa-comment-medical"></i> Observaciones</h4>
                        <p>{{ $resultado->observaciones }}</p>
                    </div>
                    @endif

                    <!-- Aviso de seguridad -->
                    <div class="security-notice">
                        <h4><i class="fas fa-info-circle"></i> Información de Seguridad</h4>
                        <p>Este resultado ha sido verificado mediante el código único <strong>{{ $resultado->codigo_verificacion }}</strong>. 
                        Cualquier resultado sin este código o con un código diferente debe considerarse no auténtico. 
                        Para verificar la autenticidad de un resultado, visite nuestra página web y escanee el código QR o ingrese el código de verificación.</p>
                    </div>

                    <!-- Botón para volver -->
                    <div class="text-center mt-4">
                        <a href="{{ url('/') }}" class="btn btn-light btn-lg">
                            <i class="fas fa-home"></i> Volver al Inicio
                        </a>
                    </div>
                </div>

                <!-- Footer -->
                <div class="footer-custom">
                    <p><i class="fas fa-hospital"></i> Clínica SaludSonrisa</p>
                    <p class="text-muted small">Documento verificado el {{ now()->format('d/m/Y H:i:s') }}</p>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
