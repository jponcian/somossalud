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
            <div class="card shadow-sm border-0 rounded-lg overflow-hidden">
                <div class="card-header border-0 d-flex justify-content-between align-items-center" style="background: linear-gradient(135deg, #dbeafe 0%, #dcfce7 100%); border-bottom: 1px solid #cbd5e1;">
                    <h3 class="card-title font-weight-bold text-primary mb-0">
                        <i class="fas fa-users mr-2"></i> Usuarios registrados
                    </h3>
                    <div class="d-flex align-items-center">
                        <form method="GET" action="{{ route('admin.users.index') }}" class="form-inline mr-3">
                            <label class="mr-2 text-muted small font-weight-bold text-uppercase">Filtrar:</label>
                            <select name="rol" class="custom-select custom-select-sm border-0 shadow-sm bg-white text-dark font-weight-bold" onchange="this.form.submit()" style="min-width: 150px;">
                                <option value="">Todos los roles</option>
                                @foreach ($roles ?? [] as $rol)
                                    <option value="{{ $rol }}" {{ ($filtroRol ?? '') === $rol ? 'selected' : '' }}>{{ ucfirst(str_replace('_',' ', $rol)) }}</option>
                                @endforeach
                            </select>
                            @if(request('rol'))
                                <a href="{{ route('admin.users.index') }}" class="btn btn-link btn-sm text-danger ml-2" title="Limpiar filtro"><i class="fas fa-times"></i></a>
                            @endif
                        </form>
                        <a href="{{ route('admin.users.create') }}" class="btn btn-primary btn-sm font-weight-bold shadow-sm rounded-pill px-3">
                            <i class="fas fa-user-plus mr-1"></i> Nuevo usuario
                        </a>
                    </div>
                </div>
                <div class="card-body p-0">
                    <div class="table-responsive">
                        <table class="table table-hover mb-0 align-middle">
                            <thead style="background-color: #f8fafc;">
                                <tr>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold pl-4">Usuario</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Roles</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Especialidades</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Registrado</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold text-right pr-4">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                @forelse ($usuarios as $usuario)
                                    <tr>
                                        <td class="pl-4">
                                            <div class="d-flex align-items-center">
                                                <div class="rounded-circle bg-light d-flex align-items-center justify-content-center mr-3 text-primary font-weight-bold" style="width: 40px; height: 40px;">
                                                    {{ substr($usuario->name, 0, 1) }}
                                                </div>
                                                <div>
                                                    <div class="font-weight-bold text-dark">{{ $usuario->name }}</div>
                                                    <div class="small text-muted">{{ $usuario->email }}</div>
                                                    @if($usuario->cedula)
                                                        <div class="small text-muted">CI: {{ $usuario->cedula }}</div>
                                                    @endif
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            @php
                                                $roleNames = $usuario->getRoleNames();
                                            @endphp
                                            @if($roleNames->isEmpty())
                                                <span class="badge badge-light text-muted">Sin roles</span>
                                            @else
                                                @foreach($roleNames as $role)
                                                    @php
                                                        $badgeClass = match($role) {
                                                            'admin' => 'badge-danger',
                                                            'especialista' => 'badge-success',
                                                            'recepcionista' => 'badge-info',
                                                            'paciente' => 'badge-secondary',
                                                            default => 'badge-primary'
                                                        };
                                                    @endphp
                                                    <span class="badge {{ $badgeClass }} px-2 py-1 rounded-pill mr-1">{{ ucfirst(str_replace('_',' ', $role)) }}</span>
                                                @endforeach
                                            @endif
                                        </td>
                                        <td>
                                            @php
                                                $especialidades = $usuario->especialidades->pluck('nombre')->toArray();
                                            @endphp
                                            @if(!empty($especialidades))
                                                @foreach($especialidades as $esp)
                                                    <span class="badge badge-light border px-2 py-1 rounded mr-1">{{ $esp }}</span>
                                                @endforeach
                                            @else
                                                <span class="text-muted small font-italic">N/A</span>
                                            @endif
                                        </td>
                                        <td>
                                            <span class="text-muted small">
                                                <i class="far fa-calendar-alt mr-1"></i>
                                                {{ optional($usuario->created_at)->format('d/m/Y') }}
                                            </span>
                                        </td>
                                        <td class="text-right pr-4">
                                            <a href="{{ route('admin.users.edit', $usuario) }}" class="btn btn-sm btn-light text-primary shadow-sm rounded-circle" title="Editar usuario">
                                                <i class="fas fa-user-edit"></i>
                                            </a>
                                        </td>
                                    </tr>
                                @empty
                                    <tr>
                                        <td colspan="5" class="text-center py-5">
                                            <div class="text-muted">
                                                <i class="fas fa-users-slash fa-3x mb-3 opacity-50"></i>
                                                <p class="mb-0 font-weight-bold">No hay usuarios registrados</p>
                                            </div>
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