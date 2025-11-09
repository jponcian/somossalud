<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">Nueva cita</h2>
    </x-slot>

    <div class="container py-4">
        <style>
            /* Estilo elegante para el bloque de disponibilidad */
            .ss-cal{background:#fff;border:1px solid rgba(0,0,0,.08);box-shadow:0 .25rem .75rem rgba(0,0,0,.04);border-left:.35rem solid var(--bs-primary);}
            #cal-rango{font-weight:600;color:#495057}
            /* Cuadros de día más compactos y estilizados */
            .ss-day{border-radius:.5rem;background:#fff;border:1px solid var(--bs-border-color);transition:.15s ease}
            .ss-day:hover{transform:translateY(-1px);box-shadow:0 .25rem .5rem rgba(0,0,0,.06)}
            .ss-day.active,.ss-day:focus{background:var(--bs-primary-bg-subtle);border-color:var(--bs-primary);color:var(--bs-primary)}
            .ss-day:disabled{background:#f8f9fa!important;color:#adb5bd!important;border-color:#e9ecef!important}
            /* Wrapper general del formulario cita */
            .ss-cita-wrapper{background:#ffffff; border:1px solid rgba(0,0,0,.06); box-shadow:0 .75rem 1.5rem -0.5rem rgba(0,0,0,.06); border-radius:1rem;}
            .ss-cita-header{display:flex; align-items:center; gap:.75rem; margin-bottom:1rem;}
            .ss-cita-header .ss-icon{width:42px; height:42px; display:flex; align-items:center; justify-content:center; background:var(--bs-primary-bg-subtle); color:var(--bs-primary); border-radius:.75rem; box-shadow:0 .25rem .5rem rgba(0,0,0,.08);}
            .ss-section-title{font-size:1.05rem; font-weight:600; letter-spacing:.5px; color:#343a40; margin:0;}
            .ss-divider{height:1px; background:linear-gradient(90deg,rgba(0,0,0,.08),rgba(0,0,0,.02)); margin:1rem 0 .75rem; border:0;}
            .ss-field-group label.form-label{font-weight:400; color:#555;}
            .ss-help{font-size:.7rem; text-transform:uppercase; letter-spacing:1px; font-weight:600; color:#6c757d;}
            .ss-slot-btn.btn.active{background:var(--bs-primary); color:#fff;}
            @media (min-width: 992px){ .ss-cita-wrapper{padding:2.25rem 2rem;} }
            @media (max-width: 991.98px){ .ss-cita-wrapper{padding:1.5rem 1.25rem;} }
        </style>
        <div class="ss-cita-wrapper mb-4">
            <div class="ss-cita-header">
                <div class="ss-icon"><i class="fa-solid fa-calendar-plus fa-lg"></i></div>
                <div>
                    <h1 class="ss-section-title">Agendar nueva cita</h1>
                    <div class="ss-help">Selecciona especialidad, profesional y horario disponible</div>
                </div>
            </div>
            <p class="text-muted mb-0" style="font-size:.9rem">Los horarios mostrados se calculan en tiempo real según disponibilidad configurada y citas existentes. Primero elige la especialidad para listar profesionales.</p>
        </div>
        @if(session('info'))
            <div class="alert alert-info small">{{ session('info') }}</div>
        @endif

        <div class="card shadow-sm border-0 mb-4" style="border-radius:1rem;">
            <div class="card-body pt-4 pb-3">
                <form method="POST" action="{{ route('citas.store') }}" class="row g-3" id="form-cita">
                    @csrf

                    <div class="col-md-4 ss-field-group">
                        <label class="form-label small">Especialidad</label>
                        <select name="especialidad_id" id="especialidad_id" class="form-select form-select-sm @error('especialidad_id') is-invalid @enderror" required>
                            <option value="" selected disabled>Selecciona</option>
                            @foreach($especialidades as $esp)
                                <option value="{{ $esp->id }}" {{ old('especialidad_id') == $esp->id ? 'selected' : '' }}>{{ $esp->nombre }}</option>
                            @endforeach
                        </select>
                        @error('especialidad_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-md-4 ss-field-group">
                        <label class="form-label small">Especialista</label>
                        <select name="especialista_id" id="especialista_id" class="form-select form-select-sm @error('especialista_id') is-invalid @enderror" required disabled>
                            <option value="" selected disabled>Selecciona primero especialidad</option>
                        </select>
                        @error('especialista_id')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-12 ss-field-group">
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <label class="form-label small mb-0">Disponibilidad</label>
                            <div class="btn-group btn-group-sm" role="group" aria-label="Navegación calendario">
                                <button type="button" class="btn btn-outline-secondary" id="cal-prev" disabled><i class="fa-solid fa-chevron-left"></i></button>
                                <button type="button" class="btn btn-outline-secondary" id="cal-next"><i class="fa-solid fa-chevron-right"></i></button>
                            </div>
                        </div>
                        <div class="ss-cal rounded-3 p-2 p-sm-3">
                            <div class="small text-muted mb-2" id="cal-rango"></div>
                            <div class="row row-cols-2 row-cols-sm-4 g-1" id="cal-grid"></div>
                            <div class="d-flex align-items-center gap-3 mt-2 small text-muted">
                                <div class="d-flex align-items-center gap-2"><span class="badge text-bg-primary">&nbsp;</span> Seleccionado</div>
                                <div class="d-flex align-items-center gap-2"><span class="badge border border-primary text-primary">&nbsp;</span> Disponible</div>
                                <div class="d-flex align-items-center gap-2"><span class="badge text-bg-light border">&nbsp;</span> Sin disponibilidad</div>
                            </div>
                        </div>
                    </div>

                    <div class="col-12 ss-field-group">
                        <label class="form-label small">Horas disponibles</label>
                        <div id="slot-list" class="d-flex flex-wrap gap-2"></div>
                        <select name="fecha" id="slot_hora" class="form-select form-select-sm d-none @error('fecha') is-invalid @enderror" required>
                            <option value="" selected disabled>Selecciona hora</option>
                        </select>
                        @error('fecha')<div class="invalid-feedback d-block">{{ $message }}</div>@enderror
                        <div class="form-text small" id="ayuda-slots"></div>
                    </div>

                    <div class="col-12 ss-field-group">
                        <label class="form-label small">Motivo (opcional)</label>
                        <textarea name="motivo" rows="3" class="form-control form-control-sm @error('motivo') is-invalid @enderror" placeholder="Breve descripción">{{ old('motivo') }}</textarea>
                        @error('motivo')<div class="invalid-feedback">{{ $message }}</div>@enderror
                    </div>

                    <div class="col-12 d-flex justify-content-between align-items-center pt-2">
                        <a href="{{ route('citas.index') }}" class="btn btn-outline-secondary btn-sm"><i class="fa-solid fa-arrow-left me-1"></i> Volver</a>
                        <button class="btn btn-primary btn-sm"><i class="fa-solid fa-floppy-disk me-1"></i> Guardar cita</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const espSelect = document.getElementById('especialidad_id');
            const docSelect = document.getElementById('especialista_id');
            let rangoInicio = new Date(); // hoy
            let rangoDias = 12; // 3 filas x 4 columnas
            const slotSelect = document.getElementById('slot_hora');
            const ayudaSlots = document.getElementById('ayuda-slots');
            const calGrid = document.getElementById('cal-grid');
            const calPrev = document.getElementById('cal-prev');
            const calNext = document.getElementById('cal-next');
            const calRango = document.getElementById('cal-rango');
            const slotList = document.getElementById('slot-list');

            function resetSelect(selectEl, placeholder) {
                selectEl.innerHTML = `<option value="" disabled selected>${placeholder}</option>`;
                selectEl.disabled = true;
            }

            espSelect.addEventListener('change', () => {
                resetSelect(docSelect, 'Cargando...');
                resetSelect(slotSelect, 'Selecciona fecha');
                slotList.innerHTML = '';
                ayudaSlots.textContent = '';
                fetch(`{{ route('citas.doctores') }}?especialidad_id=${espSelect.value}`, {credentials:'same-origin'})
                    .then(r => {
                        if(!r.ok) throw new Error('Status '+r.status);
                        return r.json();
                    })
                    .then(json => {
                        if (!json.data || !json.data.length) {
                            resetSelect(docSelect, 'No hay especialistas disponibles');
                            calGrid.innerHTML = '';
                            slotList.innerHTML = '';
                            calRango.textContent = '';
                            return;
                        }
                        docSelect.disabled = false;
                        docSelect.innerHTML = '<option value="" disabled selected>Selecciona</option>';
                        json.data.forEach(d => {
                            const opt = document.createElement('option');
                            opt.value = d.id; opt.textContent = d.nombre;
                            docSelect.appendChild(opt);
                        });
                    })
                    .catch(() => {
                        resetSelect(docSelect, 'Error cargando');
                    });
            });

            function fmtDate(d){ const y=d.getFullYear(); const m=(d.getMonth()+1).toString().padStart(2,'0'); const day=d.getDate().toString().padStart(2,'0'); return `${y}-${m}-${day}`; }
            function fmtDatePretty(d){ const meses=['enero','febrero','marzo','abril','mayo','junio','julio','agosto','septiembre','octubre','noviembre','diciembre']; const day=d.getDate().toString().padStart(2,'0'); return `${day} de ${meses[d.getMonth()]} de ${d.getFullYear()}`; }
            function sumarDias(base, n){ const d=new Date(base); d.setDate(d.getDate()+n); return d; }

            function renderRango(){ const fin = sumarDias(rangoInicio, rangoDias-1); calRango.textContent = `Del ${fmtDatePretty(rangoInicio)} al ${fmtDatePretty(fin)}`; }

            function cargarDias(){
                if(!docSelect.value){ calGrid.innerHTML=''; return; }
                renderRango();
                calGrid.innerHTML = '<div class="col text-center text-muted small">Cargando...</div>';
                fetch(`{{ route('citas.dias') }}?especialista_id=${docSelect.value}&dias=${rangoDias}`, {credentials:'same-origin'})
                    .then(r => { if(!r.ok) throw new Error(); return r.json(); })
                    .then(json => {
                        calGrid.innerHTML = '';
                        // Construir mapa fecha->slots
                        const map = new Map();
                        (json.data||[]).forEach(it => map.set(it.fecha, it.slots));
                        for(let i=0;i<rangoDias;i++){
                            const d = sumarDias(rangoInicio, i);
                            const f = fmtDate(d);
                            const slots = map.get(f) || 0;
                            const disabled = slots===0;
                            const card = document.createElement('div');
                            card.className = 'col';
                            card.innerHTML = `
                                <button type="button" class="w-100 btn btn-sm py-1 px-2 ss-day ${disabled?'btn-outline-light text-muted border':''} ${!disabled?'btn-outline-primary':''}" style="line-height:1.1; font-size:.85rem" data-fecha="${f}" ${disabled?'disabled':''}>
                                    <div class="small text-muted mb-0">${d.toLocaleDateString('es-VE',{weekday:'short'})}</div>
                                    <div class="fw-semibold" style="font-size:.95rem">${d.getDate().toString().padStart(2,'0')}</div>
                                </button>`;
                            calGrid.appendChild(card);
                        }
                        // Attach click handlers
                        [...calGrid.querySelectorAll('button[data-fecha]')].forEach(btn => {
                            btn.addEventListener('click', () => {
                                calGrid.querySelectorAll('button').forEach(b=>b.classList.remove('active'));
                                btn.classList.add('active');
                                cargarSlots(btn.dataset.fecha);
                            });
                        });
                    })
                    .catch(()=>{ calGrid.innerHTML = '<div class="col text-center text-danger small">Error cargando días.</div>'; });
            }

            function cargarSlots(fecha){
                resetSelect(slotSelect, 'Selecciona hora');
                slotList.innerHTML = '<span class="text-muted small">Buscando horarios...</span>';
                fetch(`{{ route('citas.slots') }}?especialista_id=${docSelect.value}&fecha=${fecha}`, {credentials:'same-origin'})
                    .then(r=>{ if(!r.ok) throw new Error(); return r.json(); })
                    .then(json=>{
                        slotSelect.disabled = false;
                        slotSelect.innerHTML = '<option value="" disabled selected>Selecciona hora</option>';
                        slotList.innerHTML = '';
                        if(!(json.data||[]).length){
                            slotList.innerHTML = '<span class="text-muted small">No hay horarios disponibles para este día.</span>';
                            return;
                        }
                        json.data.forEach(slot => {
                            const opt = document.createElement('option');
                            opt.value = slot.valor; opt.textContent = slot.hora; // hora ya viene formateada 12h
                            if ('{{ old('fecha') }}' === slot.valor) opt.selected = true;
                            slotSelect.appendChild(opt);

                            const btn = document.createElement('button');
                            btn.type = 'button';
                            btn.className = 'btn btn-outline-primary btn-sm ss-slot-btn';
                            btn.textContent = slot.hora; // etiqueta 12h
                            btn.addEventListener('click', () => {
                                // marcar selección visual
                                slotList.querySelectorAll('button').forEach(b=>b.classList.remove('active'));
                                btn.classList.add('active');
                                // setear select
                                slotSelect.value = slot.valor;
                            });
                            slotList.appendChild(btn);
                        });
                    })
                    .catch(()=>{ slotList.innerHTML = '<span class="text-danger small">Error obteniendo horarios.</span>'; });
            }

            docSelect.addEventListener('change', () => {
                rangoInicio = new Date();
                calPrev.disabled = true; // no permitir ir al pasado
                cargarDias();
                ayudaSlots.textContent = 'Selecciona un día y luego una hora.';
            });

            calNext.addEventListener('click', ()=>{ rangoInicio = sumarDias(rangoInicio, 12); calPrev.disabled = false; cargarDias(); });
            calPrev.addEventListener('click', ()=>{ rangoInicio = sumarDias(rangoInicio, -12); if (rangoInicio <= new Date()) { rangoInicio = new Date(); calPrev.disabled = true; } cargarDias(); });

            // Inicializa rango visible
            renderRango();
        });
    </script>
</x-app-layout>
