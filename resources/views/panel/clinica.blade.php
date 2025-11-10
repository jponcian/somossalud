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
        <div id="flash-bienvenida" class="alert alert-primary border-left" style="border-left:4px solid #1d6fb8;">
            <strong>Bienvenido, {{ auth()->user()->name }}.</strong>
            <span class="small ml-1">Accede a tus citas y atenciones desde el menú lateral.</span>
        </div>
    @endif

    {{-- Definimos la variable de usuario autenticado en un bloque PHP para evitar problemas de parseo --}}
    @php
        $yo = auth()->user();
    @endphp
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
        },3000);
    </script>
    @endif
    @endpush
@endsection