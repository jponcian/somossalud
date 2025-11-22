@extends('layouts.adminlte')

@section('title', 'Mis Citas | SomosSalud')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

@push('styles')
<link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
    body {
        font-family: 'Outfit', sans-serif !important;
        background-color: #f8fafc;
    }
    .content-wrapper {
        background-color: #f8fafc !important;
    }
    .card {
        border: none;
        border-radius: 16px;
        box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05), 0 2px 4px -1px rgba(0, 0, 0, 0.03);
        transition: all 0.3s ease;
        background: white;
        overflow: hidden;
    }
    .card:hover {
        box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1), 0 4px 6px -2px rgba(0, 0, 0, 0.05);
    }
    .card-header {
        background: linear-gradient(135deg, #dbeafe 0%, #dcfce7 100%);
        border-bottom: 1px solid #cbd5e1;
        padding: 1.25rem 1.5rem;
    }
    .table {
        margin-bottom: 0;
    }
    .table thead th {
        border-bottom: 2px solid #e2e8f0;
        color: #64748b;
        font-weight: 600;
        text-transform: uppercase;
        font-size: 0.75rem;
        letter-spacing: 0.05em;
        padding: 1rem;
        background: #f8fafc;
    }
    .table tbody tr {
        border-bottom: 1px solid #f1f5f9;
        transition: all 0.2s ease;
    }
    .table tbody tr:hover {
        background: #f8fafc;
    }
    .table tbody td {
        padding: 1rem;
        vertical-align: middle;
    }
    .badge {
        padding: 0.4em 0.8em;
        border-radius: 6px;
        font-weight: 500;
        font-size: 0.75rem;
    }
    .btn {
        border-radius: 8px;
        font-weight: 500;
        transition: all 0.2s ease;
    }
    .btn-primary {
        background: linear-gradient(135deg, #0ea5e9 0%, #0284c7 100%);
        border: none;
        box-shadow: 0 2px 8px rgba(14, 165, 233, 0.3);
    }
    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 12px rgba(14, 165, 233, 0.4);
    }
    .btn-sm {
        padding: 0.4rem 0.8rem;
        font-size: 0.875rem;
    }
    .empty-state {
        padding: 3rem 1rem;
        text-align: center;
        color: #94a3b8;
    }
    .empty-state i {
        font-size: 3rem;
        margin-bottom: 1rem;
        opacity: 0.3;
    }
</style>
@endpush

@section('content')
<div class="container-fluid">
    <!-- Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h1 class="h3 mb-1 font-weight-bold text-dark">
                <i class="fas fa-calendar-alt text-primary mr-2"></i>Mis Citas
            </h1>
            <p class="text-muted mb-0">Agenda nuevas consultas, confirma fechas y revisa tus atenciones</p>
        </div>
        <a href="{{ route('citas.create') }}" class="btn btn-primary shadow-sm">
            <i class="fas fa-calendar-plus mr-2"></i>Nueva cita
        </a>
    </div>

    <!-- Success Message -->
    @if(session('success'))
        <div class="alert alert-success alert-dismissible fade show">
            <i class="fas fa-check-circle mr-2"></i>{{ session('success') }}
            <button type="button" class="close" data-dismiss="alert">
                <span>&times;</span>
            </button>
        </div>
    @endif

    <!-- Citas Table -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title mb-0 font-weight-bold text-primary">
                <i class="fas fa-list mr-2"></i>Listado de Citas
            </h3>
        </div>
        <div class="card-body p-0">
            @if(isset($items))
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Fecha / Hora</th>
                                <th>Tipo</th>
                                <th>Estado</th>
                                <th>Especialista</th>
                                <th class="text-right">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        @forelse($items as $row)
                            @php
                                $__fecha = \Illuminate\Support\Carbon::parse($row['momento'])->format('d/m/Y');
                                $__hora = str_replace(' ', '', \Illuminate\Support\Carbon::parse($row['momento'])->format('h:i a'));
                                $tipo = $row['tipo'];
                                $estado = $row['estado'];
                                $badge = $tipo==='cita'
                                    ? match($estado){ 'pendiente'=>'warning','confirmada'=>'info','cancelada'=>'danger','concluida'=>'success', default=>'secondary' }
                                    : match($estado){ 'validado'=>'info','en_consulta'=>'warning','cerrado'=>'success', default=>'secondary' };
                            @endphp
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="far fa-calendar text-muted mr-2"></i>
                                        <div>
                                            <div class="font-weight-bold">{{ $__fecha }}</div>
                                            <small class="text-muted">{{ $__hora }}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    <span class="badge badge-light border">
                                        <i class="fas {{ $tipo==='cita' ? 'fa-calendar-check' : 'fa-ambulance' }} mr-1"></i>
                                        {{ $tipo==='cita' ? 'Cita' : 'Atención' }}
                                    </span>
                                </td>
                                <td>
                                    <span class="badge badge-{{ $badge }}">
                                        {{ $tipo==='cita' ? ucfirst($estado) : ($estado==='validado'?'Validada':($estado==='en_consulta'?'En proceso':($estado==='cerrado'?'Cerrada':ucfirst($estado)))) }}
                                    </span>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-md text-info mr-2"></i>
                                        {{ $row['especialista'] ?? '—' }}
                                    </div>
                                </td>
                                <td class="text-right">
                                    @if($tipo==='cita')
                                        <a href="{{ route('citas.show', $row['id']) }}" class="btn btn-sm btn-outline-primary" title="Ver detalle">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        @if($row['tiene_meds'])
                                            <a href="{{ route('citas.receta', $row['id']) }}" class="btn btn-sm btn-outline-success" title="Receta">
                                                <i class="fas fa-prescription-bottle-alt"></i>
                                            </a>
                                        @endif
                                        @if(!in_array($estado, ['cancelada','concluida']))
                                            <form action="{{ route('citas.cancelar', $row['id']) }}" method="POST" class="d-inline js-cancel-cita" data-cita-id="{{ $row['id'] }}">
                                                @csrf
                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Cancelar">
                                                    <i class="fas fa-ban"></i>
                                                </button>
                                            </form>
                                        @endif
                                    @else
                                        @if($estado==='cerrado')
                                            <a href="{{ route('atenciones.paciente.show', $row['id']) }}" class="btn btn-sm btn-outline-primary" title="Ver detalle">
                                                <i class="fas fa-eye"></i>
                                            </a>
                                        @endif
                                        @if($row['tiene_meds'])
                                            <a href="{{ route('atenciones.paciente.receta', $row['id']) }}" class="btn btn-sm btn-outline-success" title="Receta">
                                                <i class="fas fa-prescription-bottle-alt"></i>
                                            </a>
                                        @endif
                                        @if($estado!=='cerrado' && !$row['tiene_meds'])
                                            <span class="text-muted small">En curso</span>
                                        @endif
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5">
                                    <div class="empty-state">
                                        <i class="fas fa-calendar-times"></i>
                                        <p class="mb-0">Aún no tienes consultas ni atenciones registradas</p>
                                        <small>Agenda tu primera cita médica</small>
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                        </tbody>
                    </table>
                </div>
            @else
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Fecha / Hora</th>
                                <th>Estado</th>
                                <th>Especialista</th>
                                <th class="text-right">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        @forelse($citas as $cita)
                            <tr>
                                <td>
                                    @php
                                        $__f = \Illuminate\Support\Carbon::parse($cita->fecha);
                                        $__fecha = $__f->format('d/m/Y');
                                        $__hora = str_replace(' ', '', $__f->format('h:i a'));
                                    @endphp
                                    <div class="d-flex align-items-center">
                                        <i class="far fa-calendar text-muted mr-2"></i>
                                        <div>
                                            <div class="font-weight-bold">{{ $__fecha }}</div>
                                            <small class="text-muted">{{ $__hora }}</small>
                                        </div>
                                    </div>
                                </td>
                                <td>
                                    @php $badge = match($cita->estado){
                                        'pendiente' => 'warning',
                                        'confirmada' => 'info',
                                        'cancelada' => 'danger',
                                        'concluida' => 'success',
                                        default => 'secondary'
                                    }; @endphp
                                    <span class="badge badge-{{ $badge }}">{{ ucfirst($cita->estado) }}</span>
                                </td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-md text-info mr-2"></i>
                                        {{ optional($cita->especialista)->name ?? '—' }}
                                    </div>
                                </td>
                                <td class="text-right">
                                    <a href="{{ route('citas.show', $cita) }}" class="btn btn-sm btn-outline-primary" title="Ver detalle">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    @if($cita->medicamentos()->exists())
                                        <a href="{{ route('citas.receta', $cita) }}" class="btn btn-sm btn-outline-success" title="Receta">
                                            <i class="fas fa-prescription-bottle-alt"></i>
                                        </a>
                                    @endif
                                    <form action="{{ route('citas.cancelar', $cita) }}" method="POST" class="d-inline js-cancel-cita">
                                        @csrf
                                        <button class="btn btn-sm btn-outline-danger" @disabled($cita->estado==='cancelada') title="Cancelar">
                                            <i class="fas fa-ban"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4">
                                    <div class="empty-state">
                                        <i class="fas fa-calendar-times"></i>
                                        <p class="mb-0">No tienes citas registradas todavía</p>
                                        <small>Agenda tu primera cita médica</small>
                                    </div>
                                </td>
                            </tr>
                        @endforelse
                        </tbody>
                    </table>
                </div>
            @endif
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
(function(){
    function bindCancelHandlers(){
        document.querySelectorAll('form.js-cancel-cita').forEach(function(form){
            if(form._boundSwal) return;
            form._boundSwal = true;
            form.addEventListener('submit', function(e){
                e.preventDefault();
                Swal.fire({
                    title: '¿Cancelar esta cita?',
                    text: 'Esta acción no se puede revertir. Se notificará al especialista si aplica.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Sí, cancelar',
                    cancelButtonText: 'No',
                    confirmButtonColor: '#dc3545',
                    cancelButtonColor: '#6c757d'
                }).then(function(result){
                    if(result.isConfirmed){ form.submit(); }
                });
            });
        });
    }
    bindCancelHandlers();
})();
</script>
@endpush
