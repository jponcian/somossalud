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

Route::middleware(['auth', 'verified', 'role:super-admin|admin_clinica'])
    ->prefix('admin')
    ->name('admin.')
    ->group(function () {
        Route::resource('users', UserManagementController::class)->only(['index', 'create', 'store', 'edit', 'update']);
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
});

Route::middleware(['auth', 'verified', 'role:recepcionista|admin_clinica|super-admin'])
    ->prefix('recepcion')
    ->name('recepcion.')
    ->group(function () {
        Route::get('pagos', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'index'])->name('pagos.index');
        Route::post('pagos/{reporte}/aprobar', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'aprobar'])->name('pagos.aprobar');
        Route::post('pagos/{reporte}/rechazar', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'rechazar'])->name('pagos.rechazar');
    });

require __DIR__ . '/auth.php';
