<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            @if (! $tieneActiva)
                <!-- Modal Bootstrap: Activación de suscripción -->
                <div class="modal fade" id="activarSuscripcionModal" tabindex="-1" aria-labelledby="activarSuscripcionLabel" aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header bg-success text-white">
                                <h5 class="modal-title d-flex align-items-center" id="activarSuscripcionLabel">
                                    <i class="fas fa-id-card-alt me-2"></i> Activa tu suscripción
                                </h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <span class="badge rounded-pill text-bg-success me-2">Plan anual</span>
                                    <span class="badge rounded-pill text-bg-warning">Estado: inactivo</span>
                                </div>
                                <p class="mb-3">Activa tu suscripción para acceder a citas, resultados, historial y más herramientas de seguimiento médico.</p>
                                <div class="row g-3 mb-3">
                                    <div class="col-md-6">
                                        <div class="border rounded p-3 h-100">
                                            <p class="fw-semibold mb-2"><i class="fas fa-dollar-sign me-1 text-success"></i> Costo: $10 USD</p>
                                            <ul class="mb-0 small">
                                                <li>Acceso a agenda de citas</li>
                                                <li>Resultados y estudios</li>
                                                <li>Perfil clínico unificado</li>
                                            </ul>
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <div class="border rounded p-3 h-100">
                                            <p class="fw-semibold mb-2"><i class="far fa-clock me-1 text-secondary"></i> Pago Móvil</p>
                                            <ul class="mb-0 small">
                                                <li><span class="fw-medium">Banco:</span> Banco Ejemplo</li>
                                                <li><span class="fw-medium">Teléfono:</span> 0414-0000000</li>
                                                <li><span class="fw-medium">Cédula:</span> V-12.345.678</li>
                                                <li><span class="fw-medium">Nombre:</span> SomosSalud Clínica</li>
                                            </ul>
                                            <p class="text-muted small mt-2">Realiza el pago exacto y guarda la referencia antes de continuar.</p>
                                        </div>
                                    </div>
                                </div>
                                <div class="border rounded p-3 bg-light">
                                    <p class="fw-semibold mb-2"><i class="far fa-list-alt me-1 text-primary"></i> Pasos para activar</p>
                                    <ol class="mb-0 small ps-3">
                                        <li>Realiza el pago móvil por $10 USD</li>
                                        <li>Haz clic en "Reportar mi pago"</li>
                                        <li>Ingresa los datos y referencia del pago</li>
                                        <li>Espera la validación (recibirás confirmación)</li>
                                    </ol>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <a href="{{ route('suscripcion.show') }}" class="btn btn-success">
                                    <i class="fas fa-paper-plane me-1"></i> Reportar mi pago
                                </a>
                                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">Cerrar</button>
                            </div>
                        </div>
                    </div>
                </div>

                @push('scripts')
                    <script>
                        document.addEventListener('DOMContentLoaded', function () {
                            var el = document.getElementById('activarSuscripcionModal');
                            if (el && typeof bootstrap !== 'undefined' && bootstrap.Modal) {
                                var modal = new bootstrap.Modal(el);
                                modal.show();
                            }
                        });
                    </script>
                @endpush
            @endif
                    </div>
                    <div class="px-6 py-4 bg-gray-100 flex flex-col sm:flex-row sm:justify-end gap-3">
                        <a href="{{ route('suscripcion.show') }}" class="inline-flex items-center justify-center px-5 py-2.5 rounded-md text-sm font-semibold bg-emerald-600 text-white shadow hover:bg-emerald-700 focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-emerald-500 transition">
                            Reportar mi pago
                        </a>
                        <button @click="open = false" type="button" class="inline-flex items-center justify-center px-5 py-2.5 rounded-md text-sm font-medium bg-white text-gray-700 border border-gray-300 shadow-sm hover:bg-gray-50 focus:outline-none focus-visible:ring-2 focus-visible:ring-offset-2 focus-visible:ring-gray-400 transition">
                            Cerrar
                        </button>
                    </div>
                </div>
            </div>
        </div>
    @endif

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8 space-y-8">
            <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                <div class="p-6 text-gray-900">
                    <h3 class="text-lg font-semibold text-gray-800 mb-3">Tu próxima atención</h3>
                    <p class="text-sm text-gray-600">
                        Revisa el estado de tus citas, resultados de laboratorio y datos personales en un solo lugar.
                    </p>
                </div>
            </div>

            <div class="grid gap-6 md:grid-cols-2 xl:grid-cols-3">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-emerald-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">Citas médicas</h4>
                        <p class="text-sm text-gray-600 mb-4">
                            Agenda nuevas consultas, confirma fechas y recibe recordatorios automáticos.</p>
                        <a href="{{ route('citas.index') }}"
                            class="inline-flex items-center text-emerald-600 font-semibold text-sm">Gestionar citas<span
                                class="ml-2">→</span></a>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-sky-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">Resultados y estudios</h4>
                        <p class="text-sm text-gray-600 mb-4">
                            Consulta informes, descarga tus resultados y comparte con especialistas cuando lo necesites.
                        </p>
                        <a href="#"
                            class="inline-flex items-center text-sky-600 font-semibold text-sm">Ver mis resultados<span
                                class="ml-2">→</span></a>
                    </div>
                </div>

                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-t-4 border-indigo-400">
                    <div class="p-6">
                        <h4 class="text-base font-semibold text-gray-800 mb-1">Mi información</h4>
                        <p class="text-sm text-gray-600 mb-4">
                            Actualiza tus datos personales, contactos de emergencia y preferencias de comunicación.
                        </p>
                        <a href="{{ route('profile.edit') }}"
                            class="inline-flex items-center text-indigo-600 font-semibold text-sm">Actualizar perfil<span
                                class="ml-2">→</span></a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</x-app-layout>