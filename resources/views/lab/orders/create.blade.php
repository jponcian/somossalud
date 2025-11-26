@extends('layouts.adminlte')

@section('title', 'Nueva Orden de Laboratorio')

@section('content')
<div class="container-fluid">
    <form action="{{ route('lab.orders.store') }}" method="POST" id="formOrden">
        @csrf
        <div class="row">
            <!-- Left Column: Order Info -->
            <div class="col-md-4">
                <div class="card shadow-sm border-0 rounded-lg overflow-hidden">
                    <div class="card-header border-0" style="background: linear-gradient(135deg, #dbeafe 0%, #dcfce7 100%); border-bottom: 1px solid #cbd5e1;">
                        <h3 class="card-title font-weight-bold text-primary mb-0">
                            <i class="fas fa-file-invoice mr-2"></i> Datos de la Orden
                        </h3>
                    </div>
                    <div class="card-body">
                        @if($errors->any())
                        <div class="alert alert-danger alert-dismissible fade show">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <ul class="mb-0 pl-3">
                                @foreach($errors->all() as $error)
                                <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                        @endif

                        <!-- Patient -->
                        <div class="form-group">
                            <label class="small font-weight-bold text-uppercase text-muted">Paciente <span class="text-danger">*</span></label>
                            <div class="input-group input-group-sm">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-light border-0"><i class="fas fa-user text-muted"></i></span>
                                </div>
                                <select name="patient_id" id="patient_id" class="form-control bg-light border-0 select2" required>
                                    <option value="">Seleccione un paciente...</option>
                                    @foreach($patients as $patient)
                                    <option value="{{ $patient->id }}" {{ old('patient_id') == $patient->id ? 'selected' : '' }}>
                                        {{ $patient->name }} - {{ $patient->cedula }}
                                    </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <!-- Clinic -->
                        <div class="form-group">
                            <label class="small font-weight-bold text-uppercase text-muted">Clínica <span class="text-danger">*</span></label>
                            <div class="input-group input-group-sm">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-light border-0"><i class="fas fa-hospital text-muted"></i></span>
                                </div>
                                <select name="clinica_id" id="clinica_id" class="form-control bg-light border-0" required>
                                    @foreach($clinicas as $clinica)
                                    <option value="{{ $clinica->id }}" {{ old('clinica_id', Auth::user()->clinica_id) == $clinica->id ? 'selected' : '' }}>
                                        {{ $clinica->nombre }}
                                    </option>
                                    @endforeach
                                </select>
                            </div>
                        </div>

                        <!-- Date -->
                        <div class="form-group">
                            <label class="small font-weight-bold text-uppercase text-muted">Fecha de Orden <span class="text-danger">*</span></label>
                            <div class="input-group input-group-sm">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-light border-0"><i class="fas fa-calendar text-muted"></i></span>
                                </div>
                                <input type="date" 
                                       name="order_date" 
                                       id="order_date" 
                                       class="form-control bg-light border-0" 
                                       value="{{ old('order_date', date('Y-m-d')) }}"
                                       required>
                            </div>
                        </div>

                        <!-- Observations -->
                        <div class="form-group">
                            <label class="small font-weight-bold text-uppercase text-muted">Observaciones</label>
                            <textarea name="observations" 
                                      id="observations" 
                                      class="form-control bg-light border-0" 
                                      rows="4"
                                      placeholder="Observaciones adicionales...">{{ old('observations') }}</textarea>
                        </div>
                    </div>
                </div>
                
                <!-- Total Card -->
                 <div class="card shadow-sm border-0 rounded-lg overflow-hidden" style="background: linear-gradient(135deg, #f0fdf4 0%, #dbeafe 100%);">
                    <div class="card-body text-center">
                        <p class="text-uppercase text-muted small font-weight-bold mb-1">Total a Pagar</p>
                        <h3 class="mb-0 font-weight-bold text-primary">$<span id="totalAmount">0.00</span></h3>
                    </div>
                 </div>

                 <div class="mt-3 mb-4">
                    <button type="submit" class="btn btn-primary btn-block shadow-sm font-weight-bold">
                        <i class="fas fa-save mr-2"></i> Crear Orden
                    </button>
                    <a href="{{ route('lab.orders.index') }}" class="btn btn-light btn-block border shadow-sm">
                        <i class="fas fa-times mr-2"></i> Cancelar
                    </a>
                 </div>
            </div>

            <!-- Right Column: Exams -->
            <div class="col-md-8">
                <div class="card shadow-sm border-0 rounded-lg overflow-hidden" style="height: calc(100% - 1rem);">
                    <div class="card-header border-0 d-flex align-items-center" style="background: linear-gradient(135deg, #dbeafe 0%, #dcfce7 100%); border-bottom: 1px solid #cbd5e1;">
                        <h3 class="card-title font-weight-bold text-primary mb-0">
                            <i class="fas fa-flask mr-2"></i> Exámenes Solicitados
                        </h3>
                        <div class="ml-auto">
                            <div class="input-group input-group-sm" style="width: 250px;">
                                <div class="input-group-prepend">
                                    <span class="input-group-text bg-white border-0"><i class="fas fa-search text-muted"></i></span>
                                </div>
                                <input type="text" id="searchExam" class="form-control bg-white border-0" placeholder="Buscar examen...">
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="exam-list-container" style="height: 600px; overflow-y: auto; padding: 20px;">
                            @error('exams')
                                <div class="alert alert-danger mx-3">{{ $message }}</div>
                            @enderror

                            @foreach($categories as $category)
                                <div class="category-section mb-4">
                                    <h5 class="text-primary border-bottom pb-2 mb-3 category-title font-weight-bold">
                                        <i class="fas fa-folder-open mr-2"></i> {{ $category->name }}
                                    </h5>
                                    <div class="row">
                                        @foreach($category->exams as $exam)
                                            <div class="col-md-6 exam-item mb-2" data-name="{{ strtolower($exam->name) }}" data-category="{{ strtolower($category->name) }}">
                                                <div class="custom-control custom-checkbox exam-checkbox-wrapper">
                                                    <input class="custom-control-input exam-checkbox" 
                                                           type="checkbox" 
                                                           name="exams[]" 
                                                           value="{{ $exam->id }}" 
                                                           id="exam_{{ $exam->id }}"
                                                           data-price="{{ $exam->price }}"
                                                           {{ in_array($exam->id, old('exams', [])) ? 'checked' : '' }}>
                                                    <label class="custom-control-label w-100 d-flex justify-content-between align-items-center" for="exam_{{ $exam->id }}" style="cursor: pointer;">
                                                        <span class="text-dark">{{ $exam->name }}</span>
                                                        <span class="badge badge-light border px-2 py-1">${{ number_format($exam->price, 2) }}</span>
                                                    </label>
                                                </div>
                                            </div>
                                        @endforeach
                                    </div>
                                </div>
                            @endforeach
                            
                            <div id="noResults" class="text-center text-muted mt-5 py-5" style="display: none;">
                                <i class="fas fa-search fa-3x mb-3" style="color: #cbd5e1;"></i>
                                <p class="mb-0">No se encontraron exámenes que coincidan con la búsqueda.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>
@stop

@section('css')
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<style>
    .select2-container .select2-selection--single {
        height: calc(1.5em + .5rem + 2px);
        padding: .25rem .5rem;
        background-color: #f8fafc;
        border: none;
    }
    
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: calc(1.5em + .5rem);
        padding-left: 0;
    }

    .select2-container--default .select2-selection--single .select2-selection__arrow {
        height: calc(1.5em + .5rem + 2px);
    }
    
    .exam-checkbox-wrapper {
        padding: 10px 15px;
        border-radius: 8px;
        transition: all 0.2s ease;
        background-color: #f8fafc;
    }
    
    .exam-checkbox-wrapper:hover {
        background-color: #e0f2fe;
        transform: translateX(3px);
    }
    
    .exam-checkbox:checked ~ label {
        font-weight: 600;
        color: #0ea5e9 !important;
    }

    .exam-checkbox:checked ~ label .badge {
        background-color: #0ea5e9 !important;
        color: white !important;
        border-color: #0ea5e9 !important;
    }

    .category-section {
        animation: fadeIn 0.3s ease-in;
    }

    @keyframes fadeIn {
        from { opacity: 0; transform: translateY(10px); }
        to { opacity: 1; transform: translateY(0); }
    }

    .exam-list-container::-webkit-scrollbar {
        width: 8px;
    }

    .exam-list-container::-webkit-scrollbar-track {
        background: #f1f1f1;
        border-radius: 10px;
    }

    .exam-list-container::-webkit-scrollbar-thumb {
        background: #cbd5e1;
        border-radius: 10px;
    }

    .exam-list-container::-webkit-scrollbar-thumb:hover {
        background: #94a3b8;
    }
</style>
@stop

@section('js')
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
$(document).ready(function() {
    // Inicializar Select2
    $('#patient_id').select2({
        placeholder: 'Buscar paciente por nombre o cédula...',
        allowClear: true,
        width: '100%'
    });

    // Calcular total
    const checkboxes = document.querySelectorAll('.exam-checkbox');
    const totalElement = document.getElementById('totalAmount');

    function updateTotal() {
        let total = 0;
        checkboxes.forEach(checkbox => {
            if (checkbox.checked) {
                total += parseFloat(checkbox.dataset.price);
            }
        });
        totalElement.textContent = total.toFixed(2);
    }

    checkboxes.forEach(checkbox => {
        checkbox.addEventListener('change', updateTotal);
    });

    // Calcular total inicial
    updateTotal();

    // Buscador de exámenes
    $('#searchExam').on('keyup', function() {
        var value = $(this).val().toLowerCase();
        var hasVisible = false;

        $('.exam-item').each(function() {
            var name = $(this).data('name');
            var match = name.indexOf(value) > -1;
            $(this).toggle(match);
            if(match) hasVisible = true;
        });

        // Ocultar categorías vacías
        $('.category-section').each(function() {
            var visibleExams = $(this).find('.exam-item:visible').length;
            $(this).toggle(visibleExams > 0);
        });
        
        // Mostrar mensaje de no resultados
        if($('.exam-item:visible').length === 0) {
            $('#noResults').show();
        } else {
            $('#noResults').hide();
        }
    });
});
</script>
@stop
