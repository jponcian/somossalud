@extends('layouts.adminlte')

@section('title', 'Configuración - Pago Móvil')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

{{-- Breadcrumb removido para configuración de pagos --}}

@section('content')
    @push('styles')
    <style>
        .pago-movil-config-card {background:linear-gradient(135deg,#ffffff 0%,#f4f9ff 100%); border:1px solid #e1ecf7; border-left:6px solid #0d6efd;}
        .pago-movil-config-card .card-header {background: #0d6efd; color:#fff;}
        .pago-movil-config-card h3.card-title {font-weight:600; font-size:1.05rem; display:flex; align-items:center; gap:.5rem; margin:0;}
        .pago-movil-config-card .form-group label {font-weight:500; color:#0d4f7a;}
        .pago-movil-config-card input.form-control {border-color:#b9d7f2;}
        .pago-movil-config-card input.form-control:focus {box-shadow:0 0 0 .2rem rgba(13,110,253,.15); border-color:#0d6efd;}
        .pago-movil-info {font-size:.75rem; color:#0d4f7a; background:#e8f3ff; border:1px solid #d3e7f8; border-radius:6px; padding:.5rem .75rem; display:flex; align-items:center; gap:.5rem;}
        @media (max-width: 575.98px){ .pago-movil-config-card {border-left-width:4px;} }
    </style>
    @endpush
    <div class="card pago-movil-config-card">
        <div class="card-header">
            <h3 class="card-title"><i class="fa-solid fa-mobile-screen-button"></i> Datos del Pago Móvil</h3>
            @if(session('success'))
                <span class="badge badge-success ml-2">{{ session('success') }}</span>
            @endif
        </div>
        <form method="POST" action="{{ route('admin.settings.pagos.guardar') }}">
            @csrf
            <div class="card-body">
                <div class="pago-movil-info mb-3"><i class="fa-solid fa-circle-info text-primary"></i> Estos datos se mostrarán a los pacientes cuando deban reportar su pago móvil de la suscripción.</div>
                <div class="form-group">
                    <label class="small" for="banco">Banco</label>
                    <input type="text" id="banco" name="banco" value="{{ old('banco', $banco) }}" class="form-control @error('banco') is-invalid @enderror" required>
                    @error('banco')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="form-group">
                    <label class="small" for="identificacion">RIF/Cédula</label>
                    <input type="text" id="identificacion" name="identificacion" value="{{ old('identificacion', $identificacion) }}" class="form-control @error('identificacion') is-invalid @enderror" placeholder="V-12345678 o J-12345678-9" required>
                    @error('identificacion')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="form-group">
                    <label class="small" for="telefono">Teléfono</label>
                    <input type="text" id="telefono" name="telefono" value="{{ old('telefono', $telefono) }}" class="form-control @error('telefono') is-invalid @enderror" placeholder="0414-1234567" required>
                    @error('telefono')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
                <div class="form-group">
                    <label class="small" for="nombre">Nombre del titular/cuenta</label>
                    <input type="text" id="nombre" name="nombre" value="{{ old('nombre', $nombre) }}" class="form-control @error('nombre') is-invalid @enderror" required>
                    @error('nombre')<div class="invalid-feedback">{{ $message }}</div>@enderror
                </div>
            </div>
            <div class="card-footer d-flex justify-content-end">
                <button class="btn btn-primary" type="submit"><i class="fas fa-save mr-1"></i> Guardar cambios</button>
            </div>
        </form>
    </div>
@endsection
