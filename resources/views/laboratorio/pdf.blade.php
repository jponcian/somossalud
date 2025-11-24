<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Resultado de Laboratorio - {{ $resultado->codigo_verificacion }}</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Arial', sans-serif;
            font-size: 12px;
            line-height: 1.6;
            color: #333;
            padding: 20px;
        }
        
        .header {
            text-align: center;
            margin-bottom: 30px;
            border-bottom: 3px solid #667eea;
            padding-bottom: 15px;
        }
        
        .header h1 {
            color: #667eea;
            font-size: 24px;
            margin-bottom: 5px;
        }
        
        .header h2 {
            color: #764ba2;
            font-size: 18px;
            font-weight: normal;
        }
        
        .clinica-info {
            text-align: center;
            margin-bottom: 20px;
            font-size: 11px;
            color: #666;
        }
        
        .info-section {
            margin-bottom: 20px;
        }
        
        .info-section h3 {
            background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%);
            color: white;
            padding: 8px 12px;
            font-size: 14px;
            margin-bottom: 10px;
        }
        
        .info-grid {
            display: table;
            width: 100%;
            margin-bottom: 15px;
        }
        
        .info-row {
            display: table-row;
        }
        
        .info-label {
            display: table-cell;
            font-weight: bold;
            padding: 5px 10px;
            width: 30%;
            background-color: #f8f9fa;
        }
        
        .info-value {
            display: table-cell;
            padding: 5px 10px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .results-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        
        .results-table th {
            background-color: #667eea;
            color: white;
            padding: 10px;
            text-align: left;
            font-size: 11px;
        }
        
        .results-table td {
            padding: 8px 10px;
            border-bottom: 1px solid #e9ecef;
        }
        
        .results-table tr:nth-child(even) {
            background-color: #f8f9fa;
        }
        
        .observaciones {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            padding: 12px;
            margin-bottom: 20px;
        }
        
        .observaciones h4 {
            color: #856404;
            margin-bottom: 8px;
            font-size: 13px;
        }
        
        .qr-section {
            position: absolute;
            top: 20px;
            right: 20px;
            text-align: center;
            border: 2px solid #667eea;
            padding: 10px;
            background-color: white;
        }
        
        .qr-section img {
            width: 150px;
            height: 150px;
        }
        
        .qr-code {
            font-size: 10px;
            font-weight: bold;
            color: #667eea;
            margin-top: 5px;
        }
        
        .footer {
            position: fixed;
            bottom: 20px;
            left: 20px;
            right: 20px;
            text-align: center;
            font-size: 10px;
            color: #666;
            border-top: 1px solid #e9ecef;
            padding-top: 10px;
        }
        
        .verification-info {
            background-color: #d1ecf1;
            border-left: 4px solid #0c5460;
            padding: 12px;
            margin-top: 20px;
            font-size: 11px;
        }
        
        .verification-info strong {
            color: #0c5460;
        }
    </style>
</head>
<body>
    <!-- Código QR en la esquina superior derecha -->
    <div class="qr-section">
        <img src="data:image/svg+xml;base64,{{ $qrCode }}" alt="QR Code">
        <div class="qr-code">{{ $resultado->codigo_verificacion }}</div>
        <div style="font-size: 9px; color: #666; margin-top: 5px;">Escanear para verificar</div>
    </div>

    <!-- Encabezado -->
    <div class="header">
        <h1>CLÍNICA SALUDSONRISA</h1>
        <h2>Resultado de Laboratorio</h2>
    </div>

    <div class="clinica-info">
        <strong>{{ $resultado->clinica->nombre }}</strong><br>
        Fecha de emisión: {{ now()->format('d/m/Y H:i') }}
    </div>

    <!-- Información del Paciente -->
    <div class="info-section">
        <h3>Información del Paciente</h3>
        <div class="info-grid">
            <div class="info-row">
                <div class="info-label">Nombre Completo:</div>
                <div class="info-value">{{ $resultado->paciente->name }}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Cédula:</div>
                <div class="info-value">{{ $resultado->paciente->cedula }}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Email:</div>
                <div class="info-value">{{ $resultado->paciente->email }}</div>
            </div>
        </div>
    </div>

    <!-- Información del Examen -->
    <div class="info-section">
        <h3>Información del Examen</h3>
        <div class="info-grid">
            <div class="info-row">
                <div class="info-label">Tipo de Examen:</div>
                <div class="info-value">{{ $resultado->tipo_examen }}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Nombre del Examen:</div>
                <div class="info-value">{{ $resultado->nombre_examen }}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Fecha de Muestra:</div>
                <div class="info-value">{{ $resultado->fecha_muestra->format('d/m/Y') }}</div>
            </div>
            <div class="info-row">
                <div class="info-label">Fecha del Resultado:</div>
                <div class="info-value">{{ $resultado->fecha_resultado->format('d/m/Y') }}</div>
            </div>
        </div>
    </div>

    <!-- Resultados -->
    <div class="info-section">
        <h3>Resultados</h3>
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

    <!-- Observaciones -->
    @if($resultado->observaciones)
    <div class="observaciones">
        <h4>Observaciones:</h4>
        <p>{{ $resultado->observaciones }}</p>
    </div>
    @endif

    <!-- Información de Verificación -->
    <div class="verification-info">
        <strong>VERIFICACIÓN DE AUTENTICIDAD:</strong><br>
        Este documento puede ser verificado escaneando el código QR o ingresando el código <strong>{{ $resultado->codigo_verificacion }}</strong> 
        en nuestro sitio web. La verificación garantiza que este resultado fue emitido por nuestra institución y no ha sido alterado.
    </div>

    <!-- Pie de página -->
    <div class="footer">
        <p>
            <strong>Registrado por:</strong> {{ $resultado->registradoPor->name ?? 'N/A' }} | 
            <strong>Fecha de registro:</strong> {{ $resultado->created_at->format('d/m/Y H:i') }}
        </p>
        <p style="margin-top: 5px;">
            Este documento es válido únicamente con el código QR de verificación. 
            Para consultas, visite nuestro sitio web o contacte con la clínica.
        </p>
    </div>
</body>
</html>
