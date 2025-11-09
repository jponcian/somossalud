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
        @hasanyrole('super-admin|admin_clinica')
        <li class="nav-item">
            <a href="{{ route('admin.users.index') }}"
                class="nav-link {{ request()->routeIs('admin.users.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-users-cog"></i>
                <p>Gestión de usuarios</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="{{ route('admin.settings.pagos') }}"
                class="nav-link {{ request()->routeIs('admin.settings.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-cog"></i>
                <p>Configuración</p>
            </a>
        </li>
        @endhasanyrole
        @hasanyrole('recepcionista|admin_clinica|super-admin')
        <li class="nav-item">
            <a href="{{ route('recepcion.pagos.index') }}"
                class="nav-link {{ request()->routeIs('recepcion.pagos.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-money-check-alt"></i>
                <p>Validar pagos</p>
            </a>
        </li>
        @endhasanyrole
        @role('especialista')
        <li class="nav-item">
            <a href="{{ route('especialista.horarios.index') }}"
                class="nav-link {{ request()->routeIs('especialista.horarios.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-calendar-check"></i>
                <p>Mis horarios</p>
            </a>
        </li>
        <li class="nav-item">
            <a href="{{ route('citas.index') }}" class="nav-link {{ request()->routeIs('citas.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-notes-medical"></i>
                <p>Mis citas</p>
            </a>
        </li>
        @endrole
    </ul>
</nav>