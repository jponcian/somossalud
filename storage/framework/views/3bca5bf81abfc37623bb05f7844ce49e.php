

<?php $__env->startSection('title', 'Gestión de Materiales'); ?>

<?php $__env->startSection('content-header'); ?>
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-boxes text-primary"></i> Gestión de Materiales</h1>
        <a href="<?php echo e(route('inventario.materiales.create')); ?>" class="btn btn-primary shadow-sm">
            <i class="fas fa-plus"></i> Nuevo Material
        </a>
    </div>
<?php $__env->stopSection(); ?>

<?php $__env->startSection('content'); ?>
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
            <form method="GET" action="<?php echo e(route('inventario.materiales.index')); ?>">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">BUSCAR</label>
                            <input type="text" name="search" class="form-control" placeholder="Buscar por nombre o código..." value="<?php echo e(request('search')); ?>">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">CATEGORÍA</label>
                            <select name="categoria" class="form-control select2" data-minimum-results-for-search="Infinity">
                                <option value="">Todas las categorías</option>
                                <?php $__currentLoopData = $categorias; $__env->addLoop($__currentLoopData); foreach($__currentLoopData as $cat): $__env->incrementLoopIndices(); $loop = $__env->getLastLoop(); ?>
                                    <option value="<?php echo e($cat); ?>" <?php echo e(request('categoria') == $cat ? 'selected' : ''); ?>><?php echo e($cat); ?></option>
                                <?php endforeach; $__env->popLoop(); $loop = $__env->getLastLoop(); ?>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">ESTADO DE STOCK</label>
                            <select name="stock_status" class="form-control select2" data-minimum-results-for-search="Infinity">
                                <option value="">Todos</option>
                                <option value="bajo" <?php echo e(request('stock_status') == 'bajo' ? 'selected' : ''); ?>>Stock Bajo</option>
                                <option value="normal" <?php echo e(request('stock_status') == 'normal' ? 'selected' : ''); ?>>Stock Normal</option>
                            </select>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    <div class="card shadow-lg border-0">
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-hover table-striped mb-0">
                    <thead class="bg-light text-muted">
                        <tr>
                            <th class="pl-4">Código</th>
                            <th>Nombre</th>
                            <th>Categoría</th>
                            <th>Unidad</th>
                            <th class="text-center">Stock Actual</th>
                            <th class="text-center">Stock Mínimo</th>
                            <th class="text-right pr-4">Acciones</th>
                        </tr>
                    </thead>
                    <tbody id="materialesTableBody">
                        <?php echo $__env->make('inventario.materiales.table_rows', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?>
                    </tbody>
                </table>
            </div>
        </div>
        <div id="paginationLinks">
            <?php if($materiales->hasPages()): ?>
                <div class="card-footer bg-white">
                    <?php echo e($materiales->links()); ?>

                </div>
            <?php endif; ?>
        </div>
    </div>
<?php $__env->stopSection(); ?>

<?php $__env->startPush('scripts'); ?>
<script>
    $(document).ready(function() {
        let searchTimeout;

        function fetchMateriales() {
            const search = $('input[name="search"]').val();
            const categoria = $('select[name="categoria"]').val();
            const stockStatus = $('select[name="stock_status"]').val();

            $.ajax({
                url: "<?php echo e(route('inventario.materiales.index')); ?>",
                type: "GET",
                data: {
                    search: search,
                    categoria: categoria,
                    stock_status: stockStatus
                },
                success: function(response) {
                    $('#materialesTableBody').html(response);
                },
                error: function(xhr) {
                    console.error('Error fetching materials:', xhr);
                }
            });
        }

        $('input[name="search"]').on('input', function() {
            clearTimeout(searchTimeout);
            const val = $(this).val();

            if (val.length > 2 || val.length === 0) {
                searchTimeout = setTimeout(fetchMateriales, 300);
            }
        });

        $('select[name="categoria"]').on('change', function() {
            fetchMateriales();
        });

        $('select[name="stock_status"]').on('change', function() {
            fetchMateriales();
        });
        
        // Prevent form submission on enter for search input
        $('form').on('submit', function(e) {
            e.preventDefault();
            fetchMateriales();
        });

        // Initialize select2
        $('.select2').select2({
            theme: 'bootstrap4',
            width: '100%'
        });
    });
</script>
<?php $__env->stopPush(); ?>

<?php echo $__env->make('layouts.adminlte', array_diff_key(get_defined_vars(), ['__data' => 1, '__path' => 1]))->render(); ?><?php /**PATH C:\wamp64\www\somossalud\resources\views/inventario/materiales/index.blade.php ENDPATH**/ ?>