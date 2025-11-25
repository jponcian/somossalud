# 🚀 Plan de Implementación - Módulos Pendientes
## Clínica SaludSonrisa (SomosSalud)

---

## 📦 MÓDULO 1: Control de Inventario (Sistema de Solicitudes)

> **⚠️ NUEVO ENFOQUE:** El sistema de inventario ha sido rediseñado para usar un flujo de solicitudes simplificado.
> 
> **📄 Ver documentación completa:** [`MODULO_INVENTARIO_SOLICITUDES.md`](./MODULO_INVENTARIO_SOLICITUDES.md)

### Resumen del Nuevo Sistema

**Flujo de trabajo:**
1. Personal con rol `almacen` crea solicitudes por categoría
2. Selecciona categoría: ENFERMERIA, QUIROFANO, UCI, OFICINA
3. Agrega items y cantidades solicitadas
4. `admin_clinica` recibe y aprueba/rechaza la solicitud
5. `admin_clinica` despacha las cantidades aprobadas

**Características principales:**
- ✅ Sistema basado en solicitudes (no seguimiento detallado de stock)
- ✅ Nuevo rol: `almacen`
- ✅ 4 categorías predefinidas
- ✅ Flujo: Solicitud → Aprobación → Despacho
- ✅ Historial completo de solicitudes
- ✅ Filtros por estado, categoría y fechas

**Tablas de base de datos:**
- `solicitudes_inventario` - Solicitudes principales
- `items_solicitud_inventario` - Items de cada solicitud

**Modelos:**
- `SolicitudInventario`
- `ItemSolicitudInventario`

**Controlador:**
- `SolicitudInventarioController`

**Policy:**
- `SolicitudInventarioPolicy`

**Vistas:**
- `inventario/solicitudes/index.blade.php`
- `inventario/solicitudes/create.blade.php`
- `inventario/solicitudes/show.blade.php`
- `inventario/solicitudes/edit.blade.php`

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

1. **Semana 1:** Control de Inventario (Sistema de Solicitudes) - Ver [`MODULO_INVENTARIO_SOLICITUDES.md`](./MODULO_INVENTARIO_SOLICITUDES.md)
2. **Semana 2:** Gestión de Seguros (ya tienen base)
3. **Semana 3:** Código QR para Laboratorio (ya implementado ✅)
4. **Semana 4:** Estadísticas y Dashboard

---

*Documento generado por Antigravity AI - 23/11/2025*
