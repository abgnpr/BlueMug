<# : 
Rem Blue Mug is a programming environment for C/C++ built upon MinGW and notepad++.
Rem Copyright (C) 2018 Abhigyan Prakash

Rem This program is free software: you can redistribute it and/or modify
Rem it under the terms of the GNU General Public License as published by
Rem the Free Software Foundation, either version 3 of the License, or
Rem (at your option) any later version.

Rem This program is distributed in the hope that it will be useful,
Rem but WITHOUT ANY WARRANTY; without even the implied warranty of
Rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
Rem GNU General Public License for more details.

Rem You should have received a copy of the GNU General Public License
Rem along with this program.
@echo off
cls
:select
title RUN
cls
color 3f
setlocal enabledelayedexpansion
echo.
echo:           Select a program[.exe] / python script / JavaScript to run
echo.
echo:                   ...please wait for selection window...
for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    set "cf=%%~I"
)
:runag 
cls
echo.
title RUN: !cf!
color 2F
if defined cf (
echo.
cls
echo.*******************************************************************************
echo.
echo.                               SUPPLY ARGUMENTS
echo.
echo.  Please supply arguments - if any
echo.
echo.  Then, press Enter to continue.  
echo.
echo.
echo.
echo.
set /p "args=!cf! "
cls
echo.*******************************************************************************
echo.
echo.                              EXECUTION / OUTPUT
echo.
if !cf:~-2! EQU js call node "!cf!" !args! & set "args=" & goto runagask
if !cf:~-2! EQU py call python "!cf!" !args! & set "args=" & goto runagask
Rem to run c and c++
"!cf!" !args!
set "args="
echo.
goto runagask
 ) else (
echo: No files selected.
echo.
goto runan )

Rem Run-again-ask
:runagask 
echo.
echo.
echo. RUN SUCCESSFUL
echo.
CHOICE /C YN /M "Run the same prog again?"
if %errorlevel% EQU 1  GOTO runag 
if %errorlevel% EQU 2  set "cf="
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
$f.Filter = "Executable/py script/JavaScript|*.exe;*.py;*.js"
$f.ShowHelp = $true
$f.Multiselect = $false
[void]$f.ShowDialog()
if ($f.Multiselect) { $f.FileNames } else { $f.FileName }