@echo off
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
set path=%systemdrive%\mingw\bin;%systemdrive%\nodejs;%PYTHONBIN%;%path%
cls

Rem %1 - where run_fildg is located i.e. home

Rem this step is to prevent problems caused by slash while calling fildgpath
Rem in the for statement below.
if [%1]==[] ( set "fildgpath=" ) else ( set "fildgpath=%~1\") 

:select
title RUN
cls
color 1f
setlocal enabledelayedexpansion
echo.
echo.                            Choose a program to run
echo.
FOR /F "usebackq delims=" %%j IN (`%PYTHONBIN%python.exe "%fildgpath%run_fildg.py"`) DO set filename=%%j
:runag 
cls
echo.
title RUN: !filename!
color 2F
if defined filename (
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
set /p "args=!filename! "
cls
echo.*******************************************************************************
echo.
echo.                              EXECUTION / OUTPUT
echo.
if !filename:~-2! EQU js call "%systemdrive%\nodejs\node" "!filename!" !args! & set "args=" & goto runagask
if !filename:~-2! EQU py call !PYTHONBIN!python "!filename!" !args! & set "args=" & goto runagask
Rem to run c and c++
"!filename!" !args!
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
echo. RUN SUCCESSFUL
echo.
CHOICE /C YN /M "Run the same prog again?"
if %errorlevel% EQU 1  GOTO runag 
if %errorlevel% EQU 2  set "filename="

Rem Run-another
:runan 
cls
endlocal
echo.
echo.
echo.
CHOICE /C YN /M "Run another program?"
IF %errorlevel% EQU 1 ( GOTO select )
IF %errorlevel% EQU 2 ( GOTO :EOF )