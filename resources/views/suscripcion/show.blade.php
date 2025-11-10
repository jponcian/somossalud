<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">Mi suscripción</h2>
    </x-slot>

    <div class="container py-4">
        {{-- <h1 class="h4 mb-4">Mi suscripción</h1> --}}

        @if(session('error'))
            <div class="alert alert-danger small">{{ session('error') }}</div>
        @endif
        @if(session('success'))
            <div class="alert alert-success small">{{ session('success') }}</div>
        @endif

        @if($suscripcion)
            <div class="card mb-4 shadow-sm">
                <div class="card-body">
                    <div class="row g-3 align-items-center">
                        <div class="col-6 col-md-3">
                            <div class="text-muted small">Plan</div>
                            <div class="fw-semibold text-uppercase">{{ $suscripcion->plan }}</div>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="text-muted small">Estado</div>
                            <span class="badge {{ $suscripcion->estado === 'activo' ? 'text-bg-success' : 'text-bg-warning' }}">{{ ucfirst($suscripcion->estado) }}</span>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="text-muted small">Vence</div>
                            <div class="fw-medium">{{ \Illuminate\Support\Carbon::parse($suscripcion->periodo_vencimiento)->format('d/m/Y') }}</div>
                        </div>
                        <div class="col-6 col-md-3">
                            <div class="text-muted small">Método</div>
                            <div class="fw-medium">{{ str_replace('_', ' ', $suscripcion->metodo_pago) }}</div>
                        </div>
                    </div>
                    <div class="mt-3">
                        <a href="{{ route('suscripcion.carnet') }}" class="btn btn-success btn-sm"><i class="fa-solid fa-id-card me-1"></i> Ver carnet</a>
                    </div>
                </div>
            </div>
        @else
            <div class="alert alert-primary small">No tienes una suscripción activa.</div>
        @endif

        @if(isset($ultimoReporte) && $ultimoReporte)
            @if($ultimoReporte->estado === 'pendiente')
                <div class="alert alert-warning small">Reporte de pago pendiente (ref: <strong>{{ $ultimoReporte->referencia }}</strong>). Te avisaremos cuando se apruebe.</div>
            @elseif($ultimoReporte->estado === 'rechazado')
                <div class="alert alert-danger small">Tu último reporte fue rechazado. @if($ultimoReporte->observaciones) Motivo: <strong>{{ $ultimoReporte->observaciones }}</strong>@endif</div>
            @endif
        @endif

        <div class="row g-4">
            <div class="col-lg-6">
                <div class="card shadow-sm h-100">
                    <div class="card-body">
                        @push('styles')
                            <style>
                                .reportar-pago-card {
                                    background: linear-gradient(145deg,#ffffff 0%,#f8fafc 70%);
                                    border: 1px solid #e5e9ef;
                                    position: relative;
                                }
                                .reportar-pago-header {
                                    display:flex;
                                    align-items:center;
                                    gap:.75rem;
                                    padding:.65rem .85rem;
                                    background:#0d6efd;
                                    color:#fff;
                                    border-radius:.5rem;
                                    box-shadow:0 4px 12px -3px rgba(13,110,253,.35);
                                }
                                .reportar-pago-header i {font-size:1.1rem;}
                                .reportar-pago-hint {font-size:.7rem; letter-spacing:.5px; text-transform:uppercase; color:#6c757d;}
                                .form-floating-sm {position:relative;}
                                .form-floating-sm > label {font-size:.65rem; text-transform:uppercase; letter-spacing:.5px; background:#fff; padding:0 .35rem; margin-left:.25rem;}
                                .reportar-pago-card .form-control:focus {box-shadow:0 0 0 .2rem rgba(25,135,84,.15);}
                                .badge-soft-info {background:rgba(13,110,253,.08); color:#0d6efd; border:1px solid rgba(13,110,253,.18);}
                                .helper-box {background:#fff; border:1px dashed #ced4da; border-radius:.5rem; padding:.6rem .75rem; font-size:.7rem; color:#495057;}
                            </style>
                        @endpush
                        <div class="reportar-pago-header mb-3">
                            <i class="fa-solid fa-paper-plane"></i>
                            <div class="fw-semibold">Reportar pago</div>
                        </div>
                        @if(isset($ultimoReporte) && $ultimoReporte && $ultimoReporte->estado === 'pendiente')
                            <div class="alert alert-warning small">Ya registraste un pago pendiente. Espera la validación.</div>
                            <a href="{{ route('panel.pacientes') }}" class="btn btn-success btn-sm"><i class="fa-solid fa-arrow-left me-1"></i> Volver al panel</a>
                        @else
                        <form method="POST" action="{{ route('suscripcion.reportar') }}" class="row g-3 reportar-pago-card p-3 rounded-3">
                            @csrf
                            @php
                                $__rateForm = optional(\App\Models\ExchangeRate::latestEffective()->first());
                                $__bsDefaultNumeric = ($__rateForm && $__rateForm->rate) ? (10 * (float) $__rateForm->rate) : null;
                                // Para el value del input number usamos punto decimal
                                $__bsDefaultValue = $__bsDefaultNumeric !== null ? number_format($__bsDefaultNumeric, 2, '.', '') : '';
                                // Para mostrar en texto usamos formato local con coma
                                $__bsDefaultDisplay = $__bsDefaultNumeric !== null ? number_format($__bsDefaultNumeric, 2, ',', '.') : null;
                            @endphp
                            <div class="col-12 col-md-6">
                                <label for="cedula_pagador" class="form-label small fw-semibold">Cédula del pagador</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white"><i class="fa-solid fa-id-card"></i></span>
                                    <input type="text" id="cedula_pagador" name="cedula_pagador" value="{{ old('cedula_pagador') }}" class="form-control @error('cedula_pagador') is-invalid @enderror" required>
                                    @error('cedula_pagador')<div class="invalid-feedback">{{ $message }}</div>@enderror
                                </div>
                            </div>
                            <div class="col-12 col-md-6">
                                <label for="telefono_pagador" class="form-label small fw-semibold">Teléfono del pagador</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white"><i class="fa-solid fa-phone"></i></span>
                                    <input type="text" id="telefono_pagador" name="telefono_pagador" value="{{ old('telefono_pagador') }}" class="form-control @error('telefono_pagador') is-invalid @enderror" placeholder="0414-1234567" required>
                                    @error('telefono_pagador')<div class="invalid-feedback">{{ $message }}</div>@enderror
                                </div>
                            </div>
                            
                            <div class="col-sm-6">
                                <label for="fecha_pago" class="form-label small">Fecha del pago</label>
                                <input type="date" id="fecha_pago" name="fecha_pago" value="{{ old('fecha_pago', now()->format('Y-m-d')) }}" class="form-control form-control-sm @error('fecha_pago') is-invalid @enderror" required>
                                @error('fecha_pago')<div class="invalid-feedback">{{ $message }}</div>@enderror
                            </div>
                            <div class="col-sm-6">
                                <label for="monto" class="form-label small fw-semibold">Monto (Bs)</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white"><i class="fa-solid fa-sack-dollar"></i></span>
                                    <input type="number" step="0.01" id="monto" name="monto" value="{{ old('monto', $__bsDefaultValue) }}" class="form-control @error('monto') is-invalid @enderror" required>
                                    @error('monto')<div class="invalid-feedback">{{ $message }}</div>@enderror
                                </div>
                                @if($__bsDefaultDisplay)
                                    <div class="form-text small">Sugerido según tasa actual para $10: {{ $__bsDefaultDisplay }} Bs</div>
                                @endif
                            </div>
                            <div class="col-12">
                                <label for="referencia" class="form-label small fw-semibold">Referencia del pago</label>
                                <div class="input-group input-group-sm">
                                    <span class="input-group-text bg-white"><i class="fa-solid fa-hashtag"></i></span>
                                    <input type="text" id="referencia" name="referencia" value="{{ old('referencia') }}" class="form-control @error('referencia') is-invalid @enderror" required>
                                    @error('referencia')<div class="invalid-feedback">{{ $message }}</div>@enderror
                                </div>
                            </div>
                            <div class="col-12">
                                <div class="helper-box">Verifica que el monto coincida con el pago realizado y que la referencia sea exacta. Un error puede retrasar la activación.</div>
                            </div>
                            <div class="col-12 d-flex justify-content-between align-items-center">
                                <button class="btn btn-success btn-sm d-inline-flex align-items-center" type="submit"><i class="fa-solid fa-paper-plane me-1"></i><span>Enviar reporte</span></button>
                                <div class="text-muted small">Al aprobarse tu pago podrás agendar una cita médica</div>
                            </div>
                        </form>
                        @endif
                    </div>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="card shadow-sm h-100">
                    <div class="card-body">
                        <h2 class="h6 fw-semibold mb-2">Pagar suscripción anual</h2>
                        @php
                            $__ratePago = optional(\App\Models\ExchangeRate::latestEffective()->first());
                            $__bsEquivPago = ($__ratePago && $__ratePago->rate) ? 10 * (float) $__ratePago->rate : null;
                        @endphp
                        <p class="small mb-2">Precio: <span class="fw-bold">$10</span>
                            @if($__bsEquivPago !== null)
                                <span class="text-muted">(aprox. {{ number_format((float)$__bsEquivPago, 2, ',', '.') }} Bs · tasa actual)</span>
                            @else
                                <span class="text-muted">(equivalente en Bs no disponible)</span>
                            @endif
                        </p>
                        @if($user->clinica && $user->clinica->descuento)
                            <p class="small mb-3">Afiliado a: <span class="fw-semibold">{{ $user->clinica->nombre }}</span> — Descuento: <span class="fw-semibold">{{ $user->clinica->descuento }}%</span></p>
                        @endif
                        <div class="border-top pt-3">
                            <div class="fw-semibold small mb-2">Datos de Pago Móvil</div>
                            <div class="row small g-2">
                                <div class="col-6">
                                    <div class="text-muted">Banco</div>
                                    <div class="fw-medium">{{ $pagoMovil['banco'] }}</div>
                                </div>
                                <div class="col-6">
                                    <div class="text-muted">RIF/Cédula</div>
                                    <div class="fw-medium">{{ $pagoMovil['identificacion'] }}</div>
                                </div>
                                <div class="col-6">
                                    <div class="text-muted">Teléfono</div>
                                    <div class="fw-medium">{{ $pagoMovil['telefono'] }}</div>
                                </div>
                                <div class="col-6">
                                    <div class="text-muted">Nombre</div>
                                    <div class="fw-medium">{{ $pagoMovil['nombre'] }}</div>
                                </div>
                            </div>
                            <p class="mt-3 text-muted small">Si ves datos incorrectos, por favor contacta a administración.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

        {{-- Sección sandbox eliminada para entorno productivo --}}
    </div>
</x-app-layout>