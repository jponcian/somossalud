@extends('layouts.adminlte')

@section('title', 'Editar Material')

@section('content_header')
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-edit text-warning"></i> Editar Material</h1>
        <a href="{{ route('inventario.materiales.index') }}" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Volver
        </a>
    </div>
@stop

@section('content')
    <div class="card shadow-sm">
        <div class="card-body">
            <form action="{{ route('inventario.materiales.update', $material) }}" method="POST">
                @csrf
                @method('PUT')
                
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Código <span class="text-danger">*</span></label>
                            <input type="text" name="codigo" class="form-control @error('codigo') is-invalid @enderror" value="{{ old('codigo', $material->codigo) }}" required>
                            @error('codigo') <span class="invalid-feedback">{{ $message }}</span> @enderror
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Nombre del Material <span class="text-danger">*</span></label>
                            <input type="text" name="nombre" class="form-control @error('nombre') is-invalid @enderror" value="{{ old('nombre', $material->nombre) }}" required>
                            @error('nombre') <span class="invalid-feedback">{{ $message }}</span> @enderror
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <label>Descripción</label>
                    <textarea name="descripcion" class="form-control" rows="2">{{ old('descripcion', $material->descripcion) }}</textarea>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Categoría <span class="text-danger">*</span></label>
                            <select name="categoria_default" class="form-control @error('categoria_default') is-invalid @enderror" required>
                                <option value="">Seleccione...</option>
                                @foreach($categorias as $cat)
                                    <option value="{{ $cat }}" {{ old('categoria_default', $material->categoria_default) == $cat ? 'selected' : '' }}>{{ $cat }}</option>
                                @endforeach
                            </select>
                            @error('categoria_default') <span class="invalid-feedback">{{ $message }}</span> @enderror
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Unidad de Medida <span class="text-danger">*</span></label>
                            <select name="unidad_medida_default" class="form-control @error('unidad_medida_default') is-invalid @enderror" required>
                                <option value="">Seleccione...</option>
                                @foreach($unidades as $u)
                                    <option value="{{ $u }}" {{ old('unidad_medida_default', $material->unidad_medida_default) == $u ? 'selected' : '' }}>{{ $u }}</option>
                                @endforeach
                            </select>
                            @error('unidad_medida_default') <span class="invalid-feedback">{{ $message }}</span> @enderror
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="form-group">
                            <label>Stock Mínimo (Alerta) <span class="text-danger">*</span></label>
                            <input type="number" name="stock_minimo" class="form-control @error('stock_minimo') is-invalid @enderror" value="{{ old('stock_minimo', $material->stock_minimo) }}" min="0" required>
                            @error('stock_minimo') <span class="invalid-feedback">{{ $message }}</span> @enderror
                        </div>
                    </div>
                </div>
                
                <div class="form-group">
                    <div class="custom-control custom-switch">
                        <input type="hidden" name="activo" value="0">
                        <input type="checkbox" class="custom-control-input" id="activoSwitch" name="activo" value="1" {{ old('activo', $material->activo) ? 'checked' : '' }}>
                        <label class="custom-control-label" for="activoSwitch">Material Activo</label>
                    </div>
                </div>

                <hr>
                <button type="submit" class="btn btn-primary btn-lg shadow-sm">
                    <i class="fas fa-save"></i> Actualizar Material
                </button>
            </form>
        </div>
    </div>
@stop
