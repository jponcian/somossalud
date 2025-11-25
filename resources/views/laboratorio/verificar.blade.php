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
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }

        <style>body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 0;
        }

        .verification-container {
            max-width: 900px;
            margin: 0 auto;
        }

        .verification-badge {
            background: white;
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            margin-bottom: 30px;
        }

        .verification-badge i {
            font-size: 60px;
            color: #10b981;
            margin-bottom: 15px;
        }

        .verification-badge h1 {
            color: #10b981;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .verification-code {
            background: #f3f4f6;
            padding: 15px;
            border-radius: 10px;
            font-family: 'Courier New', monospace;
            font-size: 24px;
            font-weight: bold;
            color: #1f2937;
            letter-spacing: 2px;
        }

        .results-card {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.2);
            margin-bottom: 20px;
        }

        .section-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 15px 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }

        .section-header h3 {
            margin: 0;
            font-size: 18px;
        }

        .info-row {
            padding: 10px 0;
            border-bottom: 1px solid #e5e7eb;
        }

        .info-row:last-child {
            border-bottom: none;
        }

        .info-label {
            font-weight: 600;
            color: #6b7280;
        }

        .info-value {
            color: #1f2937;
        }

        .results-table {
            width: 100%;
            margin-top: 15px;
        }

        .results-table th {
            background-color: #f9fafb;
            padding: 12px;
            text-align: left;
            font-weight: 600;
            color: #374151;
            border-bottom: 2px solid #e5e7eb;
        }

        .results-table td {
            padding: 12px;
            border-bottom: 1px solid #e5e7eb;
        }

        .exam-section {
            margin-bottom: 30px;
        }

        .exam-title {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            padding: 12px 20px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .security-notice {
            background: #fef3c7;
            border-left: 4px solid #f59e0b;
            padding: 20px;
            border-radius: 8px;
            margin-top: 30px;
        }

        .security-notice h5 {
            color: #92400e;
            margin-bottom: 10px;
        }

        .security-notice p {
            color: #78350f;
            margin: 0;
            font-size: 14px;
        }
    </style>
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
                        <div class="verification-container">
                            <!-- Badge de verificación -->
                            <div class="verification-badge">
                                <i class="fas fa-check-circle"></i>
                                <h1>RESULTADO VERIFICADO Y AUTÉNTICO</h1>
                                <p class="text-muted mb-3">Este documento ha sido verificado exitosamente</p>
                                <div class="verification-code">
                                    {{ $resultado->codigo_verificacion }}
                                </div>
                            </div>

                            <!-- Información de la orden -->
                            <div class="results-card">
                                <div class="section-header">
                                    <h3><i class="fas fa-file-medical"></i> Información de la Orden</h3>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="info-row">
                                            <div class="info-label">Nº de Orden</div>
                                            <div class="info-value">
                                                <strong>{{ $resultado->codigo_verificacion }}</strong></div>
                                        </div>
                                        <div class="info-row">
                                            <div class="info-label">Fecha de Muestra</div>
                                            <div class="info-value">
                                                {{ \Carbon\Carbon::parse($resultado->fecha_muestra)->format('d/m/Y') }}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="info-row">
                                            <div class="info-label">Fecha de Resultado</div>
                                            <div class="info-value">
                                                {{ \Carbon\Carbon::parse($resultado->fecha_resultado)->format('d/m/Y') }}
                                            </div>
                                        </div>
                                        <div class="info-row">
                                            <div class="info-label">Clínica</div>
                                            <div class="info-value">{{ $resultado->clinica->nombre }}</div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Información del paciente -->
                            <div class="results-card">
                                <div class="section-header">
                                    <h3><i class="fas fa-user"></i> Datos del Paciente</h3>
                                </div>
                                <div class="row">
                                    <div class="col-md-6">
                                        <div class="info-row">
                                            <div class="info-label">Nombre</div>
                                            <div class="info-value"><strong>{{ $resultado->paciente->name }}</strong>
                                            </div>
                                        </div>
                                        <div class="info-row">
                                            <div class="info-label">Cédula</div>
                                            <div class="info-value">{{ $resultado->paciente->cedula }}</div>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="info-row">
                                            <div class="info-label">Fecha de Nacimiento</div>
                                            <div class="info-value">
                                                {{ $resultado->paciente->fecha_nacimiento ? \Carbon\Carbon::parse($resultado->paciente->fecha_nacimiento)->format('d/m/Y') : 'N/A' }}
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Resultados -->
                            <div class="results-card">
                                <div class="section-header">
                                    <h3><i class="fas fa-flask"></i> Resultados de Laboratorio</h3>
                                </div>
                                <div class="exam-section">
                                    <div class="exam-title">
                                        {{ $resultado->nombre_examen }}
                                    </div>
                                    <div class="table-responsive">
                                        <table class="results-table">
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
                                    </div>
                                </div>
                                @if($resultado->observaciones)
                                    <div class="alert alert-info mt-4">
                                        <h6><i class="fas fa-comment"></i> Observaciones Generales</h6>
                                        <p class="mb-0">{{ $resultado->observaciones }}</p>
                                    </div>
                                @endif
                            </div>

                            <!-- Aviso de seguridad -->
                            <div class="security-notice">
                                <h5><i class="fas fa-shield-alt"></i> Información de Seguridad</h5>
                                <p>
                                    <i class="fas fa-check"></i> Este documento ha sido verificado como auténtico.<br>
                                    <i class="fas fa-check"></i> El código QR y de verificación garantizan la integridad
                                    del documento.<br>
                                    <i class="fas fa-check"></i> Cualquier alteración invalidará este certificado.<br>
                                    <i class="fas fa-info-circle"></i> Verificado el {{ now()->format('d/m/Y H:i') }}
                                </p>
                            </div>

                            <!-- Botón para volver -->
                            <div class="text-center mt-4">
                                <a href="{{ url('/') }}" class="btn btn-light btn-lg">
                                    <i class="fas fa-home"></i> Ir al Inicio
                                </a>
                            </div>
                        </div>