@echo off
color 1F
SetLocal EnableDelayedExpansion
cd %cd%
set L=C
title tasker%L%
set ext=.c
echo.
echo: HELLO THERE
echo.
echo: N - Create a new program in %L%
echo.
echo: X - Continue with an existing %L% program.
echo.
CHOICE /C NX
if %errorlevel% EQU 1 (goto new) 
if %errorlevel% EQU 2 (
:editx 
cls
color 1F
echo.
echo ***AVAILABLE PROGRAM FILES***
echo.
dir /b *%ext%
echo.
echo:Choose one of the above files
echo:{Optionally, you can also create a new program file 
echo: by specifying a program name below.}
echo.
set /p new=Name of the existing program that you want to edit: 
goto edit ) 
:new 
cls
title NEW PROGRAM in %L%
color 1F
echo.
set /p new=Enter name of the new program: 
type nul > "%new%%ext%"
:edit 
cls 
color 1F
title EDIT: %new%
echo.
echo:CODING WINDOW OPEN
echo.
echo:Type...
echo:SAVE...(Third icon from top left in the coding window)
echo:and then close the coding window.
echo.
echo.
echo:WARNING : DONT CLOSE THE CODING WINDOW WITHOUT SAVING YOUR WORK.
echo.
E:\nppbin\notepad++.exe "%new%%ext%"
cls
echo.
echo:Ready to Compile and Run?
echo.
echo:You can close this window at this stage if you dont want to compile and run your program. However, your program file has been saved. 
echo.
pause
echo: Please wait...
type nul > error.tmp
C:\MinGW\bin\gcc.exe "%new%%ext%" -o "%cd%\%new%.exe" 2>> error.tmp 
for /f %%i IN ("error.tmp") DO set size=%%~zi
if %size% EQU 0  ( 
:run 
color 2f
title RUN: %new%.exe
echo.
cls
ECHO: ***OUTPUT***
echo.
"%new%.exe"
echo.
echo.
echo RUN SUCCESSFUL
echo. 
pause 
del error.tmp
GOTO option 
) ELSE (
cls
color 4f
title: "ERROR(s) in: %new%"
echo:Your code has FOLLOWING ERRORS:
echo.
type error.tmp
echo.
echo:RUN UNSUCCESSFUL
del error.tmp
echo.
pause
goto :option ) 

:option 
cls
title WHAT NEXT?
color 6f
echo.
echo  *************MENU***************
echo.
echo: CURRENT PROGRAM in memory: %new%
echo.
echo: E: Re-edit current program code
echo.
echo: R: Run the current program again
echo.
echo: D: Delete current program file
echo.
echo: N: Create new program
echo.
echo: X: Edit another program
echo.
echo: Q: Quit
echo.

CHOICE /C ERDNXQ
IF %errorlevel% EQU 1 ( GOTO edit ) 
IF %errorlevel% EQU 2 ( GOTO run ) 
IF %errorlevel% EQU 3 ( 
2>nul del "%new%%ext%"
2>nul del "%new%.exe"
set new= 
echo: DELETE succcessful!
pause
goto option ) 
IF %errorlevel% EQU 4 ( GOTO new ) 
IF %errorlevel% EQU 5 ( GOTO editx ) 
IF %errorlevel% EQU 6 ( GOTO exitb ) 


:exitb 
cls
color 02
CHOICE /C YN /M "Sure, Exit IDE"
IF %errorlevel% EQU 1  (
EXIT
) 
IF %errorlevel% EQU 2 ( GOTO option ) 