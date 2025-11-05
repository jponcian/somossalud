<?php

use App\Http\Controllers\Admin\UserManagementController;
use App\Http\Controllers\Especialista\DisponibilidadController;
use App\Http\Controllers\ProfileController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('landing');
});

Route::get('/dashboard', function () {
    return view('dashboard');
})->middleware(['auth', 'verified'])->name('dashboard');

// El panel de pacientes es accesible por cualquier usuario autenticado (pacientes y personal)
Route::middleware(['auth', 'verified'])->get('/panel/pacientes', function () {
    return view('panel.pacientes');
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
        Route::resource('users', UserManagementController::class)->only(['index', 'create', 'store']);
    });

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Rutas de suscripción (MVP sandbox)
    Route::get('/suscripcion', [\App\Http\Controllers\SuscripcionController::class, 'show'])
        ->name('suscripcion.show');
    Route::post('/suscripcion/pagar', [\App\Http\Controllers\SuscripcionController::class, 'paySandbox'])
        ->name('suscripcion.pagar');
    Route::post('/suscripcion/reportar', [\App\Http\Controllers\SuscripcionController::class, 'reportarPago'])
        ->name('suscripcion.reportar');
    Route::get('/suscripcion/carnet', [\App\Http\Controllers\SuscripcionController::class, 'carnet'])
        ->name('suscripcion.carnet');

    // Rutas para citas (resource). El controlador protegerá creación/almacenamiento con verificar.suscripcion.
    Route::resource('citas', \App\Http\Controllers\CitaController::class);
});

Route::middleware(['auth', 'verified', 'role:recepcionista'])
    ->prefix('recepcion')
    ->name('recepcion.')
    ->group(function () {
        Route::get('pagos', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'index'])->name('pagos.index');
        Route::post('pagos/{reporte}/aprobar', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'aprobar'])->name('pagos.aprobar');
        Route::post('pagos/{reporte}/rechazar', [\App\Http\Controllers\Recepcion\PagoManualController::class, 'rechazar'])->name('pagos.rechazar');
    });

require __DIR__ . '/auth.php';
