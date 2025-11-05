<?php

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

Route::middleware('auth')->group(function () {
    Route::get('/profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('/profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::delete('/profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    // Rutas de suscripción (MVP sandbox)
    Route::get('/suscripcion', [\App\Http\Controllers\SuscripcionController::class, 'show'])
        ->name('suscripcion.show');
    Route::post('/suscripcion/pagar', [\App\Http\Controllers\SuscripcionController::class, 'paySandbox'])
        ->name('suscripcion.pagar');

    // Rutas para citas (resource). El controlador protegerá creación/almacenamiento con verificar.suscripcion.
    Route::resource('citas', \App\Http\Controllers\CitaController::class);
});

require __DIR__ . '/auth.php';
