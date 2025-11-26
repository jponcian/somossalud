@extends('layouts.adminlte')

@section('title', 'Detalle de Orden')

@section('sidebar')
    @include('panel.partials.sidebar')
@stop

@section('content_header')
    <h1>Detalle de Orden de Laboratorio</h1>
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
            <!-- Información de la Orden -->
            <div class="card">
                <div class="card-header" style="background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: white;">
                    <h3 class="card-title mb-0">
                        <i class="fas fa-file-medical"></i> Orden {{ $order->order_number }}
                    </h3>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <h5 class="text-muted mb-2">Información del Paciente</h5>
                            <p class="mb-1"><strong>Nombre:</strong> {{ $order->patient->name }}</p>
                            <p class="mb-1"><strong>Cédula:</strong> {{ $order->patient->cedula }}</p>
                            <p class="mb-1"><strong>Email:</strong> {{ $order->patient->email }}</p>
                        </div>
                        <div class="col-md-6">
                            <h5 class="text-muted mb-2">Información de la Orden</h5>
                            <p class="mb-1"><strong>Estado:</strong> 
                                @if($order->status == 'pending')
                                    <span class="badge badge-warning">Pendiente</span>
                                @elseif($order->status == 'in_progress')
                                    <span class="badge badge-info">En Proceso</span>
                                @elseif($order->status == 'completed')
                                    <span class="badge badge-success">Completado</span>
                                @else
                                    <span class="badge badge-danger">Cancelado</span>
                                @endif
                            </p>
                            <p class="mb-1"><strong>Fecha Orden:</strong> {{ $order->order_date->format('d/m/Y') }}</p>
                            @if($order->sample_date)
                                <p class="mb-1"><strong>Fecha Muestra:</strong> {{ $order->sample_date->format('d/m/Y') }}</p>
                            @endif
                            @if($order->result_date)
                                <p class="mb-1"><strong>Fecha Resultado:</strong> {{ $order->result_date->format('d/m/Y') }}</p>
                            @endif
                            <p class="mb-1"><strong>Clínica:</strong> {{ $order->clinica->nombre }}</p>
                        </div>
                    </div>

                    <hr>

                    <h5 class="text-muted mb-3">Exámenes Solicitados</h5>
                    @foreach($order->details as $detail)
                        <div class="mb-4">
                            <h6 class="text-primary">
                                <i class="fas fa-flask"></i> {{ $detail->exam->name }}
                                <span class="badge badge-info">${{ number_format($detail->price, 2) }}</span>
                            </h6>
                            
                            @if($detail->results->count() > 0)
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-sm">
                                        <thead class="thead-light">
                                            <tr>
                                                <th>Parámetro</th>
                                                <th>Valor</th>
                                                <th>Unidad</th>
                                                <th>Rango de Referencia</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            @foreach($detail->results as $result)
                                            <tr>
                                                <td><strong>{{ $result->examItem->name }}</strong></td>
                                                <td>{{ $result->value }}</td>
                                                <td>{{ $result->examItem->unit ?? '-' }}</td>
                                                <td>
                                                    @php
                                                        $rango = $result->examItem->getReferenceRangeForPatient($order->patient);
                                                    @endphp
                                                    @if($rango)
                                                        <span class="badge badge-light border text-wrap" style="font-size: 0.9em;">
                                                            {{ $rango->value_text ?? ($rango->value_min . ' - ' . $rango->value_max) }}
                                                        </span>
                                                        @if($rango->condition)
                                                            <br><small class="text-muted">({{ $rango->condition }})</small>
                                                        @endif
                                                    @else
                                                        {{ $result->examItem->reference_value ?? '-' }}
                                                    @endif
                                                </td>
                                            </tr>
                                            @endforeach
                                        </tbody>
                                    </table>
                                </div>
                            @else
                                <p class="text-muted"><em>Sin resultados cargados</em></p>
                            @endif
                        </div>
                    @endforeach

                    @if($order->observations)
                    <hr>
                    <h5 class="text-muted mb-2">Observaciones</h5>
                    <p class="text-justify">{{ $order->observations }}</p>
                    @endif

                    <hr>

                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Registrado por:</strong> {{ $order->createdBy->name ?? 'N/A' }}</p>
                            <p class="mb-1"><strong>Fecha de registro:</strong> {{ $order->created_at->format('d/m/Y H:i') }}</p>
                        </div>
                        <div class="col-md-6 text-right">
                            <p class="mb-1"><strong>Total:</strong> <span class="h4 text-success">${{ number_format($order->total, 2) }}</span></p>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    @if($order->isCompleted())
                        <a href="{{ route('lab.orders.pdf', $order->id) }}" class="btn btn-danger">
                            <i class="fas fa-file-pdf"></i> Descargar PDF con QR
                        </a>
                    @endif
                    @if($order->isPending() || $order->isInProgress())
                        <a href="{{ route('lab.orders.load-results', $order->id) }}" class="btn btn-primary">
                            <i class="fas fa-edit"></i> Cargar Resultados
                        </a>
                    @endif
                    <a href="{{ route('lab.orders.index') }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver al Listado
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            @if($order->isCompleted() && $order->verification_code)
                <!-- Código de Verificación -->
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-qrcode"></i> Código de Verificación
                        </h3>
                    </div>
                    <div class="card-body text-center">
                        <div class="mb-3">
                            {!! QrCode::size(200)->generate(route('lab.orders.verify', $order->verification_code)) !!}
                        </div>
                        <p class="mb-2"><strong>Código:</strong></p>
                        <h4 class="text-primary">{{ $order->verification_code }}</h4>
                        <hr>
                        <p class="text-muted small mb-2">URL de Verificación:</p>
                        <a href="{{ route('lab.orders.verify', $order->verification_code) }}" target="_blank" class="btn btn-sm btn-outline-primary">
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
            @else
                <!-- Estado de la Orden -->
                <div class="card">
                    <div class="card-header bg-warning text-white">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-exclamation-triangle"></i> Estado
                        </h3>
                    </div>
                    <div class="card-body">
                        <p class="mb-2">
                            <strong>Esta orden aún no tiene resultados cargados.</strong>
                        </p>
                        <p class="text-muted small mb-0">
                            El código QR de verificación se generará automáticamente cuando se carguen los resultados.
                        </p>
                    </div>
                </div>
            @endif
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
