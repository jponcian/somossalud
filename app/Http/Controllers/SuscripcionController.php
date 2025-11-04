<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\Suscripcion;

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
}
