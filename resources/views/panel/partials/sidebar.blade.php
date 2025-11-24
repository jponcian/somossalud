<nav class="mt-2">
    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
        {{-- Bloque de marca interno eliminado: solo queda la imagen arriba en brand-link --}}
        <li class="nav-item">
            <a href="{{ route('panel.clinica') }}"
                class="nav-link {{ request()->routeIs('panel.clinica') ? 'active' : '' }}">
                <i class="nav-icon fas fa-home"></i>
                <p>Inicio</p>
            </a>
        </li>
        @hasanyrole('recepcionista|admin_clinica|super-admin')
        <li class="nav-item">
            <a href="{{ route('recepcion.pagos.index') }}"
                class="nav-link {{ request()->routeIs('recepcion.pagos.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-money-check-alt"></i>
                <p>Validar pagos</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="{{ route('atenciones.index') }}" class="nav-link {{ request()->routeIs('atenciones.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-briefcase-medical"></i>
                <p>Atenciones</p>
            </a>
        </li>
        @endhasanyrole
        @hasanyrole('super-admin|admin_clinica|recepcionista')
        <li class="nav-item">
            <a href="{{ route('admin.users.index') }}"
                class="nav-link {{ request()->routeIs('admin.users.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-users-cog"></i>
                <p>Gestión de usuarios</p>
            </a>
        </li>
        @endhasanyrole
        @hasanyrole('laboratorio|admin_clinica|super-admin')
        <li class="nav-item">
            <a href="{{ route('laboratorio.index') }}"
                class="nav-link {{ request()->routeIs('laboratorio.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-flask"></i>
                <p>Laboratorio</p>
            </a>
        </li>
        @endhasanyrole
        @hasanyrole('super-admin|admin_clinica')
        <li class="nav-item">
            <a href="{{ route('admin.settings.pagos') }}"
                class="nav-link {{ request()->routeIs('admin.settings.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-cog"></i>
                <p>Configuración</p>
            </a>
        </li>
        @endhasanyrole
        @role('super-admin')
        <li class="nav-item">
            <a href="{{ route('admin.settings.cache.clear') }}" class="nav-link text-warning" id="btn-limpiar-cache">
                <i class="nav-icon fas fa-broom"></i>
                <p>Limpiar Caché</p>
            </a>
        </li>
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                document.getElementById('btn-limpiar-cache').addEventListener('click', function(e) {
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
        @endrole
        @role('especialista')
        <li class="nav-item">
            <a href="{{ route('citas.index') }}" class="nav-link {{ request()->routeIs('citas.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-notes-medical"></i>
                <p>Mis citas</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="{{ route('atenciones.index') }}" class="nav-link {{ request()->routeIs('atenciones.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-ambulance"></i>
                <p>Mis atenciones</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="{{ route('especialista.horarios.index') }}"
                class="nav-link {{ request()->routeIs('especialista.horarios.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-calendar-check"></i>
                <p>Mis horarios</p>
            </a>
        </li>
        @endrole
    </ul>
</nav>