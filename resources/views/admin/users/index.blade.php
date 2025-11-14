@extends('layouts.adminlte')

@section('title', 'SomosSalud | Gestión de usuarios')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

{{-- Breadcrumb removido para gestión de usuarios (index) --}}

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
                <div class="card-header d-flex flex-wrap justify-content-between align-items-center">
                    <h3 class="card-title mb-0">Usuarios registrados</h3>
                    <form method="GET" action="{{ route('admin.users.index') }}" class="form-inline mr-2">
                        <div class="form-group mb-0 mr-2">
                            <select name="rol" class="form-control form-control-sm" onchange="this.form.submit()">
                                <option value="">Todos los roles</option>
                                @foreach ($roles ?? [] as $rol)
                                    <option value="{{ $rol }}" {{ ($filtroRol ?? '') === $rol ? 'selected' : '' }}>{{ ucfirst(str_replace('_',' ', $rol)) }}</option>
                                @endforeach
                            </select>
                        </div>
                        @if(request('rol'))
                            <a href="{{ route('admin.users.index') }}" class="btn btn-link btn-sm">Limpiar filtro</a>
                        @endif
                    </form>
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
                                    <th>Especialidades</th>
                                    <th class="text-nowrap">Registrado</th>
                                    <th class="text-right">Acciones</th>
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
                                        <td>
                                            @php
                                                $especialidades = $usuario->especialidades->pluck('nombre')->toArray();
                                            @endphp
                                            @if(!empty($especialidades))
                                                {!! '<span class="badge badge-info">' . implode('</span> <span class="badge badge-info">', $especialidades) . '</span>' !!}
                                            @else
                                                <span class="text-muted">N/A</span>
                                            @endif
                                        </td>
                                        <td class="text-nowrap">
                                            {{ optional($usuario->created_at)->format('d/m/Y H:i') ?? '—' }}
                                        </td>
                                        <td class="text-right text-nowrap align-middle">
                                            <a href="{{ route('admin.users.edit', $usuario) }}" class="btn btn-sm btn-outline-primary">
                                                <i class="fas fa-user-edit mr-1"></i> Editar
                                            </a>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="7" class="text-center py-4">
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