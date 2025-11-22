@extends('layouts.adminlte')

@section('title', 'Detalle de Cita | SomosSalud')

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
    .info-item {
        padding: 1rem;
        background: #f8fafc;
        border-radius: 12px;
        border-left: 4px solid #0ea5e9;
    }
    .info-label {
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.05em;
        color: #64748b;
        font-weight: 600;
        margin-bottom: 0.25rem;
    }
    .info-value {
        font-weight: 600;
        color: #1e293b;
        font-size: 1rem;
    }
    .medicamento-item {
        background: #f8fafc;
        border: 2px solid #e2e8f0;
        border-radius: 12px;
        padding: 1rem;
        position: relative;
        transition: all 0.2s ease;
    }
    .medicamento-item:hover {
        border-color: #cbd5e1;
        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
    }
    .form-control {
        border-radius: 8px;
        border: 2px solid #e2e8f0;
        transition: all 0.2s ease;
    }
    .form-control:focus {
        border-color: #0ea5e9;
        box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.1);
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
    .badge {
        padding: 0.5em 0.8em;
        border-radius: 6px;
        font-weight: 500;
    }
</style>
@endpush

@section('content')
<div class="container-fluid">
    <!-- Breadcrumb -->
    <div class="mb-4">
        <a href="{{ route('citas.index') }}" class="text-muted text-decoration-none">
            <i class="fas fa-arrow-left mr-2"></i>Volver a mis citas
        </a>
    </div>

    <!-- Información de la cita -->
    <div class="card mb-4">
        <div class="card-header">
            <h3 class="card-title mb-0 font-weight-bold text-primary">
                <i class="fas fa-calendar-check mr-2"></i>Detalle de la cita
            </h3>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-3 mb-3">
                    <div class="info-item">
                        <div class="info-label">Fecha y hora</div>
                        <div class="info-value">
                            <i class="far fa-calendar-alt mr-2 text-primary"></i>
                            {{ \Illuminate\Support\Carbon::parse($cita->fecha)->format('d/m/Y H:i') }}
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="info-item">
                        <div class="info-label">Estado</div>
                        <div class="info-value">
                            @php
                                $badgeClass = match($cita->estado) {
                                    'pendiente' => 'badge-warning',
                                    'confirmada' => 'badge-info',
                                    'concluida' => 'badge-success',
                                    'cancelada' => 'badge-danger',
                                    default => 'badge-secondary'
                                };
                            @endphp
                            <span class="badge {{ $badgeClass }}">{{ ucfirst($cita->estado) }}</span>
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="info-item">
                        <div class="info-label">Clínica</div>
                        <div class="info-value">
                            <i class="fas fa-hospital mr-2 text-success"></i>
                            {{ optional($cita->clinica)->nombre ?? '—' }}
                        </div>
                    </div>
                </div>
                <div class="col-md-3 mb-3">
                    <div class="info-item">
                        <div class="info-label">Especialista</div>
                        <div class="info-value">
                            <i class="fas fa-user-md mr-2 text-info"></i>
                            {{ optional($cita->especialista)->name ?? '—' }}
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="mt-3 d-flex justify-content-end">
                <form action="{{ route('citas.cancelar', $cita) }}" method="POST" class="form-cancelar-cita">
                    @csrf
                    <button class="btn btn-outline-danger btn-sm" @disabled($cita->estado==='cancelada' || $cita->estado==='concluida')>
                        <i class="fas fa-ban mr-1"></i>Cancelar cita
                    </button>
                </form>
            </div>
        </div>
    </div>

    @php($yo = auth()->user())
    @if(($yo->id === $cita->especialista_id) || $yo->hasRole(['super-admin','admin_clinica']))
        <!-- Gestión de la consulta -->
        <div class="card" id="gestion">
            <div class="card-header">
                <h3 class="card-title mb-0 font-weight-bold text-primary">
                    <i class="fas fa-stethoscope mr-2"></i>Gestión de la consulta xxxx
                </h3>
            </div>
            <div class="card-body">
                @if(session('success'))
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle mr-2"></i>{{ session('success') }}
                        <button type="button" class="close" data-dismiss="alert">
                            <span>&times;</span>
                        </button>
                    </div>
                @endif
                
                @php($bloqueada = in_array($cita->estado,['cancelada','concluida']))
                @if($bloqueada)
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle mr-2"></i>
                        Esta cita está {{ $cita->estado==='cancelada' ? 'cancelada' : 'concluida' }}. No es posible modificar la gestión.
                    </div>
                @endif
                
                <form action="{{ route('citas.gestion', $cita) }}" method="POST" enctype="multipart/form-data" id="form-gestion-cita">
                    @csrf
                    
                    <!-- Diagnóstico -->
                    <div class="form-group">
                        <label class="font-weight-bold text-uppercase small text-muted">Diagnóstico *</label>
                        <textarea name="diagnostico" class="form-control" rows="3" required {{ $bloqueada ? 'disabled' : '' }} placeholder="Describe el diagnóstico del paciente...">{{ old('diagnostico', $cita->diagnostico) }}</textarea>
                        @error('diagnostico')<div class="text-danger small mt-1">{{ $message }}</div>@enderror
                    </div>

                    <!-- Medicamentos -->
                    <div class="form-group">
                        <label class="font-weight-bold text-uppercase small text-muted d-flex align-items-center justify-content-between">
                            <span>Medicamentos estructurados sdsdsdsdsd</span>
                            <span class="badge badge-light">Máx 10</span>
                        </label>
                        <div id="medicamentos-wrapper" class="mb-3">
                            @php($oldMeds = old('medicamentos', $cita->medicamentos->map(fn($m)=>[
                                'nombre_generico'=>$m->nombre_generico,
                                'presentacion'=>$m->presentacion,
                                'posologia'=>$m->posologia,
                                'frecuencia'=>$m->frecuencia,
                                'duracion'=>$m->duracion,
                            ])->toArray()))
                            @forelse($oldMeds as $idx => $med)
                                <div class="medicamento-item mb-3">
                                    <div class="row align-items-center">
                                        <div class="col-md-4 mb-2">
                                            <input type="text" name="medicamentos[{{ $idx }}][nombre_generico]" class="form-control form-control-sm" placeholder="Ej: Ibuprofeno 800mg" value="{{ trim(($med['nombre_generico'] ?? '') . ' ' . ($med['presentacion'] ?? '')) }}" {{ $bloqueada ? 'disabled' : '' }}>
                                            <small class="text-muted d-block mt-1">Medicamento (nombre + presentación)</small>
                                        </div>
                                        <div class="col-md-3 mb-2">
                                            <input type="text" name="medicamentos[{{ $idx }}][posologia]" class="form-control form-control-sm" placeholder="Ej: 1 tableta" value="{{ $med['posologia'] ?? '' }}" {{ $bloqueada ? 'disabled' : '' }}>
                                            <small class="text-muted d-block mt-1">Posología</small>
                                        </div>
                                        <div class="col-md-2 mb-2">
                                            <input type="text" name="medicamentos[{{ $idx }}][frecuencia]" class="form-control form-control-sm" placeholder="Ej: Cada 12 horas" value="{{ $med['frecuencia'] ?? '' }}" {{ $bloqueada ? 'disabled' : '' }}>
                                            <small class="text-muted d-block mt-1">Frecuencia</small>
                                        </div>
                                        <div class="col-md-2 mb-2">
                                            <input type="text" name="medicamentos[{{ $idx }}][duracion]" class="form-control form-control-sm" placeholder="Ej: 7 días" value="{{ $med['duracion'] ?? '' }}" {{ $bloqueada ? 'disabled' : '' }}>
                                            <small class="text-muted d-block mt-1">Duración</small>
                                        </div>
                                        <div class="col-md-1 mb-2 d-flex align-items-center justify-content-center">
                                            <button type="button" class="btn btn-sm btn-outline-danger remove-med" title="Eliminar medicamento" {{ $bloqueada ? 'disabled' : '' }}>
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            @empty
                            @endforelse
                        </div>
                        @unless($bloqueada)
                            <button type="button" class="btn btn-outline-primary btn-sm" id="btn-add-med">
                                <i class="fas fa-plus mr-1"></i>Añadir medicamento
                            </button>
                        @endunless
                    </div>

                    <!-- Observaciones -->
                    <div class="form-group">
                        <label class="font-weight-bold text-uppercase small text-muted">Observaciones</label>
                        <textarea name="observaciones" class="form-control" rows="2" {{ $bloqueada ? 'disabled' : '' }} placeholder="Observaciones adicionales...">{{ old('observaciones', $cita->observaciones) }}</textarea>
                    </div>

                    <!-- Adjuntos -->
                    <div class="form-group">
                        <label class="font-weight-bold text-uppercase small text-muted">Adjuntos (imágenes / PDF)</label>
                        <input type="file" name="adjuntos[]" class="form-control" accept="image/*,application/pdf" multiple {{ $bloqueada ? 'disabled' : '' }}>
                        <small class="form-text text-muted">Máx 6 archivos, 5MB c/u.</small>
                    </div>
                    
                    @if($cita->adjuntos()->exists())
                        <div class="mb-3">
                            <div class="text-muted small mb-2">Archivos existentes:</div>
                            <div class="d-flex flex-wrap gap-2">
                                @foreach($cita->adjuntos as $adj)
                                    <a href="{{ Storage::disk('public')->url($adj->ruta) }}" target="_blank" class="badge badge-light text-decoration-none">
                                        <i class="fas fa-file mr-1"></i>{{ $adj->nombre_original ?? basename($adj->ruta) }}
                                    </a>
                                @endforeach
                            </div>
                        </div>
                    @endif

                    <!-- Concluir cita -->
                    <div class="custom-control custom-switch mb-4">
                        <input class="custom-control-input" type="checkbox" id="concluirSwitch" name="concluir" value="1" @checked($cita->estado==='concluida') {{ $bloqueada ? 'disabled' : '' }}>
                        <label class="custom-control-label font-weight-bold" for="concluirSwitch">Marcar cita como concluida</label>
                    </div>

                    <!-- Botones -->
                    <div class="d-flex justify-content-end gap-2">
                        @unless($bloqueada)
                            <button class="btn btn-primary shadow-sm">
                                <i class="fas fa-save mr-1"></i>Guardar gestión
                            </button>
                        @endunless
                        @if($cita->medicamentos()->exists())
                            <a href="{{ route('citas.receta', $cita) }}" class="btn btn-outline-primary shadow-sm ml-2">
                                <i class="fas fa-prescription-bottle-medical mr-1"></i>Ver receta
                            </a>
                        @endif
                    </div>
                </form>
            </div>
        </div>
    @else
        @if($cita->medicamentos()->exists())
            <div class="text-center mt-4">
                <a href="{{ route('citas.receta', $cita) }}" class="btn btn-outline-primary">
                    <i class="fas fa-prescription-bottle-medical mr-1"></i>Ver receta
                </a>
            </div>
        @endif
    @endif
</div>
@endsection

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<script>
(function(){
    const wrapper = document.getElementById('medicamentos-wrapper');
    if(!wrapper) return;
    const btnAdd = document.getElementById('btn-add-med');
    function currentCount(){ return wrapper.querySelectorAll('.medicamento-item').length; }
    
    if(btnAdd) {
        btnAdd.addEventListener('click', () => {
            if(currentCount() >= 10) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Límite alcanzado',
                    text: 'Máximo 10 medicamentos permitidos',
                    confirmButtonColor: '#0ea5e9'
                });
                return;
            }
            const idx = Date.now();
            const div = document.createElement('div');
            div.className = 'medicamento-item mb-3';
            div.innerHTML = `
                <div class="row align-items-center">
                    <div class="col-md-4 mb-2">
                        <input type="text" name="medicamentos[\${idx}][nombre_generico]" class="form-control form-control-sm" placeholder="Ej: Ibuprofeno 800mg">
                        <small class="text-muted d-block mt-1">Medicamento (nombre + presentación)</small>
                    </div>
                    <div class="col-md-3 mb-2">
                        <input type="text" name="medicamentos[\${idx}][posologia]" class="form-control form-control-sm" placeholder="Ej: 1 tableta">
                        <small class="text-muted d-block mt-1">Posología</small>
                    </div>
                    <div class="col-md-2 mb-2">
                        <input type="text" name="medicamentos[\${idx}][frecuencia]" class="form-control form-control-sm" placeholder="Ej: Cada 12 horas">
                        <small class="text-muted d-block mt-1">Frecuencia</small>
                    </div>
                    <div class="col-md-2 mb-2">
                        <input type="text" name="medicamentos[\${idx}][duracion]" class="form-control form-control-sm" placeholder="Ej: 7 días">
                        <small class="text-muted d-block mt-1">Duración</small>
                    </div>
                    <div class="col-md-1 mb-2 d-flex align-items-center justify-content-center">
                        <button type="button" class="btn btn-sm btn-outline-danger remove-med" title="Eliminar medicamento">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>`;
            wrapper.appendChild(div);
        });
    }
    
    wrapper.addEventListener('click', e => {
        if(e.target.closest('.remove-med')){
            e.target.closest('.medicamento-item').remove();
        }
    });
})();

// Confirmaciones con SweetAlert2
(function(){
    const fCancel = document.querySelector('.form-cancelar-cita');
    if(fCancel){
        fCancel.addEventListener('submit', function(e){
            e.preventDefault();
            Swal.fire({
                title: 'Cancelar cita',
                text: '¿Confirmas que deseas cancelar esta cita?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Sí, cancelar',
                cancelButtonText: 'Volver',
                confirmButtonColor: '#dc3545',
                cancelButtonColor: '#6c757d'
            }).then(r=> { if(r.isConfirmed) this.submit(); });
        });
    }
    
    const formGestion = document.getElementById('form-gestion-cita');
    if(formGestion){
        const chk = formGestion.querySelector('#concluirSwitch');
        formGestion.addEventListener('submit', function(e){
            if(!chk || !chk.checked || formGestion.dataset.confirmed==='1') return;
            e.preventDefault();
            Swal.fire({
                title: 'Concluir cita',
                text: '¿Confirmas que deseas concluir esta cita? Luego no podrás modificarla.',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Sí, concluir',
                cancelButtonText: 'Cancelar',
                confirmButtonColor: '#0ea5e9',
                cancelButtonColor: '#6c757d'
            }).then(r=> { 
                if(r.isConfirmed){ 
                    formGestion.dataset.confirmed='1'; 
                    formGestion.submit(); 
                } 
            });
        });
    }
})();
</script>
@endpush
