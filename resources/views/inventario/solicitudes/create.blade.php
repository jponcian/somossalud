@extends('layouts.adminlte')

@section('title', 'Nueva Solicitud')

@section('content_header')
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-cart-plus text-primary"></i> Nueva Solicitud de Materiales</h1>
        <a href="{{ route('inventario.solicitudes.index') }}" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Volver
        </a>
    </div>
@stop

@section('content')
    <form action="{{ route('inventario.solicitudes.store') }}" method="POST" id="formSolicitud">
        @csrf
        
        <div class="row">
            <div class="col-md-8">
                {{-- Información general --}}
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-primary text-white">
                        <h3 class="card-title"><i class="fas fa-info-circle"></i> Datos de la Solicitud</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="categoria" class="font-weight-bold">Categoría <span class="text-danger">*</span></label>
                                    <select name="categoria" id="categoria" class="form-control select2 @error('categoria') is-invalid @enderror" required>
                                        <option value="">Seleccione una categoría</option>
                                        @foreach($categorias as $cat)
                                            <option value="{{ $cat }}" {{ old('categoria') == $cat ? 'selected' : '' }}>
                                                {{ $cat }}
                                            </option>
                                        @endforeach
                                    </select>
                                    <small class="form-text text-muted">La categoría ayuda a filtrar los materiales sugeridos.</small>
                                    @error('categoria')
                                        <span class="invalid-feedback">{{ $message }}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="font-weight-bold">Solicitante</label>
                                    <input type="text" class="form-control bg-light" value="{{ auth()->user()->name }}" readonly>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="observaciones_solicitante" class="font-weight-bold">Observaciones / Justificación</label>
                            <textarea name="observaciones_solicitante" 
                                      id="observaciones_solicitante" 
                                      class="form-control @error('observaciones_solicitante') is-invalid @enderror" 
                                      rows="2" 
                                      placeholder="Ej: Reposición mensual para el área de emergencias...">{{ old('observaciones_solicitante') }}</textarea>
                            @error('observaciones_solicitante')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                </div>

                {{-- Items de la solicitud --}}
                <div class="card shadow-lg border-primary">
                    <div class="card-header bg-white">
                        <h3 class="card-title text-primary font-weight-bold"><i class="fas fa-boxes"></i> Items Solicitados</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-success shadow-sm" id="btnAgregarItem">
                                <i class="fas fa-plus"></i> Agregar Item
                            </button>
                        </div>
                    </div>
                    <div class="card-body bg-light">
                        <div id="contenedorItems">
                            {{-- Los items se agregarán aquí dinámicamente --}}
                        </div>
                        
                        <div id="emptyState" class="text-center py-5 text-muted">
                            <i class="fas fa-box-open fa-3x mb-3"></i>
                            <p>No hay items agregados a la solicitud.</p>
                            <p class="small">Haga clic en "Agregar Item" para comenzar.</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                {{-- Resumen Sticky --}}
                <div class="card card-outline card-primary shadow sticky-top" style="top: 20px;">
                    <div class="card-header">
                        <h3 class="card-title font-weight-bold"><i class="fas fa-clipboard-check"></i> Resumen</h3>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                            <span class="text-muted">Total Items:</span>
                            <span id="totalItems" class="font-weight-bold h5 text-primary mb-0">0</span>
                        </div>
                        
                        <div class="alert alert-info small">
                            <i class="fas fa-lightbulb"></i> <strong>Tip:</strong>
                            Puede buscar materiales existentes o escribir nombres nuevos si no encuentra lo que busca.
                        </div>
                    </div>
                    <div class="card-footer bg-white">
                        <button type="submit" class="btn btn-primary btn-block btn-lg shadow-sm">
                            <i class="fas fa-paper-plane"></i> Enviar Solicitud
                        </button>
                        <a href="{{ route('inventario.solicitudes.index') }}" class="btn btn-default btn-block">
                            Cancelar
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>
@stop

@push('scripts')
<script>
let itemCounter = 0;
const unidadesMedida = @json($unidadesMedida);

// Template de item optimizado
function getItemTemplate(index) {
    let opcionesUnidad = unidadesMedida.map(u => `<option value="${u}">${u}</option>`).join('');
    
    return `
        <div class="card item-card mb-3 shadow-sm border-left-primary" data-item-index="${index}" style="border-left: 4px solid #007bff;">
            <div class="card-body py-3">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h6 class="font-weight-bold text-primary m-0">
                        <i class="fas fa-box-open"></i> Item #${index + 1}
                    </h6>
                    <button type="button" class="btn btn-tool text-danger btn-eliminar-item" title="Eliminar item">
                        <i class="fas fa-trash-alt"></i>
                    </button>
                </div>
                
                <div class="row">
                    <div class="col-md-12 mb-2">
                        <div class="form-group mb-0">
                            <label class="small font-weight-bold text-muted">BUSCAR MATERIAL O ESCRIBIR NOMBRE</label>
                            <select name="items[${index}][material_select]" class="form-control material-select" style="width: 100%;">
                                <option value="">Buscar material...</option>
                            </select>
                            <input type="hidden" name="items[${index}][material_id]" class="material-id-input">
                            <input type="hidden" name="items[${index}][nombre_item]" class="nombre-item-input">
                        </div>
                    </div>
                    
                    <div class="col-md-8">
                        <div class="form-group mb-0">
                            <label class="small font-weight-bold text-muted">DESCRIPCIÓN ADICIONAL</label>
                            <input type="text" name="items[${index}][descripcion]" class="form-control form-control-sm" placeholder="Detalles adicionales...">
                        </div>
                    </div>
                    
                    <div class="col-md-4">
                        <div class="row">
                            <div class="col-6 pr-1">
                                <div class="form-group mb-0">
                                    <label class="small font-weight-bold text-muted">UNIDAD</label>
                                    <select name="items[${index}][unidad_medida]" class="form-control form-control-sm unidad-input">
                                        ${opcionesUnidad}
                                    </select>
                                </div>
                            </div>
                            <div class="col-6 pl-1">
                                <div class="form-group mb-0">
                                    <label class="small font-weight-bold text-muted">CANTIDAD</label>
                                    <input type="number" name="items[${index}][cantidad_solicitada]" class="form-control form-control-sm font-weight-bold text-center" min="1" value="1" required>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `;
}

// Inicializar Select2 en un elemento
function initMaterialSelect(element) {
    $(element).select2({
        theme: 'bootstrap4',
        placeholder: 'Escriba para buscar...',
        allowClear: true,
        tags: true, // Permite crear nuevos términos (texto libre)
        minimumInputLength: 1, // Reducido a 1 para facilitar búsqueda
        ajax: {
            url: '{{ url("inventario/solicitudes/buscar-materiales") }}',
            dataType: 'json',
            delay: 300,
            data: function (params) {
                return {
                    q: params.term,
                    categoria: $('#categoria').val() // Filtrar por categoría seleccionada
                };
            },
            processResults: function (data, params) {
                // Si hay error en la respuesta
                if (data.error) {
                    console.error('Error del servidor:', data.error);
                    return { results: [] };
                }
                return {
                    results: data
                };
            },
            error: function(xhr, status, error) {
                console.error('Error AJAX:', {
                    status: xhr.status,
                    statusText: xhr.statusText,
                    error: error,
                    response: xhr.responseText
                });
            },
            cache: true
        },
        createTag: function (params) {
            // Solo permitir crear tags personalizados si no hay resultados
            var term = $.trim(params.term);
            if (term === '') {
                return null;
            }
            
            // Mostrar opción de crear nuevo solo si el término tiene al menos 2 caracteres
            if (term.length < 2) {
                return null;
            }
            
            return {
                id: 'new:' + term,
                text: '➕ ' + term + ' (Crear nuevo)',
                newOption: true,
                nombre: term // Guardar nombre limpio
            };
        },
        language: {
            searching: function() {
                return 'Buscando...';
            },
            noResults: function() {
                return 'No se encontraron materiales. Escriba para crear uno nuevo.';
            },
            inputTooShort: function() {
                return 'Escriba al menos 1 carácter para buscar';
            },
            errorLoading: function() {
                return 'No se pudieron cargar los resultados. Verifique la consola del navegador (F12).';
            }
        }
    }).on('select2:select', function (e) {
        var data = e.params.data;
        var $card = $(this).closest('.item-card');
        
        if (data.newOption) {
            // Es un texto nuevo
            $card.find('.material-id-input').val('');
            $card.find('.nombre-item-input').val(data.nombre);
        } else {
            // Es un material existente del catálogo
            $card.find('.material-id-input').val(data.id);
            $card.find('.nombre-item-input').val(data.nombre);
            
            // Autocompletar unidad si existe
            if (data.unidad) {
                $card.find('.unidad-input').val(data.unidad);
            }
            
            // Autocompletar descripción si existe
            if (data.descripcion) {
                $card.find('input[name$="[descripcion]"]').val(data.descripcion);
            }
        }
    }).on('select2:unselecting', function() {
        var $card = $(this).closest('.item-card');
        $card.find('.material-id-input').val('');
        $card.find('.nombre-item-input').val('');
    });
}

// Agregar item
$('#btnAgregarItem').click(function() {
    $('#emptyState').hide();
    const itemHtml = getItemTemplate(itemCounter);
    const $newItem = $(itemHtml).appendTo('#contenedorItems');
    
    // Inicializar select2 en el nuevo item
    initMaterialSelect($newItem.find('.material-select'));
    
    itemCounter++;
    actualizarResumen();
});

// Eliminar item
$(document).on('click', '.btn-eliminar-item', function() {
    $(this).closest('.item-card').fadeOut(300, function() {
        $(this).remove();
        actualizarResumen();
        renumerarItems();
        
        if ($('.item-card').length === 0) {
            $('#emptyState').fadeIn();
        }
    });
});

// Renumerar items
function renumerarItems() {
    $('.item-card').each(function(index) {
        $(this).find('h6').html(`<i class="fas fa-box-open"></i> Item #${index + 1}`);
        
        // Actualizar índices en nombres de inputs
        $(this).find('input, select').each(function() {
            const name = $(this).attr('name');
            if (name) {
                const newName = name.replace(/items\[\d+\]/, `items[${index}]`);
                $(this).attr('name', newName);
            }
        });
    });
}

// Actualizar resumen
function actualizarResumen() {
    $('#totalItems').text($('.item-card').length);
}

// Validar formulario antes de enviar
$('#formSolicitud').submit(function(e) {
    if ($('.item-card').length === 0) {
        e.preventDefault();
        Swal.fire({
            icon: 'warning',
            title: 'Solicitud vacía',
            text: 'Debe agregar al menos un item a la solicitud.',
            confirmButtonText: 'Entendido'
        });
        return false;
    }
    
    // Verificar que todos los items tengan nombre (select2 seleccionado o texto)
    let valid = true;
    $('.material-select').each(function() {
        if (!$(this).val()) {
            valid = false;
            $(this).next('.select2').find('.select2-selection').addClass('is-invalid');
        } else {
            $(this).next('.select2').find('.select2-selection').removeClass('is-invalid');
        }
    });
    
    if (!valid) {
        e.preventDefault();
        Swal.fire({
            icon: 'error',
            title: 'Datos incompletos',
            text: 'Por favor, seleccione un material o escriba un nombre para todos los items.',
        });
        return false;
    }
});

// Inicialización
$(document).ready(function() {
    // Select2 para categoría
    $('#categoria').select2({
        theme: 'bootstrap4',
        placeholder: 'Seleccione categoría'
    });
    
    // Agregar primer item automáticamente
    $('#btnAgregarItem').click();
});
</script>

{{-- Estilos adicionales para Select2 validation --}}
<style>
    .select2-selection.is-invalid {
        border-color: #dc3545 !important;
    }
</style>
@endpush
