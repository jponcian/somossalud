

<?php $__env->startSection('title', 'Solicitudes de Inventario'); ?>

<?php $__env->startSection('content_header'); ?>
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-clipboard-list text-primary"></i> Solicitudes de Inventario</h1>
        <div>
            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('create', App\Models\SolicitudInventario::class)): ?>
                <a href="<?php echo e(route('inventario.solicitudes.create')); ?>" class="btn btn-primary btn-lg shadow-sm mr-2">
                    <i class="fas fa-plus-circle"></i> Nueva Solicitud
                </a>
            <?php endif; ?>
            <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('create', App\Models\Material::class)): ?>
                <a href="<?php echo e(route('inventario.materiales.create')); ?>" class="btn btn-success btn-lg shadow-sm">
                    <i class="fas fa-box"></i> Registrar Material Nuevo
                </a>
            <?php endif; ?>
        </div>
    </div>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('content'); ?>
    
    <div class="row mb-4">
        <div class="col-md-4">
            <div class="small-box bg-warning shadow-sm">
                <div class="inner">
                    <h3><?php echo e($stats['pendientes']); ?></h3>
                    <p>Pendientes de Aprobación</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="small-box bg-info shadow-sm">
                <div class="inner">
                    <h3><?php echo e($stats['aprobadas']); ?></h3>
                    <p>Aprobadas / Por Despachar</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check-circle"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="small-box bg-success shadow-sm">
                <div class="inner">
                    <h3><?php echo e($stats['despachadas_mes']); ?></h3>
                    <p>Despachadas en <?php echo e(now()->locale('es')->translatedFormat('F Y')); ?></p>
                </div>
                <div class="icon">
                    <i class="fas fa-truck-loading"></i>
                </div>
            </div>
        </div>
    </div>

    
    <div class="card shadow-sm mb-4">
        <div class="card-header bg-light">
            <h3 class="card-title text-muted"><i class="fas fa-filter"></i> Filtros de Búsqueda</h3>
            <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                </button>
            </div>
        </div>
        <div class="card-body">
            <form method="GET" action="<?php echo e(route('inventario.solicitudes.index')); ?>">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">ESTADO</label>
                            <select name="estado" class="form-control select2" data-minimum-results-for-search="Infinity">
                                <option value="">Todos los estados</option>
                                <option value="pendiente" <?php echo e(request('estado') == 'pendiente' ? 'selected' : ''); ?>>Pendiente</option>
                                <option value="aprobada" <?php echo e(request('estado') == 'aprobada' ? 'selected' : ''); ?>>Aprobada</option>
                                <option value="despachada" <?php echo e(request('estado') == 'despachada' ? 'selected' : ''); ?>>Despachada</option>
                                <option value="rechazada" <?php echo e(request('estado') == 'rechazada' ? 'selected' : ''); ?>>Rechazada</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">CATEGORÍA</label>
                            <select name="categoria" class="form-control select2" data-minimum-results-for-search="Infinity">
                                <option value="">Todas las categorías</option>
                                <option value="ENFERMERIA" <?php echo e(request('categoria') == 'ENFERMERIA' ? 'selected' : ''); ?>>Enfermería</option>
                                <option value="QUIROFANO" <?php echo e(request('categoria') == 'QUIROFANO' ? 'selected' : ''); ?>>Quirófano</option>
                                <option value="UCI" <?php echo e(request('categoria') == 'UCI' ? 'selected' : ''); ?>>UCI</option>
                                <option value="OFICINA" <?php echo e(request('categoria') == 'OFICINA' ? 'selected' : ''); ?>>Oficina</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">DESDE</label>
                            <input type="date" name="fecha_desde" class="form-control" value="<?php echo e(request('fecha_desde')); ?>">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">HASTA</label>
                            <input type="date" name="fecha_hasta" class="form-control" value="<?php echo e(request('fecha_hasta')); ?>">
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    
    <div class="card shadow-lg border-0">
        <div class="card-header bg-white border-bottom-0">
            <h3 class="card-title text-primary font-weight-bold"><i class="fas fa-list-alt"></i> Listado de Solicitudes</h3>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="bg-light text-muted">
                        <tr>
                            <th class="pl-4">Número</th>
                            <th>Fecha</th>
                            <th>Solicitante</th>
                            <th>Categoría</th>
                            <th class="text-center">Items</th>
                            <th class="text-center">Estado</th>
                            <th class="text-right pr-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php $__empty_1 = true; $__currentLoopData = $solicitudes; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $solicitud): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); $__empty_1 = false; ?>
                            <tr>
                                <td class="pl-4 align-middle">
                                    <span class="font-weight-bold text-dark"><?php echo e($solicitud->numero_solicitud); ?></span>
                                </td>
                                <td class="align-middle">
                                    <i class="far fa-calendar-alt text-muted mr-1"></i>
                                    <?php echo e($solicitud->created_at->format('d/m/Y H:i')); ?>

                                </td>
                                <td class="align-middle">
                                    <div class="d-flex align-items-center">
                                        <div class="avatar-circle bg-light text-primary mr-2" style="width:30px;height:30px;border-radius:50%;display:flex;align-items:center;justify-content:center;font-weight:bold;">
                                            <?php echo e(substr($solicitud->solicitante->name, 0, 1)); ?>

                                        </div>
                                        <?php echo e($solicitud->solicitante->name); ?>

                                    </div>
                                </td>
                                <td class="align-middle">
                                    <span class="badge badge-light border px-2 py-1">
                                        <?php echo e($solicitud->categoria); ?>

                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="badge badge-pill badge-info px-3">
                                        <?php echo e($solicitud->total_items); ?>

                                    </span>
                                </td>
                                <td class="align-middle text-center">
                                    <span class="badge badge-<?php echo e($solicitud->badge_color); ?> px-3 py-2 rounded-pill shadow-sm">
                                        <?php echo e(ucfirst($solicitud->estado)); ?>

                                    </span>
                                </td>
                                <td class="align-middle text-right pr-4">
                                    <div class="btn-group">
                                        <a href="<?php echo e(route('inventario.solicitudes.show', $solicitud)); ?>" 
                                           class="btn btn-sm btn-outline-primary" 
                                           title="Ver detalle">
                                            <i class="fas fa-eye"></i>
                                        </a>
                                        
                                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('approve', $solicitud)): ?>
                                            <?php if($solicitud->isPendiente()): ?>
                                                <a href="<?php echo e(route('inventario.solicitudes.edit', $solicitud)); ?>" 
                                                   class="btn btn-sm btn-outline-warning" 
                                                   title="Gestionar Aprobación">
                                                    <i class="fas fa-tasks"></i>
                                                </a>
                                            <?php endif; ?>
                                        <?php endif; ?>
                                        
                                        <?php if (app(\Illuminate\Contracts\Auth\Access\Gate::class)->check('delete', $solicitud)): ?>
                                            <?php if($solicitud->isPendiente()): ?>
                                                <form action="<?php echo e(route('inventario.solicitudes.destroy', $solicitud)); ?>" 
                                                      method="POST" 
                                                      style="display: inline-block;"
                                                      onsubmit="return confirm('¿Está seguro de eliminar esta solicitud?');">
                                                    <?php echo csrf_field(); ?>
                                                    <?php echo method_field('DELETE'); ?>
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Eliminar">
                                                        <i class="fas fa-trash"></i>
                                                    </button>
                                                </form>
                                            <?php endif; ?>
                                        <?php endif; ?>
                                    </div>
                                </td>
                            </tr>
                        <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); if ($__empty_1): ?>
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <div class="empty-state">
                                        <i class="fas fa-inbox fa-4x text-muted mb-3"></i>
                                        <h5 class="text-muted">No se encontraron solicitudes</h5>
                                        <p class="text-muted small">Intente ajustar los filtros o cree una nueva solicitud.</p>
                                    </div>
                                </td>
                            </tr>
                        <?php endif; ?>
                    </tbody>
                </table>
            </div>
        </div>
        <?php if($solicitudes->hasPages()): ?>
            <div class="card-footer bg-white">
                <?php echo e($solicitudes->links()); ?>

            </div>
        <?php endif; ?>
    </div>
<?php $__env->stopSection(); ?>

<?php $__env->startPush('styles'); ?>
<style>
    .avatar-circle {
        font-size: 14px;
    }
    .table td {
        vertical-align: middle;
    }
</style>
<?php $__env->stopPush(); ?>

<?php $__env->startPush('scripts'); ?>
<script>
$(document).ready(function() {
    // Aplica select2 con tema bootstrap4 a todos los select2
    $('select.select2').select2({
        theme: 'bootstrap4',
        width: '100%'
    });
});
</script>
<?php $__env->stopPush(); ?>

<?php echo $__env->make('layouts.adminlte', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH C:\wamp64\www\somossalud\resources\views/inventario/solicitudes/index.blade.php ENDPATH**/ ?>