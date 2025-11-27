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

        // Si es recepcionista (y no es admin): solo puede ver pacientes
        if ($usuarioActual && $usuarioActual->hasRole('recepcionista') && !$usuarioActual->hasAnyRole(['super-admin', 'admin_clinica'])) {
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
            $usuariosQuery->whereHas('roles', function ($q) use ($filtroRol) {
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
        $esRecepcionistaLimitado = Auth::user()->hasRole('recepcionista') && !Auth::user()->hasAnyRole(['super-admin', 'admin_clinica']);

        $roles = $esRecepcionistaLimitado
            ? collect(['paciente'])
            : Role::where('name', '!=', 'super-admin')->orderBy('name')->pluck('name');
        $especialidades = Especialidad::orderBy('nombre')->get();

        // Obtener posibles representantes (usuarios que no son dependientes)
        // Filtramos por aquellos que NO tienen representante_id
        $posiblesRepresentantes = User::whereNull('representante_id')
            ->orderBy('name')
            ->get(['id', 'name', 'cedula', 'email']);

        return view('admin.users.create', [
            'roles' => $roles,
            'especialidades' => $especialidades,
            'posiblesRepresentantes' => $posiblesRepresentantes,
        ]);
    }

    public function store(Request $request): RedirectResponse
    {
        // Si es recepcionista (y no admin), forzar rol paciente y sin especialidad
        if (Auth::user()->hasRole('recepcionista') && !Auth::user()->hasAnyRole(['super-admin', 'admin_clinica'])) {
            $request->merge(['roles' => ['paciente'], 'especialidad_id' => null]);
        }

        // Normalizar cédula antes de validar (ahora acepta sufijo -H1, -H2, etc. para hijos)
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
                'regex:/^[VEJGP]-\d{6,8}(-H\d+)?$/i' // Acepta V-12345678 o V-12345678-H1
            ],
            'email' => ['required', 'string', 'email', 'max:255'], // Removido unique para permitir emails compartidos
            'fecha_nacimiento' => ['required', 'date', 'before:today'],
            'sexo' => ['required', 'in:M,F'],
            'password' => ['required', 'string', 'min:8', 'confirmed'],
            'roles' => ['required', 'array', 'min:1'],
            'roles.*' => ['string', 'in:' . implode(',', $roleNames)],
            'representante_id' => ['nullable', 'exists:usuarios,id'], // ID del representante si es un dependiente
        ], [
            'cedula.regex' => 'El formato de la cédula debe ser: V-12345678 o V-12345678-H1 (para hijos). Letras permitidas: V, E, J, G, P',
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
            'representante_id' => $validated['representante_id'] ?? null,
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

        // Recepcionista (no admin) solo puede editar pacientes
        $esRecepcionistaLimitado = Auth::user()->hasRole('recepcionista') && !Auth::user()->hasAnyRole(['super-admin', 'admin_clinica']);

        if ($esRecepcionistaLimitado && !$user->hasRole('paciente')) {
            abort(403);
        }

        $roles = $esRecepcionistaLimitado
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
        // Recepcionista (no admin) solo puede actualizar pacientes y forzar rol paciente
        if (Auth::user()->hasRole('recepcionista') && !Auth::user()->hasAnyRole(['super-admin', 'admin_clinica'])) {
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
                'regex:/^[VEJGP]-\d{6,8}(-H\d+)?$/i' // Acepta V-12345678 o V-12345678-H1
            ],
            'email' => ['required', 'string', 'email', 'max:255'], // Removido unique para permitir emails compartidos
            'fecha_nacimiento' => ['required', 'date', 'before:today'],
            'sexo' => ['required', 'in:M,F'],
            'password' => ['nullable', 'string', 'min:8', 'confirmed'],
            'roles' => ['required', 'array', 'min:1'],
            'roles.*' => ['string', 'in:' . implode(',', $roleNames)],
            'representante_id' => ['nullable', 'exists:usuarios,id'],
        ], [
            'cedula.regex' => 'El formato de la cédula debe ser: V-12345678 o V-12345678-H1 (para hijos). Letras permitidas: V, E, J, G, P',
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
    public function sendPasswordResetLink(User $user): \Illuminate\Http\JsonResponse
    {
        // Enviar el enlace de restablecimiento de contraseña
        $status = \Illuminate\Support\Facades\Password::broker()->sendResetLink(
            ['email' => $user->email]
        );

        if ($status == \Illuminate\Support\Facades\Password::RESET_LINK_SENT) {
            return response()->json([
                'success' => true,
                'message' => __($status)
            ]);
        }

        return response()->json([
            'success' => false,
            'message' => __($status)
        ], 400);
    }

    public function getNextDependentNumber(User $representante): \Illuminate\Http\JsonResponse
    {
        // Obtener todos los dependientes del representante
        $dependientes = User::where('representante_id', $representante->id)
            ->where('cedula', 'LIKE', $representante->cedula . '-H%')
            ->get();

        // Extraer los números de los sufijos existentes
        $numeros = $dependientes->map(function ($dep) {
            if (preg_match('/-H(\d+)$/', $dep->cedula, $matches)) {
                return (int) $matches[1];
            }
            return 0;
        })->filter()->toArray();

        // Calcular el siguiente número disponible
        $siguienteNumero = empty($numeros) ? 1 : max($numeros) + 1;

        return response()->json([
            'next_number' => $siguienteNumero,
            'representante_cedula' => $representante->cedula
        ]);
    }

    public function searchRepresentantes(Request $request): \Illuminate\Http\JsonResponse
    {
        $term = trim($request->query('q', ''));

        if (strlen($term) < 3) {
            return response()->json(['results' => []]);
        }

        $users = User::where(function ($q) use ($term) {
            $q->where('name', 'like', "%{$term}%")
                ->orWhere('cedula', 'like', "%{$term}%");
        })
            ->orderBy('name')
            ->limit(20)
            ->get(['id', 'name', 'cedula', 'email']);

        // Formatear para Select2
        $results = $users->map(function ($user) {
            return [
                'id' => $user->id,
                'text' => $user->name . ' (' . $user->cedula . ')',
                'cedula' => $user->cedula,
                'email' => $user->email
            ];
        });

        return response()->json(['results' => $results]);
    }
}
