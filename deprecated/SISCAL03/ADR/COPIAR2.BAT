"C:\Program Files\ADR\ADR.exe" %cd%\TABLA.DBF

COPY %cd%\TABLA_fixed.DBF  %cd%\TABLA2.DBF

DEL %cd%\TABLA_fixed.DBF

ping -n 15 127.0.0.1 > null