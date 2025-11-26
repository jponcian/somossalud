@extends('layouts.adminlte')

@section('title', 'Cargar Resultados')

@section('sidebar')
    @include('panel.partials.sidebar')
@stop

@section('content_header')
    <h1 class="m-0">Cargar Resultados - Orden {{ $order->order_number }}</h1>
@stop

@section('content')
<div class="container-fluid">
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="h3 mb-0">
                <i class="fas fa-edit text-primary"></i> Cargar Resultados - Orden {{ $order->order_number }}
            </h1>
        </div>
    </div>

    <!-- Información del paciente -->
    <div class="card mb-4">
        <div class="card-header bg-info text-white">
            <h5 class="mb-0"><i class="fas fa-user"></i> Información del Paciente</h5>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-4">
                    <strong>Paciente:</strong> {{ $order->patient->name }}
                </div>
                <div class="col-md-4">
                    <strong>Cédula:</strong> {{ $order->patient->cedula }}
                </div>
                <div class="col-md-4">
                    <strong>Fecha de Orden:</strong> {{ $order->order_date->format('d/m/Y') }}
                </div>
            </div>
        </div>
    </div>

    <form action="{{ route('lab.orders.store-results', $order->id) }}" method="POST">
        @csrf
        
        <!-- Fechas -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="mb-0"><i class="fas fa-calendar"></i> Fechas</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-6">
                        <label class="form-label">Fecha de Toma de Muestra <span class="text-danger">*</span></label>
                        <input type="date" 
                               name="sample_date" 
                               class="form-control @error('sample_date') is-invalid @enderror" 
                               value="{{ old('sample_date', $order->sample_date?->format('Y-m-d') ?? $order->order_date->format('Y-m-d')) }}" 
                               required>
                        @error('sample_date')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                    <div class="col-md-6">
                        <label class="form-label">Fecha de Resultados <span class="text-danger">*</span></label>
                        <input type="date" 
                               name="result_date" 
                               class="form-control @error('result_date') is-invalid @enderror" 
                               value="{{ old('result_date', $order->result_date?->format('Y-m-d') ?? date('Y-m-d')) }}" 
                               required>
                        @error('result_date')
                            <div class="invalid-feedback">{{ $message }}</div>
                        @enderror
                    </div>
                </div>
            </div>
        </div>

        <!-- Resultados por examen -->
        @foreach($order->details as $detail)
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">
                        <i class="fas fa-flask"></i> {{ $detail->exam->name }}
                        @if($detail->exam->abbreviation)
                            <small>({{ $detail->exam->abbreviation }})</small>
                        @endif
                    </h5>
                </div>
                <div class="card-body">
                    @if($detail->exam->items->count() > 0)
                        <div class="table-responsive">
                            <table class="table table-bordered">
                                <thead class="table-light">
                                    <tr>
                                        <th width="30%">Parámetro</th>
                                        <th width="20%">Valor</th>
                                        <th width="15%">Unidad</th>
                                        <th width="20%">Rango de Referencia</th>
                                        <th width="15%">Observación</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    @foreach($detail->exam->items as $item)
                                        @php
                                            $existingResult = $detail->results->where('lab_exam_item_id', $item->id)->first();
                                        @endphp
                                        <tr>
                                            <td>
                                                <strong>{{ $item->name }}</strong>
                                            </td>
                                            <td>
                                                <input type="text" 
                                                       name="results[{{ $item->id }}][value]" 
                                                       class="form-control" 
                                                       value="{{ old('results.'.$item->id.'.value', $existingResult?->value) }}"
                                                       placeholder="Ingrese valor">
                                            </td>
                                            <td>
                                                <span class="text-muted">{{ $item->unit ?? 'N/A' }}</span>
                                            </td>
                                            <td>
                                                @php
                                                    $rango = $item->getReferenceRangeForPatient($order->patient);
                                                @endphp
                                                @if($rango)
                                                    <span class="badge badge-info text-wrap" style="font-size: 0.9em;">
                                                        {{ $rango->value_text ?? ($rango->value_min . ' - ' . $rango->value_max) }}
                                                    </span>
                                                    @if($rango->condition)
                                                        <br><small class="text-muted">({{ $rango->condition }})</small>
                                                    @endif
                                                @else
                                                    <span class="text-muted">{{ $item->reference_value ?? 'N/A' }}</span>
                                                @endif
                                            </td>
                                            <td>
                                                <input type="text" 
                                                       name="results[{{ $item->id }}][observation]" 
                                                       class="form-control form-control-sm" 
                                                       value="{{ old('results.'.$item->id.'.observation', $existingResult?->observation) }}"
                                                       placeholder="Obs.">
                                            </td>
                                        </tr>
                                    @endforeach
                                </tbody>
                            </table>
                        </div>
                    @else
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-triangle"></i> Este examen no tiene ítems configurados.
                        </div>
                    @endif
                </div>
            </div>
        @endforeach

        <!-- Botones -->
        <div class="row">
            <div class="col-12">
                <div class="d-flex justify-content-between">
                    <a href="{{ route('lab.orders.show', $order->id) }}" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver
                    </a>
                    <button type="submit" class="btn btn-success">
                        <i class="fas fa-save"></i> Guardar Resultados
                    </button>
                </div>
            </div>
        </div>
    </form>
</div>
@endsection
