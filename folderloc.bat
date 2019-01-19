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

REM %1 - the place where loc.wsp is
REM %2 - the place where get_wspFolder.py is located i.e. home

setlocal
color 3f
echo.
echo:                    ...Please select your workspace folder...
echo.
for /f "delims=" %%j IN ('"%~2\get_wspFolder.py"') DO set folder=%%j
setlocal enabledelayedexpansion
if defined folder ( 
type nul > "%~1\loc.wsp"
if !folder:~-2!==:\ set "folder=%folder:~0,-1%"
>> "%~1\loc.wsp" echo !folder!
echo.
echo:Your new workspace - !folder!
echo:
pause
) else ( 
echo.
echo.No folder selected...Work space remains unchanged
echo.
type "%~1\loc.wsp"
echo.
pause
) 

endlocal

GOTO :EOF