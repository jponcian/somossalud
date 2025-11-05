@extends('layouts.adminlte')

@section('title', 'SomosSalud | Gestión de usuarios')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

@section('content-header')
    <div class="row mb-2">
        <div class="col-sm-6">
            <h1 class="m-0 text-dark">Gestión de usuarios</h1>
        </div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="{{ route('panel.clinica') }}">Inicio</a></li>
                <li class="breadcrumb-item active">Usuarios</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    <div class="row">
        <div class="col-12">
            @if (session('status'))
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    {{ session('status') }}
                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            @endif
        </div>
        <div class="col-12">
            <div class="card">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h3 class="card-title mb-0">Usuarios registrados</h3>
                    <a href="{{ route('admin.users.create') }}" class="btn btn-primary btn-sm">
                        <i class="fas fa-user-plus mr-1"></i> Nuevo usuario
                    </a>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mb-0">
                            <thead class="thead-light">
                                <tr>
                                    <th>Nombre</th>
                                    <th>Cédula</th>
                                    <th>Correo</th>
                                    <th>Roles</th>
                                    <th>Especialidad</th>
                                    <th class="text-nowrap">Registrado</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($usuarios as $usuario)
                                    <tr>
                                        <td>{{ $usuario->name }}</td>
                                        <td>{{ $usuario->cedula ?? '—' }}</td>
                                        <td>{{ $usuario->email }}</td>
                                        <td>
                                            @php
                                                $roleNames = $usuario->getRoleNames();
                                            @endphp
                                            {{ $roleNames->isEmpty() ? 'Sin roles' : $roleNames->implode(', ') }}
                                        </td>
                                        <td>{{ $usuario->especialidad->nombre ?? 'N/A' }}</td>
                                        <td class="text-nowrap">
                                            {{ optional($usuario->created_at)->format('d/m/Y H:i') ?? '—' }}
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="5" class="text-center py-4">
                                            No hay usuarios registrados todavía.
                                        </td>
                                    </tr>
                                @endforelse
                            </tbody>
                        </table>
                    </div>
                </div>
                @if ($usuarios->hasPages())
                    <div class="card-footer clearfix">
                        {{ $usuarios->links() }}
                    </div>
                @endif
            </div>
        </div>
    </div>
@endsection