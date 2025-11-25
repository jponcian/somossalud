@extends('layouts.adminlte')

@section('title', 'Órdenes de Laboratorio')

@section('sidebar')
@include('panel.partials.sidebar')
@stop

@section('content_header')
<h1 class="m-0">Órdenes de Laboratorio</h1>
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

    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center"
            style="background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: white; padding: 1rem 1.25rem;">
            <h3 class="card-title mb-0" style="font-weight: 600;">
                <i class="fas fa-flask mr-2"></i> Listado de Exámenes
            </h3>
            <a href="{{ route('lab.orders.create') }}"
                style="background: white; color: #0ea5e9; font-weight: 600; padding: 0.5rem 1.25rem; border-radius: 8px; border: 2px solid rgba(255, 255, 255, 0.3); box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15); text-decoration: none; display: inline-flex; align-items: center; transition: all 0.3s ease; margin-left: auto;"
                onmouseover="this.style.transform='translateY(-2px)'; this.style.boxShadow='0 6px 16px rgba(0, 0, 0, 0.2)'; this.style.color='#0284c7';"
                onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 4px 12px rgba(0, 0, 0, 0.15)'; this.style.color='#0ea5e9';">
                <i class="fas fa-plus-circle mr-2"></i> Nueva Orden
            </a>
        </div>
        <div class="card-body">
            @if($orders->count() > 0)
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>Nº Orden</th>
                                <th>Número Diario</th>
                                <th>Paciente</th>
                                <th>Exámenes</th>
                                <th>Fecha Orden</th>
                                <th>Fecha Resultado</th>
                                <th>Estado</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            @foreach($orders as $order)
                                <tr>
                                    <td>
                                        <code class="text-primary">{{ $order->order_number }}</code>
                                    </td>
                                    <td>
                                        <span class="badge badge-success">{{ $order->daily_exam_count }}</span>
                                    </td>
                                    <td>
                                        <strong>{{ $order->patient->name }}</strong><br>
                                        <small class="text-muted">{{ $order->patient->cedula }}</small>
                                    </td>
                                    <td>
                                        <span class="badge badge-info">{{ $order->details->count() }} examen(es)</span>
                                    </td>
                                    <td>{{ $order->order_date->format('d/m/Y') }}</td>
                                    <td>
                                        @if($order->result_date)
                                            {{ $order->result_date->format('d/m/Y') }}
                                        @else
                                            <span class="text-muted">-</span>
                                        @endif
                                    </td>
                                    <td>
                                        @if($order->status == 'pending')
                                            <span class="badge badge-warning">Pendiente</span>
                                        @elseif($order->status == 'in_progress')
                                            <span class="badge badge-info">En Proceso</span>
                                        @elseif($order->status == 'completed')
                                            <span class="badge badge-success">Completado</span>
                                        @else
                                            <span class="badge badge-danger">Cancelado</span>
                                        @endif
                                    </td>
                                    <td>
                                        <div class="btn-group" role="group">
                                            @if($order->isPending() || $order->isInProgress())
                                                <a href="{{ route('lab.orders.load-results', $order->id) }}"
                                                    class="btn btn-sm btn-primary" title="Cargar resultados">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                            @endif

                                            <a href="{{ route('lab.orders.show', $order->id) }}" class="btn btn-sm btn-info"
                                                title="Ver detalle">
                                                <i class="fas fa-eye"></i>
                                            </a>

                                            @if($order->isCompleted())
                                                <a href="{{ route('lab.orders.pdf', $order->id) }}" class="btn btn-sm btn-danger"
                                                    title="Descargar PDF">
                                                    <i class="fas fa-file-pdf"></i>
                                                </a>
                                            @endif
                                        </div>
                                    </td>
                                </tr>
                            @endforeach
                        </tbody>
                    </table>
                </div>

                <div class="mt-3">
                    {{ $orders->links() }}
                </div>
            @else
                <div class="text-center py-5">
                    <i class="fas fa-file-medical fa-3x text-muted mb-3"></i>
                    <p class="text-muted">No hay órdenes de laboratorio registradas.</p>
                    <a href="{{ route('lab.orders.create') }}" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Crear Primera Orden
                    </a>
                </div>
            @endif
        </div>
    </div>
</div>
@stop

@section('css')
<style>
    .card-header {
        border-radius: 0.25rem 0.25rem 0 0 !important;
    }

    .table th {
        font-weight: 600;
        color: #495057;
        border-bottom: 2px solid #dee2e6;
    }

    .btn-group .btn {
        margin: 0 2px;
    }
</style>
@stop