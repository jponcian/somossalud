<nav class="mt-2">
    <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
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
        @endhasanyrole
        @role('recepcionista')
        <li class="nav-item">
            <a href="{{ route('recepcion.pagos.index') }}"
                class="nav-link {{ request()->routeIs('recepcion.pagos.*') ? 'active' : '' }}">
                <i class="nav-icon fas fa-money-check-alt"></i>
                <p>Validar pagos</p>
            </a>
        </li>
        @endrole
        @role('especialista')
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