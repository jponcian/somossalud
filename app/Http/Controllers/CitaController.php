<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Cita;

class CitaController extends Controller
{
    public function __construct()
    {
        // El grupo de rutas ya requiere 'auth'; aplicamos verificar.suscripcion
        // solo a creación/almacenamiento de citas.
        $this->middleware('verificar.suscripcion')->only(['create', 'store']);
    }

    public function index()
    {
        $user = Auth::user();
        if ($user->hasRole('paciente')) {
            $citas = Cita::where('usuario_id', $user->id)->get();
        } else {
            $citas = Cita::all();
        }

        return view('citas.index', compact('citas'));
    }

    public function create()
    {
        return view('citas.create');
    }

    public function store(Request $request)
    {
        $data = $request->validate([
            'clinica_id' => 'required|exists:clinicas,id',
            'fecha_hora' => 'required|date',
            'motivo' => 'nullable|string|max:500',
        ]);

        $data['usuario_id'] = Auth::id();
        $data['estado'] = 'pendiente';

        $cita = Cita::create($data);

        return redirect()->route('citas.index')->with('success', 'Cita creada correctamente.');
    }

    public function show(Cita $cita)
    {
        return view('citas.show', compact('cita'));
    }

    public function destroy(Cita $cita)
    {
        $this->authorize('delete', $cita);
        $cita->delete();
        return redirect()->route('citas.index')->with('success', 'Cita eliminada.');
    }
}
