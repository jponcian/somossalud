@extends('layouts.adminlte')

@section('title', 'SomosSalud | Panel interno')

@section('sidebar')
    @include('panel.partials.sidebar')
@endsection

{{-- Se eliminó el breadcrumb para reducir altura y ruido visual --}}

@section('content')
    {{-- Se eliminó el callout de "Panel en construcción" para mostrar directamente los widgets disponibles --}}

    @php
        // Mostrar mensaje solo una vez por sesión
        $mostrarBienvenida = !session()->pull('panel_bienvenida_mostrada', false);
        if($mostrarBienvenida){ session(['panel_bienvenida_mostrada' => true]); }
    @endphp
    @if($mostrarBienvenida)
        <div id="flash-bienvenida" class="card border-0 shadow-sm mb-4 overflow-hidden" style="background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: white;">
            <div class="card-body p-4 position-relative">
                <div class="position-absolute" style="right: -20px; top: -20px; opacity: 0.1; font-size: 8rem;">
                    <i class="fas fa-user-md"></i>
                </div>
                <div class="d-flex align-items-center position-relative z-1">
                    <div class="bg-white rounded-circle p-3 mr-3 shadow-sm" style="width: 60px; height: 60px; display: flex; align-items: center; justify-content: center;">
                        <i class="fas fa-user-check text-primary fa-lg"></i>
                    </div>
                    <div>
                        <h4 class="mb-1 font-weight-bold">¡Bienvenido de nuevo, {{ auth()->user()->name }}!</h4>
                        <p class="mb-0 text-white-50">Accede a tus citas, atenciones y configuraciones desde el menú lateral.</p>
                    </div>
                    <button type="button" class="close text-white ml-auto" onclick="document.getElementById('flash-bienvenida').remove()" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            </div>
        </div>
    @endif

    {{-- Definimos la variable de usuario autenticado en un bloque PHP para evitar problemas de parseo --}}
    @php
        $yo = auth()->user();
    @endphp
    @role('super-admin|admin_clinica')
    <div class="row">
        <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ \App\Models\User::role('paciente')->count() }}</h3>
                    <p>Pacientes Registrados</p>
                </div>
                <div class="icon">
                    <i class="fas fa-users"></i>
                </div>
                <a href="{{ route('admin.users.index') }}" class="small-box-footer">Más info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ \App\Models\Cita::whereDate('fecha', now())->count() }}</h3>
                    <p>Citas Hoy</p>
                </div>
                <div class="icon">
                    <i class="fas fa-calendar-check"></i>
                </div>
                <a href="{{ route('citas.index') }}" class="small-box-footer">Más info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ \App\Models\User::role('especialista')->count() }}</h3>
                    <p>Especialistas</p>
                </div>
                <div class="icon">
                    <i class="fas fa-user-md"></i>
                </div>
                <a href="{{ route('admin.users.index') }}" class="small-box-footer">Más info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
        <div class="col-lg-3 col-6">
            <!-- small box -->
            <div class="small-box bg-danger">
                <div class="inner">
                    <h3>{{ \App\Models\ReportePago::where('estado', 'pendiente')->count() }}</h3>
                    <p>Pagos Pendientes</p>
                </div>
                <div class="icon">
                    <i class="fas fa-file-invoice-dollar"></i>
                </div>
                <a href="{{ route('recepcion.pagos.index') }}" class="small-box-footer">Más info <i class="fas fa-arrow-circle-right"></i></a>
            </div>
        </div>
        <!-- ./col -->
    </div>

    <div class="row">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header border-0">
                    <h3 class="card-title">Accesos Rápidos</h3>
                </div>
                <div class="card-body">
                    <div class="d-flex flex-wrap gap-2">
                        <a href="{{ route('register') }}" class="btn btn-app">
                            <i class="fas fa-user-plus"></i> Registrar Paciente
                        </a>
                        <a href="{{ route('citas.create') }}" class="btn btn-app">
                            <i class="fas fa-calendar-plus"></i> Nueva Cita
                        </a>
                        <a href="{{ route('admin.users.index') }}" class="btn btn-app">
                            <i class="fas fa-users-cog"></i> Usuarios
                        </a>
                        @role('super-admin')
                        <a href="{{ route('admin.settings.pagos') }}" class="btn btn-app">
                            <i class="fas fa-cogs"></i> Configuración
                        </a>
                        @endrole
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="card">
                <div class="card-header border-0">
                    <h3 class="card-title">Últimos Usuarios Registrados</h3>
                </div>
                <div class="card-body table-responsive p-0">
                    <table class="table table-striped table-valign-middle">
                        <thead>
                        <tr>
                            <th>Usuario</th>
                            <th>Rol</th>
                            <th>Fecha</th>
                        </tr>
                        </thead>
                        <tbody>
                        @foreach(\App\Models\User::latest()->take(5)->get() as $user)
                        <tr>
                            <td>
                                {{ $user->name }}
                                <br>
                                <small class="text-muted">{{ $user->email }}</small>
                            </td>
                            <td>
                                @foreach($user->roles as $role)
                                    <span class="badge badge-info">{{ $role->name }}</span>
                                @endforeach
                            </td>
                            <td>
                                <small class="text-success mr-1">
                                    <i class="fas fa-clock"></i>
                                </small>
                                {{ $user->created_at->diffForHumans() }}
                            </td>
                        </tr>
                        @endforeach
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    @endrole

    @role('especialista')
    @php
        // Conteo y listado breve de atenciones abiertas asignadas al especialista
        $totalAbiertas = \App\Models\Atencion::abiertas()->where('medico_id', $yo->id)->count();
        $abiertas = \App\Models\Atencion::abiertas()
            ->where('medico_id', $yo->id)
            ->with(['paciente'])
            ->latest('iniciada_at')
            ->take(5)
            ->get();
    @endphp
    <div class="row">
        <div class="col-lg-4 col-md-6">
            <div class="card border-left border-left-warning" style="border-left: .35rem solid #ffc107;">
                <div class="card-header">
                    <h3 class="card-title mb-0">
                        <i class="fas fa-ambulance text-warning mr-2"></i>
                        Atenciones en curso
                    </h3>
                </div>
                <div class="card-body py-2">
                    <div class="d-flex align-items-center">
                        <span class="badge badge-warning mr-2">{{ $totalAbiertas }}</span>
                        @if($totalAbiertas > 0)
                            <div class="small text-muted">Tienes atenciones asignadas esperando gestión.</div>
                        @else
                            <div class="small text-muted">No tienes atenciones en curso por ahora.</div>
                        @endif
                    </div>
                </div>
                @if($totalAbiertas > 0)
                <ul class="list-group list-group-flush">
                    @foreach($abiertas as $a)
                        <li class="list-group-item d-flex justify-content-between align-items-center">
                            <div>
                                <div class="small"><strong>#{{ $a->id }}</strong> · {{ optional($a->paciente)->name ?? 'Paciente' }}</div>
                                @php
                                    $labelEstado = match($a->estado){
                                        'validado' => 'Validada',
                                        'en_consulta' => 'En proceso',
                                        'cerrado' => 'Cerrada',
                                        default => ucfirst($a->estado),
                                    };
                                    $badgeClass = match($a->estado){
                                        'validado' => 'badge-info',
                                        'en_consulta' => 'badge-warning',
                                        'cerrado' => 'badge-success',
                                        default => 'badge-light'
                                    };
                                @endphp
                                <div class="small text-muted">Estado: <span class="badge {{ $badgeClass }}">{{ $labelEstado }}</span></div>
                            </div>
                            <a href="{{ route('atenciones.gestion', $a) }}" class="btn btn-sm btn-outline-primary">Gestionar</a>
                        </li>
                    @endforeach
                </ul>
                @endif
            </div>
        </div>
        <div class="col-lg-4 col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><i class="fas fa-calendar-check text-primary mr-2"></i> Mis citas</h3>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush">
                        @php
                            $proximas = \App\Models\Cita::where('especialista_id', $yo->id)
                                ->orderBy('fecha','asc')
                                ->take(5)
                                ->get();
                        @endphp
                        @forelse($proximas as $c)
                            <li class="list-group-item d-flex justify-content-between align-items-center">
                                <div>
                                    <div class="small text-muted">{{ \Illuminate\Support\Carbon::parse($c->fecha)->format('d/m/Y h:i a') }}</div>
                                    <div class="small">Paciente: {{ optional($c->usuario)->name ?? '—' }}</div>
                                </div>
                                <div class="text-nowrap">
                                    <a href="{{ route('citas.show', $c) }}#gestion" class="btn btn-sm btn-outline-secondary" title="Gestionar"><i class="fas fa-stethoscope"></i></a>
                                </div>
                            </li>
                        @empty
                            <li class="list-group-item text-muted small">Sin citas próximas</li>
                        @endforelse
                    </ul>
                </div>
            </div>
        </div>

        <div class="col-lg-4 col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3 class="card-title"><i class="far fa-clock text-teal mr-2"></i> Mis horarios</h3>
                </div>
                <div class="card-body">
                    <p class="small text-muted mb-2">Administra tu disponibilidad semanal.</p>
                    <a href="{{ route('especialista.horarios.index') }}" class="btn btn-outline-teal btn-sm"><i class="far fa-clock mr-1"></i> Configurar</a>
                </div>
            </div>
        </div>
    </div>
    @endrole
    @push('scripts')
    @if($mostrarBienvenida)
    <script>
        setTimeout(()=>{
            const el = document.getElementById('flash-bienvenida');
            if(el){ el.classList.add('fade'); el.style.transition='opacity .4s'; el.style.opacity='0'; setTimeout(()=>el.remove(),400); }
        }, 5000);
    </script>
    @endif
    @endpush
@endsection