

<?php $__env->startSection('title', 'Registrar Ingreso'); ?>

<?php $__env->startSection('content-header'); ?>
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-plus-circle text-success"></i> Registrar Ingreso de Materiales</h1>
        <a href="<?php echo e(route('inventario.ingresos.index')); ?>" class="btn btn-secondary">
            <i class="fas fa-arrow-left"></i> Volver
        </a>
    </div>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('content'); ?>
    <form action="<?php echo e(route('inventario.ingresos.store')); ?>" method="POST" id="formIngreso">
        <?php echo csrf_field(); ?>
        
        <div class="row">
            <div class="col-md-8">
                
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-success text-white">
                        <h3 class="card-title"><i class="fas fa-info-circle"></i> Datos del Ingreso</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="referencia" class="font-weight-bold">Referencia (Factura/Orden)</label>
                                    <input type="text" name="referencia" id="referencia" class="form-control <?php $__errorArgs = ['referencia'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" value="<?php echo e(old('referencia')); ?>" placeholder="Ej: FAC-12345">
                                    <?php $__errorArgs = ['referencia'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                        <span class="invalid-feedback"><?php echo e($message); ?></span>
                                    <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label class="font-weight-bold">Usuario</label>
                                    <input type="text" class="form-control bg-light" value="<?php echo e(auth()->user()->name); ?>" readonly>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="motivo" class="font-weight-bold">Motivo / Observación</label>
                            <textarea name="motivo" id="motivo" class="form-control <?php $__errorArgs = ['motivo'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?> is-invalid <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>" rows="2" placeholder="Ej: Compra mensual de insumos"><?php echo e(old('motivo', 'COMPRA DE INSUMOS')); ?></textarea>
                            <?php $__errorArgs = ['motivo'];
$__bag = $errors->getBag($__errorArgs[1] ?? 'default');
if ($__bag->has($__errorArgs[0])) :
if (isset($message)) { $__messageOriginal = $message; }
$message = $__bag->first($__errorArgs[0]); ?>
                                <span class="invalid-feedback"><?php echo e($message); ?></span>
                            <?php unset($message);
if (isset($__messageOriginal)) { $message = $__messageOriginal; }
endif;
unset($__errorArgs, $__bag); ?>
                        </div>
                    </div>
                </div>

                
                <div class="card shadow-lg border-success">
                    <div class="card-header bg-white">
                        <h3 class="card-title text-success font-weight-bold"><i class="fas fa-boxes"></i> Materiales a Ingresar</h3>
                    </div>
                    <div class="card-body bg-light">
                        <div class="row">
                            <div class="col-md-8 mb-3">
                                <label class="small font-weight-bold text-muted">BUSCAR MATERIAL</label>
                                <select id="materialSelect" class="form-control" style="width: 100%;">
                                    <option value="">Buscar material...</option>
                                    <?php $__currentLoopData = $materiales; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $material): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                        <option value="<?php echo e($material->id); ?>" data-nombre="<?php echo e($material->nombre); ?>" data-codigo="<?php echo e($material->codigo); ?>" data-stock="<?php echo e($material->stock_actual); ?>">
                                            <?php echo e($material->nombre); ?> (<?php echo e($material->codigo); ?>) - Stock: <?php echo e($material->stock_actual); ?>

                                        </option>
                                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                </select>
                            </div>
                            
                            <div class="col-md-4 mb-3">
                                <label class="small font-weight-bold text-muted">CANTIDAD</label>
                                <input type="number" id="cantidadInput" class="form-control font-weight-bold text-center" min="1" value="1">
                            </div>
                        </div>
                        
                        <div class="text-right">
                            <button type="button" class="btn btn-success shadow-sm" id="btnAgregarAlCarrito">
                                <i class="fas fa-cart-plus"></i> Agregar al Carrito
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                
                <div class="card card-outline card-success shadow sticky-top" style="top: 20px;">
                    <div class="card-header">
                        <h3 class="card-title font-weight-bold"><i class="fas fa-clipboard-check"></i> Resumen</h3>
                    </div>
                    <div class="card-body">
                        <div class="d-flex justify-content-between mb-3 border-bottom pb-2">
                            <span class="text-muted">Total Items:</span>
                            <span id="totalItems" class="font-weight-bold h5 text-success mb-0">0</span>
                        </div>
                        
                        <div id="listaItems" class="mb-3" style="max-height: 400px; overflow-y: auto;">
                            <!-- Los items se mostrarán aquí -->
                        </div>
                        
                        <div id="emptyState" class="text-center py-4 text-muted">
                            <i class="fas fa-shopping-cart fa-2x mb-2"></i>
                            <p class="small mb-0">No hay items en el carrito</p>
                        </div>
                        
                        <div class="alert alert-info small mb-0">
                            <i class="fas fa-lightbulb"></i> <strong>Tip:</strong>
                            Agregue los materiales que desea ingresar al inventario.
                        </div>
                    </div>
                    <div class="card-footer bg-white">
                        <button type="submit" class="btn btn-success btn-block btn-lg shadow-sm">
                            <i class="fas fa-save"></i> Registrar Ingreso
                        </button>
                        <a href="<?php echo e(route('inventario.ingresos.index')); ?>" class="btn btn-default btn-block">
                            Cancelar
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>
<?php $__env->stopSection(); ?>

<?php $__env->startPush('scripts'); ?>
<script>
let carrito = [];
let itemCounter = 0;

// Inicializar Select2 para el material
$(document).ready(function() {
    $('#materialSelect').select2({
        theme: 'bootstrap4',
        placeholder: 'Seleccione un material...',
        allowClear: true
    });
    
    $('#emptyState').show();
});

// Agregar item al carrito
$('#btnAgregarAlCarrito').click(function() {
    const materialId = $('#materialSelect').val();
    const materialData = $('#materialSelect option:selected');
    
    if (!materialId) {
        Swal.fire({
            icon: 'warning',
            title: 'Material requerido',
            text: 'Por favor, seleccione un material.',
            confirmButtonText: 'Entendido'
        });
        return;
    }
    
    const cantidad = parseInt($('#cantidadInput').val()) || 1;
    
    // Crear objeto del item
    const item = {
        index: itemCounter++,
        material_id: materialId,
        nombre: materialData.data('nombre'),
        codigo: materialData.data('codigo'),
        stock_actual: materialData.data('stock'),
        cantidad: cantidad
    };
    
    // Agregar al carrito
    carrito.push(item);
    
    // Actualizar vista
    renderizarCarrito();
    limpiarFormulario();
    
    // Mostrar feedback
    toastr.success(`${item.nombre} agregado al carrito`);
});

// Renderizar el carrito en el resumen
function renderizarCarrito() {
    const $listaItems = $('#listaItems');
    $listaItems.empty();
    
    if (carrito.length === 0) {
        $('#emptyState').show();
        $('#totalItems').text('0');
        return;
    }
    
    $('#emptyState').hide();
    $('#totalItems').text(carrito.length);
    
    carrito.forEach((item, index) => {
        const itemHtml = `
            <div class="card mb-2 shadow-sm" data-index="${index}">
                <div class="card-body p-2">
                    <div class="d-flex justify-content-between align-items-start">
                        <div class="flex-grow-1">
                            <h6 class="mb-1 font-weight-bold text-dark" style="font-size: 0.9rem;">
                                ${item.nombre}
                            </h6>
                            <small class="text-muted d-block">${item.codigo}</small>
                            <div class="d-flex align-items-center gap-2 mt-1">
                                <span class="badge badge-success">+${item.cantidad}</span>
                                <small class="text-muted">Stock actual: ${item.stock_actual}</small>
                            </div>
                        </div>
                        <button type="button" class="btn btn-sm btn-danger btn-eliminar-item ml-2" data-index="${index}" title="Eliminar">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </div>
                    
                    <!-- Hidden inputs para enviar con el formulario -->
                    <input type="hidden" name="items[${index}][material_id]" value="${item.material_id}">
                    <input type="hidden" name="items[${index}][cantidad]" value="${item.cantidad}">
                </div>
            </div>
        `;
        $listaItems.append(itemHtml);
    });
}

// Eliminar item del carrito
$(document).on('click', '.btn-eliminar-item', function() {
    const index = $(this).data('index');
    carrito.splice(index, 1);
    renderizarCarrito();
    toastr.info('Item eliminado del carrito');
});

// Limpiar formulario después de agregar
function limpiarFormulario() {
    $('#materialSelect').val(null).trigger('change');
    $('#cantidadInput').val('1');
}

// Validar formulario antes de enviar
$('#formIngreso').submit(function(e) {
    if (carrito.length === 0) {
        e.preventDefault();
        Swal.fire({
            icon: 'warning',
            title: 'Carrito vacío',
            text: 'Debe agregar al menos un material al ingreso.',
            confirmButtonText: 'Entendido'
        });
        return false;
    }
});
</script>
<?php $__env->stopPush(); ?>

<?php echo $__env->make('layouts.adminlte', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH C:\wamp64\www\somossalud\resources\views/inventario/ingresos/create.blade.php ENDPATH**/ ?>