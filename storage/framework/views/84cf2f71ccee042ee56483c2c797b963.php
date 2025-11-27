

<?php $__env->startSection('title', 'Ingresos de Inventario'); ?>

<?php $__env->startSection('content-header'); ?>
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-dolly text-success"></i> Ingresos de Inventario</h1>
        <a href="<?php echo e(route('inventario.ingresos.create')); ?>" class="btn btn-success shadow-sm">
            <i class="fas fa-plus-circle"></i> Nuevo Ingreso
        </a>
    </div>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('content'); ?>
    <div class="card shadow-lg border-0">
        <div class="card-header bg-white border-bottom-0">
            <h3 class="card-title text-muted"><i class="fas fa-history"></i> Historial de Ingresos</h3>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="bg-light text-muted">
                        <tr>
                            <th class="pl-4">Fecha</th>
                            <th>Material</th>
                            <th>Usuario</th>
                            <th>Motivo / Referencia</th>
                            <th class="text-center">Cantidad</th>
                            <th class="text-center">Stock Resultante</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $__empty_1 = true; $__currentLoopData = $movimientos; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $mov): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
                            <tr>
                                <td class="pl-4 align-middle">
                                    <?php echo e($mov->created_at->format('d/m/Y H:i')); ?>

                                </td>
                                <td class="align-middle">
                                    <div class="font-weight-bold"><?php echo e($mov->material->nombre); ?></div>
                                    <small class="text-muted"><?php echo e($mov->material->codigo); ?></small>
                                </td>
                                <td class="align-middle">
                                    <?php echo e($mov->user->name); ?>

                                </td>
                                <td class="align-middle">
                                    <div><?php echo e($mov->motivo); ?></div>
                                    <?php if($mov->referencia): ?>
                                        <small class="text-muted"><i class="fas fa-hashtag"></i> <?php echo e($mov->referencia); ?></small>
                                    <?php endif; ?>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="badge badge-success px-3 py-2" style="font-size: 1rem;">
                                        +<?php echo e($mov->cantidad); ?>

                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="font-weight-bold text-dark"><?php echo e($mov->stock_nuevo); ?></span>
                                </td>
                            </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
                            <tr>
                                <td colspan="6" class="text-center py-5 text-muted">
                                    <i class="fas fa-box-open fa-3x mb-3"></i>
                                    <p>No hay registros de ingresos.</p>
                                </td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
        <?php if($movimientos->hasPages()): ?>
            <div class="card-footer bg-white">
                <?php echo e($movimientos->links()); ?>

            </div>
        <?php endif; ?>
    </div>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.adminlte', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH C:\wamp64\www\somossalud\resources\views/inventario/ingresos/index.blade.php ENDPATH**/ ?>