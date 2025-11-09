@extends('layouts.auth')

@section('head')
    <style>
        .auth-card{background:#ffffff; border:1px solid rgba(0,0,0,.06); box-shadow:0 .75rem 1.5rem -0.5rem rgba(0,0,0,.08); border-radius:1rem;}
        .auth-card h1{font-size:1.35rem; font-weight:600; letter-spacing:.5px;}
        .brand-pill{display:inline-flex; align-items:center; gap:.35rem; background:#0ea5e9; color:#fff; font-size:.65rem; font-weight:600; padding:.35rem .6rem; border-radius:2rem; text-transform:uppercase; letter-spacing:.5px;}
    </style>
@endsection

@section('content')
    <div class="auth-card p-4 p-md-5 mb-4">
        <div class="d-flex justify-content-between align-items-start mb-3">
            <h1 class="mb-0">Inicia sesión</h1>
            <span class="brand-pill"><i class="fa-solid fa-shield-heart"></i> Acceso seguro</span>
        </div>
        @if(session('status'))
            <div class="alert alert-info small mb-3">{{ session('status') }}</div>
        @endif
        <form method="POST" action="{{ route('login') }}" novalidate>
            @csrf
            <div class="mb-3">
                <label for="cedula" class="form-label small fw-semibold">Cédula</label>
                <input id="cedula" type="text" name="cedula" value="{{ old('cedula') }}" class="form-control form-control-sm @error('cedula') is-invalid @enderror" required autocomplete="username" autofocus placeholder="Ej: V-12345678">
                @error('cedula')<div class="invalid-feedback">{{ $message }}</div>@enderror
            </div>
            <div class="mb-3">
                <label for="password" class="form-label small fw-semibold">Contraseña</label>
                <div class="input-group input-group-sm">
                    <input id="password" type="password" name="password" class="form-control @error('password') is-invalid @enderror" required autocomplete="current-password" placeholder="••••••••">
                    <button type="button" class="btn btn-outline-secondary" id="togglePass" tabindex="-1"><i class="fa-regular fa-eye"></i></button>
                </div>
                @error('password')<div class="invalid-feedback d-block">{{ $message }}</div>@enderror
            </div>
            <div class="d-flex justify-content-between align-items-center mb-3">
                <div class="form-check form-check-sm">
                    <input class="form-check-input" type="checkbox" value="1" id="remember_me" name="remember">
                    <label class="form-check-label small" for="remember_me">Recuérdame</label>
                </div>
                @if (Route::has('password.request'))
                    <a href="{{ route('password.request') }}" class="small text-decoration-none">¿Olvidaste tu contraseña?</a>
                @endif
            </div>
            <div class="d-grid gap-2">
                <button class="btn btn-primary btn-sm fw-semibold" type="submit"><i class="fa-solid fa-right-to-bracket me-1"></i> Ingresar</button>
            </div>
        </form>
    </div>
    <div class="text-center small text-muted">
        ¿No tienes cuenta? <a href="{{ route('register') }}" class="text-decoration-none">Regístrate</a>
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