@extends('layouts.adminlte')

@section('title', 'SomosSalud | Nuevo usuario')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

{{-- Breadcrumb removido para creación de usuario --}}

@section('content')
    <div class="row">
        <div class="col-lg-8">
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <h3 class="card-title mb-0">Datos del usuario</h3>
                </div>
                <form action="{{ route('admin.users.store') }}" method="POST">
                    @csrf
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
                            <input type="text" name="name" id="name" value="{{ old('name') }}"
                                class="form-control @error('name') is-invalid @enderror" required autofocus>
                            @error('name')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="cedula">Cédula</label>
                            <input type="text" name="cedula" id="cedula" value="{{ old('cedula') }}"
                                class="form-control @error('cedula') is-invalid @enderror" required>
                            <small class="form-text text-muted">Se registrará en mayúsculas para evitar duplicados por formato.</small>
                            @error('cedula')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-group">
                            <label for="email">Correo electrónico</label>
                            <input type="email" name="email" id="email" value="{{ old('email') }}"
                                class="form-control @error('email') is-invalid @enderror" required>
                            @error('email')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="password">Contraseña</label>
                                <input type="password" name="password" id="password"
                                    class="form-control @error('password') is-invalid @enderror" required>
                                @error('password')
                                    <span class="invalid-feedback" role="alert">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group col-md-6">
                                <label for="password_confirmation">Confirmar contraseña</label>
                                <input type="password" name="password_confirmation" id="password_confirmation"
                                    class="form-control" required>
                            </div>
                        </div>
                        <div class="form-group">
                            <label>Roles</label>
                            <p class="text-muted small mb-2">Selecciona uno o varios roles que aplican al usuario.</p>
                            <div class="d-flex flex-wrap">
                                @foreach ($roles as $role)
                                    @php
                                        $roleId = 'role-' . \Illuminate\Support\Str::slug($role);
                                        $isChecked = in_array($role, old('roles', []), true);
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
                        </div>
                        <div class="form-group">
                            <label for="especialidad_id">Especialidad (solo especialistas)</label>
                            <select name="especialidad_id" id="especialidad_id"
                                class="form-control @error('especialidad_id') is-invalid @enderror">
                                <option value="">Selecciona una especialidad</option>
                                @foreach ($especialidades as $especialidad)
                                    <option value="{{ $especialidad->id }}" {{ (string) $especialidad->id === (string) old('especialidad_id') ? 'selected' : '' }}>
                                        {{ $especialidad->nombre }}
                                    </option>
                                @endforeach
                            </select>
                            <small class="form-text text-muted">Se habilita automáticamente cuando el rol "especialista"
                                esté seleccionado.</small>
                            @error('especialidad_id')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-between">
                        <a href="{{ route('admin.users.index') }}" class="btn btn-secondary">Cancelar</a>
                        <button type="submit" class="btn btn-primary">Guardar usuario</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
@endsection

@push('scripts')
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