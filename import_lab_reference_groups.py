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
    cursor = conn.cursor(buffered=True)
    
    print("=== IMPORTANDO GRUPOS DE REFERENCIA (SEXOEDA.DBF) ===")
    sexoeda_table = DBF(r'c:\wamp64\www\somossalud\SISCAL03\DBF\SEXOEDA.DBF', encoding='latin1')
    
    group_count = 0
    for record in sexoeda_table:
        code = record['COD_SEX']
        description = record['DESCRIP']
        sex = int(record['SEXO']) # 1=H, 2=M, 3=Todos
        
        age_start_day = int(record['DIA_1'] or 0)
        age_start_month = int(record['MES_1'] or 0)
        age_start_year = int(record['ANO_1'] or 0)
        
        age_end_day = int(record['DIA_2'] or 0)
        age_end_month = int(record['MES_2'] or 0)
        age_end_year = int(record['ANO_2'] or 0)
        
        cursor.execute("""
            INSERT INTO lab_reference_groups 
            (code, description, sex, age_start_day, age_start_month, age_start_year, 
             age_end_day, age_end_month, age_end_year, active, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            ON DUPLICATE KEY UPDATE
            description = VALUES(description),
            sex = VALUES(sex),
            age_start_day = VALUES(age_start_day),
            age_start_month = VALUES(age_start_month),
            age_start_year = VALUES(age_start_year),
            age_end_day = VALUES(age_end_day),
            age_end_month = VALUES(age_end_month),
            age_end_year = VALUES(age_end_year)
        """, (code, description, sex, age_start_day, age_start_month, age_start_year,
              age_end_day, age_end_month, age_end_year, True, datetime.now(), datetime.now()))
        
        group_count += 1
        print(f"  OK Grupo: {code} - {description}")
        
    conn.commit()
    print(f"\nOK Total grupos importados: {group_count}")

    print("\n=== IMPORTANDO RANGOS DE REFERENCIA (VALREF.DBF) ===")
    valref_table = DBF(r'c:\wamp64\www\somossalud\SISCAL03\DBF\VALREF.DBF', encoding='latin1')
    
    range_count = 0
    for record in valref_table:
        cod_exa = record['COD_EXA']
        cod_pru = record['COD_PRU']
        cod_sex = record['COD_SEX']
        condition = record['CONDICION']
        
        # Convertir valores numéricos, manejando posibles strings vacíos o nulos
        try:
            val_min = float(record['VALOR_REFI']) if record['VALOR_REFI'] else None
        except ValueError:
            val_min = None
            
        try:
            val_max = float(record['VALOR_REFS']) if record['VALOR_REFS'] else None
        except ValueError:
            val_max = None
            
        val_text = record['VALOR_REF2']
        order = int(record['ORDEN'] or 0)
        
        # Buscar ID del ítem
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
        
        # Buscar ID del grupo
        cursor.execute("SELECT id FROM lab_reference_groups WHERE code = %s", (cod_sex,))
        group_result = cursor.fetchone()
        if not group_result:
            continue
        group_id = group_result[0]
        
        # Insertar rango
        cursor.execute("""
            INSERT INTO lab_reference_ranges
            (lab_exam_item_id, lab_reference_group_id, `condition`, value_min, value_max, value_text, `order`, created_at, updated_at)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """, (item_id, group_id, condition, val_min, val_max, val_text, order, datetime.now(), datetime.now()))
        
        range_count += 1
        if range_count % 100 == 0:
            print(f"  Importados {range_count} rangos...")
            
    conn.commit()
    print(f"\nOK Total rangos importados: {range_count}")
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
