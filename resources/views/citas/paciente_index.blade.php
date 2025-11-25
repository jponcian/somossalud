<x-app-layout>
    <x-slot name="header">
        <h2 class="font-semibold text-xl text-gray-800 leading-tight">
            Mis Citas y Atenciones
        </h2>
    </x-slot>

    <div class="py-12">
        <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
            
            <!-- Header Action -->
            <div class="flex justify-between items-center mb-6">
                <div>
                    <h3 class="text-lg font-medium text-gray-900">Historial de Consultas</h3>
                    <p class="text-sm text-gray-500">Revisa tus citas programadas y atenciones pasadas</p>
                </div>
                <a href="{{ route('citas.create') }}" class="inline-flex items-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700 active:bg-blue-900 focus:outline-none focus:border-blue-900 focus:ring ring-blue-300 disabled:opacity-25 transition ease-in-out duration-150">
                    <i class="fas fa-plus mr-2"></i> Nueva Cita
                </a>
            </div>

            <!-- Success Message -->
            @if(session('success'))
                <div class="bg-green-100 border-l-4 border-green-500 text-green-700 p-4 mb-6" role="alert">
                    <p class="font-bold">Éxito</p>
                    <p>{{ session('success') }}</p>
                </div>
            @endif

            @if(isset($items) && count($items) > 0)
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="overflow-x-auto">
                        <table class="min-w-full divide-y divide-gray-200">
                            <thead class="bg-gray-50">
                                <tr>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Fecha / Hora
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Tipo
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Estado
                                    </th>
                                    <th scope="col" class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                                        Especialista
                                    </th>
                                    <th scope="col" class="relative px-6 py-3">
                                        <span class="sr-only">Acciones</span>
                                    </th>
                                </tr>
                            </thead>
                            <tbody class="bg-white divide-y divide-gray-200">
                                @foreach($items as $row)
                                    @php
                                        $__fecha = \Illuminate\Support\Carbon::parse($row['momento'])->format('d/m/Y');
                                        $__hora = \Illuminate\Support\Carbon::parse($row['momento'])->format('h:i a');
                                        $tipo = $row['tipo'];
                                        $estado = $row['estado'];
                                        
                                        // Colores para badges Tailwind
                                        $badgeColor = 'gray';
                                        if($tipo === 'cita') {
                                            $badgeColor = match($estado){ 
                                                'pendiente'=>'yellow', 
                                                'confirmada'=>'blue', 
                                                'cancelada'=>'red', 
                                                'concluida'=>'green', 
                                                default=>'gray' 
                                            };
                                        } else {
                                            $badgeColor = match($estado){ 
                                                'validado'=>'blue', 
                                                'en_consulta'=>'yellow', 
                                                'cerrado'=>'green', 
                                                default=>'gray' 
                                            };
                                        }
                                    @endphp
                                    <tr>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <div class="flex items-center">
                                                <div class="flex-shrink-0 h-10 w-10 flex items-center justify-center bg-gray-100 rounded-full text-gray-500">
                                                    <i class="far fa-calendar-alt"></i>
                                                </div>
                                                <div class="ml-4">
                                                    <div class="text-sm font-medium text-gray-900">{{ $__fecha }}</div>
                                                    <div class="text-sm text-gray-500">{{ $__hora }}</div>
                                                </div>
                                            </div>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-gray-100 text-gray-800">
                                                {{ $tipo==='cita' ? 'Cita Médica' : 'Atención' }}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap">
                                            <span class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-{{ $badgeColor }}-100 text-{{ $badgeColor }}-800">
                                                {{ ucfirst(str_replace('_', ' ', $estado)) }}
                                            </span>
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">
                                            {{ $row['especialista'] ?? '—' }}
                                        </td>
                                        <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                                            <div class="flex justify-end space-x-2">
                                                @if($tipo==='cita')
                                                    <a href="{{ route('citas.show', $row['id']) }}" class="text-blue-600 hover:text-blue-900" title="Ver detalle">
                                                        <i class="fas fa-eye"></i>
                                                    </a>
                                                    @if($row['tiene_meds'])
                                                        <a href="{{ route('citas.receta', $row['id']) }}" class="text-green-600 hover:text-green-900" title="Ver Receta">
                                                            <i class="fas fa-prescription-bottle-alt"></i>
                                                        </a>
                                                    @endif
                                                    @if(!in_array($estado, ['cancelada','concluida']))
                                                        <form action="{{ route('citas.cancelar', $row['id']) }}" method="POST" class="inline-block js-cancel-cita">
                                                            @csrf
                                                            <button type="submit" class="text-red-600 hover:text-red-900" title="Cancelar Cita">
                                                                <i class="fas fa-ban"></i>
                                                            </button>
                                                        </form>
                                                    @endif
                                                @else
                                                    @if($estado==='cerrado')
                                                        <a href="{{ route('atenciones.paciente.show', $row['id']) }}" class="text-blue-600 hover:text-blue-900">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                    @endif
                                                    @if($row['tiene_meds'])
                                                        <a href="{{ route('atenciones.paciente.receta', $row['id']) }}" class="text-green-600 hover:text-green-900">
                                                            <i class="fas fa-prescription-bottle-alt"></i>
                                                        </a>
                                                    @endif
                                                @endif
                                            </div>
                                        </td>
                                    </tr>
                                @endforeach
                            </tbody>
                        </table>
                    </div>
                </div>
            @else
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg p-10 text-center">
                    <div class="mb-4 text-gray-300">
                        <i class="fas fa-calendar-times fa-4x"></i>
                    </div>
                    <h3 class="text-lg font-medium text-gray-900 mb-2">No tienes citas registradas</h3>
                    <p class="text-gray-500 mb-6">Comienza agendando tu primera consulta médica con nosotros.</p>
                    <a href="{{ route('citas.create') }}" class="inline-flex items-center px-4 py-2 bg-blue-600 border border-transparent rounded-md font-semibold text-xs text-white uppercase tracking-widest hover:bg-blue-700 active:bg-blue-900 focus:outline-none focus:border-blue-900 focus:ring ring-blue-300 disabled:opacity-25 transition ease-in-out duration-150">
                        Agendar Cita Ahora
                    </a>
                </div>
            @endif
        </div>
    </div>

    @push('scripts')
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        document.querySelectorAll('.js-cancel-cita').forEach(form => {
            form.addEventListener('submit', e => {
                e.preventDefault();
                Swal.fire({
                    title: '¿Cancelar cita?',
                    text: "Esta acción no se puede deshacer.",
                    icon: 'warning',
                    showCancelButton: true,
                    confirmButtonColor: '#ef4444',
                    cancelButtonColor: '#6b7280',
                    confirmButtonText: 'Sí, cancelar',
                    cancelButtonText: 'No'
                }).then((result) => {
                    if (result.isConfirmed) form.submit();
                });
            });
        });
    </script>
    @endpush
</x-app-layout>
