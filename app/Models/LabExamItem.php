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
}
?>
