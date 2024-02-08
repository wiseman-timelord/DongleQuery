@echo off

:: Initialization
mode con cols=64 lines=45
color 80
title FilesCollect-Py
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
echo.
timeout /t 1 /nobreak >nul
echo Checking PowerShell Capabilities..
timeout /t 1 /nobreak >nul
where pwsh >nul 2>&1
if %ERRORLEVEL% equ 0 (
    echo ...Launching As Psc Script..
    timeout /t 1 /nobreak >nul
    if "%choice%"=="1" (
        pwsh.exe -NoProfile -ExecutionPolicy Bypass -Command "& '.\basicinfo.ps1' > '.\BasicInfo.Txt'; Get-Content '.\BasicInfo.Txt'"
        echo Log saved to ".\BasicInfo.Txt".
    ) else if "%choice%"=="2" (
        pwsh.exe -NoProfile -ExecutionPolicy Bypass -Command "& '.\commands.ps1' > '.\Commands.Txt'; Get-Content '.\Commands.Txt'"
        echo Log saved to ".\Commands.Txt".
    )
    echo ..Psc Process Exited.
) else (
    echo ...Launching As Ps Script..
    timeout /t 1 /nobreak >nul
    if "%choice%"=="1" (
        powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '.\basicinfo.ps1' > '.\BasicInfo.Txt'; Get-Content '.\BasicInfo.Txt'"
        echo Log saved to ".\BasicInfo.Txt".
    ) else if "%choice%"=="2" (
        powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '.\commands.ps1' > '.\Commands.Txt'; Get-Content '.\Commands.Txt'"
        echo Log saved to ".\Commands.Txt".
    )
    echo ..Ps Process Exited.
    echo.
)
echo Returning to menu..
timeout /t 2 /nobreak >nul
goto menu

:end
echo ...Exit Process Initiated.
timeout /t 5 /nobreak >nul