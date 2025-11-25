@extends('layouts.adminlte')

@section('title', 'Nueva Orden de Laboratorio')

@section('sidebar')
    @include('panel.partials.sidebar')
@stop

@section('content_header')
    <h1>Nueva Orden de Laboratorio</h1>
@stop

@section('content')
<div class="container-fluid">
    <form action="{{ route('lab.orders.store') }}" method="POST" id="formOrden">
        @csrf
        <div class="row">
            <!-- Left Column: Order Info -->
            <div class="col-md-4">
                <div class="card card-primary card-outline">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-file-invoice"></i> Datos de la Orden</h3>
                    </div>
                    <div class="card-body">
                        @if($errors->any())
                        <div class="alert alert-danger">
                            <ul class="mb-0 pl-3">
                                @foreach($errors->all() as $error)
                                <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                        @endif

                        <!-- Patient -->
                        <div class="form-group">
                            <label for="patient_id">Paciente <span class="text-danger">*</span></label>
                            <select name="patient_id" id="patient_id" class="form-control select2" required>
                                <option value="">Seleccione un paciente...</option>
                                @foreach($patients as $patient)
                                <option value="{{ $patient->id }}" {{ old('patient_id') == $patient->id ? 'selected' : '' }}>
                                    {{ $patient->name }} - {{ $patient->cedula }}
                                </option>
                                @endforeach
                            </select>
                        </div>

                        <!-- Clinic -->
                        <div class="form-group">
                            <label for="clinica_id">Clínica <span class="text-danger">*</span></label>
                            <select name="clinica_id" id="clinica_id" class="form-control" required>
                                @foreach($clinicas as $clinica)
                                <option value="{{ $clinica->id }}" {{ old('clinica_id', Auth::user()->clinica_id) == $clinica->id ? 'selected' : '' }}>
                                    {{ $clinica->nombre }}
                                </option>
                                @endforeach
                            </select>
                        </div>

                        <!-- Date -->
                        <div class="form-group">
                            <label for="order_date">Fecha de Orden <span class="text-danger">*</span></label>
                            <input type="date" 
                                   name="order_date" 
                                   id="order_date" 
                                   class="form-control" 
                                   value="{{ old('order_date', date('Y-m-d')) }}"
                                   required>
                        </div>

                        <!-- Observations -->
                        <div class="form-group">
                            <label for="observations">Observaciones</label>
                            <textarea name="observations" 
                                      id="observations" 
                                      class="form-control" 
                                      rows="4"
                                      placeholder="Observaciones adicionales...">{{ old('observations') }}</textarea>
                        </div>
                    </div>
                </div>
                
                <!-- Total Card -->
                 <div class="card bg-light">
                    <div class="card-body">
                        <h4 class="text-center mb-0">Total: $<span id="totalAmount">0.00</span></h4>
                    </div>
                 </div>

                 <div class="mt-3 mb-4">
                    <button type="submit" class="btn btn-primary btn-block btn-lg">
                        <i class="fas fa-save"></i> Crear Orden
                    </button>
                    <a href="{{ route('lab.orders.index') }}" class="btn btn-secondary btn-block">
                        <i class="fas fa-times"></i> Cancelar
                    </a>
                 </div>
            </div>

            <!-- Right Column: Exams -->
            <div class="col-md-8">
                <div class="card card-success card-outline" style="height: calc(100% - 1rem);">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-flask"></i> Exámenes Solicitados</h3>
                        <div class="card-tools">
                            <div class="input-group input-group-sm" style="width: 250px;">
                                <input type="text" id="searchExam" class="form-control float-right" placeholder="Buscar examen...">
                                <div class="input-group-append">
                                    <span class="input-group-text"><i class="fas fa-search"></i></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card-body p-0">
                        <div class="exam-list-container" style="height: 600px; overflow-y: auto; padding: 15px;">
                            @error('exams')
                                <div class="alert alert-danger">{{ $message }}</div>
                            @enderror

                            @foreach($categories as $category)
                                <div class="category-section mb-3">
                                    <h5 class="text-primary border-bottom pb-2 mb-2 category-title">
                                        <i class="fas fa-folder-open"></i> {{ $category->name }}
                                    </h5>
                                    <div class="row">
                                        @foreach($category->exams as $exam)
                                            <div class="col-md-6 exam-item" data-name="{{ strtolower($exam->name) }}" data-category="{{ strtolower($category->name) }}">
                                                <div class="form-check mb-2">
                                                    <input class="form-check-input exam-checkbox" 
                                                           type="checkbox" 
                                                           name="exams[]" 
                                                           value="{{ $exam->id }}" 
                                                           id="exam_{{ $exam->id }}"
                                                           data-price="{{ $exam->price }}"
                                                           {{ in_array($exam->id, old('exams', [])) ? 'checked' : '' }}>
                                                    <label class="form-check-label w-100" for="exam_{{ $exam->id }}" style="cursor: pointer;">
                                                        <span class="d-flex justify-content-between align-items-center pr-3">
                                                            <span>{{ $exam->name }}</span>
                                                            <span class="badge badge-light border">${{ number_format($exam->price, 2) }}</span>
                                                        </span>
                                                    </label>
                                                </div>
                                            </div>
                                        @endforeach
                                    </div>
                                </div>
                            @endforeach
                            
                            <div id="noResults" class="text-center text-muted mt-4" style="display: none;">
                                <i class="fas fa-search fa-3x mb-3 text-gray-300"></i>
                                <p>No se encontraron exámenes que coincidan con la búsqueda.</p>
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
        height: 38px;
        padding: 6px 12px;
    }
    
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 24px;
    }
    
    .form-check {
        padding: 8px 10px 8px 30px;
        border-radius: 5px;
        transition: background-color 0.2s;
    }
    
    .form-check:hover {
        background-color: #f8f9fa;
    }
    
    .exam-checkbox:checked + label {
        font-weight: bold;
        color: #007bff;
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
