@extends('layouts.adminlte')

@section('title', 'Gestión de Materiales')

@section('content-header')
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-boxes text-primary"></i> Gestión de Materiales</h1>
        <a href="{{ route('inventario.materiales.create') }}" class="btn btn-primary shadow-sm">
            <i class="fas fa-plus"></i> Nuevo Material
        </a>
    </div>
@stop

@section('content')
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
            <form method="GET" action="{{ route('inventario.materiales.index') }}">
                <div class="row">
                    <div class="col-md-4">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">BUSCAR</label>
                            <input type="text" name="search" class="form-control" placeholder="Buscar por nombre o código..." value="{{ request('search') }}">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">CATEGORÍA</label>
                            <select name="categoria" class="form-control select2" data-minimum-results-for-search="Infinity">
                                <option value="">Todas las categorías</option>
                                @foreach($categorias as $cat)
                                    <option value="{{ $cat }}" {{ request('categoria') == $cat ? 'selected' : '' }}>{{ $cat }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label class="font-weight-bold text-muted small">ESTADO DE STOCK</label>
                            <select name="stock_status" class="form-control select2" data-minimum-results-for-search="Infinity">
                                <option value="">Todos</option>
                                <option value="bajo" {{ request('stock_status') == 'bajo' ? 'selected' : '' }}>Stock Bajo</option>
                                <option value="normal" {{ request('stock_status') == 'normal' ? 'selected' : '' }}>Stock Normal</option>
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
                        @include('inventario.materiales.table_rows')
                    </tbody>
                </table>
            </div>
        </div>
        <div id="paginationLinks">
            @if($materiales->hasPages())
                <div class="card-footer bg-white">
                    {{ $materiales->links() }}
                </div>
            @endif
        </div>
    </div>
@stop

@push('scripts')
<script>
    $(document).ready(function() {
        let searchTimeout;

        function fetchMateriales() {
            const search = $('input[name="search"]').val();
            const categoria = $('select[name="categoria"]').val();
            const stockStatus = $('select[name="stock_status"]').val();

            $.ajax({
                url: "{{ route('inventario.materiales.index') }}",
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
@endpush
