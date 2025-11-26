# 📦 Módulo de Control de Inventario - Sistema de Solicitudes
## Clínica SaludSonrisa

---

## 📋 Descripción General

Sistema simplificado de control de inventario basado en **solicitudes por categoría**. El personal con rol `almacen` puede crear solicitudes, el `admin_clinica` las aprueba y despacha las cantidades aprobadas.

### Categorías de Solicitud
- **ENFERMERIA**
- **QUIROFANO**
- **UCI**
- **OFICINA**

### Flujo de Trabajo
1. Usuario con rol `almacen` crea una solicitud seleccionando una categoría
2. Agrega items y cantidades solicitadas a la solicitud
3. El `admin_clinica` recibe la solicitud
4. Aprueba o rechaza la solicitud (puede modificar cantidades)
5. Una vez aprobada, despacha los items

---

## 🗄️ Base de Datos

### Migración 1: `create_solicitudes_inventario_table.php`

```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('solicitudes_inventario', function (Blueprint $table) {
            $table->id();
            $table->string('numero_solicitud', 50)->unique(); // Ej: SOL-2025-0001
            $table->foreignId('solicitante_id')->constrained('usuarios')->cascadeOnDelete();
            $table->foreignId('clinica_id')->constrained('clinicas')->cascadeOnDelete();
            $table->enum('categoria', ['ENFERMERIA', 'QUIROFANO', 'UCI', 'OFICINA']);
            $table->enum('estado', ['pendiente', 'aprobada', 'rechazada', 'despachada'])->default('pendiente');
            $table->text('observaciones_solicitante')->nullable();
            $table->text('observaciones_aprobador')->nullable();
            $table->foreignId('aprobado_por')->nullable()->constrained('usuarios')->nullOnDelete();
            $table->timestamp('fecha_aprobacion')->nullable();
            $table->foreignId('despachado_por')->nullable()->constrained('usuarios')->nullOnDelete();
            $table->timestamp('fecha_despacho')->nullable();
            $table->timestamps();
            
            $table->index(['clinica_id', 'estado', 'created_at']);
            $table->index(['categoria', 'estado']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('solicitudes_inventario');
    }
};
```

### Migración 2: `create_items_solicitud_inventario_table.php`

```php
<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up()
    {
        Schema::create('items_solicitud_inventario', function (Blueprint $table) {
            $table->id();
            $table->foreignId('solicitud_id')->constrained('solicitudes_inventario')->cascadeOnDelete();
            $table->string('nombre_item', 200); // Nombre del material/producto
            $table->text('descripcion')->nullable();
            $table->string('unidad_medida', 50)->nullable(); // unidad, caja, litro, etc.
            $table->integer('cantidad_solicitada');
            $table->integer('cantidad_aprobada')->nullable();
            $table->integer('cantidad_despachada')->nullable();
            $table->text('observaciones')->nullable();
            $table->timestamps();
            
            $table->index(['solicitud_id']);
        });
    }

    public function down()
    {
        Schema::dropIfExists('items_solicitud_inventario');
    }
};
```

### Migración 3: Actualizar `RolesSeeder.php`

```php
<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;

class RolesSeeder extends Seeder
{
    public function run()
    {
        $roles = [
            'super-admin', 
            'admin_clinica', 
            'recepcionista', 
            'especialista', 
            'laboratorio', 
            'paciente',
            'almacen' // NUEVO ROL
        ];

        foreach ($roles as $role) {
            Role::firstOrCreate(['name' => $role]);
        }
    }
}
```

---

## 📦 Modelos

### `SolicitudInventario.php`

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Database\Eloquent\Relations\HasMany;

class SolicitudInventario extends Model
{
    protected $table = 'solicitudes_inventario';
    
    protected $fillable = [
        'numero_solicitud',
        'solicitante_id',
        'clinica_id',
        'categoria',
        'estado',
        'observaciones_solicitante',
        'observaciones_aprobador',
        'aprobado_por',
        'fecha_aprobacion',
        'despachado_por',
        'fecha_despacho'
    ];
    
    protected $casts = [
        'fecha_aprobacion' => 'datetime',
        'fecha_despacho' => 'datetime'
    ];
    
    // Boot para generar número de solicitud automáticamente
    protected static function boot()
    {
        parent::boot();
        
        static::creating(function ($solicitud) {
            if (empty($solicitud->numero_solicitud)) {
                $year = date('Y');
                $ultimo = static::whereYear('created_at', $year)
                    ->orderBy('id', 'desc')
                    ->first();
                
                $numero = $ultimo ? intval(substr($ultimo->numero_solicitud, -4)) + 1 : 1;
                $solicitud->numero_solicitud = 'SOL-' . $year . '-' . str_pad($numero, 4, '0', STR_PAD_LEFT);
            }
        });
    }
    
    // Relaciones
    public function solicitante(): BelongsTo
    {
        return $this->belongsTo(User::class, 'solicitante_id');
    }
    
    public function clinica(): BelongsTo
    {
        return $this->belongsTo(Clinica::class);
    }
    
    public function aprobadoPor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'aprobado_por');
    }
    
    public function despachadoPor(): BelongsTo
    {
        return $this->belongsTo(User::class, 'despachado_por');
    }
    
    public function items(): HasMany
    {
        return $this->hasMany(ItemSolicitudInventario::class, 'solicitud_id');
    }
    
    // Scopes
    public function scopePendientes($query)
    {
        return $query->where('estado', 'pendiente');
    }
    
    public function scopeAprobadas($query)
    {
        return $query->where('estado', 'aprobada');
    }
    
    public function scopeDespachadas($query)
    {
        return $query->where('estado', 'despachada');
    }
    
    public function scopePorCategoria($query, $categoria)
    {
        return $query->where('categoria', $categoria);
    }
    
    // Métodos auxiliares
    public function isPendiente(): bool
    {
        return $this->estado === 'pendiente';
    }
    
    public function isAprobada(): bool
    {
        return $this->estado === 'aprobada';
    }
    
    public function isDespachada(): bool
    {
        return $this->estado === 'despachada';
    }
    
    public function isRechazada(): bool
    {
        return $this->estado === 'rechazada';
    }
    
    public function getTotalItemsAttribute(): int
    {
        return $this->items()->count();
    }
    
    public function getBadgeColorAttribute(): string
    {
        return match($this->estado) {
            'pendiente' => 'warning',
            'aprobada' => 'info',
            'despachada' => 'success',
            'rechazada' => 'danger',
            default => 'secondary'
        };
    }
}
```

### `ItemSolicitudInventario.php`

```php
<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class ItemSolicitudInventario extends Model
{
    protected $table = 'items_solicitud_inventario';
    
    protected $fillable = [
        'solicitud_id',
        'nombre_item',
        'descripcion',
        'unidad_medida',
        'cantidad_solicitada',
        'cantidad_aprobada',
        'cantidad_despachada',
        'observaciones'
    ];
    
    // Relaciones
    public function solicitud(): BelongsTo
    {
        return $this->belongsTo(SolicitudInventario::class, 'solicitud_id');
    }
    
    // Métodos auxiliares
    public function getCantidadFinalAttribute(): int
    {
        return $this->cantidad_despachada ?? $this->cantidad_aprobada ?? $this->cantidad_solicitada;
    }
    
    public function getDiferenciaAttribute(): int
    {
        if ($this->cantidad_aprobada !== null) {
            return $this->cantidad_aprobada - $this->cantidad_solicitada;
        }
        return 0;
    }
}
```

---

## 🎮 Controladores

### `SolicitudInventarioController.php`

```php
<?php

namespace App\Http\Controllers;

use App\Models\SolicitudInventario;
use App\Models\ItemSolicitudInventario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;

class SolicitudInventarioController extends Controller
{
    /**
     * Mostrar lista de solicitudes
     */
    public function index(Request $request)
    {
        $query = SolicitudInventario::with(['solicitante', 'clinica', 'items'])
            ->where('clinica_id', auth()->user()->clinica_id)
            ->orderBy('created_at', 'desc');
        
        // Filtros
        if ($request->filled('estado')) {
            $query->where('estado', $request->estado);
        }
        
        if ($request->filled('categoria')) {
            $query->where('categoria', $request->categoria);
        }
        
        if ($request->filled('fecha_desde')) {
            $query->whereDate('created_at', '>=', $request->fecha_desde);
        }
        
        if ($request->filled('fecha_hasta')) {
            $query->whereDate('created_at', '<=', $request->fecha_hasta);
        }
        
        // Si es usuario de almacén, solo ver sus propias solicitudes
        if (auth()->user()->hasRole('almacen')) {
            $query->where('solicitante_id', auth()->id());
        }
        
        $solicitudes = $query->paginate(15);
        
        // Estadísticas
        $stats = [
            'pendientes' => SolicitudInventario::pendientes()
                ->where('clinica_id', auth()->user()->clinica_id)
                ->count(),
            'aprobadas' => SolicitudInventario::aprobadas()
                ->where('clinica_id', auth()->user()->clinica_id)
                ->count(),
            'despachadas' => SolicitudInventario::despachadas()
                ->where('clinica_id', auth()->user()->clinica_id)
                ->count(),
        ];
        
        return view('inventario.solicitudes.index', compact('solicitudes', 'stats'));
    }
    
    /**
     * Mostrar formulario de creación
     */
    public function create()
    {
        $this->authorize('create', SolicitudInventario::class);
        
        $categorias = ['ENFERMERIA', 'QUIROFANO', 'UCI', 'OFICINA'];
        $unidadesMedida = ['Unidad', 'Caja', 'Paquete', 'Litro', 'Kilogramo', 'Metro', 'Rollo'];
        
        return view('inventario.solicitudes.create', compact('categorias', 'unidadesMedida'));
    }
    
    /**
     * Guardar nueva solicitud
     */
    public function store(Request $request)
    {
        $this->authorize('create', SolicitudInventario::class);
        
        $validated = $request->validate([
            'categoria' => 'required|in:ENFERMERIA,QUIROFANO,UCI,OFICINA',
            'observaciones_solicitante' => 'nullable|string|max:1000',
            'items' => 'required|array|min:1',
            'items.*.nombre_item' => 'required|string|max:200',
            'items.*.descripcion' => 'nullable|string|max:500',
            'items.*.unidad_medida' => 'nullable|string|max:50',
            'items.*.cantidad_solicitada' => 'required|integer|min:1',
        ]);
        
        DB::beginTransaction();
        try {
            // Crear solicitud
            $solicitud = SolicitudInventario::create([
                'solicitante_id' => auth()->id(),
                'clinica_id' => auth()->user()->clinica_id,
                'categoria' => $validated['categoria'],
                'observaciones_solicitante' => $validated['observaciones_solicitante'],
                'estado' => 'pendiente'
            ]);
            
            // Crear items
            foreach ($validated['items'] as $itemData) {
                $solicitud->items()->create([
                    'nombre_item' => $itemData['nombre_item'],
                    'descripcion' => $itemData['descripcion'] ?? null,
                    'unidad_medida' => $itemData['unidad_medida'] ?? 'Unidad',
                    'cantidad_solicitada' => $itemData['cantidad_solicitada'],
                ]);
            }
            
            DB::commit();
            
            return redirect()
                ->route('inventario.solicitudes.show', $solicitud)
                ->with('success', 'Solicitud creada exitosamente: ' . $solicitud->numero_solicitud);
                
        } catch (\Exception $e) {
            DB::rollBack();
            return back()
                ->withInput()
                ->with('error', 'Error al crear la solicitud: ' . $e->getMessage());
        }
    }
    
    /**
     * Mostrar detalle de solicitud
     */
    public function show(SolicitudInventario $solicitud)
    {
        $this->authorize('view', $solicitud);
        
        $solicitud->load(['solicitante', 'clinica', 'aprobadoPor', 'despachadoPor', 'items']);
        
        return view('inventario.solicitudes.show', compact('solicitud'));
    }
    
    /**
     * Mostrar formulario de aprobación
     */
    public function edit(SolicitudInventario $solicitud)
    {
        $this->authorize('approve', $solicitud);
        
        if (!$solicitud->isPendiente()) {
            return redirect()
                ->route('inventario.solicitudes.show', $solicitud)
                ->with('warning', 'Esta solicitud ya fue procesada.');
        }
        
        $solicitud->load(['solicitante', 'items']);
        
        return view('inventario.solicitudes.edit', compact('solicitud'));
    }
    
    /**
     * Aprobar o rechazar solicitud
     */
    public function aprobar(Request $request, SolicitudInventario $solicitud)
    {
        $this->authorize('approve', $solicitud);
        
        if (!$solicitud->isPendiente()) {
            return back()->with('error', 'Esta solicitud ya fue procesada.');
        }
        
        $validated = $request->validate([
            'accion' => 'required|in:aprobar,rechazar',
            'observaciones_aprobador' => 'nullable|string|max:1000',
            'items' => 'required_if:accion,aprobar|array',
            'items.*.id' => 'required_if:accion,aprobar|exists:items_solicitud_inventario,id',
            'items.*.cantidad_aprobada' => 'required_if:accion,aprobar|integer|min:0',
        ]);
        
        DB::beginTransaction();
        try {
            if ($validated['accion'] === 'aprobar') {
                // Actualizar cantidades aprobadas
                foreach ($validated['items'] as $itemData) {
                    ItemSolicitudInventario::where('id', $itemData['id'])
                        ->update(['cantidad_aprobada' => $itemData['cantidad_aprobada']]);
                }
                
                $solicitud->update([
                    'estado' => 'aprobada',
                    'aprobado_por' => auth()->id(),
                    'fecha_aprobacion' => now(),
                    'observaciones_aprobador' => $validated['observaciones_aprobador']
                ]);
                
                $mensaje = 'Solicitud aprobada exitosamente.';
            } else {
                $solicitud->update([
                    'estado' => 'rechazada',
                    'aprobado_por' => auth()->id(),
                    'fecha_aprobacion' => now(),
                    'observaciones_aprobador' => $validated['observaciones_aprobador']
                ]);
                
                $mensaje = 'Solicitud rechazada.';
            }
            
            DB::commit();
            
            return redirect()
                ->route('inventario.solicitudes.show', $solicitud)
                ->with('success', $mensaje);
                
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Error al procesar la solicitud: ' . $e->getMessage());
        }
    }
    
    /**
     * Despachar solicitud aprobada
     */
    public function despachar(Request $request, SolicitudInventario $solicitud)
    {
        $this->authorize('dispatch', $solicitud);
        
        if (!$solicitud->isAprobada()) {
            return back()->with('error', 'Solo se pueden despachar solicitudes aprobadas.');
        }
        
        $validated = $request->validate([
            'items' => 'required|array',
            'items.*.id' => 'required|exists:items_solicitud_inventario,id',
            'items.*.cantidad_despachada' => 'required|integer|min:0',
        ]);
        
        DB::beginTransaction();
        try {
            // Actualizar cantidades despachadas
            foreach ($validated['items'] as $itemData) {
                ItemSolicitudInventario::where('id', $itemData['id'])
                    ->update(['cantidad_despachada' => $itemData['cantidad_despachada']]);
            }
            
            $solicitud->update([
                'estado' => 'despachada',
                'despachado_por' => auth()->id(),
                'fecha_despacho' => now()
            ]);
            
            DB::commit();
            
            return redirect()
                ->route('inventario.solicitudes.show', $solicitud)
                ->with('success', 'Solicitud despachada exitosamente.');
                
        } catch (\Exception $e) {
            DB::rollBack();
            return back()->with('error', 'Error al despachar la solicitud: ' . $e->getMessage());
        }
    }
    
    /**
     * Eliminar solicitud (solo si está pendiente)
     */
    public function destroy(SolicitudInventario $solicitud)
    {
        $this->authorize('delete', $solicitud);
        
        if (!$solicitud->isPendiente()) {
            return back()->with('error', 'Solo se pueden eliminar solicitudes pendientes.');
        }
        
        $numero = $solicitud->numero_solicitud;
        $solicitud->delete();
        
        return redirect()
            ->route('inventario.solicitudes.index')
            ->with('success', "Solicitud {$numero} eliminada exitosamente.");
    }
}
```

---

## 🔐 Policies

### `SolicitudInventarioPolicy.php`

```php
<?php

namespace App\Policies;

use App\Models\SolicitudInventario;
use App\Models\User;

class SolicitudInventarioPolicy
{
    /**
     * Ver lista de solicitudes
     */
    public function viewAny(User $user): bool
    {
        return $user->hasAnyRole(['super-admin', 'admin_clinica', 'almacen']);
    }
    
    /**
     * Ver detalle de solicitud
     */
    public function view(User $user, SolicitudInventario $solicitud): bool
    {
        // Admin puede ver todas
        if ($user->hasAnyRole(['super-admin', 'admin_clinica'])) {
            return true;
        }
        
        // Usuario de almacén solo puede ver sus propias solicitudes
        if ($user->hasRole('almacen')) {
            return $solicitud->solicitante_id === $user->id;
        }
        
        return false;
    }
    
    /**
     * Crear solicitud
     */
    public function create(User $user): bool
    {
        return $user->hasRole('almacen');
    }
    
    /**
     * Aprobar/rechazar solicitud
     */
    public function approve(User $user, SolicitudInventario $solicitud): bool
    {
        return $user->hasAnyRole(['super-admin', 'admin_clinica']) 
            && $solicitud->isPendiente();
    }
    
    /**
     * Despachar solicitud
     */
    public function dispatch(User $user, SolicitudInventario $solicitud): bool
    {
        return $user->hasAnyRole(['super-admin', 'admin_clinica']) 
            && $solicitud->isAprobada();
    }
    
    /**
     * Eliminar solicitud
     */
    public function delete(User $user, SolicitudInventario $solicitud): bool
    {
        // Solo el solicitante puede eliminar si está pendiente
        if ($user->hasRole('almacen')) {
            return $solicitud->solicitante_id === $user->id && $solicitud->isPendiente();
        }
        
        // Admin puede eliminar cualquiera que esté pendiente
        return $user->hasAnyRole(['super-admin', 'admin_clinica']) && $solicitud->isPendiente();
    }
}
```

---

## 🛣️ Rutas

### `web.php` (agregar al archivo existente)

```php
// Rutas de Inventario - Solicitudes
Route::middleware(['auth', 'verified'])
    ->prefix('inventario/solicitudes')
    ->name('inventario.solicitudes.')
    ->group(function () {
        Route::get('/', [SolicitudInventarioController::class, 'index'])
            ->name('index')
            ->middleware('role:super-admin|admin_clinica|almacen');
        
        Route::get('/crear', [SolicitudInventarioController::class, 'create'])
            ->name('create')
            ->middleware('role:almacen');
        
        Route::post('/', [SolicitudInventarioController::class, 'store'])
            ->name('store')
            ->middleware('role:almacen');
        
        Route::get('/{solicitud}', [SolicitudInventarioController::class, 'show'])
            ->name('show')
            ->middleware('role:super-admin|admin_clinica|almacen');
        
        Route::get('/{solicitud}/editar', [SolicitudInventarioController::class, 'edit'])
            ->name('edit')
            ->middleware('role:super-admin|admin_clinica');
        
        Route::post('/{solicitud}/aprobar', [SolicitudInventarioController::class, 'aprobar'])
            ->name('aprobar')
            ->middleware('role:super-admin|admin_clinica');
        
        Route::post('/{solicitud}/despachar', [SolicitudInventarioController::class, 'despachar'])
            ->name('despachar')
            ->middleware('role:super-admin|admin_clinica');
        
        Route::delete('/{solicitud}', [SolicitudInventarioController::class, 'destroy'])
            ->name('destroy')
            ->middleware('role:super-admin|admin_clinica|almacen');
    });
```

---

## 🎨 Vistas (Blade Templates)

### Estructura de carpetas
```
resources/views/inventario/solicitudes/
├── index.blade.php          # Lista de solicitudes
├── create.blade.php         # Crear nueva solicitud
├── show.blade.php           # Ver detalle
├── edit.blade.php           # Aprobar/rechazar (admin)
└── _partials/
    ├── filtros.blade.php    # Filtros de búsqueda
    ├── stats.blade.php      # Estadísticas
    └── item-row.blade.php   # Fila de item
```

### `index.blade.php`

```blade
@extends('layouts.adminlte')

@section('title', 'Solicitudes de Inventario')

@section('content_header')
    <div class="d-flex justify-content-between align-items-center">
        <h1><i class="fas fa-clipboard-list"></i> Solicitudes de Inventario</h1>
        @can('create', App\Models\SolicitudInventario::class)
            <a href="{{ route('inventario.solicitudes.create') }}" class="btn btn-primary">
                <i class="fas fa-plus"></i> Nueva Solicitud
            </a>
        @endcan
    </div>
@stop

@section('content')
    {{-- Estadísticas --}}
    <div class="row mb-3">
        <div class="col-md-4">
            <div class="small-box bg-warning">
                <div class="inner">
                    <h3>{{ $stats['pendientes'] }}</h3>
                    <p>Pendientes</p>
                </div>
                <div class="icon">
                    <i class="fas fa-clock"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="small-box bg-info">
                <div class="inner">
                    <h3>{{ $stats['aprobadas'] }}</h3>
                    <p>Aprobadas</p>
                </div>
                <div class="icon">
                    <i class="fas fa-check"></i>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="small-box bg-success">
                <div class="inner">
                    <h3>{{ $stats['despachadas'] }}</h3>
                    <p>Despachadas</p>
                </div>
                <div class="icon">
                    <i class="fas fa-box"></i>
                </div>
            </div>
        </div>
    </div>

    {{-- Filtros --}}
    <div class="card">
        <div class="card-header">
            <h3 class="card-title"><i class="fas fa-filter"></i> Filtros</h3>
            <div class="card-tools">
                <button type="button" class="btn btn-tool" data-card-widget="collapse">
                    <i class="fas fa-minus"></i>
                </button>
            </div>
        </div>
        <div class="card-body">
            <form method="GET" action="{{ route('inventario.solicitudes.index') }}">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Estado</label>
                            <select name="estado" class="form-control">
                                <option value="">Todos</option>
                                <option value="pendiente" {{ request('estado') == 'pendiente' ? 'selected' : '' }}>Pendiente</option>
                                <option value="aprobada" {{ request('estado') == 'aprobada' ? 'selected' : '' }}>Aprobada</option>
                                <option value="despachada" {{ request('estado') == 'despachada' ? 'selected' : '' }}>Despachada</option>
                                <option value="rechazada" {{ request('estado') == 'rechazada' ? 'selected' : '' }}>Rechazada</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <label>Categoría</label>
                            <select name="categoria" class="form-control">
                                <option value="">Todas</option>
                                <option value="ENFERMERIA" {{ request('categoria') == 'ENFERMERIA' ? 'selected' : '' }}>Enfermería</option>
                                <option value="QUIROFANO" {{ request('categoria') == 'QUIROFANO' ? 'selected' : '' }}>Quirófano</option>
                                <option value="UCI" {{ request('categoria') == 'UCI' ? 'selected' : '' }}>UCI</option>
                                <option value="OFICINA" {{ request('categoria') == 'OFICINA' ? 'selected' : '' }}>Oficina</option>
                            </select>
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Desde</label>
                            <input type="date" name="fecha_desde" class="form-control" value="{{ request('fecha_desde') }}">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>Hasta</label>
                            <input type="date" name="fecha_hasta" class="form-control" value="{{ request('fecha_hasta') }}">
                        </div>
                    </div>
                    <div class="col-md-2">
                        <div class="form-group">
                            <label>&nbsp;</label>
                            <button type="submit" class="btn btn-primary btn-block">
                                <i class="fas fa-search"></i> Buscar
                            </button>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>

    {{-- Lista de solicitudes --}}
    <div class="card">
        <div class="card-header">
            <h3 class="card-title"><i class="fas fa-list"></i> Listado de Solicitudes</h3>
        </div>
        <div class="card-body table-responsive p-0">
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th>Número</th>
                        <th>Fecha</th>
                        <th>Solicitante</th>
                        <th>Categoría</th>
                        <th>Items</th>
                        <th>Estado</th>
                        <th>Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    @forelse($solicitudes as $solicitud)
                        <tr>
                            <td>
                                <strong>{{ $solicitud->numero_solicitud }}</strong>
                            </td>
                            <td>{{ $solicitud->created_at->format('d/m/Y H:i') }}</td>
                            <td>{{ $solicitud->solicitante->name }}</td>
                            <td>
                                <span class="badge badge-secondary">
                                    {{ $solicitud->categoria }}
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-info">
                                    {{ $solicitud->total_items }} items
                                </span>
                            </td>
                            <td>
                                <span class="badge badge-{{ $solicitud->badge_color }}">
                                    {{ ucfirst($solicitud->estado) }}
                                </span>
                            </td>
                            <td>
                                <a href="{{ route('inventario.solicitudes.show', $solicitud) }}" 
                                   class="btn btn-sm btn-info" 
                                   title="Ver detalle">
                                    <i class="fas fa-eye"></i>
                                </a>
                                
                                @can('approve', $solicitud)
                                    @if($solicitud->isPendiente())
                                        <a href="{{ route('inventario.solicitudes.edit', $solicitud) }}" 
                                           class="btn btn-sm btn-warning" 
                                           title="Aprobar/Rechazar">
                                            <i class="fas fa-check-circle"></i>
                                        </a>
                                    @endif
                                @endcan
                                
                                @can('delete', $solicitud)
                                    @if($solicitud->isPendiente())
                                        <form action="{{ route('inventario.solicitudes.destroy', $solicitud) }}" 
                                              method="POST" 
                                              style="display: inline-block;"
                                              onsubmit="return confirm('¿Está seguro de eliminar esta solicitud?');">
                                            @csrf
                                            @method('DELETE')
                                            <button type="submit" class="btn btn-sm btn-danger" title="Eliminar">
                                                <i class="fas fa-trash"></i>
                                            </button>
                                        </form>
                                    @endif
                                @endcan
                            </td>
                        </tr>
                    @empty
                        <tr>
                            <td colspan="7" class="text-center text-muted py-4">
                                <i class="fas fa-inbox fa-3x mb-3"></i>
                                <p>No hay solicitudes registradas</p>
                            </td>
                        </tr>
                    @endforelse
                </tbody>
            </table>
        </div>
        @if($solicitudes->hasPages())
            <div class="card-footer">
                {{ $solicitudes->links() }}
            </div>
        @endif
    </div>
@stop
```

### `create.blade.php`

```blade
@extends('layouts.adminlte')

@section('title', 'Nueva Solicitud de Inventario')

@section('content_header')
    <h1><i class="fas fa-plus-circle"></i> Nueva Solicitud de Inventario</h1>
@stop

@section('content')
    <form action="{{ route('inventario.solicitudes.store') }}" method="POST" id="formSolicitud">
        @csrf
        
        <div class="row">
            <div class="col-md-8">
                {{-- Información general --}}
                <div class="card">
                    <div class="card-header bg-gradient-primary">
                        <h3 class="card-title"><i class="fas fa-info-circle"></i> Información General</h3>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label for="categoria">Categoría <span class="text-danger">*</span></label>
                                    <select name="categoria" id="categoria" class="form-control @error('categoria') is-invalid @enderror" required>
                                        <option value="">Seleccione una categoría</option>
                                        @foreach($categorias as $cat)
                                            <option value="{{ $cat }}" {{ old('categoria') == $cat ? 'selected' : '' }}>
                                                {{ $cat }}
                                            </option>
                                        @endforeach
                                    </select>
                                    @error('categoria')
                                        <span class="invalid-feedback">{{ $message }}</span>
                                    @enderror
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="form-group">
                                    <label>Solicitante</label>
                                    <input type="text" class="form-control" value="{{ auth()->user()->name }}" readonly>
                                </div>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label for="observaciones_solicitante">Observaciones</label>
                            <textarea name="observaciones_solicitante" 
                                      id="observaciones_solicitante" 
                                      class="form-control @error('observaciones_solicitante') is-invalid @enderror" 
                                      rows="3" 
                                      placeholder="Ingrese cualquier observación o comentario adicional...">{{ old('observaciones_solicitante') }}</textarea>
                            @error('observaciones_solicitante')
                                <span class="invalid-feedback">{{ $message }}</span>
                            @enderror
                        </div>
                    </div>
                </div>

                {{-- Items de la solicitud --}}
                <div class="card">
                    <div class="card-header bg-gradient-info">
                        <h3 class="card-title"><i class="fas fa-boxes"></i> Items Solicitados</h3>
                        <div class="card-tools">
                            <button type="button" class="btn btn-sm btn-success" id="btnAgregarItem">
                                <i class="fas fa-plus"></i> Agregar Item
                            </button>
                        </div>
                    </div>
                    <div class="card-body">
                        <div id="contenedorItems">
                            {{-- Los items se agregarán aquí dinámicamente --}}
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                {{-- Resumen --}}
                <div class="card card-primary card-outline sticky-top" style="top: 20px;">
                    <div class="card-header">
                        <h3 class="card-title"><i class="fas fa-clipboard-check"></i> Resumen</h3>
                    </div>
                    <div class="card-body">
                        <dl>
                            <dt>Total de Items:</dt>
                            <dd id="totalItems" class="h4 text-primary">0</dd>
                            
                            <dt>Categoría:</dt>
                            <dd id="resumenCategoria" class="text-muted">No seleccionada</dd>
                        </dl>
                    </div>
                    <div class="card-footer">
                        <button type="submit" class="btn btn-primary btn-block">
                            <i class="fas fa-paper-plane"></i> Enviar Solicitud
                        </button>
                        <a href="{{ route('inventario.solicitudes.index') }}" class="btn btn-secondary btn-block">
                            <i class="fas fa-times"></i> Cancelar
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </form>
@stop

@section('js')
<script>
let itemCounter = 0;

// Template de item
function getItemTemplate(index) {
    return `
        <div class="card item-card mb-3" data-item-index="${index}">
            <div class="card-header bg-light">
                <h5 class="card-title mb-0">
                    <i class="fas fa-box"></i> Item #<span class="item-number">${index + 1}</span>
                </h5>
                <div class="card-tools">
                    <button type="button" class="btn btn-sm btn-danger btn-eliminar-item">
                        <i class="fas fa-trash"></i>
                    </button>
                </div>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Nombre del Item <span class="text-danger">*</span></label>
                            <input type="text" 
                                   name="items[${index}][nombre_item]" 
                                   class="form-control" 
                                   placeholder="Ej: Guantes de látex talla M"
                                   required>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="form-group">
                            <label>Descripción</label>
                            <textarea name="items[${index}][descripcion]" 
                                      class="form-control" 
                                      rows="2" 
                                      placeholder="Descripción adicional del item..."></textarea>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Unidad de Medida</label>
                            <select name="items[${index}][unidad_medida]" class="form-control">
                                @foreach($unidadesMedida as $unidad)
                                    <option value="{{ $unidad }}">{{ $unidad }}</option>
                                @endforeach
                            </select>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label>Cantidad Solicitada <span class="text-danger">*</span></label>
                            <input type="number" 
                                   name="items[${index}][cantidad_solicitada]" 
                                   class="form-control" 
                                   min="1" 
                                   value="1"
                                   required>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    `;
}

// Agregar item
$('#btnAgregarItem').click(function() {
    const itemHtml = getItemTemplate(itemCounter);
    $('#contenedorItems').append(itemHtml);
    itemCounter++;
    actualizarResumen();
});

// Eliminar item
$(document).on('click', '.btn-eliminar-item', function() {
    if ($('.item-card').length > 1) {
        $(this).closest('.item-card').remove();
        renumerarItems();
        actualizarResumen();
    } else {
        alert('Debe haber al menos un item en la solicitud');
    }
});

// Renumerar items después de eliminar
function renumerarItems() {
    $('.item-card').each(function(index) {
        $(this).attr('data-item-index', index);
        $(this).find('.item-number').text(index + 1);
        
        // Actualizar nombres de inputs
        $(this).find('input, select, textarea').each(function() {
            const name = $(this).attr('name');
            if (name) {
                const newName = name.replace(/items\[\d+\]/, `items[${index}]`);
                $(this).attr('name', newName);
            }
        });
    });
}

// Actualizar resumen
function actualizarResumen() {
    $('#totalItems').text($('.item-card').length);
}

// Actualizar categoría en resumen
$('#categoria').change(function() {
    const categoria = $(this).val();
    $('#resumenCategoria').text(categoria || 'No seleccionada');
});

// Validar formulario
$('#formSolicitud').submit(function(e) {
    if ($('.item-card').length === 0) {
        e.preventDefault();
        alert('Debe agregar al menos un item a la solicitud');
        return false;
    }
});

// Agregar primer item automáticamente
$(document).ready(function() {
    $('#btnAgregarItem').click();
});
</script>
@stop
```

---

## 📝 Pasos de Implementación

### Paso 1: Actualizar Roles
```bash
php artisan db:seed --class=RolesSeeder
```

### Paso 2: Crear Migraciones
```bash
php artisan make:migration create_solicitudes_inventario_table
php artisan make:migration create_items_solicitud_inventario_table
```

### Paso 3: Ejecutar Migraciones
```bash
php artisan migrate
```

### Paso 4: Crear Modelos
```bash
php artisan make:model SolicitudInventario
php artisan make:model ItemSolicitudInventario
```

### Paso 5: Crear Controlador
```bash
php artisan make:controller SolicitudInventarioController
```

### Paso 6: Crear Policy
```bash
php artisan make:policy SolicitudInventarioPolicy --model=SolicitudInventario
```

### Paso 7: Registrar Policy en `AuthServiceProvider.php`
```php
protected $policies = [
    SolicitudInventario::class => SolicitudInventarioPolicy::class,
];
```

### Paso 8: Crear Vistas
Crear las vistas en `resources/views/inventario/solicitudes/`

### Paso 9: Agregar al Menú
Agregar enlaces en el menú de navegación para usuarios con rol `almacen` y `admin_clinica`

---

## ✅ Checklist de Implementación

- [ ] Actualizar `RolesSeeder.php` con rol `almacen`
- [ ] Ejecutar seeder de roles
- [ ] Crear migración `solicitudes_inventario`
- [ ] Crear migración `items_solicitud_inventario`
- [ ] Ejecutar migraciones
- [ ] Crear modelo `SolicitudInventario`
- [ ] Crear modelo `ItemSolicitudInventario`
- [ ] Crear `SolicitudInventarioController`
- [ ] Crear `SolicitudInventarioPolicy`
- [ ] Registrar policy en `AuthServiceProvider`
- [ ] Agregar rutas en `web.php`
- [ ] Crear vista `index.blade.php`
- [ ] Crear vista `create.blade.php`
- [ ] Crear vista `show.blade.php`
- [ ] Crear vista `edit.blade.php`
- [ ] Agregar enlaces en el menú
- [ ] Probar flujo completo
- [ ] Asignar rol `almacen` a usuarios de prueba

---

*Documento generado - {{ date('d/m/Y') }}*
