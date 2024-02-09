@echo off

:: Initialization
mode con cols=64 lines=45
color 80
title DongleQuery
cd /d "%~dp0"
echo.
echo Launcher Script Initialized...
echo.
timeout /t 2 /nobreak >nul

:: Maintenance
echo Performing Maintenance..
if exist "BasicInfo.Txt" (
    echo ..BasicInfo.Txt Found..
    del "BasicInfo.Txt"
    echo ..BasicInfo.Txt Deleted..
) else (
    echo ..BasicInfo.Txt not found..
)
if exist "Commands.Txt" (
    echo ..Commands.Txt Found..
    del "Commands.Txt"
    echo ..Commands.Txt Deleted.
) else (
    echo ..Commands.Txt not found.
)
echo.
timeout /t 2 /nobreak >nul

:: Main Menu
:menu
cls
echo.
echo ========================( DongleQuery )========================
echo.
echo                      1. Basic Dongle Info
echo                      2. List AT Commands
echo                       3. AT Console Mode
echo                        X. Exit Launcher
echo.
echo ---------------------------------------------------------------
set /p choice=Select an option (1-3, X to Exit): 
echo.
timeout /t 1 /nobreak >nul

:: Convert choice to lowercase to handle case-insensitivity
set choice=%choice:~0,1%
if /i "%choice%"=="x" goto end

echo Checking PowerShell Capabilities..
timeout /t 1 /nobreak >nul
where pwsh >nul 2>&1
set pwshAvailable=%ERRORLEVEL%

:: Launching script based on choice
if %pwshAvailable% equ 0 (set psCmd=pwsh.exe) else (set psCmd=powershell.exe)
echo ...Launching Script...

if "%choice%"=="1" (
    %psCmd% -NoProfile -ExecutionPolicy Bypass -File ".\basicinfo.ps1" > ".\BasicInfo.Txt"
    echo Log saved to ".\BasicInfo.Txt".
) else if "%choice%"=="2" (
    %psCmd% -NoProfile -ExecutionPolicy Bypass -File ".\commands.ps1" > ".\Commands.Txt"
    echo Log saved to ".\Commands.Txt".
) else if "%choice%"=="3" (
    %psCmd% -NoProfile -ExecutionPolicy Bypass -File ".\console.ps1"
    echo Console Mode exited.
)

echo.
echo Returning to menu..
timeout /t 2 /nobreak >nul
goto menu

:end
echo ...Exit Process Initiated.
timeout /t 5 /nobreak >nul
