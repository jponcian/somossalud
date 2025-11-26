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
                <div class="col-md-2">
                    <strong>Paciente:</strong><br>{{ $order->patient->name }}
                </div>
                <div class="col-md-2">
                    <strong>Cédula:</strong><br>{{ $order->patient->cedula }}
                </div>
                <div class="col-md-2">
                    <strong>Fecha de Orden:</strong><br>{{ $order->order_date->format('d/m/Y') }}
                </div>
                <div class="col-md-2">
                    <strong>Sexo:</strong><br>{{ $order->patient->sexo == 'M' ? 'Masculino' : ($order->patient->sexo == 'F' ? 'Femenino' : 'No especificado') }}
                </div>
                <div class="col-md-2">
                    <strong>Edad:</strong><br>{{ \Carbon\Carbon::parse($order->patient->fecha_nacimiento)->age ?? 'No disponible' }} años
                </div>
            </div>
        </div>
    </div>

    <form action="{{ route('lab.orders.store-results', $order->id) }}" method="POST">
        @csrf
        

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
                                                <div class="input-group">
                                                    <input type="text" 
                                                           name="results[{{ $item->id }}][observation]" 
                                                           class="form-control form-control-sm" 
                                                           value="{{ old('results.'.$item->id.'.observation', $existingResult?->observation) }}"
                                                           placeholder="Obs.">
                                                    <button type="button" class="btn btn-danger btn-sm delete-exam-item" title="Borrar parámetro" data-item-id="{{ $item->id }}">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </div>
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

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
document.addEventListener('DOMContentLoaded', function() {
    document.querySelectorAll('.delete-exam-item').forEach(function(btn) {
        btn.addEventListener('click', function() {
            Swal.fire({
                title: '¿Seguro que desea borrar este parámetro?',
                text: 'Esta acción no se puede deshacer.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonColor: '#d33',
                cancelButtonColor: '#3085d6',
                confirmButtonText: 'Sí, borrar',
                cancelButtonText: 'Cancelar'
            }).then((result) => {
                if (result.isConfirmed) {
                    var itemId = btn.getAttribute('data-item-id');
                    fetch("{{ route('lab.orders.delete-exam-item') }}", {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                            'X-CSRF-TOKEN': '{{ csrf_token() }}'
                        },
                        body: JSON.stringify({ item_id: itemId })
                    })
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            Swal.fire({
                                title: '¡Borrado!',
                                text: 'El parámetro fue eliminado correctamente.',
                                icon: 'success',
                                timer: 1500,
                                showConfirmButton: false
                            }).then(() => {
                                location.reload();
                            });
                        } else {
                            Swal.fire('Error', 'No se pudo borrar el parámetro.', 'error');
                        }
                    })
                    .catch(() => Swal.fire('Error', 'Error de red al intentar borrar.', 'error'));
                }
            });
        });
    });
});
</script>
@endpush
