import sys
from dbfread import DBF

files = [
    r'c:\laragon\www\somossalud\SISCAL03\DBF\LVTEXAM.DBF',
    r'c:\laragon\www\somossalud\SISCAL03\DBF\LVTTIPO.DBF',
    r'c:\laragon\www\somossalud\SISCAL03\DBF\LVTPRUE.DBF'
]

for file_path in files:
    print(f"--- Inspecting {file_path} ---")
    try:
        table = DBF(file_path, encoding='latin1') # FoxPro usually uses latin1 or cp850
        print(f"Fields: {table.field_names}")
        print("First 5 records:")
        for i, record in enumerate(table):
            if i >= 5: break
            print(record)
    except Exception as e:
        print(f"Error reading {file_path}: {e}")
    print("\n")
