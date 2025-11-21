@extends('layouts.auth')


@section('content')
    <div class="auth-card">
        <div class="auth-card-header">
            <div class="d-flex justify-content-between align-items-start mb-3">
                <div>
                    <h1>Inicia sesión</h1>
                    <p class="auth-card-subtitle">Accede a tu cuenta de paciente</p>
                </div>
                <span class="brand-pill">
                    <i class="fa-solid fa-shield-heart"></i>
                    Seguro
                </span>
            </div>
        </div>

        @if(session('status'))
            <div class="alert alert-info mb-4">
                <i class="fa-solid fa-circle-info me-2"></i>{{ session('status') }}
            </div>
        @endif

        <form method="POST" action="{{ route('login') }}" novalidate>
            @csrf
            
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
                    autofocus 
                    placeholder="Ej: V-12345678"
                >
                @error('cedula')
                    <div class="invalid-feedback">
                        <i class="fa-solid fa-circle-exclamation me-1"></i>{{ $message }}
                    </div>
                @enderror
            </div>

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
                        autocomplete="current-password" 
                        placeholder="Ingresa tu contraseña"
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

            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="form-check">
                    <input class="form-check-input" type="checkbox" value="1" id="remember_me" name="remember">
                    <label class="form-check-label" for="remember_me">
                        Recuérdame
                    </label>
                </div>
                @if (Route::has('password.request'))
                    <a href="{{ route('password.request') }}">
                        ¿Olvidaste tu contraseña?
                    </a>
                @endif
            </div>

            <div class="d-grid mb-4">
                <button class="btn btn-primary" type="submit">
                    <i class="fa-solid fa-right-to-bracket me-2"></i>
                    Ingresar
                </button>
            </div>

            <div class="text-center">
                <span style="color: #718096;">¿No tienes cuenta?</span>
                <a href="{{ route('register') }}" class="ms-1">
                    Regístrate aquí
                </a>
            </div>
        </form>
    </div>
@endsection

@push('scripts')
<script>
document.addEventListener('DOMContentLoaded',()=>{
    const btn = document.getElementById('togglePass');
    const pass = document.getElementById('password');
    btn.addEventListener('click',()=>{
        const visible = pass.type === 'text';
        pass.type = visible ? 'password' : 'text';
        btn.innerHTML = visible ? '<i class="fa-regular fa-eye"></i>' : '<i class="fa-regular fa-eye-slash"></i>';
    });
});
</script>
@endpush