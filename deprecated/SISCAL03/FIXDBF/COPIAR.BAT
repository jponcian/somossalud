COPY %cd%\PRODUCTS.DBF  %cd%\NEW_PRODUCTS.DBF

ping -n 25 127.0.0.1 > null


FIXDBF.EXE


ping -n 40 127.0.0.1 > null