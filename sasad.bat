<# :
setlocal enabledelayedexpansion
for /f "delims=" %%I in ('powershell -noprofile "iex (${%~f0} | out-string)"') do (
    set "cf=%%~I"
)
echo %cf%
pause
: #>

Add-Type -AssemblyName System.Windows.Forms
$f = new-object Windows.Forms.OpenFileDialog
$f.BrowseForFolder(0,'Please choose a folder.',0,0).self.path""


