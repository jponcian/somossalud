<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Redirect;
use Illuminate\View\View;

class ProfileController extends Controller
{
    /**
     * Display the user's profile form.
     */
    public function edit(Request $request): View
    {
        $context = $request->input('context');
        $user = $request->user();

        // Si el contexto es explícitamente 'clinica', mostrar layout de clínica
        if ($context === 'clinica') {
            return view('profile.edit_clinic', ['user' => $user]);
        }

        // Si el contexto es explícitamente 'paciente', mostrar layout de paciente
        if ($context === 'paciente') {
            return view('profile.edit', ['user' => $user]);
        }

        // Fallback: si tiene roles de clínica, mostrar layout de clínica por defecto
        if ($user->hasAnyRole(['super-admin', 'admin_clinica', 'recepcionista', 'especialista', 'laboratorio', 'laboratorio-resul', 'almacen', 'almacen-jefe'])) {
            return view('profile.edit_clinic', ['user' => $user]);
        }

        return view('profile.edit', [
            'user' => $user,
        ]);
    }

    /**
     * Update the user's profile information.
     */
    public function update(ProfileUpdateRequest $request): RedirectResponse
    {
        $request->user()->fill($request->validated());

        if ($request->user()->isDirty('email')) {
            $request->user()->email_verified_at = null;
        }

        $request->user()->save();

        $context = $request->query('context');
        return Redirect::route('profile.edit', ['context' => $context])->with('status', 'profile-updated');
    }

    /**
     * Delete the user's account.
     */
    public function destroy(Request $request): RedirectResponse
    {
        $request->validateWithBag('userDeletion', [
            'password' => ['required', 'current_password'],
        ]);

        $user = $request->user();

        Auth::logout();

        $user->delete();

        $request->session()->invalidate();
        $request->session()->regenerateToken();

        return Redirect::to('/');
    }
}
