<?php

use Illuminate\Foundation\Application;
use Illuminate\Foundation\Configuration\Exceptions;
use Illuminate\Foundation\Configuration\Middleware;

return Application::configure(basePath: dirname(__DIR__))
    ->withRouting(
        web: __DIR__.'/../routes/web.php',
        commands: __DIR__.'/../routes/console.php',
        health: '/up',
    )
    ->withMiddleware(function (Middleware $middleware): void {
        $middleware->redirectUsersTo(function () {
            $user = \Illuminate\Support\Facades\Auth::user();
            $perfil = request()->input('perfil');

            if ($perfil === 'empleados' && $user && $user->hasAnyRole(['super-admin', 'admin_clinica', 'recepcionista', 'especialista', 'laboratorio', 'laboratorio-resul', 'almacen', 'almacen-jefe'])) {
                return route('panel.clinica');
            }
            
            if ($perfil === 'pacientes' && $user && $user->hasRole('paciente')) {
                return route('panel.pacientes');
            }

            return route('dashboard');
        });
    })
    ->withExceptions(function (Exceptions $exceptions): void {
        //
    })->create();
