@extends('layouts.adminlte')

@section('title', 'SomosSalud | Nuevo usuario')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

{{-- Breadcrumb removido para creación de usuario --}}

@section('content')
    <div class="row justify-content-center">
        <div class="col-lg-8">
            <div class="card border-0 shadow-lg rounded-lg overflow-hidden">
                <div class="card-header text-white p-4" style="background: linear-gradient(to right, #0ea5e9, #10b981);">
                    <div class="d-flex align-items-center">
                        <h3 class="card-title mb-0 font-weight-bold text-white">
                            <i class="fas fa-user-plus mr-2"></i>Nuevo Usuario
                        </h3>
                        <span class="mx-3 text-white-50">|</span>
                        <p class="mb-0 small text-white-50">Registra un nuevo usuario en el sistema</p>
                    </div>
                </div>
                
                <form action="{{ route('admin.users.store') }}" method="POST">
                    @csrf
                    
                    <div class="card-body p-4">
                        @if ($errors->any())
                            <div class="alert alert-danger border-left-danger shadow-sm rounded-lg mb-4" role="alert">
                                <div class="d-flex align-items-center mb-2">
                                    <i class="fas fa-exclamation-circle mr-2 text-lg"></i>
                                    <h5 class="alert-heading mb-0 font-weight-bold">Por favor corrige los siguientes errores:</h5>
                                </div>
                                <ul class="mb-0 pl-4 small">
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif

                        <div class="row">
                            <div class="col-md-12 mb-4">
                                <h5 class="text-muted font-weight-bold text-uppercase small border-bottom pb-2 mb-3">
                                    <i class="fas fa-info-circle mr-1"></i> Información Personal
                                </h5>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="name" class="font-weight-bold text-dark small text-uppercase">Nombre completo <span class="text-danger">*</span></label>
                                    <div class="input-group shadow-sm">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-right-0"><i class="fas fa-user text-muted"></i></span>
                                        </div>
                                        <input type="text" name="name" id="name" value="{{ old('name') }}"
                                            class="form-control border-left-0 @error('name') is-invalid @enderror" 
                                            placeholder="Ej: Juan Pérez" required autofocus>
                                    </div>
                                    @error('name')
                                        <span class="invalid-feedback d-block" role="alert"><strong>{{ $message }}</strong></span>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="cedula" class="font-weight-bold text-dark small text-uppercase">Cédula <span class="text-danger">*</span></label>
                                    <div class="input-group shadow-sm">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-right-0"><i class="fas fa-id-card text-muted"></i></span>
                                        </div>
                                        <input type="text" name="cedula" id="cedula" value="{{ old('cedula') }}"
                                            class="form-control border-left-0 @error('cedula') is-invalid @enderror" 
                                            placeholder="Ej: V-12345678" required>
                                    </div>
                                    <small class="form-text text-muted mt-1"><i class="fas fa-info-circle mr-1"></i>Si empiezas con un número, se asume V- automáticamente.</small>
                                    @error('cedula')
                                        <span class="invalid-feedback d-block" role="alert"><strong>{{ $message }}</strong></span>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="email" class="font-weight-bold text-dark small text-uppercase">Correo electrónico <span class="text-danger">*</span></label>
                                    <div class="input-group shadow-sm">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-right-0"><i class="fas fa-envelope text-muted"></i></span>
                                        </div>
                                        <input type="email" name="email" id="email" value="{{ old('email') }}"
                                            class="form-control border-left-0 @error('email') is-invalid @enderror" 
                                            placeholder="correo@ejemplo.com" required>
                                    </div>
                                    @error('email')
                                        <span class="invalid-feedback d-block" role="alert"><strong>{{ $message }}</strong></span>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="fecha_nacimiento" class="font-weight-bold text-dark small text-uppercase">Fecha de Nacimiento <span class="text-danger">*</span></label>
                                    <div class="input-group shadow-sm">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-right-0"><i class="fas fa-calendar text-muted"></i></span>
                                        </div>
                                        <input type="date" name="fecha_nacimiento" id="fecha_nacimiento" value="{{ old('fecha_nacimiento') }}"
                                            class="form-control border-left-0 @error('fecha_nacimiento') is-invalid @enderror" 
                                            max="{{ date('Y-m-d') }}" required>
                                    </div>
                                    <small class="form-text text-muted mt-1"><i class="fas fa-info-circle mr-1"></i>Importante para el historial médico.</small>
                                    @error('fecha_nacimiento')
                                        <span class="invalid-feedback d-block" role="alert"><strong>{{ $message }}</strong></span>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="sexo" class="font-weight-bold text-dark small text-uppercase">Sexo <span class="text-danger">*</span></label>
                                    <div class="input-group shadow-sm">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-right-0"><i class="fas fa-venus-mars text-muted"></i></span>
                                        </div>
                                        <select name="sexo" id="sexo" class="form-control border-left-0 @error('sexo') is-invalid @enderror" required>
                                            <option value="">Seleccione...</option>
                                            <option value="M" {{ old('sexo') == 'M' ? 'selected' : '' }}>Masculino</option>
                                            <option value="F" {{ old('sexo') == 'F' ? 'selected' : '' }}>Femenino</option>
                                        </select>
                                    </div>
                                    <small class="form-text text-muted mt-1"><i class="fas fa-info-circle mr-1"></i>Necesario para valores de referencia de laboratorio.</small>
                                    @error('sexo')
                                        <span class="invalid-feedback d-block" role="alert"><strong>{{ $message }}</strong></span>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-12 mt-3 mb-4">
                                <h5 class="text-muted font-weight-bold text-uppercase small border-bottom pb-2 mb-3">
                                    <i class="fas fa-lock mr-1"></i> Seguridad
                                </h5>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="password" class="font-weight-bold text-dark small text-uppercase">Contraseña <span class="text-danger">*</span></label>
                                    <div class="input-group shadow-sm">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-right-0"><i class="fas fa-key text-muted"></i></span>
                                        </div>
                                        <input type="password" name="password" id="password"
                                            class="form-control border-left-0 @error('password') is-invalid @enderror" 
                                            placeholder="Mínimo 8 caracteres" required autocomplete="new-password">
                                    </div>
                                    @error('password')
                                        <span class="invalid-feedback d-block" role="alert"><strong>{{ $message }}</strong></span>
                                    @enderror
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="password_confirmation" class="font-weight-bold text-dark small text-uppercase">Confirmar Contraseña <span class="text-danger">*</span></label>
                                    <div class="input-group shadow-sm">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text bg-white border-right-0"><i class="fas fa-check-double text-muted"></i></span>
                                        </div>
                                        <input type="password" name="password_confirmation" id="password_confirmation"
                                            class="form-control border-left-0" 
                                            placeholder="Repite la contraseña" required autocomplete="new-password">
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-12 mt-3 mb-4">
                                <h5 class="text-muted font-weight-bold text-uppercase small border-bottom pb-2 mb-3">
                                    <i class="fas fa-user-tag mr-1"></i> Roles y Permisos
                                </h5>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label class="font-weight-bold text-dark small text-uppercase mb-3">Roles Asignados</label>
                                    @if (auth()->user()->hasRole('recepcionista'))
                                        <div class="alert alert-info shadow-sm border-0">
                                            <i class="fas fa-info-circle mr-2"></i>
                                            <span class="font-weight-bold">Rol: Paciente</span>
                                            <input type="hidden" name="roles[]" value="paciente">
                                            <div class="mt-1 small">Como recepcionista, solo puedes crear usuarios con rol de Paciente.</div>
                                        </div>
                                    @else
                                        <div class="bg-light p-3 rounded border">
                                            <div class="d-flex flex-wrap gap-3">
                                                @foreach ($roles as $role)
                                                    @php
                                                        $roleId = 'role-' . \Illuminate\Support\Str::slug($role);
                                                        $isChecked = in_array($role, old('roles', []), true);
                                                        $badgeClass = match($role) {
                                                            'admin' => 'danger',
                                                            'especialista' => 'success',
                                                            'recepcionista' => 'warning',
                                                            'paciente' => 'info',
                                                            default => 'secondary'
                                                        };
                                                    @endphp
                                                    <div class="custom-control custom-checkbox mr-4 mb-2">
                                                        <input type="checkbox" class="custom-control-input role-checkbox" id="{{ $roleId }}"
                                                            name="roles[]" value="{{ $role }}" {{ $isChecked ? 'checked' : '' }}>
                                                        <label class="custom-control-label font-weight-bold text-{{ $badgeClass }}" for="{{ $roleId }}">
                                                            {{ ucfirst(str_replace('_', ' ', $role)) }}
                                                        </label>
                                                    </div>
                                                @endforeach
                                            </div>
                                        </div>
                                        @error('roles')
                                            <span class="text-danger d-block mt-2 small font-weight-bold"><i class="fas fa-exclamation-triangle mr-1"></i>{{ $message }}</span>
                                        @enderror
                                    @endif
                                </div>
                            </div>

                            <div class="col-md-12">
                                <div class="form-group">
                                    <label for="especialidades" class="font-weight-bold text-dark small text-uppercase">Especialidades <span class="text-muted font-weight-normal text-lowercase">(Solo para especialistas)</span></label>
                                    <div class="d-flex align-items-stretch shadow-sm border rounded overflow-hidden bg-white">
                                        <div class="d-flex align-items-center px-3 bg-white border-right">
                                            <i class="fas fa-stethoscope text-muted"></i>
                                        </div>
                                        <div class="flex-grow-1">
                                            <select name="especialidades[]" id="especialidades" class="form-control border-0 @error('especialidades') is-invalid @enderror" multiple {{ auth()->user()->hasRole('recepcionista') ? 'disabled' : '' }} style="width: 100%;">
                                                @php
                                                    $selectedEspecialidades = old('especialidades', []);
                                                @endphp
                                                @foreach ($especialidades as $especialidad)
                                                    <option value="{{ $especialidad->id }}" {{ in_array($especialidad->id, $selectedEspecialidades) ? 'selected' : '' }}>
                                                        {{ $especialidad->nombre }}
                                                    </option>
                                                @endforeach
                                            </select>
                                        </div>
                                    </div>
                                    <small class="form-text text-muted mt-1">
                                        @if (auth()->user()->hasRole('recepcionista'))
                                            <i class="fas fa-lock mr-1"></i>Campo no disponible para recepcionistas.
                                        @else
                                            <i class="fas fa-info-circle mr-1"></i>Se habilita cuando el rol "Especialista" está seleccionado.
                                        @endif
                                    </small>
                                    @error('especialidades')
                                        <span class="invalid-feedback d-block" role="alert"><strong>{{ $message }}</strong></span>
                                    @enderror
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="card-footer bg-light p-4 d-flex justify-content-between align-items-center">
                        <a href="{{ route('admin.users.index') }}" class="btn btn-outline-secondary font-weight-bold px-4">
                            <i class="fas fa-arrow-left mr-2"></i>Cancelar
                        </a>
                        <button type="submit" class="btn btn-primary font-weight-bold px-5 shadow-sm">
                            <i class="fas fa-save mr-2"></i>Guardar Usuario
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection

@push('styles')
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
@endpush

@push('scripts')
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script src="{{ asset('js/cedula-validator.js') }}"></script>
<script>
$(document).ready(function() {
    $('#especialidades').select2({
        placeholder: "Selecciona especialidades",
        allowClear: true,
        width: '100%'
    });
    
    // Inicializar validador de cédula
    new CedulaValidator('cedula');
});
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const roleCheckboxes = Array.from(document.querySelectorAll('.role-checkbox'));
        const especialidadSelect = document.getElementById('especialidades');

        if (!especialidadSelect) {
            return;
        }

        function toggleEspecialidad() {
            const specialistSelected = roleCheckboxes.some(function (checkbox) {
                return checkbox.checked && checkbox.value === 'especialista';
            });

            especialidadSelect.disabled = !specialistSelected;
            // If using Select2, we might need to trigger an update or re-init, 
            // but standard disabled attribute usually works if Select2 respects it.
        }

        roleCheckboxes.forEach(function (checkbox) {
            checkbox.addEventListener('change', toggleEspecialidad);
        });

        // Run on load to set initial state
        toggleEspecialidad();
    });
</script>
@endpush