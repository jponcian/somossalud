<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Especialidad;
use App\Models\User;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Str;
use Illuminate\View\View;
use Spatie\Permission\Models\Role;

class UserManagementController extends Controller
{
    public function index(): View
    {
        $usuarioActual = Auth::user();
        $roles = \Spatie\Permission\Models\Role::orderBy('name')->pluck('name');
        $filtroRol = request('rol');
        $usuariosQuery = User::with(['roles', 'especialidad']);

        // Si es recepcionista: solo puede ver pacientes
        if ($usuarioActual && $usuarioActual->hasRole('recepcionista')) {
            $roles = collect(['paciente']);
            $usuariosQuery->whereHas('roles', function ($q) {
                $q->where('name', 'paciente');
            });
            // Forzar el filtro a paciente si llega otro valor
            if ($filtroRol && $filtroRol !== 'paciente') {
                $filtroRol = 'paciente';
            }
        }

        if ($filtroRol) {
            $usuariosQuery->whereHas('roles', function($q) use ($filtroRol) {
                $q->where('name', $filtroRol);
            });
        }
        $usuarios = $usuariosQuery->orderByDesc('created_at')->paginate(12)->appends(['rol' => $filtroRol]);

        return view('admin.users.index', [
            'usuarios' => $usuarios,
            'roles' => $roles,
            'filtroRol' => $filtroRol,
        ]);
    }

    public function create(): View
    {
        $roles = Auth::user()->hasRole('recepcionista')
            ? collect(['paciente'])
            : Role::orderBy('name')->pluck('name');
        $especialidades = Especialidad::orderBy('nombre')->get();

        return view('admin.users.create', [
            'roles' => $roles,
            'especialidades' => $especialidades,
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        // Si es recepcionista, forzar rol paciente y sin especialidad
        if (Auth::user()->hasRole('recepcionista')) {
            $request->merge(['roles' => ['paciente'], 'especialidad_id' => null]);
        }

        $roles = Role::pluck('name');
        $roleNames = $roles->toArray();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'cedula' => ['required', 'string', 'max:50', 'unique:usuarios,cedula'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:usuarios,email'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
            'roles' => ['required', 'array', 'min:1'],
            'roles.*' => ['string', 'in:' . implode(',', $roleNames)],
            // 'especialidad_id' => ['nullable', 'exists:especialidades,id'], // legacy, no exigir
        ]);

        $esEspecialista = collect($validated['roles'])->contains('especialista');

        if ($esEspecialista) {
            $request->validate([
                'especialidades' => ['required', 'array', 'min:1'],
                'especialidades.*' => ['exists:especialidades,id'],
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

        // Sincronizar especialidades múltiples (solo si es especialista)
        if ($esEspecialista && $request->has('especialidades')) {
            $usuario->especialidades()->sync($request->input('especialidades', []));
        }

        return redirect()
            ->route('admin.users.index')
            ->with('status', 'Usuario registrado correctamente.');
    }

    public function edit(User $user): View
    {
        $user->load(['roles', 'especialidad']);

        // Recepcionista solo puede editar pacientes
        if (Auth::user()->hasRole('recepcionista') && !$user->hasRole('paciente')) {
            abort(403);
        }

        $roles = Auth::user()->hasRole('recepcionista')
            ? collect(['paciente'])
            : Role::orderBy('name')->pluck('name');
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
        // Recepcionista solo puede actualizar pacientes y forzar rol paciente
        if (Auth::user()->hasRole('recepcionista')) {
            if (!$user->hasRole('paciente')) {
                abort(403);
            }
            $request->merge(['roles' => ['paciente'], 'especialidad_id' => null]);
        }

        $roles = Role::pluck('name');
        $roleNames = $roles->toArray();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'cedula' => ['required', 'string', 'max:50', 'unique:usuarios,cedula,' . $user->id],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:usuarios,email,' . $user->id],
            'password' => ['nullable', 'string', 'min:8', 'confirmed'],
            'roles' => ['required', 'array', 'min:1'],
            'roles.*' => ['string', 'in:' . implode(',', $roleNames)],
            // 'especialidad_id' => ['nullable', 'exists:especialidades,id'], // legacy, no exigir
        ]);

        $esEspecialista = collect($validated['roles'])->contains('especialista');

        if ($esEspecialista) {
            $request->validate([
                'especialidades' => ['required', 'array', 'min:1'],
                'especialidades.*' => ['exists:especialidades,id'],
            ]);
        }

        $user->name = $validated['name'];
        $user->cedula = Str::upper($validated['cedula']);
        $user->email = $validated['email'];
        $user->especialidad_id = $esEspecialista ? ($validated['especialidad_id'] ?? null) : null;

        if (!empty($validated['password'])) {
            $user->password = Hash::make($validated['password']);
        }

        $user->save();

        $user->syncRoles($validated['roles']);

        // Sincronizar especialidades múltiples (solo si es especialista)
        if ($esEspecialista && $request->has('especialidades')) {
            $user->especialidades()->sync($request->input('especialidades', []));
        } else {
            $user->especialidades()->detach();
        }

        return redirect()
            ->route('admin.users.index')
            ->with('status', 'Usuario actualizado correctamente.');
    }
}
