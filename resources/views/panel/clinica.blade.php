@extends('layouts.adminlte')

@section('title', 'SomosSalud | Panel interno')

@section('sidebar')
    <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
            {{-- Los ítems del menú se renderizarán según el rol del usuario --}}
        </ul>
    </nav>
@endsection

@section('content-header')
    <div class="row mb-2">
        <div class="col-sm-6">
            <h1 class="m-0 text-dark">Panel operativo de Clínica</h1>
        </div>
        <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
                <li class="breadcrumb-item"><a href="{{ route('panel.clinica') }}">Inicio</a></li>
                <li class="breadcrumb-item active">Panel</li>
            </ol>
        </div>
    </div>
@endsection

@section('content')
    <div class="row">
        <div class="col-lg-12">
            <div class="callout callout-info">
                <h5 class="font-weight-bold">Panel en construcción</h5>
                <p>Este tablero mostrará métricas, agenda y accesos rápidos gestionados por rol del usuario.</p>
            </div>
        </div>
    </div>
@endsection