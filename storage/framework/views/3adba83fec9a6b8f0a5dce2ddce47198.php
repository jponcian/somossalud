<?php $__env->startSection('title', 'Detalle de Orden'); ?>

<?php $__env->startSection('sidebar'); ?>
    <?php echo $__env->make('panel.partials.sidebar', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('content_header'); ?>
    <h1>Detalle de Orden de Laboratorio</h1>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('content'); ?>
<div class="container-fluid">
    <?php if(session('success')): ?>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <i class="fas fa-check-circle"></i> <?php echo e(session('success')); ?>

        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
            <span aria-hidden="true">&times;</span>
        </button>
    </div>
    <?php endif; ?>

    <div class="row">
        <div class="col-md-8">
            <!-- Información de la Orden -->
            <div class="card">
                <div class="card-header" style="background: linear-gradient(135deg, #0ea5e9 0%, #10b981 100%); color: white;">
                    <h3 class="card-title mb-0">
                        <i class="fas fa-file-medical"></i> Orden <?php echo e($order->order_number); ?>

                    </h3>
                </div>
                <div class="card-body">
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <h5 class="text-muted mb-2">Información del Paciente</h5>
                            <p class="mb-1"><strong>Nombre:</strong> <?php echo e($order->patient->name); ?></p>
                            <p class="mb-1"><strong>Cédula:</strong> <?php echo e($order->patient->cedula); ?></p>
                            <p class="mb-1"><strong>Email:</strong> <?php echo e($order->patient->email); ?></p>
                        </div>
                        <div class="col-md-6">
                            <h5 class="text-muted mb-2">Información de la Orden</h5>
                            <p class="mb-1"><strong>Estado:</strong> 
                                <?php if($order->status == 'pending'): ?>
                                    <span class="badge badge-warning">Pendiente</span>
                                <?php elseif($order->status == 'in_progress'): ?>
                                    <span class="badge badge-info">En Proceso</span>
                                <?php elseif($order->status == 'completed'): ?>
                                    <span class="badge badge-success">Completado</span>
                                <?php else: ?>
                                    <span class="badge badge-danger">Cancelado</span>
                                <?php endif; ?>
                            </p>
                            <p class="mb-1"><strong>Fecha Orden:</strong> <?php echo e($order->order_date->format('d/m/Y')); ?></p>
                            <?php if($order->sample_date): ?>
                                <p class="mb-1"><strong>Fecha Muestra:</strong> <?php echo e($order->sample_date->format('d/m/Y')); ?></p>
                            <?php endif; ?>
                            <?php if($order->result_date): ?>
                                <p class="mb-1"><strong>Fecha Resultado:</strong> <?php echo e($order->result_date->format('d/m/Y')); ?></p>
                            <?php endif; ?>
                            <p class="mb-1"><strong>Clínica:</strong> <?php echo e($order->clinica->nombre); ?></p>
                        </div>
                    </div>

                    <hr>

                    <h5 class="text-muted mb-3">Exámenes Solicitados</h5>
                    <?php $__currentLoopData = $order->details; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $detail): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                        <div class="mb-4">
                            <h6 class="text-primary">
                                <i class="fas fa-flask"></i> <?php echo e($detail->exam->name); ?>

                                <span class="badge badge-info">$<?php echo e(number_format($detail->price, 2)); ?></span>
                            </h6>
                            
                            <?php if($detail->results->count() > 0): ?>
                                <div class="table-responsive">
                                    <table class="table table-bordered table-hover table-sm">
                                        <thead class="thead-light">
                                            <tr>
                                                <th>Parámetro</th>
                                                <th>Valor</th>
                                                <th>Unidad</th>
                                                <th>Rango de Referencia</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <?php $__currentLoopData = $detail->results; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $result): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                            <tr>
                                                <td><strong><?php echo e($result->examItem->name); ?></strong></td>
                                                <td><?php echo e($result->value); ?></td>
                                                <td><?php echo e($result->examItem->unit ?? '-'); ?></td>
                                                <td>
                                                    <?php
                                                        $rango = $result->examItem->getReferenceRangeForPatient($order->patient);
                                                    ?>
                                                    <?php if($rango): ?>
                                                        <span class="badge badge-light border text-wrap" style="font-size: 0.9em;">
                                                            <?php echo e($rango->value_text ?? ($rango->value_min . ' - ' . $rango->value_max)); ?>

                                                        </span>
                                                        <?php if($rango->condition): ?>
                                                            <br><small class="text-muted">(<?php echo e($rango->condition); ?>)</small>
                                                        <?php endif; ?>
                                                    <?php else: ?>
                                                        <?php echo e($result->examItem->reference_value ?? '-'); ?>

                                                    <?php endif; ?>
                                                </td>
                                            </tr>
                                            <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                                        </tbody>
                                    </table>
                                </div>
                            <?php else: ?>
                                <p class="text-muted"><em>Sin resultados cargados</em></p>
                            <?php endif; ?>
                        </div>
                    <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>

                    <?php if($order->observations): ?>
                    <hr>
                    <h5 class="text-muted mb-2">Observaciones</h5>
                    <p class="text-justify"><?php echo e($order->observations); ?></p>
                    <?php endif; ?>

                    <hr>

                    <div class="row">
                        <div class="col-md-6">
                            <p class="mb-1"><strong>Registrado por:</strong> <?php echo e($order->createdBy->name ?? 'N/A'); ?></p>
                            <p class="mb-1"><strong>Fecha de registro:</strong> <?php echo e($order->created_at->format('d/m/Y H:i')); ?></p>
                        </div>
                        <div class="col-md-6 text-right">
                            <p class="mb-1"><strong>Total:</strong> <span class="h4 text-success">$<?php echo e(number_format($order->total, 2)); ?></span></p>
                        </div>
                    </div>
                </div>
                <div class="card-footer">
                    <?php if($order->isCompleted()): ?>
                        <a href="<?php echo e(route('lab.orders.pdf', $order->id)); ?>" class="btn btn-danger">
                            <i class="fas fa-file-pdf"></i> Descargar PDF con QR
                        </a>
                    <?php endif; ?>
                    <?php if($order->isPending() || $order->isInProgress()): ?>
                        <a href="<?php echo e(route('lab.orders.load-results', $order->id)); ?>" class="btn btn-primary">
                            <i class="fas fa-edit"></i> Cargar Resultados
                        </a>
                    <?php endif; ?>
                    <a href="<?php echo e(route('lab.orders.index')); ?>" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Volver al Listado
                    </a>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <?php if($order->isCompleted() && $order->verification_code): ?>
                <!-- Código de Verificación -->
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-qrcode"></i> Código de Verificación
                        </h3>
                    </div>
                    <div class="card-body text-center">
                        <div class="mb-3">
                            <?php echo QrCode::size(200)->generate(route('lab.orders.verify', $order->verification_code)); ?>

                        </div>
                        <p class="mb-2"><strong>Código:</strong></p>
                        <h4 class="text-primary"><?php echo e($order->verification_code); ?></h4>
                        <hr>
                        <p class="text-muted small mb-2">URL de Verificación:</p>
                        <a href="<?php echo e(route('lab.orders.verify', $order->verification_code)); ?>" target="_blank" class="btn btn-sm btn-outline-primary">
                            <i class="fas fa-external-link-alt"></i> Verificar Resultado
                        </a>
                    </div>
                </div>

                <!-- Información Adicional -->
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-info-circle"></i> Información
                        </h3>
                    </div>
                    <div class="card-body">
                        <p class="small text-muted mb-2">
                            <i class="fas fa-shield-alt"></i> Este resultado puede ser verificado escaneando el código QR o ingresando el código de verificación en nuestro sitio web.
                        </p>
                        <p class="small text-muted mb-0">
                            <i class="fas fa-lock"></i> El código QR garantiza la autenticidad del documento y previene falsificaciones.
                        </p>
                    </div>
                </div>
            <?php else: ?>
                <!-- Estado de la Orden -->
                <div class="card">
                    <div class="card-header bg-warning text-white">
                        <h3 class="card-title mb-0">
                            <i class="fas fa-exclamation-triangle"></i> Estado
                        </h3>
                    </div>
                    <div class="card-body">
                        <p class="mb-2">
                            <strong>Esta orden aún no tiene resultados cargados.</strong>
                        </p>
                        <p class="text-muted small mb-0">
                            El código QR de verificación se generará automáticamente cuando se carguen los resultados.
                        </p>
                    </div>
                </div>
            <?php endif; ?>
        </div>
    </div>
</div>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('css'); ?>
<style>
    .table th {
        background-color: #f8f9fa;
        font-weight: 600;
    }
    
    .card-header {
        border-radius: 0.25rem 0.25rem 0 0 !important;
    }
</style>
<?php $__env->stopSection(); ?>

<?php echo $__env->make('layouts.adminlte', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH C:\wamp64\www\somossalud\resources\views/lab/orders/show.blade.php ENDPATH**/ ?>