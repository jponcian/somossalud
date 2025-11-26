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
    
    print("=== IMPORTANDO VALORES DE REFERENCIA ===")
    # Leer valores de referencia
    valref_table = DBF(r'c:\wamp64\www\somossalud\SISCAL03\DBF\VALREF.DBF', encoding='latin1')
    
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
        
        # Actualizar el valor de referencia
        cursor.execute("""
            UPDATE lab_exam_items 
            SET reference_value = %s
            WHERE id = %s
        """, (reference_value, item_id))
        
        ref_count += 1
        if ref_count <= 10:
            print(f"  OK Referencia: {cod_exa}/{cod_pru} = {reference_value}")
    
    conn.commit()
    print(f"\nOK Total valores de referencia importados: {ref_count}")
    print("\nOK IMPORTACION DE REFERENCIAS COMPLETADA EXITOSAMENTE")
    
except Exception as e:
    print(f"\nERROR: {e}")
    import traceback
    traceback.print_exc()
finally:
    if 'cursor' in locals():
        cursor.close()
    if 'conn' in locals():
        conn.close()
