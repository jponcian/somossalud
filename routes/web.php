<?php

use App\Http\Controllers\Admin\UserManagementController;
use App\Http\Controllers\Especialista\DisponibilidadController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

use Illuminate\Support\Facades\Log;
Route::get('/', function () {
    try {
        app(\App\Services\BcvRateService::class)->syncIfMissing();
    } catch (\Throwable $e) {
        Log::warning('BCV sync failed: '.$e->getMessage());
    }
    return view('landing');
});

Route::get('/dashboard', function () {
    $user = \Illuminate\Support\Facades\Auth::user();
    // Si el usuario tiene rol de personal clínico distinto a paciente, podría ir a panel.clinica
    if ($user->hasRole(['super-admin','admin_clinica','recepcionista','especialista','laboratorio']) && !$user->hasRole('paciente')) {
        return redirect()->route('panel.clinica');
    }
    // Panel de paciente unificado
    $suscripcionActiva = \App\Models\Suscripcion::where('usuario_id', $user->id)->where('estado','activo')->latest()->first();
    $reportePendiente = \App\Models\ReportePago::where('usuario_id', $user->id)->where('estado','pendiente')->latest()->first();
    $ultimoRechazado = \App\Models\ReportePago::where('usuario_id', $user->id)->where('estado','rechazado')->latest()->first();
    $ultimaReceta = \App\Models\Cita::with(['medicamentos','especialista','clinica'])
        ->where('usuario_id', $user->id)
        ->whereHas('medicamentos')
        ->orderByRaw('COALESCE(concluida_at, updated_at) DESC')
        ->first();
    return view('panel.pacientes', compact('suscripcionActiva','reportePendiente','ultimoRechazado','ultimaReceta'));
})->middleware(['auth', 'verified'])->name('dashboard');

// El panel de pacientes es accesible por cualquier usuario autenticado (pacientes y personal)
// Mantener ruta antigua pero redirigir al nuevo dashboard unificado
Route::middleware(['auth', 'verified'])->get('/panel/pacientes', function () {
    return redirect()->route('dashboard');
})->name('panel.pacientes');

Route::middleware(['auth', 'verified', 'role:super-admin|admin_clinica|recepcionista|especialista|laboratorio'])->get('/panel/clinica', function () {
    return view('panel.clinica');
})->name('panel.clinica');

Route::middleware(['auth', 'verified', 'role:especialista'])
    ->prefix('especialista')
    ->name('especialista.')
    ->group(function () {
        Route::get('horarios', [DisponibilidadController::class, 'index'])->name('horarios.index');
        Route::post('horarios', [DisponibilidadController::class, 'store'])->name('horarios.store');
        Route::delete('horarios/{disponibilidad}', [DisponibilidadController::class, 'destroy'])->name('horarios.destroy');
    });

// Gestión de usuarios: también accesible por recepcionista (limitado a pacientes en el controlador)
Route::middleware(['auth', 'verified', 'role:super-admin|admin_clinica|recepcionista'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {
        Route::resource('users', UserManagementController::class)->only(['index', 'create', 'store', 'edit', 'update']);
    });

// Configuración: solo administración
Route::middleware(['auth', 'verified', 'role:super-admin|admin_clinica'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {
        Route::get('settings/pagos', [\App\Http\Controllers\Admin\SettingsController::class, 'pagos'])->name('settings.pagos');
        Route::post('settings/pagos', [\App\Http\Controllers\Admin\SettingsController::class, 'guardarPagos'])->name('settings.pagos.guardar');
    });

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Rutas de suscripción
    Route::get('/suscripcion', [\App\Http\Controllers\SuscripcionController::class, 'show'])
        ->name('suscripcion.show');
    Route::post('/suscripcion/reportar', [\App\Http\Controllers\SuscripcionController::class, 'reportarPago'])
        ->name('suscripcion.reportar');
    Route::get('/suscripcion/carnet', [\App\Http\Controllers\SuscripcionController::class, 'carnet'])
        ->name('suscripcion.carnet');

    // Endpoints auxiliares para selects dependientes y horarios disponibles (colocarlos ANTES del resource para evitar colisión con citas/{cita})
    Route::get('citas/doctores', [\App\Http\Controllers\CitaController::class, 'doctoresPorEspecialidad'])
        ->name('citas.doctores');
    Route::get('citas/slots', [\App\Http\Controllers\CitaController::class, 'slotsDisponibles'])
        ->name('citas.slots');
    Route::get('citas/dias', [\App\Http\Controllers\CitaController::class, 'diasDisponibles'])
        ->name('citas.dias');
    // Cambios de estado de cita
    Route::post('citas/{cita}/cancelar', [\App\Http\Controllers\CitaController::class, 'cancelar'])
        ->name('citas.cancelar');
    Route::post('citas/{cita}/reprogramar', [\App\Http\Controllers\CitaController::class, 'reprogramar'])
        ->name('citas.reprogramar');
    // Gestión de consulta (especialista)
    Route::post('citas/{cita}/gestion', [\App\Http\Controllers\CitaController::class, 'gestionar'])
        ->name('citas.gestion');
    // Receta visible para paciente
    Route::get('citas/{cita}/receta', [\App\Http\Controllers\CitaController::class, 'receta'])
        ->name('citas.receta');
    // Rutas para citas (resource). El controlador protegerá creación/almacenamiento con verificar.suscripcion.
    Route::resource('citas', \App\Http\Controllers\CitaController::class);

    // Ruta temporal para prueba de envío de correo de bienvenida
    Route::post('/test/send-welcome-email', function () {
        $user = \Illuminate\Support\Facades\Auth::user();
        \Illuminate\Support\Facades\Mail::to($user->email)->send(new \App\Mail\WelcomeEmail($user));
        return response()->json(['success' => true]);
    })->name('test.send-welcome-email');
});

Route::middleware(['auth', 'verified', 'role:recepcionista|admin_clinica|super-admin'])
    ->prefix('recepcion')
    ->name('recepcion.')
    ->group(function () {
        Route::get('pagos', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'index'])->name('pagos.index');
        Route::post('pagos/{reporte}/aprobar', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'aprobar'])->name('pagos.aprobar');
        Route::post('pagos/{reporte}/rechazar', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'rechazar'])->name('pagos.rechazar');
    });

// Atenciones (seguro / guardia)
Route::middleware(['auth','verified'])
    ->group(function(){
        // Listados por rol
        Route::get('atenciones', [\App\Http\Controllers\AtencionController::class, 'index'])->name('atenciones.index');
        // Recepción
        Route::post('atenciones', [\App\Http\Controllers\AtencionController::class, 'store'])->name('atenciones.store');
        Route::post('atenciones/{atencion}/asignar', [\App\Http\Controllers\AtencionController::class, 'asignarMedico'])->name('atenciones.asignar');
        Route::post('atenciones/{atencion}/cerrar', [\App\Http\Controllers\AtencionController::class, 'cerrar'])->name('atenciones.cerrar');
    // Buscadores AJAX recepción
    Route::get('ajax/pacientes', [\App\Http\Controllers\AtencionController::class, 'buscarPacientes'])->name('ajax.pacientes');
    Route::get('ajax/clinicas', [\App\Http\Controllers\AtencionController::class, 'buscarClinicas'])->name('ajax.clinicas');
    Route::get('ajax/medicos', [\App\Http\Controllers\AtencionController::class, 'buscarMedicos'])->name('ajax.medicos');
        // Especialista gestionar
    Route::get('atenciones/{atencion}/gestion', function(\App\Models\Atencion $atencion){
            // Reusar layout admin para especialistas
            $user = \Illuminate\Support\Facades\Auth::user();
            if(!$user->hasRole(['especialista','super-admin','admin_clinica'])) abort(403);
            // Historial del paciente para apoyo clínico
            $historial = collect();
            if ($atencion->paciente_id) {
                $pacienteId = $atencion->paciente_id;
                $citas = \App\Models\Cita::with(['especialista','medicamentos'])
                    ->where('usuario_id', $pacienteId)
                    ->orderBy('fecha','desc')->limit(10)->get();
                $ats = \App\Models\Atencion::with(['medico','medicamentos'])
                    ->where('paciente_id', $pacienteId)
                    ->orderByRaw('COALESCE(cerrada_at, updated_at, created_at) DESC')
                    ->limit(10)->get();
                foreach ($citas as $c) {
                    $historial->push([
                        'tipo' => 'cita',
                        'momento' => \Carbon\Carbon::parse($c->fecha),
                        'estado' => $c->estado,
                        'especialista' => optional($c->especialista)->name,
                        'diagnostico' => $c->diagnostico,
                        'observaciones' => $c->observaciones,
                        'meds_list' => $c->medicamentos->map(fn($m)=>[
                            'nombre' => $m->nombre_generico,
                            'presentacion' => $m->presentacion,
                            'posologia' => $m->posologia,
                            'frecuencia' => $m->frecuencia,
                            'duracion' => $m->duracion,
                        ])->values(),
                    ]);
                }
                foreach ($ats as $a) {
                    $historial->push([
                        'tipo' => 'atencion',
                        'momento' => $a->iniciada_at ?? $a->created_at,
                        'estado' => $a->estado,
                        'especialista' => optional($a->medico)->name,
                        'diagnostico' => $a->diagnostico,
                        'observaciones' => $a->observaciones,
                        'meds_list' => $a->medicamentos->map(fn($m)=>[
                            'nombre' => $m->nombre_generico,
                            'presentacion' => $m->presentacion,
                            'posologia' => $m->posologia,
                            'frecuencia' => $m->frecuencia,
                            'duracion' => $m->duracion,
                        ])->values(),
                    ]);
                }
                $historial = $historial->sortByDesc('momento')->take(10)->values();
            }
            return view('atenciones.especialista.gestion', compact('atencion','historial'));
        })->name('atenciones.gestion');
        Route::post('atenciones/{atencion}/gestion', [\App\Http\Controllers\AtencionController::class, 'gestionar'])->name('atenciones.gestion.post');
        // Detalle paciente (solo lectura) - reutiliza controlador para ver una atención propia
        Route::get('atenciones/paciente/{atencion}', [\App\Http\Controllers\AtencionController::class, 'showPaciente'])->name('atenciones.paciente.show');
        Route::get('atenciones/paciente/{atencion}/receta', [\App\Http\Controllers\AtencionController::class, 'recetaPaciente'])->name('atenciones.paciente.receta');
    });

require __DIR__ . '/auth.php';
