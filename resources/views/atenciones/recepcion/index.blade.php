@extends('layouts.adminlte')

@section('title','Atenciones | Recepción')

@section('content')
<div class="row">
    <div class="col-md-5">
        <div class="card shadow-sm">
            <div class="card-body">
                <h5 class="mb-3">Nueva atención (seguro)</h5>
                <form method="POST" action="{{ route('atenciones.store') }}">
                    @csrf
                    <div class="form-group position-relative">
                        <label class="small">Paciente</label>
                        <input type="hidden" name="paciente_id" id="paciente_id" required>
                        <input type="text" id="buscar_paciente" class="form-control form-control-sm" placeholder="Buscar por nombre o correo">
                    <div id="lista_pacientes" class="list-group position-absolute w-100"
                        style="z-index:2000; top:100%; left:0; max-height:240px; overflow-y:auto; display:none; border:1px solid #ddd; border-top:none; box-shadow:0 4px 12px rgba(0,0,0,.08);"></div>
                    </div>
                    {{-- Clínica fija por contrato (ID 1). Se omite selección aquí. --}}
                    <div class="form-row mt-2">
                        <div class="form-group col-md-6">
                            <label class="small">Aseguradora</label>
                            <input type="text" name="aseguradora" class="form-control form-control-sm">
                        </div>
                        <div class="form-group col-md-6">
                            <label class="small">Póliza / N° Seguro</label>
                            <input type="text" name="numero_seguro" class="form-control form-control-sm" placeholder="Ej: Póliza 123 o N° 0414-...">
                        </div>
                    </div>
                    {{-- La especialidad la definirá el médico en consulta. --}}
                    <div class="form-group mt-2 position-relative">
                        <label class="small">Asignar médico (opcional)</label>
                        <input type="hidden" name="medico_id" id="medico_id">
                        <input type="text" id="buscar_medico" class="form-control form-control-sm" placeholder="Buscar por nombre">
                    <div id="lista_medicos" class="list-group position-absolute w-100"
                        style="z-index:2000; top:100%; left:0; max-height:240px; overflow-y:auto; display:none; border:1px solid #ddd; border-top:none; box-shadow:0 4px 12px rgba(0,0,0,.08);"></div>
                    </div>
                    <div class="form-group form-check mt-2">
                        <input type="checkbox" class="form-check-input" id="seguro_validado" name="seguro_validado" value="1" checked>
                        <label class="form-check-label" for="seguro_validado">Seguro validado</label>
                    </div>
                    <div class="mt-3">
                        <button class="btn btn-primary btn-sm" type="submit">Crear atención</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-7">
        <div class="card shadow-sm">
            <div class="card-body">
                <h5 class="mb-3 d-flex justify-content-between align-items-center">
                    <span>Atenciones recientes</span>
                    <form method="GET" action="{{ route('atenciones.index') }}" class="form-inline d-flex gap-2 small">
                        @php($mapEstados = [
                            'validado' => ['label'=>'Validada','class'=>'badge-info'],
                            'en_consulta' => ['label'=>'En proceso','class'=>'badge-warning'],
                            'cerrado' => ['label'=>'Cerrada','class'=>'badge-success'],
                        ])
                        <select name="estado" class="form-control form-control-sm mr-1" onchange="this.form.submit()">
                            <option value="">Estado</option>
                            @foreach($mapEstados as $k=>$v)
                                <option value="{{ $k }}" {{ request('estado')===$k?'selected':'' }}>{{ $v['label'] }}</option>
                            @endforeach
                        </select>
                        <input type="number" name="medico_id" value="{{ request('medico_id') }}" class="form-control form-control-sm mr-1 d-none" placeholder="ID médico">
                        <input type="number" name="paciente_id" value="{{ request('paciente_id') }}" class="form-control form-control-sm mr-1 d-none" placeholder="ID paciente">
                        <button class="btn btn-outline-secondary btn-sm" type="submit">Filtrar</button>
                    </form>
                </h5>
                <div class="table-responsive mb-2">
                    <table class="table table-sm table-striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Paciente</th>
                                <th>Seguro</th>
                                <th>Estado</th>
                                <th>Médico</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                        @forelse($atenciones as $a)
                            <tr>
                                <td>#{{ $a->id }}</td>
                                <td>{{ optional($a->paciente)->name ?? '—' }}</td>
                                <td>
                                    @if($a->seguro_validado)
                                        <span class="badge badge-success">Validado</span>
                                    @else
                                        <span class="badge badge-secondary">Pendiente</span>
                                    @endif
                                    @if($a->aseguradora)
                                        <div class="small text-muted">{{ $a->aseguradora }} @if($a->numero_seguro) • {{ $a->numero_seguro }} @endif</div>
                                    @endif
                                </td>
                                <td>
                                    @php($infoEstado = $mapEstados[$a->estado] ?? ['label'=>ucfirst($a->estado),'class'=>'badge-light'])
                                    <span class="badge {{ $infoEstado['class'] }}">{{ $infoEstado['label'] }}</span>
                                </td>
                                <td>{{ optional($a->medico)->name ?? 'Sin asignar' }}</td>
                                <td class="text-right">
                                    @if(!$a->medico_id && $a->estado!=='cerrado')
                                    <form method="POST" action="{{ route('atenciones.asignar', $a) }}" class="d-inline-flex align-items-center">
                                        @csrf
                                        <input type="hidden" name="medico_id" id="medico_id_row_{{ $a->id }}">
                                        <div class="position-relative mr-2" style="width:180px">
                                            <input type="text" id="buscar_medico_row_{{ $a->id }}" class="form-control form-control-sm" placeholder="Buscar médico">
                                    <div id="lista_medicos_row_{{ $a->id }}" class="list-group position-absolute w-100"
                                        style="z-index:2000; top:100%; left:0; max-height:240px; overflow-y:auto; display:none; border:1px solid #ddd; border-top:none; box-shadow:0 4px 12px rgba(0,0,0,.08);"></div>
                                        </div>
                                        <button class="btn btn-outline-secondary btn-sm" type="submit">Asignar</button>
                                    </form>
                                    @endif
                                    @if($a->estado!=='cerrado')
                                        <form method="POST" action="{{ route('atenciones.cerrar', $a) }}" class="d-inline">
                                            @csrf
                                            <button class="btn btn-outline-danger btn-sm btn-cerrar-atencion" type="submit" data-id="{{ $a->id }}">Cerrar</button>
                                        </form>
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr><td colspan="5" class="text-center text-muted small">Sin registros</td></tr>
                        @endforelse
                        </tbody>
                    </table>
                </div>
                <div class="d-flex justify-content-center">
                    {{ $atenciones->links() }}
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('scripts')
<script>
(function(){
    function setupAutocomplete(inputId, listId, hiddenId, url, labelFn, opts={}){
        const $input = document.getElementById(inputId);
        const $list = document.getElementById(listId);
        const $hidden = document.getElementById(hiddenId);
        const floating = !!opts.floating; // si true, mover la lista al body para evitar recortes en tablas
        let controller = null;
        function hide(){
            $list.style.display='none';
            $list.innerHTML='';
        }
        $input.addEventListener('input', async () => {
            const q = $input.value.trim();
            if(q.length < 2){ hide(); return; }
            if(controller) controller.abort();
            controller = new AbortController();
            try{
                const res = await fetch(url+`?q=${encodeURIComponent(q)}`, {signal: controller.signal});
                const json = await res.json();
                const items = json.data || [];
                if(!items.length){ hide(); return; }
                $list.innerHTML = items.map(it=>`<button type="button" class="list-group-item list-group-item-action" data-id="${it.id}">${labelFn(it)}</button>`).join('');
                if(floating){
                    const rect = $input.getBoundingClientRect();
                    $list.style.position = 'absolute';
                    $list.style.top = (rect.bottom + window.scrollY) + 'px';
                    $list.style.left = (rect.left + window.scrollX) + 'px';
                    $list.style.width = rect.width + 'px';
                    $list.style.zIndex = 5000;
                    if($list.parentElement !== document.body){
                        document.body.appendChild($list);
                    }
                }
                $list.style.display='block';
            }catch(e){ /* abort/silencio */ }
        });
        $list.addEventListener('click', e => {
            const btn = e.target.closest('button[data-id]');
            if(!btn) return;
            const id = btn.getAttribute('data-id');
            const text = btn.textContent.trim();
            $hidden.value = id; $input.value = text; hide();
        });
        document.addEventListener('click', e => { if(!e.target.closest('#'+listId) && !e.target.closest('#'+inputId)) hide(); });
        if(floating){
            window.addEventListener('scroll', hide, {passive:true});
            window.addEventListener('resize', hide);
        }
    }
    setupAutocomplete('buscar_paciente','lista_pacientes','paciente_id','{{ route('ajax.pacientes') }}', it => `${it.nombre} <span class="text-muted small">(${it.email ?? ''})</span>`);
    setupAutocomplete('buscar_medico','lista_medicos','medico_id','{{ route('ajax.medicos') }}', it => it.nombre);

    // Autocomplete dinámico para cada fila (asignar médico)
    document.querySelectorAll('[id^="buscar_medico_row_"]').forEach(inp => {
        const id = inp.id.replace('buscar_medico_row_','');
        setupAutocomplete(inp.id, 'lista_medicos_row_'+id, 'medico_id_row_'+id, '{{ route('ajax.medicos') }}', it => it.nombre, {floating:true});
    });
})();

// Confirmación SweetAlert2 al cerrar atención desde recepción
(function(){
    function ensureSwal(cb){
        if(window.Swal) return cb();
        const s=document.createElement('script'); s.src='https://cdn.jsdelivr.net/npm/sweetalert2@11'; s.onload=cb; document.head.appendChild(s);
    }
    document.querySelectorAll('.btn-cerrar-atencion').forEach(btn => {
        btn.addEventListener('click', function(e){
            e.preventDefault();
            const form = this.closest('form');
            ensureSwal(()=>{
                Swal.fire({
                    title: 'Cerrar atención',
                    text: '¿Confirmas que deseas cerrar esta atención? No se podrá seguir gestionando.',
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonText: 'Sí, cerrar',
                    cancelButtonText: 'Cancelar',
                    confirmButtonColor: '#d33'
                }).then(r => { if(r.isConfirmed) form.submit(); });
            });
        });
    });
})();
</script>
@endpush
