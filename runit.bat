<# : 
@echo off
title RUN
:select
cls
color 3f
echo ...please wait for selection window...
for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    set "cf=%%~I"
)
cls
title RUN: %cf%
color 2F
echo.
set "bsp= "
IF NOT " %cf%" == "%bsp%" (  
echo hooraaah  
"%cf%"
echo.
echo.
pause
echo. ) else (
echo: No files selected. ) 
echo.
CHOICE /C YN /M "Run more?"
IF %errorlevel% EQU 1 ( GOTO select )
IF %errorlevel% EQU 2 ( GOTO :EOF )
: end Batch portion / begin PowerShell hybrid chimera #>

$loc=type loc.txt
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = $loc
$f.Filter = "Executable (*.exe)|*.exe|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $false
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }