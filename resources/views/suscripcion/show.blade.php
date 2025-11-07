@extends('layouts.app')

@section('content')
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h1 class="text-2xl font-semibold text-gray-900 mb-6">Mi suscripción</h1>

        @if(session('error'))
            <div class="mb-4 rounded-md bg-red-50 p-4 text-red-700 border border-red-200">{{ session('error') }}</div>
        @endif
        @if(session('success'))
            <div class="mb-4 rounded-md bg-green-50 p-4 text-green-700 border border-green-200">{{ session('success') }}</div>
        @endif

        @if($suscripcion)
            <div class="mb-6 bg-white shadow rounded-lg p-5">
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
                    <div>
                        <div class="text-sm text-gray-500">Plan</div>
                        <div class="font-medium text-gray-900">{{ ucfirst($suscripcion->plan) }}</div>
                    </div>
                    <div>
                        <div class="text-sm text-gray-500">Estado</div>
                        <div>
                            <span
                                class="inline-flex items-center px-2.5 py-0.5 rounded text-xs font-medium {{ $suscripcion->estado === 'activo' ? 'bg-green-100 text-green-800' : 'bg-yellow-100 text-yellow-800' }}">
                                {{ ucfirst($suscripcion->estado) }}
                            </span>
                        </div>
                    </div>
                    <div>
                        <div class="text-sm text-gray-500">Vence</div>
                        <div class="font-medium text-gray-900">
                            {{ \Illuminate\Support\Carbon::parse($suscripcion->periodo_vencimiento)->format('d/m/Y') }}
                        </div>
                    </div>
                    <div>
                        <div class="text-sm text-gray-500">Método</div>
                        <div class="font-medium text-gray-900">{{ str_replace('_', ' ', $suscripcion->metodo_pago) }}</div>
                    </div>
                </div>
                <div class="mt-4">
                    <a href="{{ route('suscripcion.carnet') }}"
                        class="inline-flex items-center px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium rounded-md">Ver
                        carnet</a>
                </div>
            </div>
        @else
            <div class="mb-6 rounded-md bg-blue-50 p-4 text-blue-800 border border-blue-200">No tienes una suscripción activa.
            </div>
        @endif

        <div class="grid grid-cols-1 lg:grid-cols-2 gap-6">
            <div class="bg-white shadow rounded-lg p-6">
                <h2 class="text-lg font-semibold text-gray-900 mb-2">Pagar suscripción anual</h2>
                <p class="text-sm text-gray-700 mb-2">Precio: <span class="font-semibold">$10</span> (equivalente en Bs. al
                    momento del pago).</p>
                @if($user->clinica && $user->clinica->descuento)
                    <p class="text-sm text-gray-700 mb-4">Afiliado a: <span
                            class="font-semibold">{{ $user->clinica->nombre }}</span> — Descuento: <span
                            class="font-semibold">{{ $user->clinica->descuento }}%</span></p>
                @endif
                <div class="border-t border-gray-100 pt-4">
                    <div class="text-sm font-medium text-gray-900 mb-2">Datos de Pago Móvil</div>
                    <dl class="text-sm text-gray-700 grid grid-cols-1 sm:grid-cols-2 gap-x-6 gap-y-2">
                        <div class="flex justify-between sm:block">
                            <dt class="text-gray-500">Banco</dt>
                            <dd class="font-medium">Banesco</dd>
                        </div>
                        <div class="flex justify-between sm:block">
                            <dt class="text-gray-500">RIF/Cédula</dt>
                            <dd class="font-medium">J-12345678-9</dd>
                        </div>
                        <div class="flex justify-between sm:block">
                            <dt class="text-gray-500">Teléfono</dt>
                            <dd class="font-medium">0414-0000000</dd>
                        </div>
                        <div class="flex justify-between sm:block">
                            <dt class="text-gray-500">Nombre</dt>
                            <dd class="font-medium">SomosSalud C.A.</dd>
                        </div>
                    </dl>
                    <p class="mt-3 text-xs text-gray-500">Estos datos son de ejemplo. Sustituir por los definitivos cuando
                        la empresa los confirme.</p>
                </div>
            </div>

            <div class="bg-white shadow rounded-lg p-6">
                <h2 class="text-lg font-semibold text-gray-900 mb-4">Reportar pago</h2>
                <form method="POST" action="{{ route('suscripcion.reportar') }}" class="space-y-4">
                    @csrf
                    <div>
                        <label for="cedula_pagador" class="block text-sm font-medium text-gray-700">Cédula del
                            pagador</label>
                        <input type="text" id="cedula_pagador" name="cedula_pagador" value="{{ old('cedula_pagador') }}"
                            class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-emerald-500 focus:ring-emerald-500 @error('cedula_pagador') border-red-300 focus:border-red-500 focus:ring-red-500 @enderror"
                            required>
                        @error('cedula_pagador')<p class="mt-1 text-sm text-red-600">{{ $message }}</p>@enderror
                    </div>
                    <div>
                        <label for="telefono_pagador" class="block text-sm font-medium text-gray-700">Teléfono del
                            pagador</label>
                        <input type="text" id="telefono_pagador" name="telefono_pagador"
                            value="{{ old('telefono_pagador') }}"
                            class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-emerald-500 focus:ring-emerald-500 @error('telefono_pagador') border-red-300 focus:border-red-500 focus:ring-red-500 @enderror"
                            required>
                        @error('telefono_pagador')<p class="mt-1 text-sm text-red-600">{{ $message }}</p>@enderror
                    </div>
                    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
                        <div>
                            <label for="fecha_pago" class="block text-sm font-medium text-gray-700">Fecha del pago</label>
                            <input type="date" id="fecha_pago" name="fecha_pago" value="{{ old('fecha_pago') }}"
                                class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-emerald-500 focus:ring-emerald-500 @error('fecha_pago') border-red-300 focus:border-red-500 focus:ring-red-500 @enderror"
                                required>
                            @error('fecha_pago')<p class="mt-1 text-sm text-red-600">{{ $message }}</p>@enderror
                        </div>
                        <div>
                            <label for="monto" class="block text-sm font-medium text-gray-700">Monto</label>
                            <input type="number" step="0.01" id="monto" name="monto" value="{{ old('monto') }}"
                                class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-emerald-500 focus:ring-emerald-500 @error('monto') border-red-300 focus:border-red-500 focus:ring-red-500 @enderror"
                                required>
                            @error('monto')<p class="mt-1 text-sm text-red-600">{{ $message }}</p>@enderror
                        </div>
                    </div>
                    <div>
                        <label for="referencia" class="block text-sm font-medium text-gray-700">Referencia</label>
                        <input type="text" id="referencia" name="referencia" value="{{ old('referencia') }}"
                            class="mt-1 block w-full rounded-md border-gray-300 shadow-sm focus:border-emerald-500 focus:ring-emerald-500 @error('referencia') border-red-300 focus:border-red-500 focus:ring-red-500 @enderror"
                            required>
                        @error('referencia')<p class="mt-1 text-sm text-red-600">{{ $message }}</p>@enderror
                    </div>
                    <div class="flex items-center justify-between">
                        <button
                            class="inline-flex items-center px-4 py-2 bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium rounded-md"
                            type="submit">Enviar reporte</button>
                        <div class="text-xs text-gray-500">Tiempo de validación: 24-48 horas hábiles.</div>
                    </div>
                </form>
            </div>
        </div>

        {{-- Sección sandbox eliminada para entorno productivo --}}
    </div>
@endsection