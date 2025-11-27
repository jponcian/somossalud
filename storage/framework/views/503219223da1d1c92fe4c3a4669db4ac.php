<?php $__empty_1 = true; $__currentLoopData = $materiales; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $material): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
    <tr>
        <td class="pl-4 font-weight-bold text-muted"><?php echo e($material->codigo); ?></td>
        <td>
            <div class="font-weight-bold"><?php echo e($material->nombre); ?></div>
            <small class="text-muted"><?php echo e(Str::limit($material->descripcion, 50)); ?></small>
        </td>
        <td><span class="badge badge-light border"><?php echo e($material->categoria_default); ?></span></td>
        <td><?php echo e($material->unidad_medida_default); ?></td>
        <td class="text-center">
            <span class="badge badge-<?php echo e($material->stock_actual <= $material->stock_minimo ? 'danger' : 'success'); ?> px-3 py-2" style="font-size: 1rem;">
                <?php echo e($material->stock_actual); ?>

            </span>
        </td>
        <td class="text-center text-muted"><?php echo e($material->stock_minimo); ?></td>
        <td class="text-right pr-4">
            <a href="<?php echo e(route('inventario.materiales.edit', $material)); ?>" class="btn btn-sm btn-outline-primary" title="Editar">
                <i class="fas fa-edit"></i>
            </a>
            <form action="<?php echo e(route('inventario.materiales.destroy', $material)); ?>" method="POST" class="d-inline" onsubmit="return confirm('¿Eliminar material?');">
                <?php echo csrf_field(); ?> <?php echo method_field('DELETE'); ?>
                <button type="submit" class="btn btn-sm btn-outline-danger" title="Eliminar">
                    <i class="fas fa-trash"></i>
                </button>
            </form>
        </td>
    </tr>
<?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
    <tr>
        <td colspan="7" class="text-center py-5 text-muted">No se encontraron materiales.</td>
    </tr>
<?php endif; ?>
<?php /**PATH C:\wamp64\www\somossalud\resources\views/inventario/materiales/table_rows.blade.php ENDPATH**/ ?>