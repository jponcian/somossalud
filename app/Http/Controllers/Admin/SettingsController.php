<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Setting;
use Illuminate\Http\Request;
use Illuminate\View\View;
use Illuminate\Http\RedirectResponse;

class SettingsController extends Controller
{
    public function pagos(): View
    {
        $data = [
            'banco' => Setting::getValue('pago_movil_banco', ''),
            'identificacion' => Setting::getValue('pago_movil_identificacion', ''),
            'telefono' => Setting::getValue('pago_movil_telefono', ''),
            'nombre' => Setting::getValue('pago_movil_nombre', ''),
        ];
        return view('admin.settings.pagos', $data);
    }

    public function guardarPagos(Request $request): RedirectResponse
    {
        $validated = $request->validate([
            'banco' => ['required','string','max:100'],
            'identificacion' => ['required','string','max:50','regex:/^[VEJG]-?\d{7,9}-?\d?$/i'],
            'telefono' => ['required','string','max:30','regex:/^0\d{3}-?\d{7}$/'], // Ej: 0414-1234567 o 04141234567
            'nombre' => ['required','string','max:150'],
        ], [
            'identificacion.regex' => 'Formato inválido. Ejemplos válidos: V-12345678, J-12345678-9',
            'telefono.regex' => 'Formato inválido. Use 0414-1234567 (guion opcional).',
        ]);

        // Normalizar identificación (mayúsculas, sin espacios)
        $identificacion = strtoupper(str_replace(' ', '', $validated['identificacion']));
        // Normalizar teléfono: quitar guion y volver a insertarlo 4-7
        $telefonoDigits = str_replace('-', '', $validated['telefono']);
        $telefonoNormalizado = substr($telefonoDigits,0,4) . '-' . substr($telefonoDigits,4);

        Setting::setValue('pago_movil_banco', trim($validated['banco']));
        Setting::setValue('pago_movil_identificacion', $identificacion);
        Setting::setValue('pago_movil_telefono', $telefonoNormalizado); // Guardamos ya formateado
        Setting::setValue('pago_movil_nombre', trim($validated['nombre']));

        return back()->with('success', 'Datos de Pago Móvil actualizados.');
    }
}
