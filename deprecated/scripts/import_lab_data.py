import sys
from dbfread import DBF
import mysql.connector
from datetime import datetime

# Configuración de la base de datos
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'javier_ponciano_5'
}

try:
    # Conectar a MySQL
    conn = mysql.connector.connect(**db_config)
    cursor = conn.cursor()
    
    print("=== IMPORTANDO CATEGORIAS DE EXAMENES ===")
    # Leer tipos de exámenes (categorías)
    tipos_table = DBF(r'c:\wamp64\www\somossalud\SISCAL03\DBF\LVTTIPO.DBF', encoding='latin1')
    
    for record in tipos_table:
        code = record['TIP_EXA']
        name = record['DES_TIP']
        
        # Insertar categoría
        cursor.execute("""
            INSERT INTO lab_categories (code, name, active, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE name = VALUES(name)
        """, (code, name, True, datetime.now(), datetime.now()))
        
        print(f"  OK Categoria: {code} - {name}")
    
    conn.commit()
    print(f"\nOK Total categorias importadas: {cursor.rowcount}")
    
    print("\n=== IMPORTANDO EXAMENES ===")
    # Leer exámenes
    exams_table = DBF(r'c:\wamp64\www\somossalud\SISCAL03\DBF\LVTEXAM.DBF', encoding='latin1')
    
    exam_count = 0
    for record in exams_table:
        if not record['STATUS']:  # Solo exámenes activos
            continue
            
        code = record['COD_EXA']
        tip_exa = record['TIP_EXA']
        name = record['DES_EXA'] or ''
        abbreviation = record['DES_ABR'] or ''
        price = float(record['PRE_EX1'] or 0)
        
        # Obtener el ID de la categoría
        cursor.execute("SELECT id FROM lab_categories WHERE code = %s", (tip_exa,))
        category_result = cursor.fetchone()
        category_id = category_result[0] if category_result else None
        
        # Insertar examen
        cursor.execute("""
            INSERT INTO lab_exams (code, lab_category_id, name, abbreviation, price, active, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE 
                name = VALUES(name),
                abbreviation = VALUES(abbreviation),
                price = VALUES(price)
        """, (code, category_id, name, abbreviation, price, True, datetime.now(), datetime.now()))
        
        exam_count += 1
        if exam_count <= 10:  # Mostrar solo los primeros 10
            print(f"  OK Examen: {code} - {name} (${price})")
    
    conn.commit()
    print(f"\nOK Total examenes importados: {exam_count}")
    
    print("\n=== IMPORTANDO ÍTEMS DE EXÁMENES ===")
    # Leer ítems/pruebas de exámenes
    items_table = DBF(r'c:\wamp64\www\somossalud\SISCAL03\DBF\LVTPRUE.DBF', encoding='latin1')
    
    item_count = 0
    for record in items_table:
        cod_exa = record['COD_EXA']
        cod_pru = record['COD_PRU']
        name = record['DES_PRU'] or ''
        unit = record['UNI_RES'] or ''
        tipo_res = record['TIP_RES'] or ''
        pos_pru = int(record['POS_PRU'] or 0)
        
        # Obtener el ID del examen
        cursor.execute("SELECT id FROM lab_exams WHERE code = %s", (cod_exa,))
        exam_result = cursor.fetchone()
        
        if not exam_result:
            continue
            
        exam_id = exam_result[0]
        
        # Insertar ítem
        cursor.execute("""
            INSERT INTO lab_exam_items (lab_exam_id, code, name, unit, type, `order`, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE 
                name = VALUES(name),
                unit = VALUES(unit)
        """, (exam_id, cod_pru, name, unit, tipo_res, pos_pru, datetime.now(), datetime.now()))
        
        item_count += 1
        if item_count <= 10:  # Mostrar solo los primeros 10
            print(f"  OK Item: {cod_exa}/{cod_pru} - {name}")
    
    conn.commit()
    print(f"\nOK Total items importados: {item_count}")
    
    print("\n=== IMPORTANDO VALORES DE REFERENCIA ===")
    # Leer valores de referencia
    valref_table = DBF(r'c:\wamp64\www\somossalud\SISCAL03\DBF\VALREF.DBF', encoding='latin1')
    
    # Crear un cursor adicional para las actualizaciones
    cursor2 = conn.cursor()
    
    ref_count = 0
    for record in valref_table:
        cod_exa = record['COD_EXA']
        cod_pru = record['COD_PRU']
        valor_inf = record['VALOR_REFI'] or ''
        valor_sup = record['VALOR_REFS'] or ''
        
        # Construir el rango de referencia
        if valor_inf and valor_sup:
            reference_value = f"{valor_inf} - {valor_sup}"
        elif valor_inf:
            reference_value = f"> {valor_inf}"
        elif valor_sup:
            reference_value = f"< {valor_sup}"
        else:
            continue
        
        # Buscar el ítem correspondiente
        cursor.execute("""
            SELECT lei.id 
            FROM lab_exam_items lei
            JOIN lab_exams le ON lei.lab_exam_id = le.id
            WHERE le.code = %s AND lei.code = %s
        """, (cod_exa, cod_pru))
        
        item_result = cursor.fetchone()
        if not item_result:
            continue
            
        item_id = item_result[0]
        
        # Actualizar el valor de referencia con el segundo cursor
        cursor2.execute("""
            UPDATE lab_exam_items 
            SET reference_value = %s
            WHERE id = %s
        """, (reference_value, item_id))
        
        ref_count += 1
        if ref_count <= 10:
            print(f"  OK Referencia: {cod_exa}/{cod_pru} = {reference_value}")
    
    cursor2.close()
    conn.commit()
    print(f"\nOK Total valores de referencia importados: {ref_count}")
    
    print("\nOK IMPORTACION COMPLETADA EXITOSAMENTE")

    
except Exception as e:
    print(f"\nERROR: {e}")
    import traceback
    traceback.print_exc()
finally:
    if 'cursor' in locals():
        cursor.close()
    if 'conn' in locals():
        conn.close()
