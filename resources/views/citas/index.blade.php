<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">Consultas y atenciones</h2>
    </x-slot>

    <div class="container py-4">
        {{-- <h1 class="h4 mb-4">Citas médicas</h1> --}}
        @if(session('success'))
            <div class="alert alert-success small mb-3">{{ session('success') }}</div>
        @endif

        <div class="mb-3 d-flex justify-content-between align-items-center flex-wrap gap-2">
            <p class="text-muted small mb-0">Agenda nuevas consultas, confirma fechas y revisa tus atenciones por seguro.</p>
            <a href="{{ route('citas.create') }}" class="btn btn-sm btn-primary"><i class="fa-solid fa-calendar-plus me-1"></i> Nueva cita</a>
        </div>

        <div class="card shadow-sm">
            <div class="card-body p-0">
                @if(isset($items))
                    <table class="table table-sm mb-0">
                        <thead class="table-light">
                            <tr class="small text-uppercase text-muted">
                                <th>Fecha / Hora</th>
                                <th>Tipo</th>
                                <th>Estado</th>
                                <th>Especialista</th>
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        @forelse($items as $row)
                            @php
                                $__fecha = \Illuminate\Support\Carbon::parse($row['momento'])->format('d/m/Y');
                                $__hora = str_replace(' ', '', \Illuminate\Support\Carbon::parse($row['momento'])->format('h:i a'));
                                $tipo = $row['tipo'];
                                $estado = $row['estado'];
                                $badge = $tipo==='cita'
                                    ? match($estado){ 'pendiente'=>'secondary','confirmada'=>'success','cancelada'=>'danger','concluida'=>'primary', default=>'light' }
                                    : match($estado){ 'validado'=>'info','en_consulta'=>'warning','cerrado'=>'success', default=>'light' };
                            @endphp
                            <tr class="align-middle">
                                <td class="small">{{ $__fecha }} {{ $__hora }}</td>
                                <td class="small">
                                    <span class="badge text-bg-light text-muted">{{ $tipo==='cita' ? 'Cita' : 'Atención' }}</span>
                                </td>
                                <td class="small"><span class="badge text-bg-{{ $badge }}">{{ $tipo==='cita' ? ucfirst($estado) : ($estado==='validado'?'Validada':($estado==='en_consulta'?'En proceso':($estado==='cerrado'?'Cerrada':ucfirst($estado)))) }}</span></td>
                                <td class="small">{{ $row['especialista'] ?? '—' }}</td>
                                <td class="text-end">
                                    @if($tipo==='cita')
                                        <a href="{{ route('citas.show', $row['id']) }}" class="btn btn-outline-secondary btn-sm" title="Ver detalle"><i class="fa-solid fa-eye"></i></a>
                                        @if($row['tiene_meds'])
                                            <a href="{{ route('citas.receta', $row['id']) }}" class="btn btn-outline-success btn-sm" title="Receta"><i class="fas fa-prescription-bottle-alt"></i></a>
                                        @endif
                                        @if(!in_array($estado, ['cancelada','concluida']))
                                            <form action="{{ route('citas.cancelar', $row['id']) }}" method="POST" class="d-inline js-cancel-cita" data-cita-id="{{ $row['id'] }}">
                                                @csrf
                                                <button type="submit" class="btn btn-outline-danger btn-sm" title="Cancelar">
                                                    <i class="fa-solid fa-ban"></i>
                                                </button>
                                            </form>
                                        @endif
                                    @else
                                        @if($estado==='cerrado')
                                            <a href="{{ route('atenciones.paciente.show', $row['id']) }}" class="btn btn-outline-secondary btn-sm" title="Ver detalle"><i class="fa-solid fa-eye"></i></a>
                                        @endif
                                        @if($row['tiene_meds'])
                                            <a href="{{ route('atenciones.paciente.receta', $row['id']) }}" class="btn btn-outline-success btn-sm" title="Receta"><i class="fas fa-prescription-bottle-alt"></i></a>
                                        @endif
                                        @if($estado!=='cerrado' && !$row['tiene_meds'])
                                            <span class="text-muted small">En curso</span>
                                        @endif
                                    @endif
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center py-4 small text-muted">Aún no tienes consultas ni atenciones registradas.</td>
                            </tr>
                        @endforelse
                        </tbody>
                    </table>
                @else
                    <table class="table table-sm mb-0">
                        <thead class="table-light">
                            <tr class="small text-uppercase text-muted">
                                <th>Fecha / Hora</th>
                                <th>Estado</th>
                                <th>Especialista</th>
                                <th class="text-end">Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                        @forelse($citas as $cita)
                            <tr class="align-middle">
                                <td class="small">
                                    @php
                                        $__f = \Illuminate\Support\Carbon::parse($cita->fecha);
                                        $__fecha = $__f->format('d/m/Y');
                                        $__hora = str_replace(' ', '', $__f->format('h:i a'));
                                    @endphp
                                    {{ $__fecha }} {{ $__hora }}
                                </td>
                                <td class="small">
                                    @php $badge = match($cita->estado){
                                        'pendiente' => 'secondary',
                                        'confirmada' => 'success',
                                        'cancelada' => 'danger',
                                        default => 'light'
                                    }; @endphp
                                    <span class="badge text-bg-{{ $badge }}">{{ ucfirst($cita->estado) }}</span>
                                </td>
                                <td class="small">{{ optional($cita->especialista)->name ?? '—' }}</td>
                                <td class="text-end">
                                    <a href="{{ route('citas.show', $cita) }}" class="btn btn-outline-secondary btn-sm" title="Ver detalle"><i class="fa-solid fa-eye"></i></a>
                                    @if($cita->medicamentos()->exists())
                                        <a href="{{ route('citas.receta', $cita) }}" class="btn btn-outline-success btn-sm" title="Receta"><i class="fas fa-prescription-bottle-alt"></i></a>
                                    @endif
                                    <form action="{{ route('citas.cancelar', $cita) }}" method="POST" class="d-inline" onsubmit="return confirm('¿Cancelar esta cita?');">
                                        @csrf
                                        <button class="btn btn-outline-danger btn-sm" @disabled($cita->estado==='cancelada') title="Cancelar">
                                            <i class="fa-solid fa-ban"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="4" class="text-center py-4 small text-muted">No tienes citas registradas todavía.</td>
                            </tr>
                        @endforelse
                        </tbody>
                    </table>
                @endif
            </div>
        </div>
    </div>
</x-app-layout>

<script>
// Cargar SweetAlert2 bajo demanda si no está disponible
(function(){
    function bindCancelHandlers(){
        document.querySelectorAll('form.js-cancel-cita').forEach(function(form){
            if(form._boundSwal) return; // evitar doble binding
            form._boundSwal = true;
            form.addEventListener('submit', function(e){
                if(window.Swal){
                    e.preventDefault();
                    Swal.fire({
                        title: '¿Cancelar esta cita?',
                        text: 'Esta acción no se puede revertir. Se notificará al especialista si aplica.',
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonText: 'Sí, cancelar',
                        cancelButtonText: 'No',
                        confirmButtonColor: '#d33',
                    }).then(function(result){
                        if(result.isConfirmed){ form.submit(); }
                    });
                } else {
                    // Fallback nativo si no carga SweetAlert
                    if(!confirm('¿Cancelar esta cita?')){ e.preventDefault(); }
                }
            });
        });
    }
    if(!window.Swal){
        var s=document.createElement('script');
        s.src='https://cdn.jsdelivr.net/npm/sweetalert2@11';
        s.onload = bindCancelHandlers;
        document.head.appendChild(s);
    } else {
        bindCancelHandlers();
    }
})();
</script>
