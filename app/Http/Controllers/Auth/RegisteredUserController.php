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
        // Normalizar cédula antes de validar
        $cedula = strtoupper(trim($request->cedula));
        if (preg_match('/^([VEJGP])(\d{6,8})$/i', $cedula, $matches)) {
            $cedula = $matches[1] . '-' . $matches[2];
        }
        $request->merge(['cedula' => $cedula]);

        $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:usuarios,email'],
            'cedula' => [
                'required', 
                'string', 
                'max:50', 
                'unique:usuarios,cedula',
                'regex:/^[VEJGP]-\d{6,8}$/i'
            ],
            'password' => ['required', 'confirmed', Rules\Password::defaults()],
        ], [
            'cedula.regex' => 'El formato de la cédula debe ser: V-12345678 (6 a 8 dígitos). Letras permitidas: V, E, J, G, P',
            'cedula.unique' => 'Esta cédula ya está registrada en el sistema',
        ]);

        // Asignar a la clínica por defecto (SaludSonrisa) si existe
        $clinicaId = \App\Models\Clinica::first()?->id ?? null;

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'cedula' => $cedula,
            'password' => Hash::make($request->password),
            'clinica_id' => $clinicaId,
        ]);

        // Asignar rol de paciente por defecto a los usuarios que se registran desde el portal
        if (method_exists($user, 'assignRole')) {
            $user->assignRole('paciente');
        }

        event(new Registered($user));

        // Enviar correo de bienvenida
        \Illuminate\Support\Facades\Mail::to($user->email)->send(new \App\Mail\WelcomeEmail($user));

        Auth::login($user);

        // Redirigir a la zona de pacientes tras el registro
        return redirect()->route('panel.pacientes');
    }
}
