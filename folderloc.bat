@echo off
setlocal
echo.
echo:...Please select your workspace folder...
echo.
echo:       Opening chooser.Please wait

set "psCommand="(new-object -COM 'Shell.Application').BrowseForFolder(0,'Please choose workspace folder.',0,0).self.path""
for /f "usebackq delims=" %%I in (`powershell %psCommand%`) do set "folder=%%I"
setlocal enabledelayedexpansion
if defined folder ( 
type nul > "%userprofile%\Documents\loc.wsp"
if !folder:~-2!==:\ set folder=%folder:~0,-1%
>> "%userprofile%\Documents\loc.wsp" echo !folder!
echo.
echo:Your new workspace - !folder!
echo:
pause
) else ( 
echo.
echo.No folder selected...Work space remains unchanged i.e.
echo.
type "%userprofile%\Documents\loc.wsp"
echo.
pause
) 
endlocal
GOTO :EOF