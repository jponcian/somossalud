@extends('layouts.adminlte')

@section('title', 'SomosSalud | Panel interno')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

@section('content-header')
    <div class="row mb-2">
        <div class="col-sm-6">
            <h1 class="m-0 text-dark">Panel operativo de Clínica</h1>
        </div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="{{ route('panel.clinica') }}">Inicio</a></li>
                <li class="breadcrumb-item active">Panel</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    {{-- Se eliminó el callout de "Panel en construcción" para mostrar directamente los widgets disponibles --}}

    {{-- Definimos la variable de usuario autenticado en un bloque PHP para evitar problemas de parseo --}}
    @php
        $yo = auth()->user();
    @endphp
    @role('especialista')
    <div class="row">
        <div class="col-lg-4 col-md-6">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title"><i class="fas fa-calendar-check text-primary mr-2"></i> Mis citas</h3>
                    <a href="{{ route('citas.index') }}" class="btn btn-sm btn-outline-primary">Ver todas</a>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                        @php
                            $proximas = \App\Models\Cita::where('especialista_id', $yo->id)
                                ->orderBy('fecha','asc')
                                ->take(5)
                                ->get();
                        @endphp
                        @forelse($proximas as $c)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-muted">{{ \Illuminate\Support\Carbon::parse($c->fecha)->format('d/m/Y h:i a') }}</div>
                                    <div class="small">Paciente: {{ optional($c->usuario)->name ?? '—' }}</div>
                                </div>
                                <div class="text-nowrap">
                                    <a href="{{ route('citas.show', $c) }}#gestion" class="btn btn-sm btn-outline-secondary" title="Gestionar"><i class="fas fa-stethoscope"></i></a>
                                </div>
                            </li>
                        @empty
                            <li class="list-group-item text-muted small">Sin citas próximas</li>
                        @endforelse
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><i class="far fa-clock text-teal mr-2"></i> Mis horarios</h3>
                </div>
                <div class="card-body">
                    <p class="small text-muted mb-2">Administra tu disponibilidad semanal.</p>
                    <a href="{{ route('especialista.horarios.index') }}" class="btn btn-outline-teal btn-sm"><i class="far fa-clock mr-1"></i> Configurar</a>
                </div>
            </div>
        </div>
    </div>
    @endrole
@endsection