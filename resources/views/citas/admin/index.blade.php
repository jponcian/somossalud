@extends('layouts.adminlte')

@section('title','Citas | SomosSalud')

@section('content-header')
    <div class="row mb-2">
        <div class="col-sm-6">
            <h1 class="m-0">Citas</h1>
        </div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="{{ route('panel.clinica') }}">Inicio</a></li>
                <li class="breadcrumb-item active">Citas</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center flex-wrap">
            <h3 class="card-title"><i class="fas fa-calendar-alt mr-2 text-primary"></i> Listado de citas</h3>
            @if(auth()->user()->hasRole('paciente'))
                <a href="{{ route('citas.create') }}" class="btn btn-primary btn-sm"><i class="fas fa-calendar-plus mr-1"></i> Nueva cita</a>
            @endif
        </div>
        <div class="card-body p-0">
            <table class="table table-striped table-hover table-sm mb-0">
                <thead class="thead-light">
                <tr class="text-uppercase small text-muted">
                    <th>Fecha / Hora</th>
                    <th>Estado</th>
                    <th>Paciente</th>
                    <th>Especialista</th>
                    <th class="text-right">Acciones</th>
                </tr>
                </thead>
                <tbody>
                @forelse($citas as $cita)
                    <tr class="align-middle">
                        <td class="small">
                            @php($f = \Illuminate\Support\Carbon::parse($cita->fecha))
                            {{ $f->format('d/m/Y') }} {{ str_replace(' ', '', $f->format('h:i a')) }}
                        </td>
                        <td class="small">
                            @php $badge = match($cita->estado){
                                'pendiente' => 'secondary',
                                'confirmada' => 'success',
                                'cancelada' => 'danger',
                                'concluida' => 'info',
                                default => 'light'
                            }; @endphp
                            <span class="badge badge-{{ $badge }}">{{ ucfirst($cita->estado) }}</span>
                        </td>
                        <td class="small">{{ optional($cita->usuario)->name ?? '—' }}</td>
                        <td class="small">{{ optional($cita->especialista)->name ?? '—' }}</td>
                        <td class="text-right text-nowrap">
                            <a href="{{ route('citas.show', $cita) }}" class="btn btn-outline-secondary btn-sm" title="Ver"><i class="fas fa-eye"></i></a>
                            @php($yo = auth()->user())
                            @if(($yo->id === $cita->especialista_id) || $yo->hasRole(['super-admin','admin_clinica']))
                                <a href="{{ route('citas.show', $cita) }}#gestion" class="btn btn-outline-primary btn-sm" title="Gestionar"><i class="fas fa-stethoscope"></i></a>
                            @endif
                            @if($cita->medicamentos()->exists())
                                <a href="{{ route('citas.receta', $cita) }}" class="btn btn-outline-success btn-sm" title="Receta"><i class="fas fa-prescription-bottle"></i></a>
                            @endif
                            <form action="{{ route('citas.cancelar', $cita) }}" method="POST" class="d-inline" onsubmit="return confirm('¿Cancelar esta cita?');">
                                @csrf
                                <button class="btn btn-outline-danger btn-sm" @disabled($cita->estado==='cancelada') title="Cancelar"><i class="fas fa-ban"></i></button>
                            </form>
                        </td>
                    </tr>
                @empty
                    <tr>
                        <td colspan="5" class="text-center py-4 text-muted small">No hay citas registradas.</td>
                    </tr>
                @endforelse
                </tbody>
            </table>
        </div>
    </div>
@endsection
