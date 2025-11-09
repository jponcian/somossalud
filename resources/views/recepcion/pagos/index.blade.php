@extends('layouts.adminlte')

@section('title', 'Validación de pagos')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

@push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        $(function () {
            // Toast de resultado tras acciones
            @if(session('success'))
            Swal.fire({
                icon: 'success',
                title: @json(session('success')),
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 2500,
                timerProgressBar: true
            });
            @endif
            @if(session('error'))
            Swal.fire({
                icon: 'error',
                title: @json(session('error')),
                toast: true,
                position: 'top-end',
                showConfirmButton: false,
                timer: 3000,
                timerProgressBar: true
            });
            @endif

            $('form.js-approve').on('submit', function (e) {
                e.preventDefault();
                const form = this;
                const paciente = $(form).data('paciente') || '';
                const ref = $(form).data('ref') || '';
                Swal.fire({
                    title: 'Aprobar pago',
                    html: `¿Confirmas aprobar el pago ${ref ? 'ref <b>' + ref + '</b>' : ''}${paciente ? ' de <b>' + paciente + '</b>' : ''}?`,
                    icon: 'question',
                    showCancelButton: true,
                    confirmButtonText: 'Sí, aprobar',
                    cancelButtonText: 'Cancelar'
                }).then((result) => {
                    if (result.isConfirmed) {
                        form.submit();
                    }
                });
            });

            $('form.js-reject').on('submit', function (e) {
                e.preventDefault();
                const form = this;
                const paciente = $(form).data('paciente') || '';
                const ref = $(form).data('ref') || '';
                const prev = $(form).find('input[name="observaciones"]').val() || '';
                Swal.fire({
                    title: 'Rechazar pago',
                    html: `${ref ? 'Ref <b>' + ref + '</b>' : ''}${paciente ? ' — <b>' + paciente + '</b>' : ''}`,
                    input: 'textarea',
                    inputLabel: 'Motivo de rechazo',
                    inputPlaceholder: 'Escribe el motivo...',
                    inputValue: prev,
                    inputAttributes: { 'aria-label': 'Motivo de rechazo' },
                    showCancelButton: true,
                    confirmButtonText: 'Rechazar',
                    cancelButtonText: 'Cancelar',
                    preConfirm: (value) => {
                        if (!value) {
                            Swal.showValidationMessage('Indica un motivo para continuar');
                        }
                        return value;
                    }
                }).then((result) => {
                    if (result.isConfirmed) {
                        let obs = $(form).find('input[name="observaciones"]');
                        if (!obs.length) {
                            obs = $('<input>').attr({ type: 'hidden', name: 'observaciones' });
                            $(form).append(obs);
                        }
                        obs.val(result.value);
                        form.submit();
                    }
                });
            });
        });
    </script>
@endpush

@section('content-header')
    <div class="row mb-2">
        <div class="col-sm-6">
            <h1 class="m-0 text-dark">Validación de pagos</h1>
        </div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="{{ route('panel.clinica') }}">Inicio</a></li>
                <li class="breadcrumb-item active">Pagos</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <div>
                <form method="GET" class="form-inline">
                    <label class="mr-2">Estado</label>
                    <select name="estado" class="form-control form-control-sm" onchange="this.form.submit()">
                        @foreach (['pendiente' => 'Pendiente', 'aprobado' => 'Aprobado', 'rechazado' => 'Rechazado'] as $k => $v)
                            <option value="{{ $k }}" {{ $estado === $k ? 'selected' : '' }}>{{ $v }}</option>
                        @endforeach
                    </select>
                </form>
            </div>
            @if (session('success'))
                <span class="badge badge-success">{{ session('success') }}</span>
            @endif
            @if (session('error'))
                <span class="badge badge-danger">{{ session('error') }}</span>
            @endif
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0">
                    <thead class="thead-light">
                        <tr>
                            <th>Paciente</th>
                            <th>Cédula</th>
                            <th>Teléfono</th>
                            <th>Fecha</th>
                            <th>Referencia</th>
                            <th>Monto</th>
                            <th>Estado</th>
                            <th>Revisión</th>
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($reportes as $reporte)
                            <tr>
                                <td>{{ $reporte->usuario->name }}</td>
                                <td>{{ $reporte->cedula_pagador }}</td>
                                <td>{{ $reporte->telefono_pagador }}</td>
                                <td>{{ optional($reporte->fecha_pago)->format('d/m/Y') }}</td>
                                <td>{{ $reporte->referencia }}</td>
                                <td>{{ number_format($reporte->monto, 2, ',', '.') }} Bs</td>
                                <td>
                                    <span
                                        class="badge badge-{{ $reporte->estado === 'pendiente' ? 'warning' : ($reporte->estado === 'aprobado' ? 'success' : 'danger') }}">
                                        {{ ucfirst($reporte->estado) }}
                                    </span>
                                </td>
                                <td class="text-nowrap small">
                                    @if($reporte->estado !== 'pendiente')
                                        <div>
                                            <span class="d-block">Por: {{ optional($reporte->revisor)->name ?? 'N/D' }}</span>
                                            <span class="text-muted">{{ optional($reporte->reviewed_at)->format('d/m H:i') }}</span>
                                            @if($reporte->estado === 'rechazado' && $reporte->observaciones)
                                                <span class="badge badge-light border mt-1">{{ Str::limit($reporte->observaciones, 40) }}</span>
                                            @endif
                                        </div>
                                    @else
                                        <span class="text-muted">—</span>
                                    @endif
                                </td>
                                <td class="text-nowrap">
                                    @if($reporte->estado === 'pendiente')
                                        <form action="{{ route('recepcion.pagos.aprobar', $reporte) }}" method="POST"
                                            class="d-inline js-approve" data-paciente="{{ $reporte->usuario->name }}" data-ref="{{ $reporte->referencia }}">
                                            @csrf
                                            <button class="btn btn-sm btn-success" type="submit">Aprobar</button>
                                        </form>
                                        <form action="{{ route('recepcion.pagos.rechazar', $reporte) }}" method="POST"
                                            class="d-inline ml-1 js-reject" data-paciente="{{ $reporte->usuario->name }}" data-ref="{{ $reporte->referencia }}">
                                            @csrf
                                            <input type="hidden" name="observaciones" value="Datos inconsistentes">
                                            <button class="btn btn-sm btn-outline-danger" type="submit">Rechazar</button>
                                        </form>
                                    @else
                                        <small class="text-muted">Revisado</small>
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="8" class="text-center py-4">No hay reportes para mostrar.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if ($reportes->hasPages())
            <div class="card-footer clearfix">
                {{ $reportes->links() }}
            </div>
        @endif
    </div>
@endsection