<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            Panel de pacientes
        </h2>
    </x-slot>

    @php
        // Variables ahora llegan desde la ruta, pero mantenemos fallback por si acaso
        $suscripcionActiva = $suscripcionActiva ?? \App\Models\Suscripcion::where('usuario_id', auth()->id())
            ->where('estado', 'activo')
            ->latest()
            ->first();
        $reportePendiente = $reportePendiente ?? \App\Models\ReportePago::where('usuario_id', auth()->id())->where('estado','pendiente')->latest()->first();
        $ultimoRechazado = $ultimoRechazado ?? \App\Models\ReportePago::where('usuario_id', auth()->id())->where('estado','rechazado')->latest()->first();
        $tieneActiva = (bool) $suscripcionActiva;
    @endphp

    @if (! $tieneActiva && ! $reportePendiente)
        <!-- Modal Bootstrap: Activación de suscripción -->
        <div class="modal fade" id="activarSuscripcionModal" tabindex="-1" aria-labelledby="activarSuscripcionLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header bg-success text-white">
                        <h5 class="modal-title d-flex align-items-center" id="activarSuscripcionLabel">
                            <i class="fas fa-id-card-alt me-2"></i> Activa tu suscripción
                        </h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                    </div>
                    <div class="modal-body">
                        <div class="mb-3">
                            <span class="badge rounded-pill text-bg-success me-2">Plan anual</span>
                            <span class="badge rounded-pill text-bg-warning">Estado: inactivo</span>
                        </div>
                        <p class="mb-3">Activa tu suscripción para acceder a citas, resultados, historial y más herramientas de seguimiento médico.</p>
                        <div class="row g-3 mb-3">
                            <div class="col-md-6">
                                <div class="border rounded p-3 h-100">
                                    @php
                                        $__rateModal = optional(\App\Models\ExchangeRate::latestEffective()->first());
                                        $__bsEquivModal = ($__rateModal && $__rateModal->rate) ? 10 * (float) $__rateModal->rate : null;
                                    @endphp
                                    <p class="fw-semibold mb-2"><i class="fas fa-dollar-sign me-1 text-success"></i> Costo: $10 USD
                                        @if($__bsEquivModal !== null)
                                            <span class="d-block small text-muted">Aprox. {{ number_format((float)$__bsEquivModal, 2, ',', '.') }} Bs (tasa actual)</span>
                                        @else
                                            <span class="d-block small text-muted">Equivalente en Bs no disponible</span>
                                        @endif
                                    </p>
                                    <ul class="mb-0 small">
                                        <li>Acceso a agenda de citas</li>
                                        <li>Resultados y estudios</li>
                                        <li>Perfil clínico unificado</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="border rounded p-3 h-100">
                                    <p class="fw-semibold mb-2"><i class="far fa-clock me-1 text-secondary"></i> Pago Móvil</p>
                                    <ul class="mb-0 small">
                                        <li><span class="fw-medium">Banco:</span> Banco Ejemplo</li>
                                        <li><span class="fw-medium">Teléfono:</span> 0414-0000000</li>
                                        <li><span class="fw-medium">Cédula:</span> V-12.345.678</li>
                                        <li><span class="fw-medium">Nombre:</span> SomosSalud Clínica</li>
                                    </ul>
                                    <p class="text-muted small mt-2">Realiza el pago exacto y guarda la referencia antes de continuar.</p>
                                </div>
                            </div>
                        </div>
                        <div class="border rounded p-3 bg-light">
                            <p class="fw-semibold mb-2"><i class="far fa-list-alt me-1 text-primary"></i> Pasos para activar</p>
                            <ol class="mb-0 small ps-3">
                                <li>Realiza el pago móvil por $10 USD</li>
                                <li>Haz clic en "Reportar mi pago"</li>
                                <li>Ingresa los datos y referencia del pago</li>
                                <li>Espera la validación (recibirás confirmación)</li>
                            </ol>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <a href="{{ route('suscripcion.show') }}" class="btn btn-success">
                            <i class="fas fa-paper-plane me-1"></i> Reportar mi pago
                        </a>
                        <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                    </div>
                </div>
            </div>
        </div>

        @push('scripts')
            <script>
                document.addEventListener('DOMContentLoaded', function () {
                    var el = document.getElementById('activarSuscripcionModal');
                    // Solo auto-mostrar si no hay reporte pendiente (controlado también en Blade)
                    if (el && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
                        var modal = new bootstrap.Modal(el);
                        modal.show();
                    }
                });
            </script>
        @endpush
    @endif

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-8">
            @if (!$tieneActiva)
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-start border-4 border-success">
                    <div class="p-4 d-flex align-items-center justify-content-between">
                        <div class="me-3">
                            @if($reportePendiente)
                                <div class="fw-semibold">Tu pago está en revisión</div>
                                <div class="text-muted small">Referencia: {{ $reportePendiente->referencia }} — Te avisaremos al aprobarse.</div>
                            @elseif($ultimoRechazado)
                                <div class="fw-semibold text-danger">Tu último reporte fue rechazado</div>
                                <div class="text-muted small">@if($ultimoRechazado->observaciones) Motivo: {{ $ultimoRechazado->observaciones }} @endif</div>
                            @else
                                <div class="fw-semibold">Activa tu suscripción</div>
                                <div class="text-muted small">Realiza tu pago móvil y repórtalo para habilitar todas las funciones.</div>
                            @endif
                        </div>
                        <div class="text-nowrap">
                            <a href="{{ route('suscripcion.show') }}" class="btn btn-success btn-sm">
                                <i class="fas fa-paper-plane me-1"></i>
                                {{ $reportePendiente ? 'Ver estado' : 'Reportar mi pago' }}
                            </a>
                        </div>
                    </div>
                </div>
            @endif

            {{-- <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-semibold text-gray-800 mb-3">Tu próxima atención</h3>
                    <p class="text-sm text-gray-600">
                        Revisa el estado de tus citas, resultados de laboratorio y datos personales en un solo lugar.
                    </p>
                </div>
            </div> --}}

            <div class="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-emerald-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">Consultas y atenciones</h4>
                        <p class="text-sm text-gray-600 mb-4">Agenda nuevas consultas y revisa tus atenciones por seguro en un sólo lugar.</p>
                        <a href="{{ route('citas.index') }}"
                            class="inline-flex items-center text-emerald-600 font-semibold text-sm">Gestionar citas<span
                                class="ml-2">→</span></a>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-sky-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">Resultados y estudios</h4>
                        <p class="text-sm text-gray-600 mb-4">
                            Consulta informes, descarga tus resultados y comparte con especialistas cuando lo necesites.
                        </p>
                        <a href="#"
                            class="inline-flex items-center text-sky-600 font-semibold text-sm">Ver mis resultados<span
                                class="ml-2">→</span></a>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-indigo-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">Mi información</h4>
                        <p class="text-sm text-gray-600 mb-4">
                            Actualiza tus datos personales, contactos de emergencia y preferencias de comunicación.
                        </p>
                        <a href="{{ route('profile.edit') }}"
                            class="inline-flex items-center text-indigo-600 font-semibold text-sm">Actualizar perfil<span
                                class="ml-2">→</span></a>
                    </div>
                </div>

                @if($ultimaReceta)
                    <style>
                        .card-receta {
                            background: linear-gradient(180deg, #ffffff 0%, #fff0f5 100%);
                            border: 1px solid #f8d7e2;
                        }
                        .card-receta .section-title { color: #b83280; }
                        .btn-receta { background-color: #d63384; border-color: #d63384; color: #fff; }
                        .btn-receta:hover { background-color: #b62c71; border-color: #b62c71; color: #fff; }
                    </style>
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-pink-400 relative card-receta">
                        <div class="p-6">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h4 class="text-base font-semibold section-title mb-0">Medicamentos recientes</h4>
                                <span class="badge text-bg-light small">{{ $ultimaReceta->concluida_at ? 'Concluida' : 'En curso' }}</span>
                            </div>
                            @php $__fechaRec = \Illuminate\Support\Carbon::parse($ultimaReceta->fecha)->format('d/m/Y'); @endphp
                            <p class="text-xs text-gray-500 mb-3">Receta de la cita con {{ optional($ultimaReceta->especialista)->name ?? 'Especialista' }} ({{ $__fechaRec }})</p>
                            <div class="small" style="max-height: 220px; overflow-y:auto;">
                                @foreach($ultimaReceta->medicamentos->sortBy('orden') as $m)
                                    <div class="border rounded p-2 mb-2 position-relative">                                        
                                        <div class="fw-semibold mb-1">
                                            {{ $m->nombre_generico }}
                                            @if($m->presentacion)
                                                <span class="text-muted">— {{ $m->presentacion }}</span>
                                            @endif
                                        </div>
                                        @if($m->posologia)
                                            <div class="text-muted"><span class="fw-medium">Posología:</span> {{ $m->posologia }}</div>
                                        @endif
                                        @if($m->frecuencia)
                                            <div class="text-muted"><span class="fw-medium">Frecuencia:</span> {{ $m->frecuencia }}</div>
                                        @endif
                                        @if($m->duracion)
                                            <div class="text-muted"><span class="fw-medium">Duración:</span> {{ $m->duracion }}</div>
                                        @endif
                                    </div>
                                @endforeach
                                @if($ultimaReceta->medicamentos->isEmpty())
                                    <div class="text-muted fst-italic">No hay medicamentos registrados.</div>
                                @endif
                            </div>
                            <div class="mt-3">
                                <a href="{{ route('citas.receta', $ultimaReceta) }}" class="btn btn-sm btn-receta">
                                    <i class="fas fa-prescription-bottle-alt me-1"></i> Ver receta completa
                                </a>
                            </div>
                        </div>
                        <span class="position-absolute top-0 end-0 p-2 text-pink-400">
                            <i class="fas fa-pills"></i>
                        </span>
                    </div>
                @endif
                @php
                    $ultimaAtencionConMeds = \App\Models\Atencion::with(['medicamentos','medico'])
                        ->where('paciente_id', auth()->id())
                        ->whereHas('medicamentos')
                        ->orderByRaw('COALESCE(cerrada_at, updated_at) DESC')
                        ->first();
                @endphp
                @if($ultimaAtencionConMeds)
                    <style>
                        .card-atencion-meds { background: linear-gradient(180deg,#ffffff 0%, #eef9ff 100%); border:1px solid #cfe8ff; }
                        .card-atencion-meds .section-title { color:#0d6efd; }
                        .btn-atencion-meds { background:#0d6efd; border-color:#0d6efd; color:#fff; }
                        .btn-atencion-meds:hover { background:#0b5ed7; border-color:#0b5ed7; color:#fff; }
                    </style>
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-info-400 relative card-atencion-meds">
                        <div class="p-6">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <h4 class="text-base font-semibold section-title mb-0">Medicamentos recientes (Atención)</h4>
                                <span class="badge text-bg-light small">{{ $ultimaAtencionConMeds->estado==='cerrado' ? 'Cerrada' : 'En curso' }}</span>
                            </div>
                            @php $__fechaAten = ($ultimaAtencionConMeds->iniciada_at ?? $ultimaAtencionConMeds->created_at)->format('d/m/Y'); @endphp
                            <p class="text-xs text-gray-500 mb-3">Indicados en atención con {{ optional($ultimaAtencionConMeds->medico)->name ?? 'Especialista' }} ({{ $__fechaAten }})</p>
                            <div class="small" style="max-height: 220px; overflow-y:auto;">
                                @foreach($ultimaAtencionConMeds->medicamentos->sortBy('orden') as $m)
                                    <div class="border rounded p-2 mb-2 position-relative">
                                        <div class="fw-semibold mb-1">
                                            {{ $m->nombre_generico }} @if($m->presentacion)<span class="text-muted">— {{ $m->presentacion }}</span>@endif
                                        </div>
                                        @if($m->posologia)
                                            <div class="text-muted"><span class="fw-medium">Posología:</span> {{ $m->posologia }}</div>
                                        @endif
                                        @if($m->frecuencia)
                                            <div class="text-muted"><span class="fw-medium">Frecuencia:</span> {{ $m->frecuencia }}</div>
                                        @endif
                                        @if($m->duracion)
                                            <div class="text-muted"><span class="fw-medium">Duración:</span> {{ $m->duracion }}</div>
                                        @endif
                                    </div>
                                @endforeach
                                @if($ultimaAtencionConMeds->medicamentos->isEmpty())
                                    <div class="text-muted fst-italic">No hay medicamentos registrados.</div>
                                @endif
                            </div>
                            <div class="mt-3">
                                <a href="{{ route('atenciones.paciente.receta', $ultimaAtencionConMeds) }}" class="btn btn-sm btn-atencion-meds">
                                    <i class="fas fa-prescription-bottle-alt me-1"></i> Ver receta completa
                                </a>
                            </div>
                        </div>
                        <span class="position-absolute top-0 end-0 p-2 text-info">
                            <i class="fas fa-briefcase-medical"></i>
                        </span>
                    </div>
                @endif
            </div>
        </div>
    </div>
</x-app-layout>