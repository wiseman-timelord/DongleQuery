REM Script: FilesCollect.Bat

@echo off

:: Initialization
mode con cols=64 lines=30
color 80
title FilesCollect-Py
cd /d "%~dp0"
set ErrorLog=Errors-Crash.Log
echo.
echo Launcher Script Started...
echo.
timeout /t 2 /nobreak >nul
echo Cleaning up..
if exist ".\Errors-Crash.Log" (
    echo ...Deleting Log...
    del ".\Errors-Crash.Log"
)
echo ..Cleaning Done.
echo.
timeout /t 1 /nobreak >nul

:: Main Menu
:menu
cls
echo    ^_^_^_^_                    ^_       ^_^_^_
echo   ^|  ^_ ^\  ^_^_^_  ^_^_^_^_   ^_^_^_^_^| ^| ^_^_^_ ^/ ^_ ^\ ^_   ^_  ^_^_^_ ^_^_^_^_ ^_   ^_
echo   ^| ^| ^| ^|^/ ^_ ^\^|  ^_ ^\ ^/ ^_  ^| ^|^/ ^_ ^\ ^| ^| ^| ^| ^| ^|^/ ^_ ^\  ^_^_^| ^| ^| ^|
echo   ^| ^|^_^| ^| (^_) ^| ^| ^| ^| (^_^| ^| ^|  ^_^_^/ ^|^_^| ^| ^|^_^| ^|  ^_^_^/ ^|  ^| ^|^_^| ^|
echo   ^|^_^_^_^_^/ ^\^_^_^_^/^|^_^| ^|^_^|^\^_^_  ^|^_^|^\^_^_^_^|^\^_^_^\^_^\^\^_^_^_^_^|^\^_^_^_^|^_^|   ^\^_^_  ^|
echo                       ^|^_^_^_^/                              ^|^_^_^_^/
echo ========================( DongleQuery )========================
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
echo ---------------------------------------------------------------

:: Variables
set /p choice=Select, Options=1-2, Exit=X: 
if "%choice%"=="1" goto executeBasicInfo
if "%choice%"=="2" goto executeListCommands
if "%choice%"=="x" goto end
echo Invalid choice. Try again.
pause
goto menu

:: Check for presence of python and execute main.py
:executeBasicInfo
where python3 >nul 2>&1 && (
    python3 ".\basicinfo.ps1" 2>> "%ErrorLog%"
) || (
    python ".\basicinfo.ps1" 2>> "%ErrorLog%"
)
timeout /t 1 /nobreak >nul
pause
echo Returning to menu..
timeout /t 2 /nobreak >nul
goto menu

:: Check for presence of python and execute main.py
:executeListCommands
where python3 >nul 2>&1 && (
    python3 ".\commands.ps1" 2>> "%ErrorLog%"
) || (
    python ".\commands.ps1" 2>> "%ErrorLog%"
)
timeout /t 1 /nobreak >nul
pause
echo Returning to menu..
timeout /t 2 /nobreak >nul
goto menu

:: End Function
:end
echo ...Exit Process Initiated.
timeout /t 5 /nobreak >nul