<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class LabExamItem extends Model
{
    protected $table = 'lab_exam_items';
    protected $fillable = ['lab_exam_id','code','name','unit','reference_value','type','order'];

    public function exam()
    {
        return $this->belongsTo(LabExam::class, 'lab_exam_id');
    }

    public function results()
    {
        return $this->hasMany(LabResult::class, 'lab_exam_item_id');
    }

    public function referenceRanges()
    {
        return $this->hasMany(LabReferenceRange::class, 'lab_exam_item_id');
    }

    /**
     * Obtener el rango de referencia específico para un paciente
     */
    public function getReferenceRangeForPatient($patient)
    {
        if (!$patient || !$patient->fecha_nacimiento || !$patient->sexo) {
            return null;
        }

        $age = \Carbon\Carbon::parse($patient->fecha_nacimiento)->age;
        $sex = $patient->sexo; // 'M' o 'F'
        
        // Convertir sexo a formato numérico del sistema viejo (1=H, 2=M, 3=Todos)
        $sexCode = ($sex === 'M') ? 1 : 2;

        // Buscar el rango que coincida
        return $this->referenceRanges()
            ->whereHas('group', function($q) use ($age, $sexCode) {
                $q->where(function($query) use ($sexCode) {
                    $query->where('sex', $sexCode)
                          ->orWhere('sex', 3); // 3 = Todos
                })
                ->where('age_start_year', '<=', $age)
                ->where('age_end_year', '>=', $age);
            })
            ->first();
    }
}
?>
