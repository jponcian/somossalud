@extends('layouts.adminlte')

@section('title','Mis atenciones | Especialista')

@section('content')
<div class="card shadow-sm">
    <div class="card-header d-flex flex-column flex-md-row justify-content-between align-items-md-center py-2" style="background:linear-gradient(90deg,#f8fafc,#eef6ff);">
        <h5 class="mb-2 mb-md-0 d-flex align-items-center" style="font-weight:600;">
            <i class="fas fa-briefcase-medical text-primary mr-2"></i>
            Mis atenciones asignadas
        </h5>
        <form method="GET" action="{{ route('atenciones.index') }}" class="form-inline small">
            <select name="estado" class="form-control form-control-sm mr-1" onchange="this.form.submit()">
                <option value="">Estado</option>
                @foreach(['validado'=>'Validada','en_consulta'=>'En proceso','cerrado'=>'Cerrada'] as $estado => $label)
                    <option value="{{ $estado }}" {{ request('estado')===$estado?'selected':'' }}>{{ $label }}</option>
                @endforeach
            </select>
            <button class="btn btn-primary btn-sm" type="submit"><i class="fas fa-filter mr-1"></i> Filtrar</button>
        </form>
    </div>
    @php
        $yo = auth()->user();
        $conteosEstados = \App\Models\Atencion::where('medico_id',$yo->id)
            ->selectRaw("estado, count(*) as total")
            ->groupBy('estado')->pluck('total','estado');
        $totalAsignadas = array_sum($conteosEstados->toArray());
    @endphp
    <div class="card-body pt-2">
        <div class="mb-3">
            <div class="small d-flex flex-wrap align-items-center">
                <span class="mr-3">Total: <strong>{{ $totalAsignadas }}</strong></span>
                <span class="mr-3">Validada: <span class="badge badge-info">{{ $conteosEstados['validado'] ?? 0 }}</span></span>
                <span class="mr-3">En proceso: <span class="badge badge-warning">{{ $conteosEstados['en_consulta'] ?? 0 }}</span></span>
                <span class="mr-3">Cerrada: <span class="badge badge-success">{{ $conteosEstados['cerrado'] ?? 0 }}</span></span>
            </div>
        </div>
        <div class="table-responsive">
            <table class="table table-sm table-striped">
                <thead>
                    <tr>
                        <th style="width:55px">#</th>
                        <th>Paciente</th>
                        <th>Seguro</th>
                        <th>Estado</th>
                        <th></th>
                    </tr>
                </thead>
                <tbody>
                @forelse($atenciones as $idx => $a)
                    <tr class="align-middle">
                        <td class="text-muted">{{ ($atenciones->currentPage()-1)*$atenciones->perPage() + $idx + 1 }}<span class="d-none" data-atencion-id="{{ $a->id }}"></span></td>
                        <td>
                            <div class="font-weight-semibold">{{ optional($a->paciente)->name ?? '—' }}</div>
                        </td>
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
                            <span class="badge {{ $badgeClass }} px-2 py-1">{{ $labelEstado }}</span>
                        </td>
                        <td class="text-right">
                            @if($a->estado==='cerrado')
                                <a href="{{ route('atenciones.gestion', $a) }}" class="btn btn-sm btn-outline-secondary" title="Atención cerrada (solo lectura)">
                                    <i class="fas fa-eye mr-1"></i> Ver
                                </a>
                            @else
                                <a href="{{ route('atenciones.gestion', $a) }}" class="btn btn-sm btn-primary">
                                    <i class="fas fa-stethoscope mr-1"></i> Gestionar
                                </a>
                            @endif
                        </td>
                    </tr>
                @empty
                    <tr><td colspan="4" class="text-center text-muted small">Sin atenciones asignadas</td></tr>
                @endforelse
                </tbody>
            </table>
        </div>
        <div class="d-flex justify-content-center">
            {{ $atenciones->links() }}
        </div>
    </div>
</div>
@endsection

@push('styles')
<style>
    .table-striped tbody tr:hover { background:#f5faff; }
    .font-weight-semibold{ font-weight:600; }
    .badge-info{ background:#17a2b8; }
    .badge-warning{ background:#ffc107; color:#4a3d00; }
    .badge-success{ background:#28a745; }
    .badge-light{ background:#e9ecef; color:#555; }
</style>
@endpush
