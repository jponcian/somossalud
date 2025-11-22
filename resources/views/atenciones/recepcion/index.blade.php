@extends('layouts.adminlte')

@section('title','Atenciones | Recepción')

@section('content')
<div class="row">
    <div class="col-md-5">
        <div class="card shadow-sm border-0 rounded-lg overflow-hidden h-100">
            <div class="card-header border-0" style="background: linear-gradient(135deg, #dbeafe 0%, #dcfce7 100%); border-bottom: 1px solid #cbd5e1;">
                <h3 class="card-title font-weight-bold text-primary mb-0">
                    <i class="fas fa-plus-circle mr-2"></i> Nueva atención
                </h3>
            </div>
            <div class="card-body">
                <form method="POST" action="{{ route('atenciones.store') }}">
                    @csrf
                    <div class="form-group position-relative">
                        <label class="small font-weight-bold text-uppercase text-muted">Paciente</label>
                        <input type="hidden" name="paciente_id" id="paciente_id" required>
                        <div class="input-group input-group-sm">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-light border-0"><i class="fas fa-user text-muted"></i></span>
                            </div>
                            <input type="text" id="buscar_paciente" class="form-control bg-light border-0" placeholder="Buscar por nombre o correo">
                        </div>
                        <div id="lista_pacientes" class="list-group position-absolute w-100"
                            style="z-index:2000; top:100%; left:0; max-height:240px; overflow-y:auto; display:none; border:1px solid #ddd; border-top:none; box-shadow:0 4px 12px rgba(0,0,0,.08);"></div>
                    </div>

                    <div class="form-row mt-3">
                        <div class="form-group col-md-6">
                            <label class="small font-weight-bold text-uppercase text-muted">Aseguradora</label>
                            <input type="text" name="aseguradora" class="form-control form-control-sm bg-light border-0">
                        </div>
                        <div class="form-group col-md-6">
                            <label class="small font-weight-bold text-uppercase text-muted">Póliza / N° Seguro</label>
                            <input type="text" name="numero_seguro" class="form-control form-control-sm bg-light border-0" placeholder="Ej: Póliza 123">
                        </div>
                    </div>

                    <div class="form-group mt-3 position-relative">
                        <label class="small font-weight-bold text-uppercase text-muted">Asignar médico (opcional)</label>
                        <input type="hidden" name="medico_id" id="medico_id">
                        <div class="input-group input-group-sm">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-light border-0"><i class="fas fa-user-md text-muted"></i></span>
                            </div>
                            <input type="text" id="buscar_medico" class="form-control bg-light border-0" placeholder="Buscar por nombre">
                        </div>
                        <div id="lista_medicos" class="list-group position-absolute w-100"
                            style="z-index:2000; top:100%; left:0; max-height:240px; overflow-y:auto; display:none; border:1px solid #ddd; border-top:none; box-shadow:0 4px 12px rgba(0,0,0,.08);"></div>
                    </div>

                    <div class="form-group form-check mt-3">
                        <div class="custom-control custom-switch">
                            <input type="checkbox" class="custom-control-input" id="seguro_validado" name="seguro_validado" value="1" checked>
                            <label class="custom-control-label font-weight-bold text-dark" for="seguro_validado">Seguro validado</label>
                        </div>
                    </div>

                    <div class="mt-4">
                        <button class="btn btn-primary btn-block shadow-sm font-weight-bold" type="submit">
                            <i class="fas fa-save mr-2"></i> Crear atención
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="col-md-7">
        <div class="card shadow-sm border-0 rounded-lg overflow-hidden h-100">
            <div class="card-header border-0 d-flex justify-content-between align-items-center" style="background: linear-gradient(135deg, #dbeafe 0%, #dcfce7 100%); border-bottom: 1px solid #cbd5e1;">
                <h3 class="card-title font-weight-bold text-primary mb-0">
                    <i class="fas fa-list-ul mr-2"></i> Atenciones recientes
                </h3>
                <form method="GET" action="{{ route('atenciones.index') }}" class="form-inline d-flex gap-2 small">
                    @php
                        $mapEstados = [
                            'validado' => ['label'=>'Validada','class'=>'badge-info'],
                            'en_consulta' => ['label'=>'En proceso','class'=>'badge-warning'],
                            'cerrado' => ['label'=>'Cerrada','class'=>'badge-success'],
                        ];
                    @endphp
                    <select name="estado" class="custom-select custom-select-sm border-0 shadow-sm bg-white text-dark font-weight-bold" onchange="this.form.submit()">
                        <option value="">Todos los estados</option>
                        @foreach($mapEstados as $k=>$v)
                            <option value="{{ $k }}" {{ request('estado')===$k?'selected':'' }}>{{ $v['label'] }}</option>
                        @endforeach
                    </select>
                    <input type="number" name="medico_id" value="{{ request('medico_id') }}" class="form-control form-control-sm mr-1 d-none" placeholder="ID médico">
                    <input type="number" name="paciente_id" value="{{ request('paciente_id') }}" class="form-control form-control-sm mr-1 d-none" placeholder="ID paciente">
                </form>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive mb-0">
                    <table class="table table-hover mb-0 align-middle">
                        <thead style="background-color: #f8fafc;">
                            <tr>
                                <th class="border-top-0 text-uppercase text-secondary small font-weight-bold pl-4">ID</th>
                                <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Paciente</th>
                                <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Seguro</th>
                                <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Estado</th>
                                <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Médico</th>
                                <th class="border-top-0"></th>
                            </tr>
                        </thead>
                        <tbody>
                        @forelse($atenciones as $a)
                            <tr>
                                <td class="pl-4 font-weight-bold text-muted">#{{ $a->id }}</td>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <div class="rounded-circle bg-light d-flex align-items-center justify-content-center mr-2 text-primary font-weight-bold" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                            {{ substr(optional($a->paciente)->name ?? '?', 0, 1) }}
                                        </div>
                                        <div class="font-weight-bold text-dark">{{ optional($a->paciente)->name ?? '—' }}</div>
                                    </div>
                                </td>
                                <td>
                                    @if($a->seguro_validado)
                                        <i class="fas fa-check-circle text-success mr-1" title="Validado"></i>
                                    @else
                                        <i class="fas fa-clock text-warning mr-1" title="Pendiente"></i>
                                    @endif
                                    @if($a->aseguradora)
                                        <span class="small text-muted">{{ $a->aseguradora }}</span>
                                    @else
                                        <span class="small text-muted font-italic">Particular</span>
                                    @endif
                                </td>
                                <td>
                                    @php
                                        $infoEstado = $mapEstados[$a->estado] ?? ['label'=>ucfirst($a->estado),'class'=>'badge-light'];
                                        $badgeClass = match($a->estado) {
                                            'validado' => 'badge-info',
                                            'en_consulta' => 'badge-warning',
                                            'cerrado' => 'badge-success',
                                            default => 'badge-secondary'
                                        };
                                    @endphp
                                    <span class="badge {{ $badgeClass }} px-3 py-1 rounded-pill small">
                                        {{ $infoEstado['label'] }}
                                    </span>
                                </td>
                                <td>
                                    @if($a->medico)
                                        <div class="d-flex align-items-center">
                                            <i class="fas fa-user-md text-info mr-2"></i>
                                            <span class="small">{{ $a->medico->name }}</span>
                                        </div>
                                    @else
                                        <span class="text-muted small font-italic">Sin asignar</span>
                                    @endif
                                </td>
                                <td class="text-right pr-4">
                                    @if(!$a->medico_id && $a->estado!=='cerrado')
                                    <form method="POST" action="{{ route('atenciones.asignar', $a) }}" class="d-inline-flex align-items-center">
                                        @csrf
                                        <input type="hidden" name="medico_id" id="medico_id_row_{{ $a->id }}">
                                        <div class="position-relative mr-2" style="width:160px">
                                            <input type="text" id="buscar_medico_row_{{ $a->id }}" class="form-control form-control-sm bg-light border-0 rounded-pill px-3" placeholder="Asignar médico...">
                                            <div id="lista_medicos_row_{{ $a->id }}" class="list-group position-absolute w-100"
                                                style="z-index:2000; top:100%; left:0; max-height:240px; overflow-y:auto; display:none; border:1px solid #ddd; border-top:none; box-shadow:0 4px 12px rgba(0,0,0,.08);"></div>
                                        </div>
                                        <button class="btn btn-light btn-sm rounded-circle shadow-sm text-primary" type="submit" title="Guardar asignación">
                                            <i class="fas fa-save"></i>
                                        </button>
                                    </form>
                                    @endif
                                    @if($a->estado!=='cerrado')
                                        <form method="POST" action="{{ route('atenciones.cerrar', $a) }}" class="d-inline ml-2">
                                            @csrf
                                            <button class="btn btn-light btn-sm rounded-circle shadow-sm text-danger btn-cerrar-atencion" type="submit" data-id="{{ $a->id }}" title="Cerrar atención">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </form>
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr><td colspan="6" class="text-center text-muted py-5">
                                <i class="fas fa-clipboard-list fa-3x mb-3 opacity-50"></i>
                                <p class="mb-0">No hay atenciones registradas</p>
                            </td></tr>
                        @endforelse
                        </tbody>
                    </table>
                </div>
                @if($atenciones->hasPages())
                <div class="d-flex justify-content-center py-3 border-top">
                    {{ $atenciones->links() }}
                </div>
                @endif
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
