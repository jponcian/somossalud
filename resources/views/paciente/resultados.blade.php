<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            Mis Resultados de Laboratorio
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            @if($resultados->count() > 0)
            <div class="space-y-4">
                @foreach($resultados as $resultado)
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg border-l-4 border-purple-500">
                    <div class="p-6">
                        <div class="flex justify-content-between align-items-start">
                            <div class="flex-grow-1">
                                <div class="d-flex align-items-center mb-2">
                                    <h3 class="text-lg font-semibold text-gray-800 mb-0">
                                        {{ $resultado->nombre_examen }}
                                    </h3>
                                    <span class="badge bg-info ms-3">{{ $resultado->tipo_examen }}</span>
                                </div>
                                
                                <div class="row text-sm text-gray-600 mb-3">
                                    <div class="col-md-4">
                                        <i class="fas fa-calendar-alt text-purple-500 me-2"></i>
                                        <strong>Fecha Muestra:</strong> {{ $resultado->fecha_muestra->format('d/m/Y') }}
                                    </div>
                                    <div class="col-md-4">
                                        <i class="fas fa-calendar-check text-purple-500 me-2"></i>
                                        <strong>Fecha Resultado:</strong> {{ $resultado->fecha_resultado->format('d/m/Y') }}
                                    </div>
                                    <div class="col-md-4">
                                        <i class="fas fa-hospital text-purple-500 me-2"></i>
                                        <strong>Clínica:</strong> {{ $resultado->clinica->nombre }}
                                    </div>
                                </div>

                                <!-- Resultados en tabla compacta -->
                                <div class="mt-3">
                                    <h4 class="text-sm font-semibold text-gray-700 mb-2">Resultados:</h4>
                                    <div class="table-responsive">
                                        <table class="table table-sm table-bordered">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Parámetro</th>
                                                    <th>Valor</th>
                                                    <th>Unidad</th>
                                                    <th>Rango de Referencia</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                @foreach($resultado->resultados_json as $item)
                                                <tr>
                                                    <td><strong>{{ $item['parametro'] }}</strong></td>
                                                    <td>{{ $item['valor'] }}</td>
                                                    <td>{{ $item['unidad'] ?? '-' }}</td>
                                                    <td>{{ $item['rango_referencia'] ?? '-' }}</td>
                                                </tr>
                                                @endforeach
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                                @if($resultado->observaciones)
                                <div class="mt-3 p-3 bg-yellow-50 border-l-4 border-yellow-400 rounded">
                                    <p class="text-sm text-gray-700 mb-0">
                                        <strong class="text-yellow-800">Observaciones:</strong> {{ $resultado->observaciones }}
                                    </p>
                                </div>
                                @endif
                            </div>
                            
                            <div class="ms-4 text-end flex-shrink-0">
                                <div class="mb-3">
                                    {!! QrCode::size(120)->generate($resultado->url_verificacion) !!}
                                </div>
                                <p class="text-xs text-gray-500 mb-2">Código de verificación:</p>
                                <code class="text-xs text-purple-600 d-block mb-3">{{ $resultado->codigo_verificacion }}</code>
                                
                                <div class="d-grid gap-2">
                                    <a href="{{ route('laboratorio.pdf', $resultado) }}" 
                                       class="btn btn-sm btn-success">
                                        <i class="fas fa-download"></i> Descargar PDF
                                    </a>
                                    <a href="{{ $resultado->url_verificacion }}" 
                                       target="_blank"
                                       class="btn btn-sm btn-outline-primary">
                                        <i class="fas fa-external-link-alt"></i> Verificar
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                @endforeach
            </div>

            <div class="mt-4">
                {{ $resultados->links() }}
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

    <style>
        .border-purple-500 {
            border-left-color: #9333ea !important;
        }
        
        .text-purple-500 {
            color: #9333ea;
        }
        
        .text-purple-600 {
            color: #7c3aed;
        }
        
        .bg-yellow-50 {
            background-color: #fefce8;
        }
        
        .border-yellow-400 {
            border-left-color: #facc15 !important;
        }
        
        .text-yellow-800 {
            color: #854d0e;
        }
        
        .table-sm td, .table-sm th {
            padding: 0.5rem;
            font-size: 0.875rem;
        }
    </style>
</x-app-layout>
