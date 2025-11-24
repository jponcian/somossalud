<?php

namespace App\Http\Controllers\Laboratorio;

use App\Http\Controllers\Controller;
use App\Models\ResultadoLaboratorio;
use App\Models\User;
use App\Models\Clinica;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Storage;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
use Barryvdh\DomPDF\Facade\Pdf;

class ResultadoLaboratorioController extends Controller
{
    /**
     * Mostrar listado de resultados
     */
    public function index()
    {
        $user = Auth::user();
        
        // Si es laboratorio, mostrar todos los resultados de su clínica
        if ($user->hasRole('laboratorio')) {
            $resultados = ResultadoLaboratorio::with(['paciente', 'clinica', 'registradoPor'])
                ->where('clinica_id', $user->clinica_id)
                ->orderBy('created_at', 'desc')
                ->paginate(20);
        } else {
            // Administradores pueden ver todos
            $resultados = ResultadoLaboratorio::with(['paciente', 'clinica', 'registradoPor'])
                ->orderBy('created_at', 'desc')
                ->paginate(20);
        }

        return view('laboratorio.index', compact('resultados'));
    }

    /**
     * Mostrar formulario de carga de resultado
     */
    public function create()
    {
        $user = Auth::user();
        
        // Obtener pacientes
        $pacientes = User::role('paciente')
            ->orderBy('name')
            ->get();

        // Obtener clínica del usuario o todas si es admin
        if ($user->hasRole(['super-admin', 'admin_clinica'])) {
            $clinicas = Clinica::orderBy('nombre')->get();
        } else {
            $clinicas = Clinica::where('id', $user->clinica_id)->get();
        }

        return view('laboratorio.create', compact('pacientes', 'clinicas'));
    }

    /**
     * Guardar nuevo resultado
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'paciente_id' => 'required|exists:usuarios,id',
            'clinica_id' => 'required|exists:clinicas,id',
            'tipo_examen' => 'required|string|max:255',
            'nombre_examen' => 'required|string|max:255',
            'fecha_muestra' => 'required|date',
            'fecha_resultado' => 'required|date',
            'observaciones' => 'nullable|string',
            'resultados' => 'required|array',
            'resultados.*.parametro' => 'required|string',
            'resultados.*.valor' => 'required|string',
            'resultados.*.unidad' => 'nullable|string',
            'resultados.*.rango_referencia' => 'nullable|string',
        ]);

        // Generar código de verificación único
        $codigoVerificacion = ResultadoLaboratorio::generarCodigoVerificacion();

        // Crear el resultado
        $resultado = ResultadoLaboratorio::create([
            'paciente_id' => $validated['paciente_id'],
            'clinica_id' => $validated['clinica_id'],
            'tipo_examen' => $validated['tipo_examen'],
            'nombre_examen' => $validated['nombre_examen'],
            'fecha_muestra' => $validated['fecha_muestra'],
            'fecha_resultado' => $validated['fecha_resultado'],
            'observaciones' => $validated['observaciones'] ?? null,
            'resultados_json' => $validated['resultados'],
            'codigo_verificacion' => $codigoVerificacion,
            'registrado_por' => Auth::id(),
        ]);

        // Cargar relaciones para el email
        $resultado->load(['paciente', 'clinica']);

        // Enviar notificación al paciente si tiene email válido
        $paciente = $resultado->paciente;
        if ($paciente->email && !str_ends_with($paciente->email, '@paciente.temp')) {
            try {
                \Illuminate\Support\Facades\Mail::to($paciente->email)->send(
                    new \App\Mail\ResultadoLaboratorioListo($resultado, $paciente)
                );
            } catch (\Exception $e) {
                \Illuminate\Support\Facades\Log::error('Error enviando notificación de resultado: ' . $e->getMessage());
                // No fallar la creación del resultado si el email falla
            }
        }

        return redirect()
            ->route('laboratorio.show', $resultado)
            ->with('success', 'Resultado de laboratorio registrado exitosamente.' . 
                ($paciente->email && !str_ends_with($paciente->email, '@paciente.temp') 
                    ? ' Se ha enviado una notificación al paciente.' 
                    : ''));
    }

    /**
     * Mostrar detalle de un resultado
     */
    public function show(ResultadoLaboratorio $resultado)
    {
        // Verificar acceso: Dueño del resultado o personal autorizado
        $user = Auth::user();
        if ($user->hasRole('paciente') && $resultado->paciente_id !== $user->id) {
            abort(403, 'No tiene permiso para ver este resultado.');
        }

        $resultado->load(['paciente', 'clinica', 'registradoPor']);
        
        return view('laboratorio.show', compact('resultado'));
    }

    /**
     * Generar PDF con QR para imprimir
     */
    public function imprimirPDF(ResultadoLaboratorio $resultado)
    {
        // Verificar acceso: Dueño del resultado o personal autorizado
        $user = Auth::user();
        if ($user->hasRole('paciente') && $resultado->paciente_id !== $user->id) {
            abort(403, 'No tiene permiso para descargar este resultado.');
        }

        $resultado->load(['paciente', 'clinica', 'registradoPor']);
        
        // Generar QR code
        $qrCode = base64_encode(QrCode::format('svg')
            ->size(150)
            ->generate($resultado->url_verificacion));

        $pdf = Pdf::loadView('laboratorio.pdf', compact('resultado', 'qrCode'));
        
        return $pdf->download('resultado_laboratorio_' . $resultado->codigo_verificacion . '.pdf');
    }

    /**
     * Vista pública de verificación (accesible sin login)
     */
    public function verificar($codigo)
    {
        $resultado = ResultadoLaboratorio::where('codigo_verificacion', $codigo)
            ->with(['paciente', 'clinica'])
            ->firstOrFail();

        return view('laboratorio.verificar', compact('resultado'));
    }

    /**
     * Buscar pacientes (AJAX)
     */
    public function buscarPacientes(Request $request)
    {
        $query = $request->get('q', '');
        
        $pacientes = User::role('paciente')
            ->where(function($q) use ($query) {
                $q->where('name', 'like', "%{$query}%")
                  ->orWhere('cedula', 'like', "%{$query}%")
                  ->orWhere('email', 'like', "%{$query}%");
            })
            ->limit(10)
            ->get(['id', 'name', 'cedula', 'email']);

        return response()->json($pacientes);
    }

    /**
     * Crear paciente rápido desde laboratorio
     */
    public function crearPacienteRapido(Request $request)
    {
        // Normalizar cédula antes de validar
        $cedula = strtoupper(trim($request->cedula));
        if (preg_match('/^([VEJGP])(\d{6,8})$/i', $cedula, $matches)) {
            $cedula = $matches[1] . '-' . $matches[2];
        }
        $request->merge(['cedula' => $cedula]);

        $validated = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'cedula' => [
                'required', 
                'string', 
                'max:50', 
                'unique:usuarios,cedula',
                'regex:/^[VEJGP]-\d{6,8}$/i'
            ],
            'fecha_nacimiento' => ['required', 'date', 'before:today'],
            'email' => ['nullable', 'email', 'max:255', 'unique:usuarios,email'],
            'telefono' => ['nullable', 'string', 'max:20'],
        ], [
            'cedula.regex' => 'El formato de la cédula debe ser: V-12345678 (6 a 8 dígitos). Letras permitidas: V, E, J, G, P',
            'cedula.unique' => 'Esta cédula ya está registrada en el sistema',
            'email.unique' => 'Este email ya está registrado en el sistema',
            'fecha_nacimiento.required' => 'La fecha de nacimiento es obligatoria',
            'fecha_nacimiento.before' => 'La fecha de nacimiento debe ser anterior a hoy',
        ]);

        // Generar email temporal si no se proporcionó
        $email = $validated['email'] ?? str_replace('-', '', $cedula) . '@paciente.temp';
        $emailTemporal = !$validated['email'];

        // Generar contraseña temporal
        $password = 'Salud' . date('Y') . '#' . \Illuminate\Support\Str::random(3);

        // Asignar a la clínica del usuario actual
        $clinicaId = Auth::user()->clinica_id ?? \App\Models\Clinica::first()?->id;

        // Crear el usuario
        $user = User::create([
            'name' => $validated['name'],
            'cedula' => $cedula,
            'fecha_nacimiento' => $validated['fecha_nacimiento'],
            'email' => $email,
            'telefono' => $validated['telefono'] ?? null,
            'password' => \Illuminate\Support\Facades\Hash::make($password),
            'clinica_id' => $clinicaId,
        ]);

        // Asignar rol de paciente
        $user->assignRole('paciente');

        // Enviar email si tiene email real
        $emailEnviado = false;
        if (!$emailTemporal) {
            try {
                \Illuminate\Support\Facades\Mail::to($user->email)->send(
                    new \App\Mail\CredencialesNuevoPaciente($user, $password)
                );
                $emailEnviado = true;
            } catch (\Exception $e) {
                \Illuminate\Support\Facades\Log::error('Error enviando email de credenciales: ' . $e->getMessage());
            }
        }

        return response()->json([
            'success' => true,
            'message' => 'Paciente creado exitosamente.',
            'paciente' => [
                'id' => $user->id,
                'name' => $user->name,
                'cedula' => $user->cedula,
            ],
            'credenciales' => [
                'usuario' => $user->cedula,
                'password' => $password,
                'email_enviado' => $emailEnviado,
                'email_temporal' => $emailTemporal,
            ],
        ]);
    }
}
