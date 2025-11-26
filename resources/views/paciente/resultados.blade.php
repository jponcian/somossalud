<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            Mis Resultados de Laboratorio
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            @if($ordenes->count() > 0)
                <div class="space-y-6">
                    @foreach($ordenes as $order)
                    <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-l-4 border-blue-500">
                        <div class="p-6">
                            <div class="flex justify-between items-start">
                                <div class="flex-grow">
                                    <div class="flex items-center mb-2">
                                        <h3 class="text-lg font-semibold text-gray-800 mb-0">
                                            Orden #{{ $order->order_number }}
                                        </h3>
                                        <span class="ml-3 px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                                            Completado
                                        </span>
                                    </div>
                                    
                                    <div class="grid grid-cols-1 md:grid-cols-3 gap-4 text-sm text-gray-600 mb-4">
                                        <div>
                                            <i class="fas fa-calendar-alt text-blue-500 mr-2"></i>
                                            <strong>Fecha Orden:</strong> {{ $order->order_date->format('d/m/Y') }}
                                        </div>
                                        <div>
                                            <i class="fas fa-calendar-check text-blue-500 mr-2"></i>
                                            <strong>Fecha Resultado:</strong> {{ $order->result_date->format('d/m/Y') }}
                                        </div>
                                        <div>
                                            <i class="fas fa-hospital text-blue-500 mr-2"></i>
                                            <strong>Clínica:</strong> {{ $order->clinica->nombre }}
                                        </div>
                                    </div>

                                    <!-- Lista de Exámenes -->
                                    <div class="mt-4">
                                        <h4 class="text-sm font-semibold text-gray-700 mb-2 border-b pb-1">Exámenes Realizados:</h4>
                                        <ul class="list-disc list-inside text-sm text-gray-600 ml-2">
                                            @foreach($order->details as $detail)
                                                <li>{{ $detail->exam->name }}</li>
                                            @endforeach
                                        </ul>
                                    </div>

                                    @if($order->observations)
                                    <div class="mt-4 p-3 bg-blue-50 border-l-4 border-blue-400 rounded">
                                        <p class="text-sm text-gray-700 mb-0">
                                            <strong class="text-blue-800">Observaciones:</strong> {{ $order->observations }}
                                        </p>
                                    </div>
                                    @endif
                                </div>
                                
                                <div class="ml-4 text-right flex-shrink-0">
                                    <div class="mb-3 flex justify-end">
                                        {!! QrCode::size(100)->generate(route('lab.orders.verify', $order->verification_code)) !!}
                                    </div>
                                    <p class="text-xs text-gray-500 mb-1">Código de verificación:</p>
                                    <code class="text-xs text-blue-600 block mb-3 font-mono">{{ $order->verification_code }}</code>
                                    
                                    <div class="flex flex-col space-y-2">
                                        <a href="{{ route('lab.orders.pdf', $order->id) }}" 
                                           class="inline-flex items-center px-4 py-2 bg-red-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-red-700 active:bg-red-900 focus:outline-none focus:border-red-900 focus:ring ring-red-300 disabled:opacity-25 transition ease-in-out duration-150">
                                            <i class="fas fa-file-pdf mr-2"></i> Descargar PDF
                                        </a>
                                        <a href="{{ route('lab.orders.verify', $order->verification_code) }}" 
                                           target="_blank"
                                           class="inline-flex items-center px-4 py-2 bg-white border border-gray-300 rounded-md font-semibold text-xs text-gray-700 uppercase tracking-widest shadow-sm hover:text-gray-500 focus:outline-none focus:border-blue-300 focus:shadow-outline-blue active:text-gray-800 active:bg-gray-50 transition ease-in-out duration-150">
                                            <i class="fas fa-external-link-alt mr-2"></i> Verificar
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    @endforeach
                </div>
            @else
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 text-center">
                        <div class="mb-4">
                            <i class="fas fa-flask fa-4x text-gray-300"></i>
                        </div>
                        <h3 class="text-lg font-semibold text-gray-800 mb-2">No tienes resultados de laboratorio</h3>
                        <p class="text-sm text-gray-600">
                            Cuando se registren resultados de tus exámenes de laboratorio, aparecerán aquí.
                        </p>
                    </div>
                </div>
            @endif
        </div>
    </div>
</x-app-layout>
