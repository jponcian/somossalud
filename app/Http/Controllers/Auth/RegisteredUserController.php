<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\Rules;
use Illuminate\View\View;

class RegisteredUserController extends Controller
{
    /**
     * Display the registration view.
     */
    public function create(): View
    {
        return view('auth.register');
    }

    /**
     * Handle an incoming registration request.
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function store(Request $request): RedirectResponse
    {
        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:usuarios,email'],
            'cedula' => ['required', 'string', 'max:50', 'unique:usuarios,cedula'],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ]);

        // Asignar a la clínica por defecto (SaludSonrisa) si existe
        $clinicaId = \App\Models\Clinica::first()?->id ?? null;

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'cedula' => $request->cedula,
            'password' => Hash::make($request->password),
            'clinica_id' => $clinicaId,
        ]);

        // Asignar rol de paciente por defecto a los usuarios que se registran desde el portal
        if (method_exists($user, 'assignRole')) {
            $user->assignRole('paciente');
        }

        event(new Registered($user));

        Auth::login($user);

        // Redirigir a la zona de pacientes tras el registro
        return redirect()->route('panel.pacientes');
    }
}
