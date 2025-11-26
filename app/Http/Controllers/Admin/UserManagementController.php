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
        $roles = \Spatie\Permission\Models\Role::where('name', '!=', 'super-admin')->orderBy('name')->pluck('name');
        $filtroRol = request('rol');
        $usuariosQuery = User::with(['roles', 'especialidad'])
            ->whereDoesntHave('roles', function ($q) {
                $q->where('name', 'super-admin');
            });

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
            : Role::where('name', '!=', 'super-admin')->orderBy('name')->pluck('name');
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

        // Normalizar cédula antes de validar
        $cedula = strtoupper(trim($request->cedula));
        if (preg_match('/^([VEJGP])(\d{6,8})$/i', $cedula, $matches)) {
            $cedula = $matches[1] . '-' . $matches[2];
        }
        $request->merge(['cedula' => $cedula]);

        $roles = Role::where('name', '!=', 'super-admin')->pluck('name');
        $roleNames = $roles->toArray();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'cedula' => [
                'required', 
                'string', 
                'max:50', 
                'unique:usuarios,cedula',
                'regex:/^[VEJGP]-\d{6,8}$/i'
            ],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:usuarios,email'],
            'fecha_nacimiento' => ['required', 'date', 'before:today'],
            'sexo' => ['required', 'in:M,F'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
            'roles' => ['required', 'array', 'min:1'],
            'roles.*' => ['string', 'in:' . implode(',', $roleNames)],
            // 'especialidad_id' => ['nullable', 'exists:especialidades,id'], // legacy, no exigir
        ], [
            'cedula.regex' => 'El formato de la cédula debe ser: V-12345678 (6 a 8 dígitos). Letras permitidas: V, E, J, G, P',
            'cedula.unique' => 'Esta cédula ya está registrada en el sistema',
            'fecha_nacimiento.required' => 'La fecha de nacimiento es obligatoria',
            'fecha_nacimiento.date' => 'La fecha de nacimiento debe ser una fecha válida',
            'fecha_nacimiento.before' => 'La fecha de nacimiento debe ser anterior a hoy',
            'sexo.required' => 'El sexo es obligatorio',
            'sexo.in' => 'El sexo seleccionado no es válido',
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
            'cedula' => $cedula,
            'email' => $validated['email'],
            'fecha_nacimiento' => $validated['fecha_nacimiento'],
            'sexo' => $validated['sexo'],
            'password' => Hash::make($validated['password']),
            'especialidad_id' => $esEspecialista ? ($validated['especialidad_id'] ?? null) : null,
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
            : Role::where('name', '!=', 'super-admin')->orderBy('name')->pluck('name');
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

        // Normalizar cédula antes de validar
        $cedula = strtoupper(trim($request->cedula));
        if (preg_match('/^([VEJGP])(\d{6,8})$/i', $cedula, $matches)) {
            $cedula = $matches[1] . '-' . $matches[2];
        }
        $request->merge(['cedula' => $cedula]);

        $roles = Role::where('name', '!=', 'super-admin')->pluck('name');
        $roleNames = $roles->toArray();

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'cedula' => [
                'required', 
                'string', 
                'max:50', 
                'unique:usuarios,cedula,' . $user->id,
                'regex:/^[VEJGP]-\d{6,8}$/i'
            ],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:usuarios,email,' . $user->id],
            'fecha_nacimiento' => ['required', 'date', 'before:today'],
            'sexo' => ['required', 'in:M,F'],
            'password' => ['nullable', 'string', 'min:8', 'confirmed'],
            'roles' => ['required', 'array', 'min:1'],
            'roles.*' => ['string', 'in:' . implode(',', $roleNames)],
            // 'especialidad_id' => ['nullable', 'exists:especialidades,id'], // legacy, no exigir
        ], [
            'cedula.regex' => 'El formato de la cédula debe ser: V-12345678 (6 a 8 dígitos). Letras permitidas: V, E, J, G, P',
            'cedula.unique' => 'Esta cédula ya está registrada en el sistema',
            'fecha_nacimiento.required' => 'La fecha de nacimiento es obligatoria',
            'fecha_nacimiento.date' => 'La fecha de nacimiento debe ser una fecha válida',
            'fecha_nacimiento.before' => 'La fecha de nacimiento debe ser anterior a hoy',
            'sexo.required' => 'El sexo es obligatorio',
            'sexo.in' => 'El sexo seleccionado no es válido',
        ]);

        $esEspecialista = collect($validated['roles'])->contains('especialista');

        if ($esEspecialista) {
            $request->validate([
                'especialidades' => ['required', 'array', 'min:1'],
                'especialidades.*' => ['exists:especialidades,id'],
            ]);
        }

        $user->name = $validated['name'];
        $user->cedula = $cedula;
        $user->email = $validated['email'];
        $user->fecha_nacimiento = $validated['fecha_nacimiento'];
        $user->sexo = $validated['sexo'];
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
