@extends('layouts.adminlte')

@section('title', 'Ingresos de Inventario')

@section('content-header')
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-dolly text-success"></i> Ingresos de Inventario</h1>
        <a href="{{ route('inventario.ingresos.create') }}" class="btn btn-success shadow-sm">
            <i class="fas fa-plus-circle"></i> Nuevo Ingreso
        </a>
    </div>
@stop

@section('content')
    <div class="card shadow-lg border-0">
        <div class="card-header bg-white border-bottom-0">
            <h3 class="card-title text-muted"><i class="fas fa-history"></i> Historial de Ingresos</h3>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="bg-light text-muted">
                        <tr>
                            <th class="pl-4">Fecha</th>
                            <th>Material</th>
                            <th>Usuario</th>
                            <th>Motivo / Referencia</th>
                            <th class="text-center">Cantidad</th>
                            <th class="text-center">Stock Resultante</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($movimientos as $mov)
                            <tr>
                                <td class="pl-4 align-middle">
                                    {{ $mov->created_at->format('d/m/Y H:i') }}
                                </td>
                                <td class="align-middle">
                                    <div class="font-weight-bold">{{ $mov->material->nombre }}</div>
                                    <small class="text-muted">{{ $mov->material->codigo }}</small>
                                </td>
                                <td class="align-middle">
                                    {{ $mov->user->name }}
                                </td>
                                <td class="align-middle">
                                    <div>{{ $mov->motivo }}</div>
                                    @if($mov->referencia)
                                        <small class="text-muted"><i class="fas fa-hashtag"></i> {{ $mov->referencia }}</small>
                                    @endif
                                </td>
                                <td class="align-middle text-center">
                                    <span class="badge badge-success px-3 py-2" style="font-size: 1rem;">
                                        +{{ $mov->cantidad }}
                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="font-weight-bold text-dark">{{ $mov->stock_nuevo }}</span>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <i class="fas fa-box-open fa-3x mb-3"></i>
                                    <p>No hay registros de ingresos.</p>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($movimientos->hasPages())
            <div class="card-footer bg-white">
                {{ $movimientos->links() }}
            </div>
        @endif
    </div>
@stop
