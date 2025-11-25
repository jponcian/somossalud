@echo off
rem COPY %cd%\TMP2\*.*  %cd%\TMP
rem COPY %cd%\DBF\*.DBF %cd%\resp_dat
set dia=%date:~0,2%
set mes=%date:~3,2%
set anio=%date:~6,4%
"C:\Program Files\WinRAR\WinRAR.exe" A -R %cd%\Winrar\%dia%.RAR "%cd%\DBF\*.DBF"


