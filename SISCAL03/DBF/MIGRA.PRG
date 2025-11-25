CLOSE ALL


*** Modificar Estructura de la tabla FACTURA.DBF
SELECT 1
USE FACTURA.DBF
WAIT WINDOWS "Crea campo nuevo APLICATASA - NUM 1"
MODIFY STRUC

WAIT WINDOWS "Crea campo nuevo FECHATASA - DATE"
MODIFY STRUC

WAIT WINDOWS "Crea campo nuevo TASA - NUM 12,2"
MODIFY STRUC

REPLACE APLICATASA WITH 2 FOR 1=1



*** Modificar Estructura de la tabla LOCALIZ.DBF
SELECT 1
USE LOCALIZ.DBF
WAIT WINDOWS "Crear campo nuevo MONEDA2 - CHAR 10"
MODIFY STRUC

replace MONEDA2 with "US $" for 1=1


*** Modificar Estructura de la tabla LVDABON.DBF
SELECT 1
USE LVDABON.DBF
WAIT WINDOWS "Crea campo nuevo APLICATASA - NUM 1"
MODIFY STRUC

WAIT WINDOWS "Crea campo nuevo FECHATASA - DATE"
MODIFY STRUC

WAIT WINDOWS "Crea campo nuevo TASA - NUM 12,2"
MODIFY STRUC

REPLACE APLICATASA WITH 2 FOR 1=1




*** Modificar Estructura de la tabla LVDEXAM.DBF
SELECT 1
USE LVDEXAM.DBF
WAIT WINDOWS "Modificar campo existente PRE_PER - NUM 12,2"
MODIFY STRUC


*** Modificar Estructura de la tabla LVDPACI.DBF
SELECT 1
USE LVDPACI.DBF


WAIT WINDOWS "Crea campo nuevo FECHATASA - DATE"
MODIFY STRUC

WAIT WINDOWS "Modificar campo existente MDIRECTO - NUM 12,2"
MODIFY STRUC

WAIT WINDOWS "Crea campo nuevo TASA - NUM 12,2"
MODIFY STRUC


*** Modificar Estructura de la tabla LVDPRUE.DBF
SELECT 1
USE LVDPRUE.DBF

WAIT WINDOWS "Crea campo nuevo CURSIVA - CHAR 1"
MODIFY STRUC

REPLACE CURSIVA WITH "N" FOR 1=1


*** Modificar Estructura de la tabla LVTEXAM.DBF
SELECT 1
USE LVTEXAM.DBF
WAIT WINDOWS "Crea campo nuevo COS_EXA2  - Num 12,2"
MODIFY STRUC

WAIT WINDOWS "Crea campo nuevo PRE_EX12  - Num 12,2"
MODIFY STRUC

WAIT WINDOWS "Crea campo nuevo PRE_EX22  - Num 12,2"
MODIFY STRUC

WAIT WINDOWS "Crea campo nuevo PRE_EX32  - Num 12,2"
MODIFY STRUC


*** Modificar Estructura de la tabla LVTPACI.DBF
SELECT 1
USE LVTPACI.DBF
WAIT WINDOWS "Crea campo nuevo APLICATASA - NUM 1"
MODIFY STRUC

REPLACE APLICATASA WITH 2 FOR 1=1


*** Modificar Estructura de la tabla LVTPRUE.DBF
SELECT 1
USE LVTPRUE.DBF

WAIT WINDOWS "Crea campo nuevo CURSIVA - CHAR 1"
MODIFY STRUC

REPLACE CURSIVA WITH "N" FOR 1=1


WAIT WINDOWS "Crea campo nuevo VALOR_ALER - CHAR 30"
MODIFY STRUC


*** Modificar Estructura de la tabla PER_CLI.DBF
SELECT 1
USE PER_CLI.DBF
WAIT WINDOWS "Crear campo nuevo PRE_PER2  - Num 12,2"
MODIFY STRUC


*** Modificar Estructura de la tabla PRECIOS.DBF
SELECT 1
USE PRECIOS.DBF
WAIT WINDOWS "Crear campo nuevo PRE_EX42  - Num 12,2"
MODIFY STRUC



*** Modificar Estructura de la tabla RAZONSO.DBF
SELECT 1
USE RAZONSO.DBF

WAIT WINDOWS "Crear campo nuevo DONACION    - Logico"
MODIFY STRUC

WAIT WINDOWS "Crear campo nuevo MULTIMONED  - Logico"
MODIFY STRUC

replace DONACION with .F. for 1=1
replace MULTIMONED with .F. for 1=1


