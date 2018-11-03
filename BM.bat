@echo off
color 1F
SetLocal EnableDelayedExpansion
set path=C:\MinGW\bin;%path%
set "home=%cd%"
if not exist %userprofile%\Documents\loc.wsp ( 
:createloc 
type nul > "%userprofile%\Documents\loc.wsp"
2>nul mkdir "%userprofile%\Desktop\YourProgs"
>>"%userprofile%\Documents\loc.wsp" echo %userprofile%\Desktop\YourProgs
) 
rem content of loca has no quotes

<"%userprofile%\Documents\loc.wsp" ( set /p "loca=" ) 
if not defined loca ( GOTO createloc ) 
%loca:~0,2%
cd "%loca%"
set "L=C" & set "ext=.c" & set "cplr=gcc"
title BlueMug%L%

:menu 
title BlueMug%L%
color 1F
echo.
echo: HELLO THERE
echo.
echo: START MENU 
echo.
echo: Let's program in %L% (Press S to switch language C/C++)
echo.
echo: N - Create a new program in %L%
echo.
echo: X - Continue with an existing %L% program (source file)
echo.
echo: R - Run a program (Executable.exe)
echo.
echo: L - Change workspace location 
echo:     Current workspace folder - %loca%
echo.
CHOICE /C NXRLS

if %errorlevel% EQU 1 (goto new) 

if %errorlevel% EQU 2 (
:editx 
cls
color 1F
echo.
echo    AVAILABLE %L% PROGRAM FILES IN YOUR WORKSPACE
echo.
dir /b *%ext%
echo.
echo.
echo:Optionally, you can also create a new program file 
echo:by specifying a program name below
echo.
echo:OR Press ENTER to go back. 
echo.
set /p "new=Enter name of a program from the above list (just the name): "
if not defined new cls & goto menu
goto edit ) 

if %errorlevel% EQU 3 (
call "%home%\runit.bat"
cls
goto menu ) 

if %errorlevel% EQU 4 ( goto option ) 

if %errorlevel% EQU 5 (
if %L% EQU C set "ext=.cpp" & set "cplr=g++" & set "L=C++" & cls & goto menu 
if %L% EQU C++ set "ext=.c" & set "cplr=gcc" & set "L=C" & cls & goto menu ) 

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
"%systemdrive%\MinGW\bin\%cplr%.exe" "%loca%\%new%%ext%" -o "%loca%\%new%.exe" 2>> error.tmp 
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
echo: S: Start Menu
echo.
echo: Q: Quit
echo.

CHOICE /C ERDNXSQ

IF %errorlevel% EQU 1 ( 
if not defined new goto option
goto edit ) 
IF %errorlevel% EQU 2 ( 
if not defined new goto option
goto run ) 
IF %errorlevel% EQU 3 ( 
2>nul del "%new%%ext%"
2>nul del "%new%.exe"
set new=
echo: DELETE succcessful
pause
goto option ) 
IF %errorlevel% EQU 4 ( GOTO new ) 
IF %errorlevel% EQU 5 ( GOTO editx ) 
IF %errorlevel% EQU 6 ( cls & GOTO menu ) 
IF %errorlevel% EQU 7 ( GOTO exitb ) 

echo %errorlevel%
pause
:exitb 
cls
color 02
CHOICE /C YN /M "Sure, Exit IDE"
IF %errorlevel% EQU 1  (
EXIT
) 
IF %errorlevel% EQU 2 ( GOTO option ) 