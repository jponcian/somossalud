@extends('layouts.app')

@section('content')
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
        <h1 class="text-2xl font-semibold text-gray-900 mb-6">Mi carnet virtual</h1>
        <div class="bg-white shadow rounded-xl p-6 max-w-md">
            <div class="flex items-center mb-4">
                <img src="{{ asset('images/logo.png') }}" alt="SomosSalud" class="w-10 h-10 mr-2">
                <div>
                    <div class="font-semibold text-gray-900">SomosSalud</div>
                    <div class="text-xs text-gray-500">Carnet de afiliación</div>
                </div>
            </div>
            <div class="space-y-1 text-sm text-gray-700">
                <div><span class="text-gray-500">Nombre:</span> <span
                        class="font-medium text-gray-900">{{ $user->name }}</span></div>
                <div><span class="text-gray-500">Cédula:</span> <span
                        class="font-medium text-gray-900">{{ $user->cedula }}</span></div>
                <div><span class="text-gray-500">Plan:</span> <span
                        class="font-medium text-gray-900">{{ strtoupper($suscripcion->plan) }}</span></div>
                <div><span class="text-gray-500">Vence:</span> <span
                        class="font-medium text-gray-900">{{ \Illuminate\Support\Carbon::parse($suscripcion->periodo_vencimiento)->format('d/m/Y') }}</span>
                </div>
            </div>
            <div class="my-4 border-t border-gray-100"></div>
            <div class="text-center text-gray-400">
                <div class="w-40 h-40 bg-gray-100 rounded-lg mx-auto flex items-center justify-center">
                    <span class="text-sm">QR aquí</span>
                </div>
                <div class="mt-2 text-xs">Próximamente mostraremos un código QR y diseño oficial.</div>
            </div>
        </div>
        <div class="mt-4">
            <a href="{{ route('suscripcion.show') }}"
                class="inline-flex items-center px-4 py-2 text-sm font-medium text-emerald-700 bg-emerald-50 hover:bg-emerald-100 rounded-md">Volver</a>
        </div>
    </div>
@endsection