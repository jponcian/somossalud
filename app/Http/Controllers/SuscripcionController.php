<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Suscripcion;
use App\Models\ReportePago;

class SuscripcionController extends Controller
{
    public function show()
    {
        $user = Auth::user();
        $suscripcion = Suscripcion::where('usuario_id', $user->id)->latest()->first();

        return view('suscripcion.show', [
            'user' => $user,
            'suscripcion' => $suscripcion,
        ]);
    }

    public function paySandbox(Request $request)
    {
        $user = Auth::user();

        $inicio = now()->toDateString();
        $vencimiento = now()->addYear()->toDateString();

        $sus = Suscripcion::updateOrCreate(
            ['usuario_id' => $user->id],
            [
                'plan' => 'anual',
                'precio' => 10.00,
                'periodo_inicio' => $inicio,
                'periodo_vencimiento' => $vencimiento,
                'estado' => 'activo',
                'metodo_pago' => 'sandbox',
                'transaccion_id' => 'sandbox-' . uniqid(),
            ]
        );

        return redirect()->route('suscripcion.show')->with('success', 'Suscripción activada (sandbox).');
    }

    public function reportarPago(Request $request)
    {
        $user = Auth::user();

        $data = $request->validate([
            'cedula_pagador' => ['required', 'string', 'max:50'],
            'telefono_pagador' => ['required', 'string', 'max:30'],
            'fecha_pago' => ['required', 'date'],
            'referencia' => ['required', 'string', 'max:100'],
            'monto' => ['required', 'numeric', 'min:0.01'],
        ]);

        ReportePago::create([
            'usuario_id' => $user->id,
            'cedula_pagador' => strtoupper($data['cedula_pagador']),
            'telefono_pagador' => $data['telefono_pagador'],
            'fecha_pago' => $data['fecha_pago'],
            'referencia' => strtoupper($data['referencia']),
            'monto' => $data['monto'],
            'estado' => 'pendiente',
        ]);

        return redirect()->route('suscripcion.show')
            ->with('success', 'Pago reportado. Un recepcionista validará tu información y activará tu suscripción.');
    }

    public function carnet()
    {
        $user = Auth::user();
        $suscripcion = Suscripcion::where('usuario_id', $user->id)->where('estado', 'activo')->latest()->first();

        if (!$suscripcion) {
            return redirect()->route('suscripcion.show')->with('error', 'Activa tu suscripción para ver tu carnet.');
        }

        return view('suscripcion.carnet', [
            'user' => $user,
            'suscripcion' => $suscripcion,
        ]);
    }
}
