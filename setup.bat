@echo off
title PC SETUP.BAT

echo ⚠️ WARNING: This will create a bookmarklet called "Cheats" in your browser.
echo Make sure you want to proceed!
set /p userinput="Do you want to continue? (Y/N): "

if /i "%userinput%" neq "Y" (
    echo Operation cancelled.
    pause
    exit
)

:: Download gui.js temporarily
set "url=https://raw.githubusercontent.com/schoolop/Blooket-Hacks/main/gui.js"
set "tempjs=gui.js"

powershell -Command "(New-Object System.Net.WebClient).DownloadFile('%url%', '%tempjs%')"

:: Check if download succeeded
if not exist "%tempjs%" (
    echo Failed to download gui.js
    pause
    exit
)

:: Read gui.js into a single-line JavaScript for bookmarklet
setlocal EnableDelayedExpansion
set "bookmarklet=javascript:(function(){"
for /f "usebackq delims=" %%a in ("%tempjs%") do (
    set "line=%%a"
    set "line=!line:"=\"!"
    set "bookmarklet=!bookmarklet!!line!%0A"
)
set "bookmarklet=!bookmarklet!})();"

:: Generate HTML file for bookmarklet
(
echo ^<!DOCTYPE html^>
echo ^<html^>
echo ^<head^>
echo ^<title^>Cheats Bookmarklet^</title^>
echo ^</head^>
echo ^<body^>
echo Drag this link to your bookmarks bar: ^<br/^>
echo ^<a href="%bookmarklet%" style="color:red; font-family:monospace;" title="Cheats"^>Cheats^</a^>
echo ^</body^>
echo ^</html^>
) > "Cheats_Bookmarklet.html"

echo Done! Open "Cheats_Bookmarklet.html" and drag the link to your bookmarks bar.
pause
