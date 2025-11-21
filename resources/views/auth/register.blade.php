@extends('layouts.auth')

@section('content')
    <div class="auth-card">
        <div class="auth-card-header">
            <div class="d-flex justify-content-between align-items-start mb-3">
                <div>
                    <h1>Crear cuenta</h1>
                    <p class="auth-card-subtitle">Regístrate como paciente</p>
                </div>
                <span class="brand-pill">
                    <i class="fa-solid fa-user-plus"></i>
                    Nuevo
                </span>
            </div>
        </div>

        <form method="POST" action="{{ route('register') }}" novalidate>
            @csrf

            <!-- Nombre -->
            <div class="mb-4">
                <label for="name" class="form-label">
                    <i class="fa-solid fa-user me-1"></i> Nombre completo
                </label>
                <input 
                    id="name" 
                    type="text" 
                    name="name" 
                    value="{{ old('name') }}" 
                    class="form-control @error('name') is-invalid @enderror" 
                    required 
                    autofocus 
                    autocomplete="name"
                    placeholder="Ej: Juan Pérez"
                >
                @error('name')
                    <div class="invalid-feedback">
                        <i class="fa-solid fa-circle-exclamation me-1"></i>{{ $message }}
                    </div>
                @enderror
            </div>

            <!-- Correo electrónico -->
            <div class="mb-4">
                <label for="email" class="form-label">
                    <i class="fa-solid fa-envelope me-1"></i> Correo electrónico
                </label>
                <input 
                    id="email" 
                    type="email" 
                    name="email" 
                    value="{{ old('email') }}" 
                    class="form-control @error('email') is-invalid @enderror" 
                    required 
                    autocomplete="email"
                    placeholder="correo@ejemplo.com"
                >
                @error('email')
                    <div class="invalid-feedback">
                        <i class="fa-solid fa-circle-exclamation me-1"></i>{{ $message }}
                    </div>
                @enderror
            </div>

            <!-- Cédula -->
            <div class="mb-4">
                <label for="cedula" class="form-label">
                    <i class="fa-solid fa-id-card me-1"></i> Cédula
                </label>
                <input 
                    id="cedula" 
                    type="text" 
                    name="cedula" 
                    value="{{ old('cedula') }}" 
                    class="form-control @error('cedula') is-invalid @enderror" 
                    required 
                    autocomplete="username"
                    placeholder="Ej: V-12345678"
                >
                @error('cedula')
                    <div class="invalid-feedback">
                        <i class="fa-solid fa-circle-exclamation me-1"></i>{{ $message }}
                    </div>
                @enderror
            </div>

            <!-- Contraseña -->
            <div class="mb-4">
                <label for="password" class="form-label">
                    <i class="fa-solid fa-lock me-1"></i> Contraseña
                </label>
                <div class="input-group">
                    <input 
                        id="password" 
                        type="password" 
                        name="password" 
                        class="form-control @error('password') is-invalid @enderror" 
                        required 
                        autocomplete="new-password"
                        placeholder="Mínimo 8 caracteres"
                    >
                    <button type="button" class="btn btn-outline-secondary" id="togglePass" tabindex="-1">
                        <i class="fa-regular fa-eye"></i>
                    </button>
                </div>
                @error('password')
                    <div class="invalid-feedback d-block">
                        <i class="fa-solid fa-circle-exclamation me-1"></i>{{ $message }}
                    </div>
                @enderror
            </div>

            <!-- Confirmar contraseña -->
            <div class="mb-4">
                <label for="password_confirmation" class="form-label">
                    <i class="fa-solid fa-lock-keyhole me-1"></i> Confirmar contraseña
                </label>
                <div class="input-group">
                    <input 
                        id="password_confirmation" 
                        type="password" 
                        name="password_confirmation" 
                        class="form-control" 
                        required 
                        autocomplete="new-password"
                        placeholder="Repite tu contraseña"
                    >
                    <button type="button" class="btn btn-outline-secondary" id="togglePassConfirm" tabindex="-1">
                        <i class="fa-regular fa-eye"></i>
                    </button>
                </div>
            </div>

            <div class="d-grid mb-4">
                <button class="btn btn-primary" type="submit">
                    <i class="fa-solid fa-user-plus me-2"></i>
                    Crear cuenta
                </button>
            </div>

            <div class="text-center">
                <span style="color: #718096;">¿Ya tienes cuenta?</span>
                <a href="{{ route('login') }}" class="ms-1">
                    Inicia sesión aquí
                </a>
            </div>
        </form>
    </div>
@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded', () => {
    // Toggle password visibility
    const togglePass = document.getElementById('togglePass');
    const password = document.getElementById('password');
    const togglePassConfirm = document.getElementById('togglePassConfirm');
    const passwordConfirm = document.getElementById('password_confirmation');
    
    if (togglePass && password) {
        togglePass.addEventListener('click', () => {
            const visible = password.type === 'text';
            password.type = visible ? 'password' : 'text';
            togglePass.innerHTML = visible ? '<i class="fa-regular fa-eye"></i>' : '<i class="fa-regular fa-eye-slash"></i>';
        });
    }
    
    if (togglePassConfirm && passwordConfirm) {
        togglePassConfirm.addEventListener('click', () => {
            const visible = passwordConfirm.type === 'text';
            passwordConfirm.type = visible ? 'password' : 'text';
            togglePassConfirm.innerHTML = visible ? '<i class="fa-regular fa-eye"></i>' : '<i class="fa-regular fa-eye-slash"></i>';
        });
    }
});
</script>
@endpush