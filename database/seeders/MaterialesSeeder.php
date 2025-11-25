<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Material;
use App\Models\Clinica;

class MaterialesSeeder extends Seeder
{
    public function run()
    {
        // Obtener la primera clínica (o crear una si no existe para pruebas)
        $clinica = Clinica::first();
        
        if (!$clinica) {
            $this->command->error('No se encontró ninguna clínica. Ejecuta primero el seeder de clínicas.');
            return;
        }

        $materiales = [
            // ENFERMERIA
            ['nombre' => 'Guantes de Látex Talla M', 'categoria' => 'ENFERMERIA', 'unidad' => 'Caja x 100'],
            ['nombre' => 'Guantes de Látex Talla L', 'categoria' => 'ENFERMERIA', 'unidad' => 'Caja x 100'],
            ['nombre' => 'Gasas Estériles 10x10', 'categoria' => 'ENFERMERIA', 'unidad' => 'Paquete'],
            ['nombre' => 'Alcohol Etílico 70%', 'categoria' => 'ENFERMERIA', 'unidad' => 'Litro'],
            ['nombre' => 'Jeringas 5ml con aguja', 'categoria' => 'ENFERMERIA', 'unidad' => 'Caja x 100'],
            ['nombre' => 'Algodón Hidrófilo', 'categoria' => 'ENFERMERIA', 'unidad' => 'Paquete 500g'],
            ['nombre' => 'Vendas Elásticas 10cm', 'categoria' => 'ENFERMERIA', 'unidad' => 'Unidad'],
            ['nombre' => 'Adhesivo Micropore', 'categoria' => 'ENFERMERIA', 'unidad' => 'Rollo'],
            
            // QUIROFANO
            ['nombre' => 'Bata Quirúrgica Desechable', 'categoria' => 'QUIROFANO', 'unidad' => 'Unidad'],
            ['nombre' => 'Gorro Quirúrgico', 'categoria' => 'QUIROFANO', 'unidad' => 'Caja x 100'],
            ['nombre' => 'Mascarilla N95', 'categoria' => 'QUIROFANO', 'unidad' => 'Caja x 20'],
            ['nombre' => 'Sutura Nylon 3-0', 'categoria' => 'QUIROFANO', 'unidad' => 'Caja x 12'],
            ['nombre' => 'Bisturí Hoja #11', 'categoria' => 'QUIROFANO', 'unidad' => 'Caja x 100'],
            ['nombre' => 'Campo Quirúrgico Estéril', 'categoria' => 'QUIROFANO', 'unidad' => 'Paquete'],
            ['nombre' => 'Solución Yodada', 'categoria' => 'QUIROFANO', 'unidad' => 'Galón'],
            
            // UCI
            ['nombre' => 'Catéter Venoso Central', 'categoria' => 'UCI', 'unidad' => 'Unidad'],
            ['nombre' => 'Sonda Nasogástrica', 'categoria' => 'UCI', 'unidad' => 'Unidad'],
            ['nombre' => 'Electrodo para ECG', 'categoria' => 'UCI', 'unidad' => 'Paquete x 50'],
            ['nombre' => 'Tubo Endotraqueal 7.5', 'categoria' => 'UCI', 'unidad' => 'Unidad'],
            ['nombre' => 'Bolsa Colectora de Orina', 'categoria' => 'UCI', 'unidad' => 'Unidad'],
            
            // OFICINA
            ['nombre' => 'Resma de Papel Carta', 'categoria' => 'OFICINA', 'unidad' => 'Resma'],
            ['nombre' => 'Bolígrafos Azules', 'categoria' => 'OFICINA', 'unidad' => 'Caja x 12'],
            ['nombre' => 'Toner Impresora HP', 'categoria' => 'OFICINA', 'unidad' => 'Unidad'],
            ['nombre' => 'Carpetas Marrones', 'categoria' => 'OFICINA', 'unidad' => 'Paquete x 25'],
            ['nombre' => 'Grapas Standard', 'categoria' => 'OFICINA', 'unidad' => 'Caja'],
        ];

        foreach ($materiales as $item) {
            Material::firstOrCreate(
                [
                    'nombre' => $item['nombre'],
                    'clinica_id' => $clinica->id
                ],
                [
                    'categoria_default' => $item['categoria'],
                    'unidad_medida_default' => $item['unidad'],
                    'descripcion' => 'Material estándar de ' . strtolower($item['categoria']),
                    'activo' => true
                ]
            );
        }
        
        $this->command->info('✅ Materiales de prueba insertados correctamente.');
    }
}
