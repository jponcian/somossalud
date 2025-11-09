@extends('layouts.adminlte')

@section('title', 'Configuración - Pago Móvil')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

{{-- Breadcrumb removido para configuración de pagos --}}

@section('content')
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Datos para que los pacientes realicen Pago Móvil</h3>
            @if(session('success'))
                <span class="badge badge-success ml-2">{{ session('success') }}</span>
            @endif
        </div>
        <form method="POST" action="{{ route('admin.settings.pagos.guardar') }}">
            @csrf
            <div class="card-body">
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
