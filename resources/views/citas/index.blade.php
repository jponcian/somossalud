<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">Mis citas</h2>
    </x-slot>

    <div class="container py-4">
        <h1 class="h4 mb-4">Citas médicas</h1>
        @if(session('success'))
            <div class="alert alert-success small mb-3">{{ session('success') }}</div>
        @endif

        <div class="mb-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
            <p class="text-muted small mb-0">Agenda nuevas consultas, confirma fechas y recibe recordatorios automáticos.</p>
            <a href="{{ route('citas.create') }}" class="btn btn-sm btn-primary"><i class="fa-solid fa-calendar-plus me-1"></i> Nueva cita</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body p-0">
                <table class="table table-sm mb-0">
                    <thead class="table-light">
                        <tr class="small text-uppercase text-muted">
                            <th>Fecha / Hora</th>
                            <th>Estado</th>
                            <th>Especialista</th>
                            <th class="text-end">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                    @forelse($citas as $cita)
                        <tr class="align-middle">
                            <td class="small">
                                @php
                                    $__f = \Illuminate\Support\Carbon::parse($cita->fecha);
                                    $__fecha = $__f->format('d/m/Y');
                                    $__hora = str_replace(' ', '', $__f->format('h:i a')); // 12h sin espacio antes de am/pm
                                @endphp
                                {{ $__fecha }} {{ $__hora }}
                            </td>
                            <td class="small">
                                @php $badge = match($cita->estado){
                                    'pendiente' => 'secondary',
                                    'confirmada' => 'success',
                                    'cancelada' => 'danger',
                                    default => 'light'
                                }; @endphp
                                <span class="badge text-bg-{{ $badge }}">{{ ucfirst($cita->estado) }}</span>
                            </td>
                            <td class="small">{{ optional($cita->especialista)->name ?? '—' }}</td>
                            <td class="text-end">
                                @php($yo = auth()->user())
                                @if(($yo->id === $cita->especialista_id) || $yo->hasRole(['super-admin','admin_clinica']))
                                    <a href="{{ route('citas.show', $cita) }}#gestion" class="btn btn-outline-primary btn-sm" title="Gestionar"><i class="fa-solid fa-stethoscope"></i></a>
                                @else
                                    <a href="{{ route('citas.show', $cita) }}" class="btn btn-outline-secondary btn-sm" title="Ver detalle"><i class="fa-solid fa-eye"></i></a>
                                @endif
                                @if($cita->medicamentos()->exists())
                                    <a href="{{ route('citas.receta', $cita) }}" class="btn btn-outline-success btn-sm" title="Receta"><i class="fa-solid fa-prescription-bottle-med"></i></a>
                                @endif
                                <form action="{{ route('citas.cancelar', $cita) }}" method="POST" class="d-inline" onsubmit="return confirm('¿Cancelar esta cita?');">
                                    @csrf
                                    <button class="btn btn-outline-danger btn-sm" @disabled($cita->estado==='cancelada') title="Cancelar">
                                        <i class="fa-solid fa-ban"></i>
                                    </button>
                                </form>
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="4" class="text-center py-4 small text-muted">No tienes citas registradas todavía.</td>
                        </tr>
                    @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</x-app-layout>
