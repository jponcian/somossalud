<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Especialidad;
use App\Models\User;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\View\View;
use Spatie\Permission\Models\Role;

class UserManagementController extends Controller
{
    public function index(): View
    {
        $usuarios = User::with(['roles', 'especialidad'])->orderByDesc('created_at')->paginate(12);

        return view('admin.users.index', [
            'usuarios' => $usuarios,
        ]);
    }

    public function create(): View
    {
        $roles = Role::orderBy('name')->pluck('name');
        $especialidades = Especialidad::orderBy('nombre')->get();

        return view('admin.users.create', [
            'roles' => $roles,
            'especialidades' => $especialidades,
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        $roles = Role::pluck('name');
        $roleNames = $roles->toArray();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'cedula' => ['required', 'string', 'max:50', 'unique:usuarios,cedula'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:usuarios,email'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
            'roles' => ['required', 'array', 'min:1'],
            'roles.*' => ['string', 'in:' . implode(',', $roleNames)],
            'especialidad_id' => ['nullable', 'exists:especialidades,id'],
        ]);

        $esEspecialista = collect($validated['roles'])->contains('especialista');

        if ($esEspecialista) {
            $request->validate([
                'especialidad_id' => ['required', 'exists:especialidades,id'],
            ]);
        }

        $usuario = User::create([
            'name' => $validated['name'],
            'cedula' => Str::upper($validated['cedula']),
            'email' => $validated['email'],
            'password' => Hash::make($validated['password']),
            'especialidad_id' => $esEspecialista ? $validated['especialidad_id'] : null,
        ]);

        $usuario->syncRoles($validated['roles']);

        return redirect()
            ->route('admin.users.index')
            ->with('status', 'Usuario registrado correctamente.');
    }

    public function edit(User $user): View
    {
        $user->load(['roles', 'especialidad']);

        $roles = Role::orderBy('name')->pluck('name');
        $especialidades = Especialidad::orderBy('nombre')->get();
        $assignedRoles = $user->roles->pluck('name')->toArray();

        return view('admin.users.edit', [
            'usuario' => $user,
            'roles' => $roles,
            'especialidades' => $especialidades,
            'assignedRoles' => $assignedRoles,
        ]);
    }

    public function update(Request $request, User $user): RedirectResponse
    {
        $roles = Role::pluck('name');
        $roleNames = $roles->toArray();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'cedula' => ['required', 'string', 'max:50', 'unique:usuarios,cedula,' . $user->id],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:usuarios,email,' . $user->id],
            'password' => ['nullable', 'string', 'min:8', 'confirmed'],
            'roles' => ['required', 'array', 'min:1'],
            'roles.*' => ['string', 'in:' . implode(',', $roleNames)],
            'especialidad_id' => ['nullable', 'exists:especialidades,id'],
        ]);

        $esEspecialista = collect($validated['roles'])->contains('especialista');

        if ($esEspecialista) {
            $request->validate([
                'especialidad_id' => ['required', 'exists:especialidades,id'],
            ]);
        }

        $user->name = $validated['name'];
        $user->cedula = Str::upper($validated['cedula']);
        $user->email = $validated['email'];
        $user->especialidad_id = $esEspecialista ? $validated['especialidad_id'] : null;

        if (!empty($validated['password'])) {
            $user->password = Hash::make($validated['password']);
        }

        $user->save();

        $user->syncRoles($validated['roles']);

        return redirect()
            ->route('admin.users.index')
            ->with('status', 'Usuario actualizado correctamente.');
    }
}
