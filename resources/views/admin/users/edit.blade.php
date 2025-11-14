@extends('layouts.adminlte')

@section('title', 'SomosSalud | Editar usuario')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

{{-- Breadcrumb removido para edición de usuario --}}

@section('content')
    <div class="row">
        <div class="col-lg-8">
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <h3 class="card-title mb-0">Datos del usuario</h3>
                </div>
                <form action="{{ route('admin.users.update', $usuario) }}" method="POST">
                    @csrf
                    @method('PUT')
                    <div class="card-body">
                        @if ($errors->any())
                            <div class="alert alert-danger">
                                <p class="mb-2 font-weight-bold">Revisa los errores antes de continuar:</p>
                                <ul class="mb-0 pl-3">
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif
                        <div class="form-group">
                            <label for="name">Nombre completo</label>
                            <input type="text" name="name" id="name" value="{{ old('name', $usuario->name) }}"
                                class="form-control @error('name') is-invalid @enderror" required autofocus>
                            @error('name')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="cedula">Cédula</label>
                            <input type="text" name="cedula" id="cedula" value="{{ old('cedula', $usuario->cedula) }}"
                                class="form-control @error('cedula') is-invalid @enderror" required>
                            <small class="form-text text-muted">Se almacena en mayúsculas para evitar duplicados por formato.</small>
                            @error('cedula')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="email">Correo electrónico</label>
                            <input type="email" name="email" id="email" value="{{ old('email', $usuario->email) }}"
                                class="form-control @error('email') is-invalid @enderror" required>
                            @error('email')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="password">Contraseña</label>
                                <input type="password" name="password" id="password"
                                    class="form-control @error('password') is-invalid @enderror" autocomplete="new-password">
                                <small class="form-text text-muted">Déjalo en blanco para mantener la contraseña actual.</small>
                                @error('password')
                                    <span class="invalid-feedback" role="alert">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group col-md-6">
                                <label for="password_confirmation">Confirmar contraseña</label>
                                <input type="password" name="password_confirmation" id="password_confirmation"
                                    class="form-control" autocomplete="new-password">
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Roles</label>
                            @if (auth()->user()->hasRole('recepcionista'))
                                <p class="mb-2">
                                    <span class="badge badge-info">Paciente</span>
                                </p>
                                <input type="hidden" name="roles[]" value="paciente">
                                <small class="form-text text-muted">Como recepcionista, solo puedes editar usuarios con rol Paciente.</small>
                            @else
                                <p class="text-muted small mb-2">Selecciona uno o varios roles que aplican al usuario.</p>
                                <div class="d-flex flex-wrap">
                                    @php
                                        $selectedRoles = old('roles', $assignedRoles ?? []);
                                    @endphp
                                    @foreach ($roles as $role)
                                        @php
                                            $roleId = 'role-' . \Illuminate\Support\Str::slug($role);
                                            $isChecked = in_array($role, $selectedRoles, true);
                                        @endphp
                                        <div class="custom-control custom-checkbox mr-4 mb-2">
                                            <input type="checkbox" class="custom-control-input role-checkbox" id="{{ $roleId }}"
                                                name="roles[]" value="{{ $role }}" {{ $isChecked ? 'checked' : '' }}>
                                            <label class="custom-control-label text-capitalize"
                                                for="{{ $roleId }}">{{ str_replace('_', ' ', $role) }}</label>
                                        </div>
                                    @endforeach
                                </div>
                                @error('roles')
                                    <span class="text-danger d-block mt-1">{{ $message }}</span>
                                @enderror
                                @error('roles.*')
                                    <span class="text-danger d-block mt-1">{{ $message }}</span>
                                @enderror
                            @endif
                        </div>
                        <div class="form-group">
                            <label for="especialidades">Especialidades (múltiples, solo especialistas)</label>
                            <select name="especialidades[]" id="especialidades" class="form-control @error('especialidades') is-invalid @enderror" multiple {{ auth()->user()->hasRole('recepcionista') ? 'disabled' : '' }}>
                                @php
                                    $selectedEspecialidades = old('especialidades', $usuario->especialidades->pluck('id')->toArray() ?? []);
                                @endphp
                                @foreach ($especialidades as $especialidad)
                                    <option value="{{ $especialidad->id }}" {{ in_array($especialidad->id, $selectedEspecialidades) ? 'selected' : '' }}>
                                        {{ $especialidad->nombre }}
                                    </option>
                                @endforeach
                            </select>
                            <small class="form-text text-muted">
                                @if (auth()->user()->hasRole('recepcionista'))
                                    Campo no disponible para recepcionistas.
                                @else
                                    Se habilita automáticamente cuando el rol "especialista" esté seleccionado. Usa Ctrl o Shift para seleccionar varias.
                                @endif
                            </small>
                            @error('especialidades')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between">
                        <a href="{{ route('admin.users.index') }}" class="btn btn-secondary">Cancelar</a>
                        <button type="submit" class="btn btn-primary">Actualizar usuario</button>
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
<script>
$(document).ready(function() {
    $('#especialidades').select2({
        placeholder: "Selecciona especialidades",
        allowClear: true,
        width: '100%'
    });
});
</script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        const roleCheckboxes = Array.from(document.querySelectorAll('.role-checkbox'));
        const especialidadSelect = document.getElementById('especialidad_id');

        if (!especialidadSelect) {
            return;
        }

        function toggleEspecialidad() {
            const specialistSelected = roleCheckboxes.some(function (checkbox) {
                return checkbox.checked && checkbox.value === 'especialista';
            });

            especialidadSelect.disabled = !specialistSelected;
            especialidadSelect.classList.toggle('disabled', !specialistSelected);

            if (!specialistSelected) {
                especialidadSelect.value = '';
            }
        }

        roleCheckboxes.forEach(function (checkbox) {
            checkbox.addEventListener('change', toggleEspecialidad);
        });

        toggleEspecialidad();
    });
</script>
@endpush
