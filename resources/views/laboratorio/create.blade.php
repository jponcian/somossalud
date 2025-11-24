@extends('layouts.adminlte')

@section('title', 'Cargar Resultado de Laboratorio')

@section('sidebar')
    @include('panel.partials.sidebar')
@stop

@section('content_header')
    <h1>Cargar Resultado de Laboratorio</h1>
@stop

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-header" style="background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: white;">
                    <h3 class="card-title mb-0">
                        <i class="fas fa-flask"></i> Nuevo Resultado de Laboratorio
                    </h3>
                </div>
                <form action="{{ route('laboratorio.store') }}" method="POST" id="formResultado">
                    @csrf
                    <div class="card-body">
                        @if($errors->any())
                        <div class="alert alert-danger">
                            <h5><i class="icon fas fa-ban"></i> Error!</h5>
                            <ul class="mb-0">
                                @foreach($errors->all() as $error)
                                <li>{{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                        @endif

                        <div class="row">
                            <!-- Información del Paciente -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="paciente_id">Paciente <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <select name="paciente_id" id="paciente_id" class="form-control select2" required style="width: calc(100% - 120px);">
                                            <option value="">Seleccione un paciente...</option>
                                            @foreach($pacientes as $paciente)
                                            <option value="{{ $paciente->id }}" {{ old('paciente_id') == $paciente->id ? 'selected' : '' }}>
                                                {{ $paciente->name }} - {{ $paciente->cedula }}
                                            </option>
                                            @endforeach
                                        </select>
                                        <div class="input-group-append">
                                            <button type="button" class="btn btn-success" data-toggle="modal" data-target="#modalNuevoPaciente" title="Registrar nuevo paciente">
                                                <i class="fas fa-user-plus"></i> Nuevo
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-md-6">
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
                            </div>
                        </div>

                        <div class="row">
                            <!-- Tipo y Nombre del Examen -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="tipo_examen">Tipo de Examen <span class="text-danger">*</span></label>
                                    <select name="tipo_examen" id="tipo_examen" class="form-control" required>
                                        <option value="">Seleccione...</option>
                                        <option value="Hematología" {{ old('tipo_examen') == 'Hematología' ? 'selected' : '' }}>Hematología</option>
                                        <option value="Química Sanguínea" {{ old('tipo_examen') == 'Química Sanguínea' ? 'selected' : '' }}>Química Sanguínea</option>
                                        <option value="Urianálisis" {{ old('tipo_examen') == 'Urianálisis' ? 'selected' : '' }}>Urianálisis</option>
                                        <option value="Microbiología" {{ old('tipo_examen') == 'Microbiología' ? 'selected' : '' }}>Microbiología</option>
                                        <option value="Inmunología" {{ old('tipo_examen') == 'Inmunología' ? 'selected' : '' }}>Inmunología</option>
                                        <option value="Hormonas" {{ old('tipo_examen') == 'Hormonas' ? 'selected' : '' }}>Hormonas</option>
                                        <option value="Coagulación" {{ old('tipo_examen') == 'Coagulación' ? 'selected' : '' }}>Coagulación</option>
                                        <option value="Otros" {{ old('tipo_examen') == 'Otros' ? 'selected' : '' }}>Otros</option>
                                    </select>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="nombre_examen">Nombre del Examen <span class="text-danger">*</span></label>
                                    <input type="text" 
                                           name="nombre_examen" 
                                           id="nombre_examen" 
                                           class="form-control" 
                                           value="{{ old('nombre_examen') }}"
                                           placeholder="Ej: Hemograma Completo, Glicemia, etc."
                                           required>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <!-- Fechas -->
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="fecha_muestra">Fecha de Toma de Muestra <span class="text-danger">*</span></label>
                                    <input type="date" 
                                           name="fecha_muestra" 
                                           id="fecha_muestra" 
                                           class="form-control" 
                                           value="{{ old('fecha_muestra', date('Y-m-d')) }}"
                                           required>
                                </div>
                            </div>

                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="fecha_resultado">Fecha del Resultado <span class="text-danger">*</span></label>
                                    <input type="date" 
                                           name="fecha_resultado" 
                                           id="fecha_resultado" 
                                           class="form-control" 
                                           value="{{ old('fecha_resultado', date('Y-m-d')) }}"
                                           required>
                                </div>
                            </div>
                        </div>

                        <!-- Resultados Dinámicos -->
                        <div class="form-group">
                            <label>Resultados del Examen <span class="text-danger">*</span></label>
                            <div id="resultados-container">
                                <div class="resultado-item border rounded p-3 mb-3" style="background-color: #f8f9fa;">
                                    <div class="row">
                                        <div class="col-md-3">
                                            <label>Parámetro</label>
                                            <input type="text" 
                                                   name="resultados[0][parametro]" 
                                                   class="form-control" 
                                                   placeholder="Ej: Hemoglobina"
                                                   required>
                                        </div>
                                        <div class="col-md-2">
                                            <label>Valor</label>
                                            <input type="text" 
                                                   name="resultados[0][valor]" 
                                                   class="form-control" 
                                                   placeholder="Ej: 14.5"
                                                   required>
                                        </div>
                                        <div class="col-md-2">
                                            <label>Unidad</label>
                                            <input type="text" 
                                                   name="resultados[0][unidad]" 
                                                   class="form-control" 
                                                   placeholder="Ej: g/dL">
                                        </div>
                                        <div class="col-md-4">
                                            <label>Rango de Referencia</label>
                                            <input type="text" 
                                                   name="resultados[0][rango_referencia]" 
                                                   class="form-control" 
                                                   placeholder="Ej: 12-16 g/dL">
                                        </div>
                                        <div class="col-md-1 d-flex align-items-end">
                                            <button type="button" class="btn btn-danger btn-sm btn-remove-resultado" style="display: none;">
                                                <i class="fas fa-times"></i>
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <button type="button" id="btn-add-resultado" class="btn btn-sm btn-success">
                                <i class="fas fa-plus"></i> Agregar Parámetro
                            </button>
                        </div>

                        <!-- Observaciones -->
                        <div class="form-group">
                            <label for="observaciones">Observaciones</label>
                            <textarea name="observaciones" 
                                      id="observaciones" 
                                      class="form-control" 
                                      rows="3"
                                      placeholder="Observaciones adicionales sobre el resultado...">{{ old('observaciones') }}</textarea>
                        </div>
                    </div>

                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Guardar Resultado
                        </button>
                        <a href="{{ route('laboratorio.index') }}" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Cancelar
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Modal Nuevo Paciente -->
<div class="modal fade" id="modalNuevoPaciente" tabindex="-1" role="dialog" aria-labelledby="modalNuevoPacienteLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg" role="document">
        <div class="modal-content">
            <div class="modal-header" style="background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: white;">
                <h5 class="modal-title" id="modalNuevoPacienteLabel">
                    <i class="fas fa-user-plus"></i> Registro Rápido de Paciente
                </h5>
                <button type="button" class="close text-white" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form id="formNuevoPaciente">
                @csrf
                <div class="modal-body">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle"></i> 
                        <strong>Registro rápido:</strong> Complete los datos mínimos del paciente. 
                        Se generarán credenciales automáticamente para que pueda acceder al portal.
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="nuevo_nombre">Nombre Completo <span class="text-danger">*</span></label>
                                <input type="text" 
                                       class="form-control" 
                                       id="nuevo_nombre" 
                                       name="name" 
                                       placeholder="Ej: Juan Pérez"
                                       required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="nuevo_cedula">Cédula <span class="text-danger">*</span></label>
                                <input type="text" 
                                       class="form-control" 
                                       id="nuevo_cedula" 
                                       name="cedula" 
                                       placeholder="Ej: V-12345678"
                                       required>
                                <small class="text-muted">Si empiezas con un número, se asume V- automáticamente</small>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="nuevo_fecha_nacimiento">Fecha de Nacimiento <span class="text-danger">*</span></label>
                                <input type="date" 
                                       class="form-control" 
                                       id="nuevo_fecha_nacimiento" 
                                       name="fecha_nacimiento" 
                                       max="{{ date('Y-m-d') }}"
                                       required>
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-group">
                                <label for="nuevo_telefono">Teléfono <small class="text-muted">(opcional)</small></label>
                                <input type="text" 
                                       class="form-control" 
                                       id="nuevo_telefono" 
                                       name="telefono" 
                                       placeholder="Ej: 0414-1234567">
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <div class="form-group">
                                <label for="nuevo_email">Email <small class="text-muted">(opcional pero recomendado)</small></label>
                                <input type="email" 
                                       class="form-control" 
                                       id="nuevo_email" 
                                       name="email" 
                                       placeholder="correo@ejemplo.com">
                                <small class="text-muted">
                                    <i class="fas fa-info-circle"></i> 
                                    Si proporciona email, el paciente recibirá sus credenciales de acceso automáticamente.
                                </small>
                            </div>
                        </div>
                    </div>

                    <div class="alert alert-warning mb-0">
                        <i class="fas fa-key"></i> 
                        <strong>Credenciales:</strong> Se generará una contraseña temporal automáticamente. 
                        Si el paciente tiene email, recibirá sus credenciales por correo. 
                        Si no, se imprimirá una hoja con las credenciales.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">
                        <i class="fas fa-times"></i> Cancelar
                    </button>
                    <button type="submit" class="btn btn-success" id="btnGuardarPaciente">
                        <i class="fas fa-save"></i> Crear Paciente
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>
@stop

@section('css')
<link href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css" rel="stylesheet" />
<style>
    .resultado-item {
        position: relative;
        transition: all 0.3s ease;
    }
    
    .resultado-item:hover {
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    
    .select2-container .select2-selection--single {
        height: 38px;
        padding: 6px 12px;
    }
    
    .select2-container--default .select2-selection--single .select2-selection__rendered {
        line-height: 24px;
    }
</style>
@stop

@section('js')
<script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
<script>
$(document).ready(function() {
    // Inicializar Select2
    $('#paciente_id').select2({
        placeholder: 'Buscar paciente por nombre o cédula...',
        allowClear: true,
        width: '100%'
    });

    let resultadoIndex = 1;

    // Agregar nuevo parámetro
    $('#btn-add-resultado').click(function() {
        const newItem = `
            <div class="resultado-item border rounded p-3 mb-3" style="background-color: #f8f9fa;">
                <div class="row">
                    <div class="col-md-3">
                        <label>Parámetro</label>
                        <input type="text" 
                               name="resultados[${resultadoIndex}][parametro]" 
                               class="form-control" 
                               placeholder="Ej: Hemoglobina"
                               required>
                    </div>
                    <div class="col-md-2">
                        <label>Valor</label>
                        <input type="text" 
                               name="resultados[${resultadoIndex}][valor]" 
                               class="form-control" 
                               placeholder="Ej: 14.5"
                               required>
                    </div>
                    <div class="col-md-2">
                        <label>Unidad</label>
                        <input type="text" 
                               name="resultados[${resultadoIndex}][unidad]" 
                               class="form-control" 
                               placeholder="Ej: g/dL">
                    </div>
                    <div class="col-md-4">
                        <label>Rango de Referencia</label>
                        <input type="text" 
                               name="resultados[${resultadoIndex}][rango_referencia]" 
                               class="form-control" 
                               placeholder="Ej: 12-16 g/dL">
                    </div>
                    <div class="col-md-1 d-flex align-items-end">
                        <button type="button" class="btn btn-danger btn-sm btn-remove-resultado">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>
                </div>
            </div>
        `;
        
        $('#resultados-container').append(newItem);
        resultadoIndex++;
        
        // Mostrar botones de eliminar si hay más de un item
        updateRemoveButtons();
    });

    // Eliminar parámetro
    $(document).on('click', '.btn-remove-resultado', function() {
        $(this).closest('.resultado-item').remove();
        updateRemoveButtons();
    });

    function updateRemoveButtons() {
        const items = $('.resultado-item');
        if (items.length > 1) {
            $('.btn-remove-resultado').show();
        } else {
            $('.btn-remove-resultado').hide();
        }
    }

    // Validador de cédula para el modal
    $('#nuevo_cedula').on('blur', function() {
        let cedula = $(this).val().trim().toUpperCase();
        
        // Si empieza con número, agregar V-
        if (/^\d/.test(cedula)) {
            cedula = 'V-' + cedula;
        }
        
        // Si no tiene guión, agregarlo
        if (/^[VEJGP]\d/.test(cedula)) {
            cedula = cedula.charAt(0) + '-' + cedula.substring(1);
        }
        
        $(this).val(cedula);
    });

    // Manejar envío del formulario de nuevo paciente
    $('#formNuevoPaciente').on('submit', function(e) {
        e.preventDefault();
        
        const btnGuardar = $('#btnGuardarPaciente');
        const originalText = btnGuardar.html();
        
        // Deshabilitar botón y mostrar loading
        btnGuardar.prop('disabled', true).html('<i class="fas fa-spinner fa-spin"></i> Creando...');
        
        $.ajax({
            url: '{{ route("laboratorio.crear-paciente-rapido") }}',
            method: 'POST',
            data: $(this).serialize(),
            success: function(response) {
                if (response.success) {
                    // Cerrar modal
                    $('#modalNuevoPaciente').modal('hide');
                    
                    // Agregar nuevo paciente al select
                    const newOption = new Option(
                        response.paciente.name + ' - ' + response.paciente.cedula,
                        response.paciente.id,
                        true,
                        true
                    );
                    $('#paciente_id').append(newOption).trigger('change');
                    
                    // Limpiar formulario
                    $('#formNuevoPaciente')[0].reset();
                    
                    // Mostrar mensaje de éxito
                    let mensaje = '<div class="alert alert-success alert-dismissible fade show" role="alert">' +
                        '<i class="fas fa-check-circle"></i> ' + response.message;
                    
                    if (response.credenciales) {
                        mensaje += '<br><strong>Credenciales generadas:</strong><br>' +
                            'Usuario: ' + response.credenciales.usuario + '<br>' +
                            'Contraseña: ' + response.credenciales.password;
                        
                        if (!response.credenciales.email_enviado) {
                            mensaje += '<br><span class="text-warning"><i class="fas fa-print"></i> ' +
                                'Recuerde imprimir las credenciales para entregar al paciente.</span>';
                        }
                    }
                    
                    mensaje += '<button type="button" class="close" data-dismiss="alert">' +
                        '<span>&times;</span></button></div>';
                    
                    $('.card-body').prepend(mensaje);
                    
                    // Scroll al inicio
                    $('html, body').animate({ scrollTop: 0 }, 500);
                }
            },
            error: function(xhr) {
                let errorMsg = 'Error al crear el paciente.';
                
                if (xhr.responseJSON && xhr.responseJSON.errors) {
                    errorMsg += '<ul class="mb-0 mt-2">';
                    $.each(xhr.responseJSON.errors, function(key, value) {
                        errorMsg += '<li>' + value[0] + '</li>';
                    });
                    errorMsg += '</ul>';
                } else if (xhr.responseJSON && xhr.responseJSON.message) {
                    errorMsg += ' ' + xhr.responseJSON.message;
                }
                
                alert(errorMsg);
            },
            complete: function() {
                // Rehabilitar botón
                btnGuardar.prop('disabled', false).html(originalText);
            }
        });
    });
});
</script>
@stop
