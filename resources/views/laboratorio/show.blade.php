@extends('layouts.adminlte')

@section('title', 'Detalle del Resultado')

@section('sidebar')
    @include('panel.partials.sidebar')
@stop

@section('content_header')
    <h1>Detalle del Resultado de Laboratorio</h1>
@stop

@section('content')
<div class="container-fluid">
    @if(session('success'))
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle"></i> {{ session('success') }}
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    @endif

    <div class="row">
        <div class="col-md-8">
            <!-- Información del Resultado -->
            <div class="card">
                <div class="card-header" style="background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: white;">
                    <h3 class="card-title mb-0">
                        <i class="fas fa-flask"></i> {{ $resultado->nombre_examen }}
                    </h3>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <h5 class="text-muted mb-2">Información del Paciente</h5>
                            <p class="mb-1"><strong>Nombre:</strong> {{ $resultado->paciente->name }}</p>
                            <p class="mb-1"><strong>Cédula:</strong> {{ $resultado->paciente->cedula }}</p>
                            <p class="mb-1"><strong>Email:</strong> {{ $resultado->paciente->email }}</p>
                        </div>
                        <div class="col-md-6">
                            <h5 class="text-muted mb-2">Información del Examen</h5>
                            <p class="mb-1"><strong>Tipo:</strong> <span class="badge badge-info">{{ $resultado->tipo_examen }}</span></p>
                            <p class="mb-1"><strong>Fecha Muestra:</strong> {{ $resultado->fecha_muestra->format('d/m/Y') }}</p>
                            <p class="mb-1"><strong>Fecha Resultado:</strong> {{ $resultado->fecha_resultado->format('d/m/Y') }}</p>
                            <p class="mb-1"><strong>Clínica:</strong> {{ $resultado->clinica->nombre }}</p>
                        </div>
                    </div>

                    <hr>

                    <h5 class="text-muted mb-3">Resultados</h5>
                    <div class="table-responsive">
                        <table class="table table-bordered table-hover">
                            <thead class="thead-light">
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

                    @if($resultado->observaciones)
                    <hr>
                    <h5 class="text-muted mb-2">Observaciones</h5>
                    <p class="text-justify">{{ $resultado->observaciones }}</p>
                    @endif

                    <hr>

                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Registrado por:</strong> {{ $resultado->registradoPor->name ?? 'N/A' }}</p>
                            <p class="mb-1"><strong>Fecha de registro:</strong> {{ $resultado->created_at->format('d/m/Y H:i') }}</p>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <a href="{{ route('laboratorio.pdf', $resultado) }}" class="btn btn-success">
                        <i class="fas fa-file-pdf"></i> Descargar PDF con QR
                    </a>
                    <a href="{{ route('laboratorio.index') }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver al Listado
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <!-- Código de Verificación -->
            <div class="card">
                <div class="card-header bg-success text-white">
                    <h3 class="card-title mb-0">
                        <i class="fas fa-qrcode"></i> Código de Verificación
                    </h3>
                </div>
                <div class="card-body text-center">
                    <div class="mb-3">
                        {!! QrCode::size(200)->generate($resultado->url_verificacion) !!}
                    </div>
                    <p class="mb-2"><strong>Código:</strong></p>
                    <h4 class="text-primary">{{ $resultado->codigo_verificacion }}</h4>
                    <hr>
                    <p class="text-muted small mb-2">URL de Verificación:</p>
                    <a href="{{ $resultado->url_verificacion }}" target="_blank" class="btn btn-sm btn-outline-primary">
                        <i class="fas fa-external-link-alt"></i> Verificar Resultado
                    </a>
                </div>
            </div>

            <!-- Información Adicional -->
            <div class="card">
                <div class="card-header bg-info text-white">
                    <h3 class="card-title mb-0">
                        <i class="fas fa-info-circle"></i> Información
                    </h3>
                </div>
                <div class="card-body">
                    <p class="small text-muted mb-2">
                        <i class="fas fa-shield-alt"></i> Este resultado puede ser verificado escaneando el código QR o ingresando el código de verificación en nuestro sitio web.
                    </p>
                    <p class="small text-muted mb-0">
                        <i class="fas fa-lock"></i> El código QR garantiza la autenticidad del documento y previene falsificaciones.
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>
@stop

@section('css')
<style>
    .table th {
        background-color: #f8f9fa;
        font-weight: 600;
    }
    
    .card-header {
        border-radius: 0.25rem 0.25rem 0 0 !important;
    }
</style>
@stop
