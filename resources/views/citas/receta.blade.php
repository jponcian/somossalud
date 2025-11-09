<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">Receta médica</h2>
    </x-slot>
    <div class="container py-4">
        <h1 class="h5 mb-3 d-flex align-items-center gap-2"><i class="fa-solid fa-prescription-bottle-med text-primary"></i> Receta de la cita</h1>
        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <div class="row small mb-3">
                    <div class="col-md-6">
                        <div class="text-muted">Paciente</div>
                        <div class="fw-semibold">{{ optional($cita->usuario)->name }}</div>
                    </div>
                    <div class="col-md-6">
                        <div class="text-muted">Especialista</div>
                        <div class="fw-semibold">{{ optional($cita->especialista)->name }}</div>
                    </div>
                    <div class="col-md-6 mt-3">
                        <div class="text-muted">Fecha de la cita</div>
                        <div class="fw-medium">{{ \Illuminate\Support\Carbon::parse($cita->fecha)->format('d/m/Y H:i') }}</div>
                    </div>
                    <div class="col-md-6 mt-3">
                        <div class="text-muted">Clínica</div>
                        <div class="fw-medium">{{ optional($cita->clinica)->nombre ?? '—' }}</div>
                    </div>
                </div>

                @if($cita->diagnostico)
                    <div class="mb-3">
                        <div class="text-muted small mb-1">Diagnóstico</div>
                        <div class="border rounded p-2 bg-light small" style="white-space:pre-wrap">{{ $cita->diagnostico }}</div>
                    </div>
                @endif

                @if($cita->medicamentos->count())
                    <div class="mb-3">
                        <div class="text-muted small mb-2">Medicamentos prescritos</div>
                        <div class="list-group">
                            @foreach($cita->medicamentos as $m)
                                <div class="list-group-item py-2">
                                    <div class="fw-semibold">Medicamento {{ $loop->iteration }}: {{ $m->nombre_generico }} @if($m->presentacion) <span class="text-muted">— {{ $m->presentacion }}</span>@endif</div>
                                    @if($m->posologia)
                                        <div class="small"><strong>Posología:</strong> {{ $m->posologia }}</div>
                                    @endif
                                    @if($m->frecuencia)
                                        <div class="small"><strong>Frecuencia:</strong> {{ $m->frecuencia }}</div>
                                    @endif
                                    @if($m->duracion)
                                        <div class="small"><strong>Duración:</strong> {{ $m->duracion }}</div>
                                    @endif
                                </div>
                            @endforeach
                        </div>
                    </div>
                @endif

                @if($cita->observaciones)
                    <div class="mb-3">
                        <div class="text-muted small mb-1">Observaciones</div>
                        <div class="border rounded p-2 bg-light small" style="white-space:pre-wrap">{{ $cita->observaciones }}</div>
                    </div>
                @endif

                <div class="d-flex justify-content-between">
                    <a href="{{ route('citas.show', $cita) }}" class="btn btn-outline-secondary btn-sm"><i class="fa-solid fa-arrow-left me-1"></i> Volver</a>
                    @if($cita->medicamentos->count())
                        <button onclick="window.print()" class="btn btn-outline-primary btn-sm"><i class="fa-solid fa-print me-1"></i> Imprimir</button>
                    @endif
                </div>
            </div>
        </div>
    </div>
</x-app-layout>
