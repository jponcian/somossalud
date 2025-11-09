<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">Detalle de la cita</h2>
    </x-slot>

    <div class="container py-4">
    <h1 class="h4 mb-4 d-flex align-items-center gap-2"><i class="fa-solid fa-calendar-check text-primary"></i> Detalle de la cita</h1>

        <div class="card shadow-sm mb-4">
            <div class="card-body">
                <div class="row g-3">
                    <div class="col-md-4">
                        <div class="text-muted small">Fecha y hora</div>
                        <div class="fw-semibold">{{ \Illuminate\Support\Carbon::parse($cita->fecha)->format('d/m/Y H:i') }}</div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-muted small">Estado</div>
                        <div><span class="badge text-bg-secondary">{{ ucfirst($cita->estado) }}</span></div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-muted small">Clínica</div>
                        <div class="fw-medium">{{ optional($cita->clinica)->nombre ?? '—' }}</div>
                    </div>
                    <div class="col-md-4">
                        <div class="text-muted small">Especialista</div>
                        <div class="fw-medium">{{ optional($cita->especialista)->name ?? '—' }}</div>
                    </div>
                </div>
                <div class="mt-3 d-flex justify-content-between">
                    <a href="{{ route('citas.index') }}" class="btn btn-outline-secondary btn-sm"><i class="fa-solid fa-arrow-left me-1"></i> Volver</a>
                    <form action="{{ route('citas.cancelar', $cita) }}" method="POST" onsubmit="return confirm('¿Cancelar esta cita?');">
                        @csrf
                        <button class="btn btn-outline-danger btn-sm" @disabled($cita->estado==='cancelada') title="Cancelar"><i class="fa-solid fa-ban"></i></button>
                    </form>
                </div>
            </div>
        </div>

        @php($yo = auth()->user())
        @if(($yo->id === $cita->especialista_id) || $yo->hasRole(['super-admin','admin_clinica']))
            <div class="card shadow-sm">
                <div class="card-body">
                    <h2 class="h6 mb-3 d-flex align-items-center gap-2"><i class="fa-solid fa-stethoscope text-primary"></i> Gestión de la consulta</h2>
                    @if(session('success'))
                        <div class="alert alert-success small py-2 mb-3">{{ session('success') }}</div>
                    @endif
                    <form action="{{ route('citas.gestion', $cita) }}" method="POST" enctype="multipart/form-data" class="small" id="form-gestion-cita">
                        @csrf
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Diagnóstico *</label>
                            <textarea name="diagnostico" class="form-control form-control-sm" rows="2" required>{{ old('diagnostico', $cita->diagnostico) }}</textarea>
                            @error('diagnostico')<div class="text-danger small">{{ $message }}</div>@enderror
                        </div>
                        {{-- Tratamiento explícito removido: se infiere de los medicamentos registrados --}}
                        <div class="mb-3">
                            <label class="form-label fw-semibold d-flex align-items-center gap-2">Medicamentos estructurados <span class="badge text-bg-light">Máx 10</span></label>
                            <div id="medicamentos-wrapper" class="d-grid gap-3">
                                @php($oldMeds = old('medicamentos', $cita->medicamentos->map(fn($m)=>[
                                    'nombre_generico'=>$m->nombre_generico,
                                    'presentacion'=>$m->presentacion,
                                    'posologia'=>$m->posologia,
                                    'frecuencia'=>$m->frecuencia,
                                    'duracion'=>$m->duracion,
                                ])->toArray()))
                                @forelse($oldMeds as $idx => $med)
                                    <div class="border rounded p-2 position-relative bg-light medicamento-item">
                                        <button type="button" class="btn-close position-absolute top-0 end-0 small text-danger remove-med" aria-label="Eliminar" style="font-size:.6rem"></button>
                                        <div class="row g-2">
                                            <div class="col-md-6">
                                                <input type="text" name="medicamentos[{{ $idx }}][nombre_generico]" class="form-control form-control-sm" placeholder="Medicamento (nombre + presentación)" value="{{ trim(($med['nombre_generico'] ?? '') . ' ' . ($med['presentacion'] ?? '')) }}">
                                            </div>
                                            <div class="col-md-3">
                                                <input type="text" name="medicamentos[{{ $idx }}][posologia]" class="form-control form-control-sm" placeholder="Posología" value="{{ $med['posologia'] ?? '' }}">
                                            </div>
                                            <div class="col-md-2">
                                                <input type="text" name="medicamentos[{{ $idx }}][frecuencia]" class="form-control form-control-sm" placeholder="Frecuencia" value="{{ $med['frecuencia'] ?? '' }}">
                                            </div>
                                            <div class="col-md-1">
                                                <input type="text" name="medicamentos[{{ $idx }}][duracion]" class="form-control form-control-sm" placeholder="Duración" value="{{ $med['duracion'] ?? '' }}">
                                            </div>
                                        </div>
                                    </div>
                                @empty
                                @endforelse
                            </div>
                            <div class="mt-2">
                                <button type="button" class="btn btn-outline-primary btn-sm" id="btn-add-med"><i class="fa-solid fa-plus me-1"></i> Añadir medicamento</button>
                            </div>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Observaciones</label>
                            <textarea name="observaciones" class="form-control form-control-sm" rows="2">{{ old('observaciones', $cita->observaciones) }}</textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label fw-semibold">Adjuntos (imágenes / PDF)</label>
                            <input type="file" name="adjuntos[]" class="form-control form-control-sm" accept="image/*,application/pdf" multiple>
                            <div class="form-text">Máx 6 archivos, 5MB c/u.</div>
                        </div>
                        @if($cita->adjuntos()->exists())
                            <div class="mb-3">
                                <div class="text-muted small mb-1">Archivos existentes</div>
                                <div class="d-flex flex-wrap gap-2">
                                    @foreach($cita->adjuntos as $adj)
                                        <a href="{{ Storage::disk('public')->url($adj->ruta) }}" target="_blank" class="badge text-bg-light text-decoration-none">{{ $adj->nombre_original ?? basename($adj->ruta) }}</a>
                                    @endforeach
                                </div>
                            </div>
                        @endif
                        <div class="form-check form-switch mb-3">
                            <input class="form-check-input" type="checkbox" role="switch" id="concluirSwitch" name="concluir" value="1" @checked($cita->estado==='concluida')>
                            <label class="form-check-label small" for="concluirSwitch">Marcar cita como concluida</label>
                        </div>
                        <div class="d-flex justify-content-end gap-2">
                            <button class="btn btn-primary btn-sm"><i class="fa-solid fa-floppy-disk me-1"></i> Guardar gestión</button>
                            @if($cita->medicamentos()->exists())
                                <a href="{{ route('citas.receta', $cita) }}" class="btn btn-outline-primary btn-sm"><i class="fa-solid fa-prescription-bottle-med me-1"></i> Ver receta</a>
                            @endif
                        </div>
                    </form>
                </div>
            </div>
        @else
            @if($cita->medicamentos()->exists())
                <div class="mt-4">
                    <a href="{{ route('citas.receta', $cita) }}" class="btn btn-outline-primary btn-sm"><i class="fa-solid fa-prescription-bottle-med me-1"></i> Ver receta</a>
                </div>
            @endif
        @endif
    </div>
</x-app-layout>

@push('scripts')
<script>
(function(){
    const wrapper = document.getElementById('medicamentos-wrapper');
    if(!wrapper) return;
    const btnAdd = document.getElementById('btn-add-med');
    function currentCount(){ return wrapper.querySelectorAll('.medicamento-item').length; }
    btnAdd.addEventListener('click', () => {
        if(currentCount() >= 10) return alert('Máximo 10 medicamentos');
        const idx = Date.now();
        const div = document.createElement('div');
            div.className = 'border rounded p-2 position-relative bg-light medicamento-item';
            div.innerHTML = \`
                <button type="button" class="btn-close position-absolute top-0 end-0 small text-danger remove-med" aria-label="Eliminar" style="font-size:.6rem"></button>
                <div class="row g-2">
                    <div class="col-md-6">
                        <input type="text" name="medicamentos[\${idx}][nombre_generico]" class="form-control form-control-sm" placeholder="Medicamento (nombre + presentación)">
                    </div>
                    <div class="col-md-3">
                        <input type="text" name="medicamentos[\${idx}][posologia]" class="form-control form-control-sm" placeholder="Posología">
                    </div>
                    <div class="col-md-2">
                        <input type="text" name="medicamentos[\${idx}][frecuencia]" class="form-control form-control-sm" placeholder="Frecuencia">
                    </div>
                    <div class="col-md-1">
                        <input type="text" name="medicamentos[\${idx}][duracion]" class="form-control form-control-sm" placeholder="Duración">
                    </div>
                </div>\`;
        wrapper.appendChild(div);
    });
    wrapper.addEventListener('click', e => {
        if(e.target.classList.contains('remove-med')){
            e.target.closest('.medicamento-item').remove();
        }
    });
})();
</script>
@endpush
