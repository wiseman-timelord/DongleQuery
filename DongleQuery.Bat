@echo off
mode con cols=64 lines=45
color 80
title FilesCollect-Py
cd /d "%~dp0"
set ErrorLog=Errors-Crash.Log
echo.
echo Launcher Script Started...
timeout /t 2 /nobreak >nul

:: Main Menu
:menu
cls
echo    ^_^_^_^_                    ^_       ^_^_^_
echo   ^|  ^_ ^\  ^_^_^_  ^_^_^_^_   ^_^_^_^_^| ^| ^_^_^_ ^/ ^_ ^\ ^_   ^_  ^_^_^_ ^_^_^_^_ ^_   ^_
echo   ^| ^| ^| ^|^/ ^_ ^\^|  ^_ ^\ ^/ ^_  ^| ^|^/ ^_ ^\ ^| ^| ^| ^| ^| ^|^/ ^_ ^\  ^_^_^| ^| ^| ^|
echo   ^| ^|^_^| ^| (^_) ^| ^| ^| ^| (^_^| ^| ^|  ^_^_^/ ^|^_^| ^| ^|^_^| ^|  ^_^_^/ ^|  ^| ^|^_^| ^|
echo   ^|^_^_^_^_^/ ^\^_^_^_^/^|^_^| ^|^_^|^\^_^_  ^|^_^|^\^_^_^_^|^\^_^_^\^_^\^\^_^_^_^_^|^\^_^_^_^|^_^|   ^\^_^_  ^|
echo                       ^|^_^_^_^/                              ^|^_^_^_^/
echo.
echo ========================( DongleQuery )========================
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo                      1. Basic Dongle Info,
echo.
echo                      2. List AT Commands,
echo.
echo                        X. Exit Launcher.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo ---------------------------------------------------------------
set /p choice=Select, Options=1-2, Exit=X: 
if "%choice%"=="1" set scriptName=basicinfo.ps1
if "%choice%"=="2" set scriptName=commands.ps1
if "%choice%"=="x" goto end
if not defined scriptName (
    echo Invalid choice. Try again.
	timeout /t 1 /nobreak >nul
    goto menu
)
echo.
timeout /t 1 /nobreak >nul
echo Checking PowerShell Capabilities..
timeout /t 1 /nobreak >nul
where pwsh >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo ...Launching As Psc Script..
    timeout /t 1 /nobreak >nul
    pwsh.exe -NoProfile -ExecutionPolicy Bypass -File ".\%scriptName%"
    echo ..Psc Process Exited.
) else (
    echo ...Launching As Ps Script..
    timeout /t 1 /nobreak >nul
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File ".\%scriptName%"
    echo ..Ps Process Exited.
    echo.
)
echo Returning to menu..
timeout /t 2 /nobreak >nul
goto menu

:end
echo ...Exit Process Initiated.
timeout /t 5 /nobreak >nul
