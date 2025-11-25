import sys
from dbfread import DBF

files = [
    r'c:\laragon\www\somossalud\SISCAL03\DBF\VALREF.DBF',
    r'c:\laragon\www\somossalud\SISCAL03\DBF\SEXOEDA.DBF'
]

for file_path in files:
    print(f"--- Inspecting {file_path} ---")
    try:
        table = DBF(file_path, encoding='latin1')
        print(f"Fields: {table.field_names}")
        print("First 10 records:")
        for i, record in enumerate(table):
            if i >= 10: break
            print(record)
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
    print("\n")
