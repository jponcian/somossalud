<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Panel de pacientes') }}
        </h2>
    </x-slot>

    @php
        // Determinar si el usuario tiene una suscripción activa
        $suscripcionActiva = \App\Models\Suscripcion::where('usuario_id', auth()->id())
            ->where('estado', 'activo')
            ->latest()
            ->first();
        $tieneActiva = (bool) $suscripcionActiva;
    @endphp

    @if (! $tieneActiva)
        <!-- Modal de activación de suscripción -->
        <div x-data="{ open: true }" x-show="open" x-cloak class="fixed inset-0 z-50 flex items-center justify-center p-4">
            <div class="absolute inset-0 bg-gray-900 bg-opacity-60" @click="open = false"></div>
            <div class="relative bg-white w-full max-w-lg rounded-lg shadow-lg overflow-hidden">
                <div class="px-6 py-4 border-b">
                    <h3 class="text-lg font-semibold text-gray-800 flex items-center">
                        <svg class="w-5 h-5 text-emerald-500 mr-2" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24" aria-hidden="true">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M13 16h-1v-4h-1m1-4h.01M12 2a10 10 0 100 20 10 10 0 000-20z" />
                        </svg>
                        {{ __('Activa tu suscripción') }}
                    </h3>
                </div>
                <div class="px-6 py-5 space-y-4">
                    <p class="text-sm text-gray-700 leading-relaxed">
                        {{ __('Para usar todas las funciones del panel (citas, estudios, historial), activa tu suscripción anual.') }}
                    </p>
                    <div class="bg-emerald-50 border border-emerald-200 rounded-md p-3 text-sm text-emerald-800">
                        <p class="font-semibold">Costo: $10 USD (plan anual)</p>
                        <p class="mt-1">Incluye acceso a agenda de citas, resultados de laboratorio y actualización de tu perfil médico.</p>
                    </div>
                    <div class="bg-gray-50 border rounded-md p-3 text-sm">
                        <p class="font-semibold mb-1">Datos para Pago Móvil:</p>
                        <ul class="space-y-1 text-gray-700">
                            <li><span class="font-medium">Banco:</span> Banco Ejemplo</li>
                            <li><span class="font-medium">Teléfono:</span> 0414-0000000</li>
                            <li><span class="font-medium">Cédula:</span> V-12.345.678</li>
                            <li><span class="font-medium">Nombre:</span> SomosSalud Clínica</li>
                        </ul>
                        <p class="text-xs text-gray-500 mt-2">Realiza el pago exacto y guarda la referencia.</p>
                    </div>
                    <p class="text-sm text-gray-700">Después del pago, reporta tu operación y nuestro personal activará tu suscripción.</p>
                </div>
                <div class="px-6 py-4 bg-gray-100 flex flex-col sm:flex-row sm:justify-end gap-3">
                    <a href="{{ route('suscripcion.show') }}" class="inline-flex items-center justify-center px-4 py-2 rounded-md text-sm font-medium bg-emerald-600 text-white hover:bg-emerald-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-emerald-500">
                        {{ __('Reportar mi pago') }}
                    </a>
                    <button @click="open = false" type="button" class="inline-flex items-center justify-center px-4 py-2 rounded-md text-sm font-medium bg-white text-gray-700 border hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-gray-400">
                        {{ __('Cerrar') }}
                    </button>
                </div>
            </div>
        </div>
    @endif

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-semibold text-gray-800 mb-3">{{ __('Tu próxima atención') }}</h3>
                    <p class="text-sm text-gray-600">
                        {{ __('Revisa el estado de tus citas, resultados de laboratorio y datos personales en un solo lugar.') }}
                    </p>
                </div>
            </div>

            <div class="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-emerald-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">{{ __('Citas médicas') }}</h4>
                        <p class="text-sm text-gray-600 mb-4">
                            {{ __('Agenda nuevas consultas, confirma fechas y recibe recordatorios automáticos.') }}</p>
                        <a href="{{ route('citas.index') }}"
                            class="inline-flex items-center text-emerald-600 font-semibold text-sm">{{ __('Gestionar citas') }}<span
                                class="ml-2">→</span></a>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-sky-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">{{ __('Resultados y estudios') }}</h4>
                        <p class="text-sm text-gray-600 mb-4">
                            {{ __('Consulta informes, descarga tus resultados y comparte con especialistas cuando lo necesites.') }}
                        </p>
                        <a href="#"
                            class="inline-flex items-center text-sky-600 font-semibold text-sm">{{ __('Ver mis resultados') }}<span
                                class="ml-2">→</span></a>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-indigo-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">{{ __('Mi información') }}</h4>
                        <p class="text-sm text-gray-600 mb-4">
                            {{ __('Actualiza tus datos personales, contactos de emergencia y preferencias de comunicación.') }}
                        </p>
                        <a href="{{ route('profile.edit') }}"
                            class="inline-flex items-center text-indigo-600 font-semibold text-sm">{{ __('Actualizar perfil') }}<span
                                class="ml-2">→</span></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>