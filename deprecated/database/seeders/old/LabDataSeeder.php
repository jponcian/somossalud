<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\LabCategory;
use App\Models\LabExam;
use App\Models\LabExamItem;

class LabDataSeeder extends Seeder
{
    public function run(): void
    {
        // Categoría: Hematología
        $hematologia = LabCategory::create([
            'code' => 'HEM',
            'name' => 'Hematología',
            'active' => true
        ]);

        $hemograma = LabExam::create([
            'code' => 'HEM001',
            'lab_category_id' => $hematologia->id,
            'name' => 'Hemograma Completo',
            'abbreviation' => 'HC',
            'price' => 25.00,
            'active' => true
        ]);

        $hemogramaItems = [
            ['code' => 'HB', 'name' => 'Hemoglobina', 'unit' => 'g/dL', 'reference_value' => '12-16 (M), 14-18 (H)', 'type' => 'numeric', 'order' => 1],
            ['code' => 'HTO', 'name' => 'Hematocrito', 'unit' => '%', 'reference_value' => '36-46 (M), 42-52 (H)', 'type' => 'numeric', 'order' => 2],
            ['code' => 'LEUC', 'name' => 'Leucocitos', 'unit' => '/mm³', 'reference_value' => '4,000-11,000', 'type' => 'numeric', 'order' => 3],
            ['code' => 'PLAQ', 'name' => 'Plaquetas', 'unit' => '/mm³', 'reference_value' => '150,000-450,000', 'type' => 'numeric', 'order' => 4],
            ['code' => 'NEUT', 'name' => 'Neutrófilos', 'unit' => '%', 'reference_value' => '40-70', 'type' => 'numeric', 'order' => 5],
            ['code' => 'LINF', 'name' => 'Linfocitos', 'unit' => '%', 'reference_value' => '20-40', 'type' => 'numeric', 'order' => 6],
        ];

        foreach ($hemogramaItems as $item) {
            LabExamItem::create(array_merge($item, ['lab_exam_id' => $hemograma->id]));
        }

        // Categoría: Química Sanguínea
        $quimica = LabCategory::create([
            'code' => 'QUI',
            'name' => 'Química Sanguínea',
            'active' => true
        ]);

        $glicemia = LabExam::create([
            'code' => 'QUI001',
            'lab_category_id' => $quimica->id,
            'name' => 'Glicemia en Ayunas',
            'abbreviation' => 'GLI',
            'price' => 8.00,
            'active' => true
        ]);

        LabExamItem::create([
            'lab_exam_id' => $glicemia->id,
            'code' => 'GLU',
            'name' => 'Glucosa',
            'unit' => 'mg/dL',
            'reference_value' => '70-100',
            'type' => 'numeric',
            'order' => 1
        ]);

        $perfilLipidico = LabExam::create([
            'code' => 'QUI002',
            'lab_category_id' => $quimica->id,
            'name' => 'Perfil Lipídico',
            'abbreviation' => 'PL',
            'price' => 35.00,
            'active' => true
        ]);

        $perfilItems = [
            ['code' => 'COLT', 'name' => 'Colesterol Total', 'unit' => 'mg/dL', 'reference_value' => '<200', 'type' => 'numeric', 'order' => 1],
            ['code' => 'HDL', 'name' => 'HDL Colesterol', 'unit' => 'mg/dL', 'reference_value' => '>40 (H), >50 (M)', 'type' => 'numeric', 'order' => 2],
            ['code' => 'LDL', 'name' => 'LDL Colesterol', 'unit' => 'mg/dL', 'reference_value' => '<100', 'type' => 'numeric', 'order' => 3],
            ['code' => 'TRIG', 'name' => 'Triglicéridos', 'unit' => 'mg/dL', 'reference_value' => '<150', 'type' => 'numeric', 'order' => 4],
        ];

        foreach ($perfilItems as $item) {
            LabExamItem::create(array_merge($item, ['lab_exam_id' => $perfilLipidico->id]));
        }

        $creatinina = LabExam::create([
            'code' => 'QUI003',
            'lab_category_id' => $quimica->id,
            'name' => 'Creatinina',
            'abbreviation' => 'CREA',
            'price' => 10.00,
            'active' => true
        ]);

        LabExamItem::create([
            'lab_exam_id' => $creatinina->id,
            'code' => 'CREA',
            'name' => 'Creatinina',
            'unit' => 'mg/dL',
            'reference_value' => '0.6-1.2 (M), 0.5-1.1 (H)',
            'type' => 'numeric',
            'order' => 1
        ]);

        // Categoría: Urianálisis
        $urianalisis = LabCategory::create([
            'code' => 'URI',
            'name' => 'Urianálisis',
            'active' => true
        ]);

        $examenOrina = LabExam::create([
            'code' => 'URI001',
            'lab_category_id' => $urianalisis->id,
            'name' => 'Examen General de Orina',
            'abbreviation' => 'EGO',
            'price' => 12.00,
            'active' => true
        ]);

        $orinaItems = [
            ['code' => 'COLOR', 'name' => 'Color', 'unit' => null, 'reference_value' => 'Amarillo claro', 'type' => 'text', 'order' => 1],
            ['code' => 'ASPECTO', 'name' => 'Aspecto', 'unit' => null, 'reference_value' => 'Transparente', 'type' => 'text', 'order' => 2],
            ['code' => 'PH', 'name' => 'pH', 'unit' => null, 'reference_value' => '5.0-7.0', 'type' => 'numeric', 'order' => 3],
            ['code' => 'DENS', 'name' => 'Densidad', 'unit' => null, 'reference_value' => '1.010-1.030', 'type' => 'numeric', 'order' => 4],
            ['code' => 'PROT', 'name' => 'Proteínas', 'unit' => null, 'reference_value' => 'Negativo', 'type' => 'text', 'order' => 5],
            ['code' => 'GLUC', 'name' => 'Glucosa', 'unit' => null, 'reference_value' => 'Negativo', 'type' => 'text', 'order' => 6],
        ];

        foreach ($orinaItems as $item) {
            LabExamItem::create(array_merge($item, ['lab_exam_id' => $examenOrina->id]));
        }

        // Categoría: Inmunología
        $inmunologia = LabCategory::create([
            'code' => 'INM',
            'name' => 'Inmunología',
            'active' => true
        ]);

        $pcr = LabExam::create([
            'code' => 'INM001',
            'lab_category_id' => $inmunologia->id,
            'name' => 'Proteína C Reactiva',
            'abbreviation' => 'PCR',
            'price' => 15.00,
            'active' => true
        ]);

        LabExamItem::create([
            'lab_exam_id' => $pcr->id,
            'code' => 'PCR',
            'name' => 'PCR',
            'unit' => 'mg/L',
            'reference_value' => '<10',
            'type' => 'numeric',
            'order' => 1
        ]);

        // Categoría: Hormonas
        $hormonas = LabCategory::create([
            'code' => 'HOR',
            'name' => 'Hormonas',
            'active' => true
        ]);

        $tsh = LabExam::create([
            'code' => 'HOR001',
            'lab_category_id' => $hormonas->id,
            'name' => 'Hormona Estimulante de Tiroides',
            'abbreviation' => 'TSH',
            'price' => 20.00,
            'active' => true
        ]);

        LabExamItem::create([
            'lab_exam_id' => $tsh->id,
            'code' => 'TSH',
            'name' => 'TSH',
            'unit' => 'μUI/mL',
            'reference_value' => '0.4-4.0',
            'type' => 'numeric',
            'order' => 1
        ]);

        $this->command->info('✅ Datos de laboratorio creados exitosamente');
        $this->command->info('   - 6 categorías');
        $this->command->info('   - 8 exámenes');
        $this->command->info('   - Múltiples ítems por examen');
    }
}
