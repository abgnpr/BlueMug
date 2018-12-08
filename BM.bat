@echo off
color 1F
title WELCOME
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
echo.                             WELCOME TO BLUEMUG
echo.
echo:    BlueMug BFPE  Copyright (C) 2018  Abhigyan Prakash {ap44122@gmail.com}
echo:  This is free software, and you are welcome to redistribute it under certain
echo:  conditions. See license for more details.
echo.
pause
cls

Rem Delayed expansion - to be able to expand variables at runtime
SetLocal EnableDelayedExpansion

Rem Setting environment variable
set path=%systemdrive%\mingw\bin;%systemdrive%\nodejs;%path%

Rem home is the directory in which this batch file lies
set "home=%cd%"

Rem File containing default workspace{desktop} is created if the file 
Rem specifying workspace directory is not found. Later on changes to
Rem workspace directory are written to this file
if not exist %userprofile%\Documents\loc.wsp ( 
:createloc 
type nul > "%userprofile%\Documents\loc.wsp"
2>nul mkdir "%userprofile%\Desktop\YourProgs"
>>"%userprofile%\Documents\loc.wsp" echo %userprofile%\Desktop\YourProgs
) 
rem content of loca has no quotes

Rem The environment is set for C by default, can be changed in menu
set "L=C" & set "ext=.c" & set "cplr=gcc"

Rem fetching current workspace location
Rem from loc.wsp in documents folder
:checkloc 
<"%userprofile%\Documents\loc.wsp" ( set /p "loca=" ) 
if not defined loca ( GOTO createloc ) 

Rem necessary step for switching drives
%loca:~0,2%

Rem All file I/O from now on will take place in loca{the workspace}
cd "%loca%"

Rem Start menu
:menu 
set "new="
title BlueMug V1.0 for %L%
Rem Blue background
color 1F
echo.
echo: HELLO THERE                                          1 - LICENSE  2 - CREDITS
echo.
echo: START MENU
echo.
echo: Let's program in %L%  (Press S to switch language C/C++/Py/TS/JS)
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
echo: O - Open workspace folder         
echo.
CHOICE /C NXRLSO12

Rem For creating new program in workspace
if %errorlevel% EQU 1 (goto newp) 

if %errorlevel% EQU 2 ( 
Rem edit existing program
:editx 
cls
color 1F
echo.
set "new="
echo:  AVAILABLE %L% PROGRAM FILES, IN YOUR WORKSPACE                     
echo.
dir *%ext% /B /W /O:D
echo.
echo.
echo.Enter name of a program from the above list.         Press ENTER {without input}
echo.                                                     to go back.
echo.
set /p "new=ENTER NAME {just the prog name, no extensions}: "
echo.
if not defined new  cls & goto menu
if exist "!loca!\!new!!ext!" goto edit
echo:The file you specified is not there. Please check above
echo.
pause
goto editx )  

Rem Choose a program in workspace and run it
if %errorlevel% EQU 3 (
call "%home%\runit.bat"
cls
goto menu ) 

Rem change workspace folder - where source files and exe files will be stored
if %errorlevel% EQU 4 ( 
cls
call "%home%\folderloc.bat"
cls
goto checkloc ) 

Rem Switching Language
if %errorlevel% EQU 5 (
if %L% EQU C set "ext=.cpp" & set "cplr=g++" & set "L=C++" & cls & goto menu 
if %L% EQU C++ set "ext=.py" & set "cplr=python" & set "L=Python" & cls & goto menu 
if %L% EQU Python set "ext=.ts" & set "cplr=tsc" & set "L=TypeScript" & cls & goto menu 
if %L% EQU TypeScript set "ext=.js" & set "cplr=node" & set "L=JavaScript" & cls & goto menu 
if %L% EQU JavaScript set "ext=.c" & set "cplr=gcc" & set "L=C" & cls & goto menu ) 

Rem to open up the workspace directory.
if %errorlevel% EQU 6 (
start .
cls
goto menu ) 

Rem View LICENSE
if %errorlevel% EQU 7 ( 
if exist "%systemdrive%\BlueMug\CREDITS" notepad.exe "%systemdrive%\BlueMug\LICENSE"
cls
goto menu ) 

Rem View CREDITS
if %errorlevel% EQU 8 ( 
if exist "%systemdrive%\BlueMug\CREDITS" notepad.exe "%systemdrive%\BlueMug\CREDITS"
cls
goto menu ) 

Rem creating new source file in workspace
:newp 
cls
title NEW PROGRAM in %L%
color 1F
echo.
echo:                                                        Press ENTER to go back
echo.
set /p "new=Enter name of the new program: "
if not defined new  cls & goto menu
if exist "%new%%ext%" goto edit
type nul > "%new%%ext%"

Rem Editing programs - new or existing{editx}
:edit 
cls 
color 1F
title EDIT: %new%
echo.
echo:CODING WINDOW OPEN
echo.
echo: TYPE...
echo: SAVE... Third icon from top left in the coding window
echo:CLOSE... 
echo.
echo.
echo:WARNING : DONT CLOSE THE CODING WINDOW WITHOUT SAVING YOUR WORK.
echo.
"%systemdrive%\BlueMug\nppbin\notepad++.exe" "%new%%ext%"
del "%systemdrive%\BlueMug\nppbin\session.xml"



color 3f
cls

Rem checking if the user has supplied some code in the source file or not
for /f "delims=" %%j IN ("!loca!\!new!!ext!") DO set sourcesize=%%~zj
if %sourcesize% EQU 0 (
color 4f
echo. 
echo:There isn't a single piece of code in your source file - %new%%ext%
echo:You must write something otherwise there will be error while compile/run.
echo.
echo:also,make sure you didn't close the CODING WINDOW without saving your work. ) 

echo.
echo:Your program(source) file has been saved at %loca% 
echo.
echo:READY TO RUN / COMPILE AND RUN?
echo.
echo: R - compile and run / run.
echo: E - re-edit
echo: D - delete
echo.
echo: S - Start menu
echo: P - Post-session menu.
echo.

choice /C REDSP
if %errorlevel% EQU 1 ( 
if %L% EQU Python goto directrun
if %L% EQU JavaScript goto directrun
Rem if Language is C/C++/TS then compile
goto compile
)
if %errorlevel% EQU 2 goto edit
if %errorlevel% EQU 3 del "%new%%ext%" & cls & goto menu
if %errorlevel% EQU 4 (cls & goto menu)
if %errorlevel% EQU 5 (cls & goto option)


Rem to run python script
:directrun 
if %L% EQU TypeScript set "ext=.js" & set "cplr=node"
if NOT EXIST "%new%%ext%" echo:%L% source file not found & pause & goto option
cls
color 2f
title RUN: %new%%ext%
echo.
%cplr% "%new%%ext%"
if %L% EQU TypeScript set "ext=.ts" & set "cplr=tsc"
echo.
echo:RUN SUCCESSFUL
pause
goto option


:compile 
echo:Please wait...COMPILING

Rem error.tmp for storing compile time errors
type nul > error.tmp
Rem compile command - errors {stderr} written to file error.tmp
if %L% EQU C ( 
"%cplr%.exe" "%new%%ext%" -o "%loca%\%new%.exe" 2>> error.tmp ) 
if %L% EQU C++ ( 
"%cplr%.exe" "%new%%ext%" -o "%loca%\%new%.exe" 2>> error.tmp ) 
if %L% EQU TypeScript (
call %cplr% "%loca%\%new%%ext%" >> error.tmp )

Rem checking if there are compile time errors...by counting char.s in errror.tmp
for /f %%i IN ("error.tmp") DO set size=%%~zi
if %size% EQU 0 ( 
Rem we proceed with run
:run 
if %L% EQU TypeScript del error.tmp & goto directrun 
color 2f
title RUN: %new%.exe
echo.
if NOT EXIST "%new%.exe" echo:Program executable file not found & pause & goto option
cls
ECHO: ***EXECUTION/OUTPUT***
echo.
"%new%.exe"
echo.
echo.
echo RUN SUCCESSFUL
echo. 
pause 
Rem error.tmp is removed once prog is successfully run
del error.tmp
GOTO option 
) ELSE (
cls
Rem else we display errors
Rem color is red
color 4f
title ERROR{s} in: %new%
echo:Your code has FOLLOWING ERRORS:
echo.
type error.tmp
echo.
echo:COMPILE UNSUCCESSFUL
del error.tmp
echo.
pause
goto :option ) 


:option 
cls
title WHAT NEXT?
rem old code - 6f
color 02
echo.
echo:  ******** Post-Session MENU *********              Press 'O' to Open Workspace
echo.
echo: CURRENT PROGRAM in memory: %new% in %L%
echo.
echo: E: Re-edit current program code
echo.
echo: R: Re-run the current program
echo.
echo: D: Delete current program{source} file
echo.
echo: N: Create a new program
echo.
echo: X: Edit another program
echo.
echo: S: Start Menu
echo.
echo: Q: Quit
echo.

CHOICE /C ERDNXSQO

IF %errorlevel% EQU 1 ( 
if not defined new goto option
goto edit ) 

IF %errorlevel% EQU 2 ( 
if %L% EQU C goto run
if %L% EQU C++ goto run
if %L% EQU Python goto directrun
if %L% EQU TypeScript goto directrun
if %L% EQU JavaScript goto directrun ) 

IF %errorlevel% EQU 3 ( 
if not defined new goto option
if %L% EQU Python del "%new%%ext%" & goto destroy
if %L% EQU TypeScript del "%new%%ext%" & goto destroy
if %L% EQU JavaScript del "%new%%ext%" & goto destroy
2>nul del "%new%%ext%"
2>nul del "%new%.exe"
:destroy
Rem the variable new is destroyed
set new=
echo: DELETE succcessful
pause
goto option ) 

IF %errorlevel% EQU 4 ( set "new=" & GOTO newp ) 
IF %errorlevel% EQU 5 ( GOTO editx ) 
IF %errorlevel% EQU 6 ( cls & GOTO menu ) 
IF %errorlevel% EQU 7 ( GOTO exitb ) 
IF %errorlevel% EQU 8 ( start . & cls & goto option ) 

:exitb
title Exit BlueMug 
cls
color 1e
echo.
echo:                           Hope you enjoyed BlueMug BFPE
echo.
echo:                                  *Best Wishes*
echo.
echo.
echo:                                    -Abhigyan,
echo:                             Creator, BlueMug for C/C++
echo:                                              
echo.
CHOICE /C YN /M "Sure, Exit"
IF %errorlevel% EQU 1  (
EXIT
) 
IF %errorlevel% EQU 2 ( GOTO option ) 