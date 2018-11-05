<# : 
@echo off
cls
:select
title RUN
cls
color 3f
setlocal enabledelayedexpansion
echo.
echo:     Select a program [.exe] to run
echo.
echo ...please wait for selection window...
for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    set "cf=%%~I"
)
:runag 
cls
echo.
echo ****EXECUTION/OUTPUT****
title RUN:%cf%
color 2F
if defined cf (
echo.
"%cf%"
echo.
goto runagask
 ) else (
echo: No files selected.
echo.
goto runan )
:runagask 
echo.
CHOICE /C YN /M "Run the same prog again?"
if %errorlevel% EQU 1  GOTO runag 
if %errorlevel% EQU 2  set cf=
:runan 
cls
echo.
CHOICE /C YN /M "Run another program?"
IF %errorlevel% EQU 1 ( GOTO select )
IF %errorlevel% EQU 2 ( GOTO :EOF )
: end Batch portion / begin PowerShell hybrid chimera #>

$loc=type -path "$ENV:Userprofile\Documents\loc.wsp"
Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.InitialDirectory = $loc
$f.Filter = "Executable (*.exe)|*.exe|All Files (*.*)|*.*"
$f.ShowHelp = $true
$f.Multiselect = $false
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }