# 🐍 Instalación de Python para Importar Datos del Sistema Viejo

**Fecha:** 25 de Noviembre de 2025  
**Proyecto:** Clínica SaludSonrisa  
**Objetivo:** Importar datos de exámenes desde archivos DBF (FoxPro) del sistema SISCAL03

---

## 📥 PASO 1: Descargar e Instalar Python

### Opción A: Desde el Sitio Oficial (Recomendado)

1. **Descargar Python 3.12:**
   - Ir a: https://www.python.org/downloads/
   - Descargar: **Python 3.12.x** (última versión estable)
   - Archivo: `python-3.12.x-amd64.exe`

2. **Instalar Python:**
   - ✅ **IMPORTANTE:** Marcar la casilla **"Add Python to PATH"**
   - Seleccionar: **"Install Now"**
   - Esperar a que termine la instalación
   - Click en **"Close"**

### Opción B: Desde Microsoft Store (Alternativa)

1. Abrir **Microsoft Store**
2. Buscar: **"Python 3.12"**
3. Click en **"Obtener"** o **"Instalar"**
4. Esperar a que termine la instalación

---

## ✅ PASO 2: Verificar la Instalación

Abrir **PowerShell** o **CMD** y ejecutar:

```powershell
python --version
```

**Resultado esperado:**
```
Python 3.12.x
```

Si aparece un error, **reiniciar la computadora** y volver a intentar.

---

## 📦 PASO 3: Instalar Dependencias de Python

Abrir **PowerShell** en la carpeta del proyecto y ejecutar:

```powershell
cd C:\wamp64\www\somossalud
```

Luego instalar las librerías necesarias:

```powershell
pip install dbfread mysql-connector-python
```

**Resultado esperado:**
```
Successfully installed dbfread-2.0.7 mysql-connector-python-8.x.x
```

---

## 🔧 PASO 4: Verificar el Script de Importación

El script ya está creado en: `import_lab_data.py`

Verificar que la configuración de la base de datos sea correcta:

```python
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'javier_ponciano_5'
}
```

---

## 🗑️ PASO 5: Limpiar Tablas Antes de Importar

Ejecutar en PowerShell:

```powershell
php artisan tinker --execute="DB::table('lab_exam_items')->delete(); DB::table('lab_exams')->delete(); DB::table('lab_categories')->delete(); echo 'Tablas limpiadas';"
```

---

## 🚀 PASO 6: Ejecutar la Importación

```powershell
python import_lab_data.py
```

**Resultado esperado:**
```
=== IMPORTANDO CATEGORÍAS DE EXÁMENES ===
  ✓ Categoría: HEM - Hematología
  ✓ Categoría: QUI - Química Sanguínea
  ...

✓ Total categorías importadas: X

=== IMPORTANDO EXÁMENES ===
  ✓ Examen: HEM001 - Hemograma Completo ($25.00)
  ✓ Examen: QUI001 - Glicemia ($8.00)
  ...

✓ Total exámenes importados: X

=== IMPORTANDO ÍTEMS DE EXÁMENES ===
  ✓ Ítem: HEM001/HB - Hemoglobina
  ✓ Ítem: HEM001/HTO - Hematocrito
  ...

✓ Total ítems importados: X

✅ IMPORTACIÓN COMPLETADA EXITOSAMENTE
```

---

## 🔍 PASO 7: Verificar los Datos Importados

```powershell
php artisan tinker --execute="echo 'Categorías: ' . DB::table('lab_categories')->count() . PHP_EOL; echo 'Exámenes: ' . DB::table('lab_exams')->count() . PHP_EOL; echo 'Ítems: ' . DB::table('lab_exam_items')->count() . PHP_EOL;"
```

---

## ⚠️ Solución de Problemas

### Problema 1: "python no se reconoce como comando"

**Solución:**
1. Reiniciar la computadora
2. Si persiste, agregar Python al PATH manualmente:
   - Buscar: **"Variables de entorno"** en Windows
   - Click en **"Variables de entorno"**
   - En **"Variables del sistema"**, buscar **"Path"**
   - Click en **"Editar"**
   - Click en **"Nuevo"**
   - Agregar: `C:\Users\TU_USUARIO\AppData\Local\Programs\Python\Python312`
   - Agregar: `C:\Users\TU_USUARIO\AppData\Local\Programs\Python\Python312\Scripts`
   - Click en **"Aceptar"**
   - Reiniciar PowerShell

### Problema 2: "pip no se reconoce como comando"

**Solución:**
```powershell
python -m pip install dbfread mysql-connector-python
```

### Problema 3: Error de conexión a MySQL

**Solución:**
- Verificar que WAMP esté corriendo
- Verificar que la base de datos `javier_ponciano_5` exista
- Verificar usuario y contraseña en `import_lab_data.py`

### Problema 4: "No se encuentra la carpeta SISCAL03"

**Solución:**
- Verificar que la carpeta `SISCAL03` esté en: `C:\wamp64\www\somossalud\SISCAL03`
- Verificar que dentro exista la carpeta `DBF` con los archivos:
  - `LVTTIPO.DBF` (categorías)
  - `LVTEXAM.DBF` (exámenes)
  - `LVTPRUE.DBF` (ítems/pruebas)

---

## 📊 Archivos DBF que se Importarán

| Archivo | Descripción | Tabla Destino |
|---------|-------------|---------------|
| `LVTTIPO.DBF` | Tipos/Categorías de exámenes | `lab_categories` |
| `LVTEXAM.DBF` | Exámenes de laboratorio | `lab_exams` |
| `LVTPRUE.DBF` | Ítems/Pruebas de cada examen | `lab_exam_items` |

---

## 🎯 Comandos Rápidos (Copiar y Pegar)

```powershell
# 1. Verificar Python
python --version

# 2. Instalar dependencias
pip install dbfread mysql-connector-python

# 3. Limpiar tablas
php artisan tinker --execute="DB::table('lab_exam_items')->delete(); DB::table('lab_exams')->delete(); DB::table('lab_categories')->delete(); echo 'Tablas limpiadas';"

# 4. Importar datos
python import_lab_data.py

# 5. Verificar importación
php artisan tinker --execute="echo 'Categorías: ' . DB::table('lab_categories')->count() . PHP_EOL; echo 'Exámenes: ' . DB::table('lab_exams')->count() . PHP_EOL; echo 'Ítems: ' . DB::table('lab_exam_items')->count() . PHP_EOL;"
```

---

## ✅ Checklist de Instalación

- [ ] Python 3.12 instalado
- [ ] Python agregado al PATH
- [ ] Comando `python --version` funciona
- [ ] Librerías instaladas (`dbfread`, `mysql-connector-python`)
- [ ] Carpeta SISCAL03/DBF existe con archivos DBF
- [ ] WAMP corriendo
- [ ] Base de datos `javier_ponciano_5` existe
- [ ] Tablas limpiadas
- [ ] Script `import_lab_data.py` ejecutado exitosamente
- [ ] Datos verificados en la base de datos

---

**Documentado por:** Sistema de Importación de Datos  
**Última actualización:** 25/11/2025
