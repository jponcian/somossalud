<?php $__env->startSection('title', 'Órdenes de Laboratorio'); ?>

<?php $__env->startSection('content'); ?>
<div class="row">
    <div class="col-12">
        <div class="card shadow-sm border-0 rounded-lg overflow-hidden">
            <div class="card-header border-0 d-flex align-items-center" style="background: linear-gradient(135deg, #dbeafe 0%, #dcfce7 100%); border-bottom: 1px solid #cbd5e1;">
                <h3 class="card-title font-weight-bold text-primary mb-0">
                    <i class="fas fa-flask mr-2"></i> Órdenes de Laboratorio
                </h3>
                <div class="ms-auto ml-auto">
                    <a href="<?php echo e(route('lab.orders.create')); ?>" 
                       class="btn btn-primary shadow-sm font-weight-bold">
                        <i class="fas fa-plus-circle mr-2"></i> Nueva Orden
                    </a>
                </div>
            </div>

            <?php if(session('success')): ?>
                <div class="alert alert-success alert-dismissible fade show mx-3 mt-3" role="alert">
                    <i class="fas fa-check-circle mr-2"></i> <?php echo e(session('success')); ?>

                    <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
            <?php endif; ?>

            <div class="card-body p-0">
                <?php if($orders->count() > 0): ?>
                    <div class="table-responsive mb-0">
                        <table class="table table-hover mb-0 align-middle">
                            <thead style="background-color: #f8fafc;">
                                <tr>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold pl-4">Nº Orden</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Nº Diario</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Paciente</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Exámenes</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Fecha Orden</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Fecha Resultado</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold">Estado</th>
                                    <th class="border-top-0 text-uppercase text-secondary small font-weight-bold pr-4">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php $__currentLoopData = $orders; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $order): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <tr>
                                        <td class="pl-4">
                                            <code class="text-primary font-weight-bold"><?php echo e($order->order_number); ?></code>
                                        </td>
                                        <td>
                                            <span class="badge badge-success px-3 py-1 rounded-pill"><?php echo e($order->daily_exam_count); ?></span>
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="rounded-circle bg-light d-flex align-items-center justify-content-center mr-2 text-primary font-weight-bold" style="width: 32px; height: 32px; font-size: 0.8rem;">
                                                    <?php echo e(substr($order->patient->name, 0, 1)); ?>

                                                </div>
                                                <div>
                                                    <div class="font-weight-bold text-dark"><?php echo e($order->patient->name); ?></div>
                                                    <small class="text-muted"><?php echo e($order->patient->cedula); ?></small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <span class="badge badge-info px-3 py-1 rounded-pill">
                                                <i class="fas fa-vial mr-1"></i> <?php echo e($order->details->count()); ?>

                                            </span>
                                        </td>
                                        <td>
                                            <i class="fas fa-calendar-alt text-primary mr-2"></i>
                                            <span class="small"><?php echo e($order->order_date->format('d/m/Y')); ?></span>
                                        </td>
                                        <td>
                                            <?php if($order->result_date): ?>
                                                <i class="fas fa-calendar-check text-success mr-2"></i>
                                                <span class="small"><?php echo e($order->result_date->format('d/m/Y')); ?></span>
                                            <?php else: ?>
                                                <span class="text-muted small font-italic">Pendiente</span>
                                            <?php endif; ?>
                                        </td>
                                        <td>
                                            <?php
                                                $badgeClass = match($order->status) {
                                                    'pending' => 'badge-warning',
                                                    'in_progress' => 'badge-info',
                                                    'completed' => 'badge-success',
                                                    default => 'badge-secondary'
                                                };
                                                $statusLabel = match($order->status) {
                                                    'pending' => 'Pendiente',
                                                    'in_progress' => 'En Proceso',
                                                    'completed' => 'Completado',
                                                    default => 'Cancelado'
                                                };
                                            ?>
                                            <span class="badge <?php echo e($badgeClass); ?> px-3 py-1 rounded-pill small">
                                                <?php echo e($statusLabel); ?>

                                            </span>
                                        </td>
                                        <td class="text-right pr-4">
                                            <div class="btn-group" role="group">
                                                <?php if($order->isPending() || $order->isInProgress()): ?>
                                                    <a href="<?php echo e(route('lab.orders.load-results', $order->id)); ?>"
                                                        class="btn btn-light btn-sm rounded-circle shadow-sm text-primary mr-1" 
                                                        title="Cargar resultados">
                                                        <i class="fas fa-edit"></i>
                                                    </a>
                                                <?php endif; ?>

                                                <a href="<?php echo e(route('lab.orders.show', $order->id)); ?>" 
                                                   class="btn btn-light btn-sm rounded-circle shadow-sm text-info mr-1"
                                                   title="Ver detalle">
                                                    <i class="fas fa-eye"></i>
                                                </a>

                                                <?php if($order->isCompleted()): ?>
                                                    <a href="<?php echo e(route('lab.orders.pdf', $order->id)); ?>" 
                                                       class="btn btn-light btn-sm rounded-circle shadow-sm text-danger"
                                                       title="Descargar PDF">
                                                        <i class="fas fa-file-pdf"></i>
                                                    </a>
                                                <?php endif; ?>
                                            </div>
                                        </td>
                                    </tr>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </tbody>
                        </table>
                    </div>

                    <?php if($orders->hasPages()): ?>
                    <div class="d-flex justify-content-center py-3 border-top">
                        <?php echo e($orders->links()); ?>

                    </div>
                    <?php endif; ?>
                <?php else: ?>
                    <div class="text-center py-5">
                        <i class="fas fa-flask fa-3x mb-3 opacity-50" style="color: #cbd5e1;"></i>
                        <p class="mb-3 text-muted">No hay órdenes de laboratorio registradas.</p>
                        <a href="<?php echo e(route('lab.orders.create')); ?>" class="btn btn-primary shadow-sm font-weight-bold">
                            <i class="fas fa-plus-circle mr-2"></i> Crear Primera Orden
                        </a>
                    </div>
                <?php endif; ?>
            </div>
        </div>
    </div>
</div>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('css'); ?>
<style>
    .table-hover tbody tr:hover {
        background-color: #f8fafc;
        transition: background-color 0.2s ease;
    }

    .btn-group .btn {
        transition: all 0.2s ease;
    }

    .btn-group .btn:hover {
        transform: translateY(-2px);
    }

    .badge {
        font-weight: 600;
        letter-spacing: 0.3px;
    }

    .rounded-circle {
        flex-shrink: 0;
    }
</style>
<?php $__env->stopSection(); ?>
<?php echo $__env->make('layouts.adminlte', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH C:\wamp64\www\somossalud\resources\views/lab/orders/index.blade.php ENDPATH**/ ?>