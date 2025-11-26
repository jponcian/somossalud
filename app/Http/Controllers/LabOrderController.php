<?php

namespace App\Http\Controllers;

use App\Models\LabOrder;
use App\Models\LabOrderDetail;
use App\Models\LabExam;
use App\Models\LabCategory;
use App\Models\LabResult;
use App\Models\User;
use App\Models\Clinica;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
use Barryvdh\DomPDF\Facade\Pdf;

class LabOrderController extends Controller
{
    /**
     * Mostrar listado de órdenes
     */
    public function index(Request $request)
    {
        $user = Auth::user();
        $status = $request->get('status', 'all');

        $query = LabOrder::with(['patient', 'doctor', 'clinica', 'details.exam'])
            ->orderBy('created_at', 'desc');

        // Filtrar por clínica si no es super-admin
        if (!$user->hasRole('super-admin')) {
            $query->where('clinica_id', $user->clinica_id);
        }

        // Filtrar por estado
        if ($status !== 'all') {
            $query->where('status', $status);
        }

        $orders = $query->paginate(20);

        return view('lab.orders.index', compact('orders', 'status'));
    }

    /**
     * Mostrar formulario de creación de orden
     */
    public function create()
    {
        $user = Auth::user();

        // Obtener categorías con sus exámenes activos
        $categories = LabCategory::active()
            ->with([
                'exams' => function ($query) {
                    $query->active()->orderBy('name');
                }
            ])
            ->orderBy('name')
            ->get();

        // Obtener pacientes (usuarios con rol paciente)
        $patients = User::role('paciente')
            ->orderBy('name')
            ->get();

        // Obtener clínicas
        if ($user->hasRole('super-admin')) {
            $clinicas = Clinica::all();
        } else {
            $clinicas = Clinica::where('id', $user->clinica_id)->get();
        }

        return view('lab.orders.create', compact('categories', 'patients', 'clinicas'));
    }

    /**
     * Guardar nueva orden
     */
    public function store(Request $request)
    {
        $request->validate([
            'patient_id' => 'required|exists:usuarios,id',
            'clinica_id' => 'required|exists:clinicas,id',
            'order_date' => 'required|date',
            'exams' => 'required|array|min:1',
            'exams.*' => 'exists:lab_exams,id',
            'observations' => 'nullable|string'
        ]);

        try {
            DB::beginTransaction();

            // Crear la orden
            $dailyCount = LabOrder::whereDate('order_date', $request->order_date)->count() + 1;
            $order = LabOrder::create([
                'order_number' => LabOrder::generateOrderNumber(),
                'patient_id' => $request->patient_id,
                'clinica_id' => $request->clinica_id,
                'order_date' => $request->order_date,
                'sample_date' => $request->order_date, // Fecha de muestra igual a la fecha de la orden
                'status' => 'pending',
                'daily_exam_count' => $dailyCount,
                'observations' => $request->observations,
                'created_by' => Auth::id()
            ]);

            // Agregar los exámenes solicitados
            $total = 0;
            foreach ($request->exams as $examId) {
                $exam = LabExam::findOrFail($examId);

                LabOrderDetail::create([
                    'lab_order_id' => $order->id,
                    'lab_exam_id' => $exam->id,
                    'price' => $exam->price,
                    'status' => 'pending'
                ]);

                $total += $exam->price;
            }

            // Actualizar el total
            $order->update(['total' => $total]);

            DB::commit();

            return redirect()
                ->route('lab.orders.show', $order->id)
                ->with('success', 'Orden de laboratorio creada exitosamente');

        } catch (\Exception $e) {
            DB::rollBack();
            return back()
                ->withInput()
                ->with('error', 'Error al crear la orden: ' . $e->getMessage());
        }
    }

    /**
     * Ver detalle de la orden
     */
    public function show($id)
    {
        $order = LabOrder::with([
            'patient',
            'doctor',
            'clinica',
            'details.exam.items',
            'details.results.examItem',
            'createdBy'
        ])->findOrFail($id);

        // Verificar permisos
        $user = Auth::user();
        if (!$user->hasRole('super-admin') && $order->clinica_id !== $user->clinica_id) {
            abort(403, 'No tiene permisos para ver esta orden');
        }

        return view('lab.orders.show', compact('order'));
    }

    /**
     * Mostrar formulario para cargar resultados
     */
    public function loadResults($id)
    {
        $order = LabOrder::with([
            'patient',
            'doctor',
            'clinica',
            'details.exam.items',
            'details.results.examItem'
        ])->findOrFail($id);

        // Verificar permisos
        $user = Auth::user();
        if (!$user->hasRole('super-admin') && $order->clinica_id !== $user->clinica_id) {
            abort(403, 'No tiene permisos para cargar resultados a esta orden');
        }

        return view('lab.orders.load_results', compact('order'));
    }

    /**
     * Guardar resultados de la orden
     */
    public function storeResults(Request $request, $id)
    {
        $order = LabOrder::findOrFail($id);

        $request->validate([
            'results' => 'required|array',
            'results.*.value' => 'nullable|string',
            'results.*.observation' => 'nullable|string'
        ]);

        try {
            DB::beginTransaction();

            // Guardar resultados
            foreach ($request->results as $itemId => $resultData) {
                $detail = $order->details()
                    ->whereHas('exam.items', function ($query) use ($itemId) {
                        $query->where('id', $itemId);
                    })
                    ->first();

                if ($detail && !empty($resultData['value'])) {
                    LabResult::updateOrCreate(
                        [
                            'lab_order_detail_id' => $detail->id,
                            'lab_exam_item_id' => $itemId
                        ],
                        [
                            'value' => $resultData['value'],
                            'observation' => $resultData['observation'] ?? null
                        ]
                    );
                }
            }

            // Actualizar fechas y estado de la orden
            $order->update([
                // sample_date se conserva
                'result_date' => now(),
                'status' => 'completed',
                'verification_code' => $order->verification_code ?? LabOrder::generateVerificationCode()
            ]);

            $order->details()->update(['status' => 'completed']);

            DB::commit();

            return redirect()
                ->route('lab.orders.show', $order->id)
                ->with('success', 'Resultados guardados exitosamente');

        } catch (\Exception $e) {
            DB::rollBack();
            return back()
                ->withInput()
                ->with('error', 'Error al guardar resultados: ' . $e->getMessage());
        }
    }

    /**
     * Generar PDF de la orden con resultados
     */
    public function downloadPDF($id)
    {
        $order = LabOrder::with([
            'patient',
            'doctor',
            'clinica',
            'details.exam.items',
            'details.results.examItem'
        ])->findOrFail($id);

        // Verificar permisos
        $user = Auth::user();
        $isAuthorizedStaff = $user->hasRole(['laboratorio', 'admin_clinica', 'super-admin', 'recepcionista']);
        $isPatientOwner = $order->patient_id === $user->id;

        if (!$isAuthorizedStaff && !$isPatientOwner) {
            abort(403, 'No tiene permisos para descargar este resultado.');
        }

        if (!$order->isCompleted()) {
            return back()->with('error', 'La orden aún no tiene resultados completos');
        }

        // Generar QR
        $qrCode = base64_encode(QrCode::format('svg')
            ->size(150)
            ->generate(route('lab.orders.verify', $order->verification_code)));

        $pdf = Pdf::loadView('lab.orders.pdf', compact('order', 'qrCode'));

        $filename = $order->order_number . '-' . strtoupper(str_replace(' ', '-', $order->patient->name)) . '.pdf';
        return $pdf->download($filename);
    }

    /**
     * Verificación pública de resultados (sin login)
     */
    public function verify($code)
    {
        $order = LabOrder::where('verification_code', $code)
            ->with([
                'patient',
                'doctor',
                'clinica',
                'details.exam.items',
                'details.results.examItem'
            ])
            ->firstOrFail();

        if (!$order->isCompleted()) {
            abort(404, 'Resultados no disponibles');
        }

        return view('lab.orders.verify', compact('order'));
    }

    /**
     * Buscar pacientes (AJAX)
     */
    public function searchPatients(Request $request)
    {
        $search = $request->get('q');

        $patients = User::role('paciente')
            ->where(function ($query) use ($search) {
                $query->where('name', 'like', "%{$search}%")
                    ->orWhere('cedula', 'like', "%{$search}%")
                    ->orWhere('email', 'like', "%{$search}%");
            })
            ->limit(10)
            ->get(['id', 'name', 'cedula', 'email']);

        return response()->json($patients);
    }

    /**
     * Eliminar un examen de la orden
     */
    public function deleteExamItem(Request $request)
    {
        $itemId = $request->input('item_id');
        $item = \App\Models\LabExamItem::find($itemId);
        if ($item) {
            $item->delete();
            return response()->json(['success' => true]);
        }
        return response()->json(['success' => false], 404);
    }
}
