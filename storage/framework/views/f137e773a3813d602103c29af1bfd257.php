<nav class="mt-2">
    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        <!-- INICIO -->
        <li class="nav-item">
            <a href="<?php echo e(route('panel.clinica')); ?>"
                class="nav-link <?php echo e(request()->routeIs('panel.clinica') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-home"></i>
                <p>Inicio</p>
            </a>
        </li>
        <!-- SECCIÓN CLÍNICA -->
        <?php if (\Illuminate\Support\Facades\Blade::check('hasanyrole', 'super-admin|admin_clinica|especialista')): ?>
        <li class="nav-header">CLÍNICA</li>
        <?php if (\Illuminate\Support\Facades\Blade::check('hasanyrole', 'super-admin|admin_clinica')): ?>
        <li class="nav-item">
            <a href="<?php echo e(route('recepcion.pagos.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('recepcion.pagos.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-money-check-alt"></i>
                <p>Validar pagos</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="<?php echo e(route('atenciones.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('atenciones.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-briefcase-medical"></i>
                <p>Atenciones</p>
            </a>
        </li>
        <?php endif; ?>
        <?php if (\Illuminate\Support\Facades\Blade::check('role', 'especialista')): ?>
        <li class="nav-item"></li>
        <a href="<?php echo e(route('citas.index')); ?>" class="nav-link <?php echo e(request()->routeIs('citas.*') ? 'active' : ''); ?>">
            <i class="nav-icon fas fa-notes-medical"></i>
            <p>Mis citas</p>
        </a>
        </li>
        <li class="nav-item">
            <a href="<?php echo e(route('atenciones.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('atenciones.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-ambulance"></i>
                <p>Mis atenciones</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="<?php echo e(route('especialista.horarios.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('especialista.horarios.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-calendar-check"></i>
                <p>Mis horarios</p>
            </a>
        </li>
        <?php endif; ?>
        <?php endif; ?>
        <!-- SECCIÓN LABORATORIO -->
        <?php if (\Illuminate\Support\Facades\Blade::check('hasanyrole', 'super-admin|admin_clinica|laboratorio|recepcionista')): ?>
        <li class="nav-header">LABORATORIO</li>
        <!-- Sistema de Órdenes (Nuevo) -->
        <li class="nav-item">
            <a href="<?php echo e(route('lab.orders.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('lab.orders.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-file-medical"></i>
                <p>Exámenes</p>
            </a>
        </li>
        <?php endif; ?>
        <!-- SECCIÓN INVENTARIO -->
        <?php if (\Illuminate\Support\Facades\Blade::check('hasanyrole', 'super-admin|admin_clinica|almacen')): ?>
        <li class="nav-header">INVENTARIO</li>
             <li class="nav-item">
            <a href="<?php echo e(route('inventario.solicitudes.create')); ?>"
                class="nav-link <?php echo e(request()->routeIs('inventario.solicitudes.create') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-plus-circle"></i>
                <p>Nueva Solicitud</p>
            </a>
        </li>   <li class="nav-item">
            <a href="<?php echo e(route('inventario.solicitudes.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('inventario.solicitudes.index') || request()->routeIs('inventario.solicitudes.show') || request()->routeIs('inventario.solicitudes.edit') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-boxes"></i>
                <p>Solicitudes</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="<?php echo e(route('inventario.ingresos.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('inventario.ingresos.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-dolly"></i>
                <p>Ingresos</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="<?php echo e(route('inventario.materiales.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('inventario.materiales.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-cubes"></i>
                <p>Gestión de Materiales</p>
            </a>
        </li>

        <?php endif; ?>
        <!-- SECCIÓN CONFIGURACIÓN -->
        <?php if (\Illuminate\Support\Facades\Blade::check('hasanyrole', 'super-admin|admin_clinica')): ?>
        <li class="nav-header">CONFIGURACIÓN</li>
        <li class="nav-item">
            <a href="<?php echo e(route('admin.users.index')); ?>"
                class="nav-link <?php echo e(request()->routeIs('admin.users.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-users-cog"></i>
                <p>Gestión de usuarios</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="<?php echo e(route('admin.settings.pagos')); ?>"
                class="nav-link <?php echo e(request()->routeIs('admin.settings.*') ? 'active' : ''); ?>">
                <i class="nav-icon fas fa-credit-card"></i>
                <p>Pago móvil</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="<?php echo e(route('admin.settings.cache.clear')); ?>" class="nav-link text-warning" id="btn-limpiar-cache">
                <i class="nav-icon fas fa-broom"></i>
                <p>Limpiar Caché</p>
            </a>
        </li>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                document.getElementById('btn-limpiar-cache').addEventListener('click', function (e) {
                    e.preventDefault();
                    const url = this.href;
                    Swal.fire({
                        title: '¿Limpiar caché del sistema?',
                        text: "Esto puede afectar el rendimiento temporalmente mientras se reconstruye.",
                        icon: 'warning',
                        showCancelButton: true,
                        confirmButtonColor: '#f59e0b',
                        cancelButtonColor: '#6b7280',
                        confirmButtonText: 'Sí, limpiar',
                        cancelButtonText: 'Cancelar'
                    }).then((result) => {
                        if (result.isConfirmed) {
                            window.location.href = url;
                        }
                    });
                });
            });
        </script>
        <?php endif; ?>
    </ul>
</nav><?php /**PATH C:\wamp64\www\somossalud\resources\views/panel/partials/sidebar.blade.php ENDPATH**/ ?>