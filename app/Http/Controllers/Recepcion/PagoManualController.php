<?php

namespace App\Http\Controllers\Recepcion;

use App\Http\Controllers\Controller;
use App\Models\ReportePago;
use App\Models\Suscripcion;
use App\Models\User;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\View\View;

class PagoManualController extends Controller
{
    public function index(Request $request): View
    {
        $estado = $request->query('estado', 'pendiente');
        $reportes = ReportePago::with('usuario')
            ->when($estado, fn($q) => $q->where('estado', $estado))
            ->orderByDesc('created_at')
            ->paginate(15);

        return view('recepcion.pagos.index', [
            'reportes' => $reportes,
            'estado' => $estado,
        ]);
    }

    public function aprobar(Request $request, ReportePago $reporte): RedirectResponse
    {
        if ($reporte->estado !== 'pendiente') {
            return back()->with('error', 'Este reporte ya fue gestionado.');
        }

        $reporte->estado = 'aprobado';
        $reporte->reviewed_by = Auth::id();
        $reporte->reviewed_at = now();
        $reporte->observaciones = $request->input('observaciones');
        $reporte->save();

        // Activar/renovar suscripción del usuario
        $inicio = now()->toDateString();
        $vencimiento = now()->addYear()->toDateString();

        Suscripcion::updateOrCreate(
            ['usuario_id' => $reporte->usuario_id],
            [
                'plan' => 'anual',
                'precio' => 10.00,
                'periodo_inicio' => $inicio,
                'periodo_vencimiento' => $vencimiento,
                'estado' => 'activo',
                'metodo_pago' => 'pago_movil',
                'transaccion_id' => 'PM-' . $reporte->referencia . '-' . \Illuminate\Support\Carbon::parse($reporte->fecha_pago)->format('Ymd'),
            ]
        );

        return back()->with('success', 'Pago aprobado y suscripción activada.');
    }

    public function rechazar(Request $request, ReportePago $reporte): RedirectResponse
    {
        if ($reporte->estado !== 'pendiente') {
            return back()->with('error', 'Este reporte ya fue gestionado.');
        }

        $request->validate([
            'observaciones' => ['nullable', 'string', 'max:500'],
        ]);

        $reporte->estado = 'rechazado';
        $reporte->reviewed_by = Auth::id();
        $reporte->reviewed_at = now();
        $reporte->observaciones = $request->input('observaciones');
        $reporte->save();

        return back()->with('success', 'Pago rechazado. Se guardaron las observaciones.');
    }
}
