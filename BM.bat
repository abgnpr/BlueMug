@echo off
color 71
title WELCOME
Rem Blue Mug is a programming environment for C/C++ built upon MinGW and notepad++.
Rem Copyright (C) 2018 Abhigyan Prakash

Rem This program is free software: you can redistribute it and/or modify
Rem it under the terms of the GNU General Public License as published by
Rem the Free Software Foundation, either version 3 of the License, or
Rem (at your option) any later version.

Rem This program is distributed in the hope that it will be useful,
Rem but WITHOUT ANY WARRANTY; without even the implied warranty of
Rem MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. 
Rem See GNU General Public License for more details.

Rem You should have received a copy of the GNU General Public License
Rem along with this program.
echo./\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P /\P 
echo.
echo.                         WELCOME TO BLUEMUG V 1.2.0
echo.
echo.    BlueMug BFPE  Copyright (C) 2018  Abhigyan Prakash {ap44122@gmail.com}
echo.  This is free software, and you are welcome to redistribute it under certain
echo.  conditions. See license for more details.
echo.
pause
cls

Rem Delayed expansion - to be able to expand variables at runtime
SetLocal EnableDelayedExpansion

Rem Setting environment variable
set path=%systemdrive%\mingw\bin;%systemdrive%\nodejs;%systemdrive%\python;%path%

Rem home is the directory in which this batch file lies
set "home=%cd%"

Rem File containing default workspace desktop is created if the file 
Rem specifying workspace directory is not found. Later on changes to
Rem workspace directory are written to this file
if not exist "%LOCALAPPDATA%\BlueMug\loc.wsp" ( 
:createloc 
2>nul mkdir "%LOCALAPPDATA%\BlueMug"
type nul > "%LOCALAPPDATA%\BlueMug\loc.wsp"
2>nul mkdir "%userprofile%\Desktop\YourProgs"
>>"%LOCALAPPDATA%\BlueMug\loc.wsp" echo %userprofile%\Desktop\YourProgs
) 
rem content of loca has no quotes

Rem The environment is set for C by default, can be changed in menu
set "L=C" & set "ext=.c" & set "cplr=gcc"

Rem fetching current workspace location
Rem from loc.wsp in documents folder
:checkloc 
<"%LOCALAPPDATA%\BlueMug\loc.wsp" ( set /p "loca=" ) 
if not defined loca ( GOTO createloc ) 

Rem necessary step for switching drives
%loca:~0,2%

Rem All file I/O from now on will take place in loca - the workspace
cd "%loca%"

Rem copy xntimer config file to workspace
if not exist "%loca%\xntimer.ini" xcopy "C:\BlueMug\timer\xntimer.ini" "%loca%\"
Rem Start menu
:menu 
set "new="
title BM for %L%
cls
Rem white on blue theme
color 1f
rem color 0a
echo.********************************************************************************
echo:  HELLO THERE                                           1: LICENSE  2: CREDITS
echo.
echo:  START MENU
echo.
echo:  Let's program in %L%  (Press S to switch language C/C++/Py/JS)
echo.
echo:  N: Create a new program in %L%
echo.
echo:  X: Continue with an existing %L% program (source file)
echo.
echo:  R: Run a program (executable/script)
echo.
echo:  L: Change workspace location 
echo:      Current workspace folder - "!loca!"
echo.
echo:  O: Open workspace folder         P: python Shell
echo.
echo:  T: Timer                         J: nodejs Shell
echo.
echo.
echo.
echo.*******************************************************************************
CHOICE /C NXRLSO12TPJ /N

Rem For creating new program in workspace
if %errorlevel% EQU 1 (goto newp) 

if %errorlevel% EQU 2 ( 
Rem edit existing program
:editx 
cls
color 71
set "new="
echo. ******************************************************************************
echo.
echo:                SELECT A %L% PROGRAM FILE, FROM YOUR WORKSPACE                     
echo.
FOR /F "usebackq delims=" %%j IN (`%systemdrive%\python\python.exe "%home%\choose_fildg.py" "%loca%" "%ext%" "%L%"`) DO set "new=%%~nj"
echo.
if not defined new  cls & goto menu
if exist "!loca!\!new!!ext!" goto edit
echo. The file you specified is not appropriate. Please check.
echo.
pause
goto editx )  

Rem Choose a program in workspace and run it
if %errorlevel% EQU 3 (
call "%home%\runit.bat" "%home%"
cls
goto menu ) 

Rem change workspace folder - where source files and exe files will be stored
if %errorlevel% EQU 4 ( 
cls
2>nul del "%loca%\xntimer.ini"
call "%home%\folderloc.bat" "%LOCALAPPDATA%\BlueMug" "%home%"
cls
goto checkloc ) 

Rem Switching Language
if %errorlevel% EQU 5 (
if %L% EQU C set "ext=.cpp" & set "cplr=g++" & set "L=C++" & cls & goto menu 
if %L% EQU C++ set "ext=.py" & set "cplr=python" & set "L=Python" & cls & goto menu 
if %L% EQU Python set "ext=.js" & set "cplr=node" & set "L=JavaScript" & cls & goto menu 
if %L% EQU JavaScript set "ext=.c" & set "cplr=gcc" & set "L=C" & cls & goto menu ) 

Rem to open up the workspace directory.
if %errorlevel% EQU 6 (
start .
cls
goto menu ) 

Rem View LICENSE
if %errorlevel% EQU 7 ( 
if exist "%home%\LICENSE" notepad.exe "%home%\LICENSE"
cls
goto menu ) 

Rem View CREDITS
if %errorlevel% EQU 8 ( 
if exist "%home%\CREDITS" notepad.exe "%home%\CREDITS"
cls
goto menu ) 

Rem Open timer
if %errorlevel% EQU 9 (
cls
start /B C:\BlueMug\timer\xntimer.exe
goto menu ) 

Rem Python shell
if %errorlevel% EQU 10 (
cls
start python
goto menu )

Rem nodejs Shell
if %errorlevel% EQU 11 (
cls 
start node
goto menu )

Rem creating new source file in workspace
:newp 
cls
title NEW PROGRAM in %L%
color 0a
echo.*******************************************************************************
echo. 
echo:                                                        Press ENTER to go back
echo.                                                        ~~~~~~~~~~~~~~~~~~~~~~
echo. 
set /p "new=Enter name of the new program: "
if not defined new  cls & goto menu
if exist "%new%%ext%" goto edit
type nul > "%new%%ext%"

Rem Editing programs
:edit 
cls 
color 84
title EDIT: !new! - %L%
echo.
echo. CODING WINDOW OPEN
echo.
echo. TYPE...
echo.
echo. SAVE... Third icon from top left in the coding window
echo.
echo. CLOSE... 
echo.
echo.
echo. WARNING : DON'T CLOSE THE CODING WINDOW WITHOUT SAVING YOUR WORK.
echo.
REM "path to your editor.exe" "%new%%ext%"
call "%systemdrive%\BlueMug\nppbin\notepad++.exe" "%new%%ext%"

color 6f
cls

echo.*******************************************************************************
echo.
echo.                                    ACTION
Rem checking if the user has supplied some code in the source file or not
for /f "delims=" %%j IN ("!loca!\!new!!ext!") DO set sourcesize=%%~zj
if %sourcesize% EQU 0 (
color 4f
cls
echo.
echo.\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\WARNING////////////////////////////////////
echo.  
echo:  There is no code in your source file - !new!!ext!
echo:  You must write something before you compile/run.
echo.
echo:  also, make sure you didn't close the 
echo:  CODING WINDOW without saving your work. ) else ( title READY )

echo.
echo:  Your program (source) file has been saved at 
echo:         - !loca!
echo.
echo:  READY TO RUN / COMPILE AND RUN? - !new!!ext!
echo.
echo:  R - RUN / COMPILE and RUN
echo:  E - re-edit
echo:  D - delete
echo.
echo:  S - Start menu
echo:  P - Post-session menu.
echo.
choice /C REDSP /N
if %errorlevel% EQU 1 ( 
if %L% EQU Python goto directrun
if %L% EQU JavaScript goto directrun
Rem if Language is C/C++/TS then compile
goto compile
)
if %errorlevel% EQU 2 goto edit
if %errorlevel% EQU 3 del /p "%new%%ext%" & (if exist "%new%.exe" del /p "%new%.exe") & cls & goto menu
if %errorlevel% EQU 4 (cls & goto menu)
if %errorlevel% EQU 5 (cls & goto option)


Rem to run python and JS scripts - direct run
:directrun 
color 2f
if %L% EQU TypeScript set "ext=.js" & set "cplr=node"
if NOT EXIST "!new!!ext!" echo:%L% source file not found & pause & goto option
cls
echo.*******************************************************************************
echo.
echo.                               SUPPLY ARGUMENTS
echo.
echo.  Please supply arguments - if any
echo.
echo.  press Enter to RUN
echo.
echo.
echo.
echo.
set /p "args=!new!!ext! "
cls
echo.*******************************************************************************
echo.
echo.                              EXECUTION / OUTPUT
echo.
title RUN: !new!!ext!
echo.
%cplr% "!new!!ext!" !args!
Rem Revert extension and compiler after running a compiled TS code(JS code)
if %L% EQU TypeScript set "ext=.ts" & set "cplr=tsc"
echo.
echo.
echo.  RUN SUCCESSFUL
pause
goto option

Rem Compile steps begin
:compile 
echo.*******************************************************************************
echo: Please wait... COMPILING
echo.*******************************************************************************

Rem error.tmp for storing compile time errors
type nul > error.tmp
Rem compile command - errors stderr written to file error.tmp
if %L% EQU C ( 
"%cplr%.exe" "%new%%ext%" -o "%loca%\%new%.exe" 2>> error.tmp ) 
if %L% EQU C++ ( 
"%cplr%.exe" "%new%%ext%" -o "%loca%\%new%.exe" 2>> error.tmp ) 
if %L% EQU TypeScript (
call %cplr% "%loca%\%new%%ext%" >> error.tmp )

Rem checking if there are compile time errors...by counting char.s in error.tmp
for /f %%i IN ("error.tmp") DO set size=%%~zi
if %size% EQU 0 ( 
Rem we proceed with run
:run 
if %L% EQU TypeScript del error.tmp & goto directrun 
color 2f
title RUN: !new!.exe
cls
if NOT EXIST "%new%.exe" echo:Program executable file not found & pause & goto option
echo.*******************************************************************************
echo.
echo.                               SUPPLY ARGUMENTS
echo.
echo.  Please supply arguments - if any
echo.
echo.  Press Enter to RUN 
echo.
echo.
echo.
echo.
echo.
set /p "args=!new!.exe "
cls
echo.*******************************************************************************
echo.
echo.                              EXECUTION / OUTPUT
echo.
"!new!.exe" !args!
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
title ERROR{s} in: !new!
echo.////////////////////////////////////////////////////////////////////////////////
echo.                      Your code has the FOLLOWING ERRORS:

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
rem old code color - 6f
color 0E
echo. ******************************************************************************
ECHO.
echo.                                POST-SESSION MENU
echo.
echo:   CURRENT PROGRAM in memory: !new! in %L%        
echo.
echo:   E: Re-edit current program code
echo.
echo:   R: Re-run the current program
echo.
echo:   D: Delete current program {source} file
echo.
echo:   N: Create a new program
echo.
echo:   X: Edit another program
echo.
echo:   S: Start Menu      O: to Open Workspace
echo.
echo:   Q: Quit
echo.
echo.
echo.
echo.
echo. ******************************************************************************
CHOICE /C ERDNXSQO /N

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
if %L% EQU Python del /p "%new%%ext%" & goto destroy
if %L% EQU TypeScript del /p "%new%%ext%" & goto destroy
if %L% EQU JavaScript del /p "%new%%ext%" & goto destroy
2>nul del /p "%new%%ext%"
2>nul del "%new%.exe"
:destroy
Rem the variable new is destroyed
if not exist "%new%%ext%" set "new=" & echo: DELETE succcessful
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
echo:                          Hope you enjoyed BlueMug BFPE
echo.
echo:                                 
echo.
echo.
echo:                                   -Abhigyan,
echo:                       Creator, BlueMug for C/C++/Python/JS
echo:                                              
echo.
CHOICE /C YN /M "Sure, Exit"
IF %errorlevel% EQU 1  (
EXIT
) 
IF %errorlevel% EQU 2 ( GOTO option ) 