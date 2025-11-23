# 🚀 Plan de Implementación - Módulos Pendientes
## Clínica SaludSonrisa (SomosSalud)

---

## 📦 MÓDULO 1: Gestión de Inventario

### Base de Datos

#### Migración 1: `create_categorias_inventario_table.php`
```php
Schema::create('categorias_inventario', function (Blueprint $table) {
    $table->id();
    $table->string('nombre', 100);
    $table->text('descripcion')->nullable();
    $table->enum('tipo', ['material', 'equipo']); // Tipo de items que contiene
    $table->timestamps();
});
```

#### Migración 2: `create_items_inventario_table.php`
```php
Schema::create('items_inventario', function (Blueprint $table) {
    $table->id();
    $table->foreignId('categoria_id')->constrained('categorias_inventario')->cascadeOnDelete();
    $table->foreignId('clinica_id')->constrained('clinicas')->cascadeOnDelete();
    $table->string('codigo', 50)->unique(); // Código único del item
    $table->string('nombre', 150);
    $table->text('descripcion')->nullable();
    $table->enum('tipo', ['material', 'equipo']);
    $table->string('unidad_medida', 50)->nullable(); // ej: unidad, caja, litro
    $table->integer('stock_actual')->default(0);
    $table->integer('stock_minimo')->default(0);
    $table->integer('stock_maximo')->nullable();
    $table->decimal('precio_unitario', 10, 2)->nullable();
    $table->string('proveedor', 150)->nullable();
    $table->date('fecha_vencimiento')->nullable();
    $table->enum('estado', ['activo', 'inactivo', 'agotado'])->default('activo');
    $table->timestamps();
    $table->softDeletes();
    
    $table->index(['clinica_id', 'tipo', 'estado']);
});
```

#### Migración 3: `create_movimientos_inventario_table.php`
```php
Schema::create('movimientos_inventario', function (Blueprint $table) {
    $table->id();
    $table->foreignId('item_id')->constrained('items_inventario')->cascadeOnDelete();
    $table->foreignId('usuario_id')->constrained('usuarios')->cascadeOnDelete(); // Quien registra
    $table->enum('tipo_movimiento', ['entrada', 'salida', 'ajuste']);
    $table->integer('cantidad');
    $table->integer('stock_anterior');
    $table->integer('stock_nuevo');
    $table->text('motivo')->nullable();
    $table->string('referencia_tipo', 50)->nullable(); // ej: 'cita', 'atencion', 'compra'
    $table->unsignedBigInteger('referencia_id')->nullable(); // ID de la cita/atención
    $table->timestamps();
    
    $table->index(['item_id', 'created_at']);
});
```

### Modelos

#### `CategoriaInventario.php`
```php
class CategoriaInventario extends Model
{
    protected $table = 'categorias_inventario';
    protected $fillable = ['nombre', 'descripcion', 'tipo'];
    
    public function items() {
        return $this->hasMany(ItemInventario::class, 'categoria_id');
    }
}
```

#### `ItemInventario.php`
```php
class ItemInventario extends Model
{
    use SoftDeletes;
    
    protected $table = 'items_inventario';
    protected $fillable = [
        'categoria_id', 'clinica_id', 'codigo', 'nombre', 'descripcion',
        'tipo', 'unidad_medida', 'stock_actual', 'stock_minimo', 'stock_maximo',
        'precio_unitario', 'proveedor', 'fecha_vencimiento', 'estado'
    ];
    
    protected $casts = [
        'fecha_vencimiento' => 'date',
        'precio_unitario' => 'decimal:2'
    ];
    
    // Relaciones
    public function categoria() {
        return $this->belongsTo(CategoriaInventario::class, 'categoria_id');
    }
    
    public function clinica() {
        return $this->belongsTo(Clinica::class);
    }
    
    public function movimientos() {
        return $this->hasMany(MovimientoInventario::class, 'item_id');
    }
    
    // Scopes
    public function scopeBajoStock($query) {
        return $query->whereRaw('stock_actual <= stock_minimo');
    }
    
    public function scopeProximosVencer($query, $dias = 30) {
        return $query->whereNotNull('fecha_vencimiento')
                    ->whereBetween('fecha_vencimiento', [now(), now()->addDays($dias)]);
    }
}
```

#### `MovimientoInventario.php`
```php
class MovimientoInventario extends Model
{
    protected $table = 'movimientos_inventario';
    protected $fillable = [
        'item_id', 'usuario_id', 'tipo_movimiento', 'cantidad',
        'stock_anterior', 'stock_nuevo', 'motivo', 'referencia_tipo', 'referencia_id'
    ];
    
    public function item() {
        return $this->belongsTo(ItemInventario::class, 'item_id');
    }
    
    public function usuario() {
        return $this->belongsTo(User::class, 'usuario_id');
    }
}
```

### Controlador: `InventarioController.php`

```php
class InventarioController extends Controller
{
    public function index() {
        $items = ItemInventario::with(['categoria', 'clinica'])
            ->where('clinica_id', auth()->user()->clinica_id)
            ->paginate(20);
        
        $bajoStock = ItemInventario::bajoStock()
            ->where('clinica_id', auth()->user()->clinica_id)
            ->count();
        
        $proximosVencer = ItemInventario::proximosVencer()
            ->where('clinica_id', auth()->user()->clinica_id)
            ->count();
        
        return view('inventario.index', compact('items', 'bajoStock', 'proximosVencer'));
    }
    
    public function registrarMovimiento(Request $request, ItemInventario $item) {
        $validated = $request->validate([
            'tipo_movimiento' => 'required|in:entrada,salida,ajuste',
            'cantidad' => 'required|integer|min:1',
            'motivo' => 'nullable|string'
        ]);
        
        DB::transaction(function() use ($item, $validated) {
            $stockAnterior = $item->stock_actual;
            
            if ($validated['tipo_movimiento'] === 'entrada') {
                $item->stock_actual += $validated['cantidad'];
            } else {
                $item->stock_actual -= $validated['cantidad'];
            }
            
            $item->save();
            
            MovimientoInventario::create([
                'item_id' => $item->id,
                'usuario_id' => auth()->id(),
                'tipo_movimiento' => $validated['tipo_movimiento'],
                'cantidad' => $validated['cantidad'],
                'stock_anterior' => $stockAnterior,
                'stock_nuevo' => $item->stock_actual,
                'motivo' => $validated['motivo']
            ]);
        });
        
        return redirect()->back()->with('success', 'Movimiento registrado correctamente');
    }
}
```

### Rutas

```php
Route::middleware(['auth', 'verified', 'role:super-admin|admin_clinica|recepcionista'])
    ->prefix('inventario')
    ->name('inventario.')
    ->group(function () {
        Route::get('/', [InventarioController::class, 'index'])->name('index');
        Route::get('/crear', [InventarioController::class, 'create'])->name('create');
        Route::post('/', [InventarioController::class, 'store'])->name('store');
        Route::get('/{item}/editar', [InventarioController::class, 'edit'])->name('edit');
        Route::put('/{item}', [InventarioController::class, 'update'])->name('update');
        Route::delete('/{item}', [InventarioController::class, 'destroy'])->name('destroy');
        Route::post('/{item}/movimiento', [InventarioController::class, 'registrarMovimiento'])->name('movimiento');
        Route::get('/alertas', [InventarioController::class, 'alertas'])->name('alertas');
    });
```

---

## 🏥 MÓDULO 2: Gestión de Empresas de Seguros

### Base de Datos

#### Migración 1: `create_empresas_seguros_table.php`
```php
Schema::create('empresas_seguros', function (Blueprint $table) {
    $table->id();
    $table->string('nombre', 150);
    $table->string('rif', 50)->unique();
    $table->string('telefono', 50)->nullable();
    $table->string('email', 100)->nullable();
    $table->text('direccion')->nullable();
    $table->string('contacto_nombre', 150)->nullable();
    $table->string('contacto_telefono', 50)->nullable();
    $table->string('contacto_email', 100)->nullable();
    $table->enum('estado', ['activo', 'inactivo'])->default('activo');
    $table->timestamps();
    $table->softDeletes();
});
```

#### Migración 2: `create_procesos_seguros_table.php`
```php
Schema::create('procesos_seguros', function (Blueprint $table) {
    $table->id();
    $table->string('numero_caso', 100)->unique();
    $table->foreignId('empresa_seguro_id')->constrained('empresas_seguros')->cascadeOnDelete();
    $table->foreignId('paciente_id')->constrained('usuarios')->cascadeOnDelete();
    $table->foreignId('atencion_id')->nullable()->constrained('atenciones')->nullOnDelete();
    $table->foreignId('clinica_id')->constrained('clinicas')->cascadeOnDelete();
    $table->string('poliza', 150);
    $table->string('numero_autorizacion', 150)->nullable();
    $table->date('fecha_apertura');
    $table->date('fecha_vencimiento')->nullable();
    $table->date('fecha_cierre')->nullable();
    $table->enum('estado', ['abierto', 'en_proceso', 'cerrado', 'vencido', 'pagado'])->default('abierto');
    $table->decimal('monto_reclamado', 10, 2)->nullable();
    $table->decimal('monto_aprobado', 10, 2)->nullable();
    $table->decimal('monto_pagado', 10, 2)->nullable();
    $table->date('fecha_pago')->nullable();
    $table->text('observaciones')->nullable();
    $table->foreignId('registrado_por')->constrained('usuarios')->cascadeOnDelete();
    $table->timestamps();
    
    $table->index(['estado', 'empresa_seguro_id']);
    $table->index(['fecha_vencimiento']);
});
```

#### Migración 3: `create_documentos_seguros_table.php`
```php
Schema::create('documentos_seguros', function (Blueprint $table) {
    $table->id();
    $table->foreignId('proceso_seguro_id')->constrained('procesos_seguros')->cascadeOnDelete();
    $table->string('nombre', 150);
    $table->string('tipo_documento', 100); // ej: factura, informe_medico, autorizacion
    $table->string('archivo_path');
    $table->foreignId('subido_por')->constrained('usuarios')->cascadeOnDelete();
    $table->timestamps();
});
```

### Modelos

#### `EmpresaSeguro.php`
```php
class EmpresaSeguro extends Model
{
    use SoftDeletes;
    
    protected $table = 'empresas_seguros';
    protected $fillable = [
        'nombre', 'rif', 'telefono', 'email', 'direccion',
        'contacto_nombre', 'contacto_telefono', 'contacto_email', 'estado'
    ];
    
    public function procesos() {
        return $this->hasMany(ProcesoSeguro::class, 'empresa_seguro_id');
    }
}
```

#### `ProcesoSeguro.php`
```php
class ProcesoSeguro extends Model
{
    protected $table = 'procesos_seguros';
    protected $fillable = [
        'numero_caso', 'empresa_seguro_id', 'paciente_id', 'atencion_id', 'clinica_id',
        'poliza', 'numero_autorizacion', 'fecha_apertura', 'fecha_vencimiento', 'fecha_cierre',
        'estado', 'monto_reclamado', 'monto_aprobado', 'monto_pagado', 'fecha_pago',
        'observaciones', 'registrado_por'
    ];
    
    protected $casts = [
        'fecha_apertura' => 'date',
        'fecha_vencimiento' => 'date',
        'fecha_cierre' => 'date',
        'fecha_pago' => 'date',
        'monto_reclamado' => 'decimal:2',
        'monto_aprobado' => 'decimal:2',
        'monto_pagado' => 'decimal:2'
    ];
    
    // Relaciones
    public function empresaSeguro() {
        return $this->belongsTo(EmpresaSeguro::class, 'empresa_seguro_id');
    }
    
    public function paciente() {
        return $this->belongsTo(User::class, 'paciente_id');
    }
    
    public function atencion() {
        return $this->belongsTo(Atencion::class, 'atencion_id');
    }
    
    public function clinica() {
        return $this->belongsTo(Clinica::class);
    }
    
    public function documentos() {
        return $this->hasMany(DocumentoSeguro::class, 'proceso_seguro_id');
    }
    
    // Scopes
    public function scopeAbiertos($query) {
        return $query->where('estado', 'abierto');
    }
    
    public function scopeVencidos($query) {
        return $query->where('estado', 'vencido')
                    ->orWhere(function($q) {
                        $q->where('estado', '!=', 'cerrado')
                          ->where('fecha_vencimiento', '<', now());
                    });
    }
    
    public function scopePagados($query) {
        return $query->where('estado', 'pagado');
    }
}
```

---

## 🔬 MÓDULO 3: Código QR para Laboratorio

### Instalación de Librería
```bash
composer require simplesoftwareio/simple-qrcode
```

### Migración: Agregar campo hash a resultados_laboratorio
```php
Schema::table('resultados_laboratorio', function (Blueprint $table) {
    $table->string('hash', 64)->unique()->after('id');
    $table->integer('vistas')->default(0)->after('descripcion');
    $table->timestamp('ultima_vista')->nullable()->after('vistas');
});
```

### Modelo: `ResultadoLaboratorio.php`
```php
class ResultadoLaboratorio extends Model
{
    protected $table = 'resultados_laboratorio';
    protected $fillable = [
        'hash', 'paciente_id', 'clinica_id', 'archivo_path',
        'descripcion', 'registrado_por', 'vistas', 'ultima_vista'
    ];
    
    protected $casts = [
        'ultima_vista' => 'datetime'
    ];
    
    // Generar hash único al crear
    protected static function boot() {
        parent::boot();
        
        static::creating(function ($resultado) {
            $resultado->hash = hash('sha256', uniqid() . time() . $resultado->paciente_id);
        });
    }
    
    // Relaciones
    public function paciente() {
        return $this->belongsTo(User::class, 'paciente_id');
    }
    
    public function clinica() {
        return $this->belongsTo(Clinica::class);
    }
    
    public function registradoPor() {
        return $this->belongsTo(User::class, 'registrado_por');
    }
    
    // Generar URL del QR
    public function getUrlVerificacionAttribute() {
        return route('laboratorio.verificar', $this->hash);
    }
}
```

### Controlador: `ResultadoLaboratorioController.php`
```php
class ResultadoLaboratorioController extends Controller
{
    public function store(Request $request) {
        $validated = $request->validate([
            'paciente_id' => 'required|exists:usuarios,id',
            'archivo' => 'required|file|mimes:pdf,jpg,jpeg,png|max:10240',
            'descripcion' => 'nullable|string'
        ]);
        
        $path = $request->file('archivo')->store('resultados_laboratorio', 'public');
        
        $resultado = ResultadoLaboratorio::create([
            'paciente_id' => $validated['paciente_id'],
            'clinica_id' => auth()->user()->clinica_id,
            'archivo_path' => $path,
            'descripcion' => $validated['descripcion'],
            'registrado_por' => auth()->id()
        ]);
        
        return redirect()->route('laboratorio.index')
            ->with('success', 'Resultado registrado. QR generado automáticamente.');
    }
    
    public function generarQR(ResultadoLaboratorio $resultado) {
        return QrCode::size(300)
            ->format('png')
            ->generate($resultado->url_verificacion);
    }
    
    public function verificar($hash) {
        $resultado = ResultadoLaboratorio::where('hash', $hash)->firstOrFail();
        
        // Incrementar contador de vistas
        $resultado->increment('vistas');
        $resultado->update(['ultima_vista' => now()]);
        
        return view('laboratorio.verificar', compact('resultado'));
    }
    
    public function descargarPDF(ResultadoLaboratorio $resultado) {
        // Generar PDF con QR incluido
        $pdf = PDF::loadView('laboratorio.pdf', [
            'resultado' => $resultado,
            'qr' => base64_encode($this->generarQR($resultado))
        ]);
        
        return $pdf->download('resultado_' . $resultado->id . '.pdf');
    }
}
```

---

## 📊 MÓDULO 4: Estadísticas y Evaluaciones

### Controlador: `EstadisticasController.php`
```php
class EstadisticasController extends Controller
{
    public function index(Request $request) {
        $fechaInicio = $request->input('fecha_inicio', now()->startOfMonth());
        $fechaFin = $request->input('fecha_fin', now()->endOfMonth());
        
        $stats = [
            'total_citas' => Cita::whereBetween('fecha', [$fechaInicio, $fechaFin])->count(),
            'total_atenciones' => Atencion::whereBetween('created_at', [$fechaInicio, $fechaFin])->count(),
            'total_pacientes' => User::role('paciente')->count(),
            'suscripciones_activas' => Suscripcion::where('estado', 'activo')->count(),
            'procesos_seguros_abiertos' => ProcesoSeguro::abiertos()->count(),
            'items_bajo_stock' => ItemInventario::bajoStock()->count(),
        ];
        
        // Citas por especialidad
        $citasPorEspecialidad = Cita::whereBetween('fecha', [$fechaInicio, $fechaFin])
            ->with('especialidad')
            ->get()
            ->groupBy('especialidad.nombre')
            ->map->count();
        
        // Ingresos por suscripciones
        $ingresosSuscripciones = Suscripcion::whereBetween('created_at', [$fechaInicio, $fechaFin])
            ->sum('monto');
        
        return view('estadisticas.index', compact('stats', 'citasPorEspecialidad', 'ingresosSuscripciones'));
    }
}
```

---

## 📝 Orden de Implementación Recomendado

1. **Semana 1:** Gestión de Seguros (ya tienen base)
2. **Semana 2:** Código QR para Laboratorio
3. **Semana 3:** Gestión de Inventario
4. **Semana 4:** Estadísticas y Dashboard

---

*Documento generado por Antigravity AI - 23/11/2025*
