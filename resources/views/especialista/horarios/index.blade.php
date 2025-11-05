@extends('layouts.adminlte')

@section('title', 'SomosSalud | Mi disponibilidad')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

@section('content-header')
    <div class="row mb-2">
        <div class="col-sm-6">
            <h1 class="m-0 text-dark">Mi disponibilidad</h1>
        </div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="{{ route('panel.clinica') }}">Inicio</a></li>
                <li class="breadcrumb-item active">Horarios</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    <div class="row">
        <div class="col-lg-5">
            <div class="card card-primary card-outline">
                <div class="card-header">
                    <h3 class="card-title mb-0">Agregar horario</h3>
                </div>
                <form action="{{ route('especialista.horarios.store') }}" method="POST">
                    @csrf
                    <div class="card-body">
                        @if ($errors->any())
                            <div class="alert alert-danger">
                                <p class="mb-2 font-weight-bold">Corrige los siguientes puntos:</p>
                                <ul class="mb-0 pl-3">
                                    @foreach ($errors->all() as $error)
                                        <li>{{ $error }}</li>
                                    @endforeach
                                </ul>
                            </div>
                        @endif
                        <div class="form-group">
                            <label for="dia_semana">Día de la semana</label>
                            <select name="dia_semana" id="dia_semana"
                                class="form-control @error('dia_semana') is-invalid @enderror" required>
                                <option value="">Selecciona un día</option>
                                @foreach ($diasSemana as $key => $label)
                                    <option value="{{ $key }}" {{ old('dia_semana') === $key ? 'selected' : '' }}>
                                        {{ $label }}
                                    </option>
                                @endforeach
                            </select>
                            @error('dia_semana')
                                <span class="invalid-feedback" role="alert">{{ $message }}</span>
                            @enderror
                        </div>
                        <div class="form-row">
                            <div class="form-group col-md-6">
                                <label for="hora_inicio">Hora de inicio</label>
                                <input type="time" name="hora_inicio" id="hora_inicio" value="{{ old('hora_inicio') }}"
                                    class="form-control @error('hora_inicio') is-invalid @enderror" required>
                                @error('hora_inicio')
                                    <span class="invalid-feedback" role="alert">{{ $message }}</span>
                                @enderror
                            </div>
                            <div class="form-group col-md-6">
                                <label for="hora_fin">Hora de fin</label>
                                <input type="time" name="hora_fin" id="hora_fin" value="{{ old('hora_fin') }}"
                                    class="form-control @error('hora_fin') is-invalid @enderror" required>
                                @error('hora_fin')
                                    <span class="invalid-feedback" role="alert">{{ $message }}</span>
                                @enderror
                            </div>
                        </div>
                    </div>
                    <div class="card-footer d-flex justify-content-end">
                        <button type="submit" class="btn btn-primary">Guardar horario</button>
                    </div>
                </form>
            </div>
        </div>
        <div class="col-lg-7">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title mb-0">Horarios cargados</h3>
                    @if (session('status'))
                        <span class="badge badge-success">{{ session('status') }}</span>
                    @endif
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mb-0">
                            <thead class="thead-light">
                                <tr>
                                    <th>Día</th>
                                    <th class="text-nowrap">Hora inicio</th>
                                    <th class="text-nowrap">Hora fin</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($disponibilidades as $disponibilidad)
                                    <tr>
                                        <td>{{ $diasSemana[$disponibilidad->dia_semana] ?? ucfirst($disponibilidad->dia_semana) }}</td>
                                        <td>{{ \Carbon\Carbon::createFromFormat('H:i:s', $disponibilidad->hora_inicio)->format('H:i') }}</td>
                                        <td>{{ \Carbon\Carbon::createFromFormat('H:i:s', $disponibilidad->hora_fin)->format('H:i') }}</td>
                                        <td class="text-right">
                                            <form action="{{ route('especialista.horarios.destroy', $disponibilidad) }}" method="POST"
                                                onsubmit="return confirm('¿Eliminar este horario?');">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="btn btn-sm btn-outline-danger">
                                                    <i class="fas fa-trash-alt"></i>
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="4" class="text-center py-4">Aún no has registrado horarios.</td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
@endsection
