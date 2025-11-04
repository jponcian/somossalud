<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            {{ __('Panel de pacientes') }}
        </h2>
    </x-slot>

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