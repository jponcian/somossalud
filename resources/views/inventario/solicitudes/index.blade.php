@extends('layouts.adminlte')

@section('title', 'Solicitudes de Inventario')

@section('content_header')
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-clipboard-list text-primary"></i> Solicitudes de Inventario</h1>
        @can('create', App\Models\SolicitudInventario::class)
            <a href="{{ route('inventario.solicitudes.create') }}" class="btn btn-primary btn-lg shadow-sm">
                <i class="fas fa-plus-circle"></i> Nueva Solicitud
            </a>
        @endcan
    </div>
@stop

@section('content')
    {{-- Estadísticas --}}
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="small-box bg-warning shadow-sm">
                <div class="inner">
                    <h3>{{ $stats['pendientes'] }}</h3>
                    <p>Pendientes de Aprobación</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="small-box bg-info shadow-sm">
                <div class="inner">
                    <h3>{{ $stats['aprobadas'] }}</h3>
                    <p>Aprobadas / Por Despachar</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="small-box bg-success shadow-sm">
                <div class="inner">
                    <h3>{{ $stats['despachadas_mes'] }}</h3>
                    <p>Despachadas en {{ now()->locale('es')->translatedFormat('F Y') }}</p>
                </div>
                <div class="icon">
                    <i class="fas fa-truck-loading"></i>
                </div>
            </div>
        </div>
    </div>

    {{-- Filtros --}}
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light">
            <h3 class="card-title text-muted"><i class="fas fa-filter"></i> Filtros de Búsqueda</h3>
            <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                </button>
            </div>
        </div>
        <div class="card-body">
            <form method="GET" action="{{ route('inventario.solicitudes.index') }}">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">ESTADO</label>
                            <select name="estado" class="form-control select2">
                                <option value="">Todos los estados</option>
                                <option value="pendiente" {{ request('estado') == 'pendiente' ? 'selected' : '' }}>Pendiente</option>
                                <option value="aprobada" {{ request('estado') == 'aprobada' ? 'selected' : '' }}>Aprobada</option>
                                <option value="despachada" {{ request('estado') == 'despachada' ? 'selected' : '' }}>Despachada</option>
                                <option value="rechazada" {{ request('estado') == 'rechazada' ? 'selected' : '' }}>Rechazada</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">CATEGORÍA</label>
                            <select name="categoria" class="form-control select2">
                                <option value="">Todas las categorías</option>
                                <option value="ENFERMERIA" {{ request('categoria') == 'ENFERMERIA' ? 'selected' : '' }}>Enfermería</option>
                                <option value="QUIROFANO" {{ request('categoria') == 'QUIROFANO' ? 'selected' : '' }}>Quirófano</option>
                                <option value="UCI" {{ request('categoria') == 'UCI' ? 'selected' : '' }}>UCI</option>
                                <option value="OFICINA" {{ request('categoria') == 'OFICINA' ? 'selected' : '' }}>Oficina</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">DESDE</label>
                            <input type="date" name="fecha_desde" class="form-control" value="{{ request('fecha_desde') }}">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">HASTA</label>
                            <input type="date" name="fecha_hasta" class="form-control" value="{{ request('fecha_hasta') }}">
                        </div>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <div class="form-group w-100">
                            <button type="submit" class="btn btn-primary btn-block">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    {{-- Lista de solicitudes --}}
    <div class="card shadow-lg border-0">
        <div class="card-header bg-white border-bottom-0">
            <h3 class="card-title text-primary font-weight-bold"><i class="fas fa-list-alt"></i> Listado de Solicitudes</h3>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="bg-light text-muted">
                        <tr>
                            <th class="pl-4">Número</th>
                            <th>Fecha</th>
                            <th>Solicitante</th>
                            <th>Categoría</th>
                            <th class="text-center">Items</th>
                            <th class="text-center">Estado</th>
                            <th class="text-right pr-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($solicitudes as $solicitud)
                            <tr>
                                <td class="pl-4 align-middle">
                                    <span class="font-weight-bold text-dark">{{ $solicitud->numero_solicitud }}</span>
                                </td>
                                <td class="align-middle">
                                    <i class="far fa-calendar-alt text-muted mr-1"></i>
                                    {{ $solicitud->created_at->format('d/m/Y H:i') }}
                                </td>
                                <td class="align-middle">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle bg-light text-primary mr-2" style="width:30px;height:30px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:bold;">
                                            {{ substr($solicitud->solicitante->name, 0, 1) }}
                                        </div>
                                        {{ $solicitud->solicitante->name }}
                                    </div>
                                </td>
                                <td class="align-middle">
                                    <span class="badge badge-light border px-2 py-1">
                                        {{ $solicitud->categoria }}
                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="badge badge-pill badge-info px-3">
                                        {{ $solicitud->total_items }}
                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="badge badge-{{ $solicitud->badge_color }} px-3 py-2 rounded-pill shadow-sm">
                                        {{ ucfirst($solicitud->estado) }}
                                    </span>
                                </td>
                                <td class="align-middle text-right pr-4">
                                    <div class="btn-group">
                                        <a href="{{ route('inventario.solicitudes.show', $solicitud) }}" 
                                           class="btn btn-sm btn-outline-primary" 
                                           title="Ver detalle">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        
                                        @can('approve', $solicitud)
                                            @if($solicitud->isPendiente())
                                                <a href="{{ route('inventario.solicitudes.edit', $solicitud) }}" 
                                                   class="btn btn-sm btn-outline-warning" 
                                                   title="Gestionar Aprobación">
                                                    <i class="fas fa-tasks"></i>
                                                </a>
                                            @endif
                                        @endcan
                                        
                                        @can('delete', $solicitud)
                                            @if($solicitud->isPendiente())
                                                <form action="{{ route('inventario.solicitudes.destroy', $solicitud) }}" 
                                                      method="POST" 
                                                      style="display: inline-block;"
                                                      onsubmit="return confirm('¿Está seguro de eliminar esta solicitud?');">
                                                    @csrf
                                                    @method('DELETE')
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Eliminar">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            @endif
                                        @endcan
                                    </div>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <div class="empty-state">
                                        <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                                        <h5 class="text-muted">No se encontraron solicitudes</h5>
                                        <p class="text-muted small">Intente ajustar los filtros o cree una nueva solicitud.</p>
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        @if($solicitudes->hasPages())
            <div class="card-footer bg-white">
                {{ $solicitudes->links() }}
            </div>
        @endif
    </div>
@stop

@push('styles')
<style>
    .avatar-circle {
        font-size: 14px;
    }
    .table td {
        vertical-align: middle;
    }
</style>
@endpush
