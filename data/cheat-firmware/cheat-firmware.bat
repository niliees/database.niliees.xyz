@echo off
setlocal EnableDelayedExpansion
title Cheat Firmware 

REM Add premium status
set "premium=0"
set "premium_code=uno/8888:8080"

REM Premium code check at start
cls
echo Welcome to Cheat Firmware
echo ========================
echo Enter Premium Code for 50% faster downloads
echo or press ENTER to continue with normal speed
echo.
set /p "code=Premium Code: "
if "%code%"=="%premium_code%" (
    set "premium=1"
    echo %GREEN%Premium Code accepted! Downloads will be 50% faster.%RESET%
) else if not "%code%"=="" (
    echo %RED%Invalid Premium Code%RESET%
)
timeout /t 2 /nobreak >nul

REM Enable colored output
reg add HKEY_CURRENT_USER\Console /v VirtualTerminalLevel /t REG_DWORD /d 1 /f >nul 2>&1

REM Define color codes with escape character
for /F %%a in ('echo prompt $E^| cmd') do set "ESC=%%a"
set "GREEN=%ESC%[32m"
set "WHITE=%ESC%[37m"
set "RED=%ESC%[31m"
set "RESET=%ESC%[0m"

REM Add download status tracker
set "firmware_downloaded=0"

REM Add status trackers for assets
set "aimbot_installed=0"
set "aimbot_active=0"
set "wallhack_installed=0"
set "wallhack_active=0"
set "triggerbot_installed=0"
set "triggerbot_active=0"
set "esp_installed=0"
set "esp_active=0"

:menu
cls
echo Cheat Command Prompt
echo ==================
if !premium! EQU 1 (
    echo %GREEN%PREMIUM MODE ACTIVE%RESET%
)
echo.
if !firmware_downloaded! EQU 0 (
    echo 1. Download Firmware
    echo 2. Exit
) else (
    echo FIRMWARE STATUS: INSTALLED
    echo ---------------------
    echo Available Hacks:
    if !aimbot_installed! EQU 1 (
        if !aimbot_active! EQU 1 (
            echo %GREEN%1. Aimbot [Installed] Status: Active%RESET%
        ) else (
            echo %RED%1. Aimbot [Installed] Status: Inactive%RESET%
        )
    ) else (
        echo %ESC%[33m1. Aimbot [Not Installed]%RESET%
    )
    if !wallhack_installed! EQU 1 (
        if !wallhack_active! EQU 1 (
            echo %GREEN%2. Wallhack [Installed] Status: Active%RESET%
        ) else (
            echo %RED%2. Wallhack [Installed] Status: Inactive%RESET%
        )
    ) else (
        echo %ESC%[33m2. Wallhack [Not Installed]%RESET%
    )
    if !triggerbot_installed! EQU 1 (
        if !triggerbot_active! EQU 1 (
            echo %GREEN%3. Triggerbot [Installed] Status: Active%RESET%
        ) else (
            echo %RED%3. Triggerbot [Installed] Status: Inactive%RESET%
        )
    ) else (
        echo %ESC%[33m3. Triggerbot [Not Installed]%RESET%
    )
    if !esp_installed! EQU 1 (
        if !esp_active! EQU 1 (
            echo %GREEN%4. ESP [Installed] Status: Active%RESET%
        ) else (
            echo %RED%4. ESP [Installed] Status: Inactive%RESET%
        )
    ) else (
        echo %ESC%[33m4. ESP [Not Installed]%RESET%
    )
    echo 5. Install All Hacks
    echo 6. Exit
)
echo.
set /p "eingabe=Enter command: "

if !firmware_downloaded! EQU 0 (
    if /i "%eingabe%"=="1" goto Download
    if /i "%eingabe%"=="launch" goto Download
    if /i "%eingabe%"=="2" exit
    if /i "%eingabe%"=="exit" exit
) else (
    if "%eingabe%"=="1" goto Aimbot
    if "%eingabe%"=="2" goto Wallhack
    if "%eingabe%"=="3" goto Triggerbot
    if "%eingabe%"=="4" goto ESP
    if "%eingabe%"=="5" goto InstallAll
    if "%eingabe%"=="6" exit
)
echo Invalid command!
timeout /t 2 /nobreak >nul
goto menu

:Download
cls
echo %GREEN%Checking connection...%RESET%
timeout /t 2 /nobreak >nul
echo %GREEN%Connection established%RESET%
echo %GREEN%Firmware size: 2.48 MB%RESET%
timeout /t 1 /nobreak >nul

echo %GREEN%Initializing download...%RESET%
timeout /t 2 /nobreak >nul

set "fill=#"
set "empty=-"

for /l %%i in (1,1,100) do (
    cls
    echo %GREEN%Downloading firmware...%RESET%
    
    REM Calculate speed (max 50 KB/s)
    set /a "speed1=(!random! %% 50) + 1"
    set /a "speed2=(!random! %% 90) + 10"
    echo %GREEN%Speed: !speed1!.!speed2! KB/s%RESET%
    
    REM Build progress bar dynamically
    set "progressbar="
    set /a "filled=%%i/10"
    for /l %%j in (1,1,!filled!) do set "progressbar=!progressbar!%fill%"
    for /l %%j in (!filled!,1,9) do set "progressbar=!progressbar!%empty%"
    
    echo %GREEN%[!progressbar!] %%i%%%RESET%
    
    REM Adjust delay based on premium status
    if !premium! EQU 1 (
        timeout /t 1 /nobreak >nul
    ) else (
        timeout /t 2 /nobreak >nul
    )
)

REM After download progress, add success/fail chance
set /a "success=!random! %% 2"

echo %WHITE%Verifying download integrity...%RESET%
timeout /t 3 /nobreak >nul

if !success! EQU 1 (
    echo %GREEN%Download Complete - Starting installation%RESET%
    timeout /t 2 /nobreak >nul
    echo %GREEN%Installing firmware...%RESET%
    timeout /t 4 /nobreak >nul
    echo %GREEN%Installation successful!%RESET%
    echo %GREEN%Firmware ready to use.%RESET%
    timeout /t 2 /nobreak >nul
    set "firmware_downloaded=1"
) else (
    echo %RED%Error: Installation failed - Invalid firmware signature%RESET%
    echo %RED%Error code: 0xE0010A%RESET%
    echo %RED%Please try downloading again.%RESET%
    set "firmware_downloaded=0"
)

pause
goto menu

REM Remove :AfterDownload label since we don't need it anymore

:Aimbot
cls
if !firmware_downloaded! EQU 0 (
    echo %RED%Error: Firmware not installed properly%RESET%
    echo %RED%Please install firmware first%RESET%
    pause
    goto menu
)
if !aimbot_installed! EQU 1 (
    echo %GREEN%Aimbot is installed%RESET%
    if !aimbot_active! EQU 1 (
        echo Current status: ACTIVE
        set /p "toggle=Deactivate Aimbot? (y/n): "
        if /i "!toggle!"=="y" set "aimbot_active=0"
    ) else (
        echo Current status: INACTIVE
        set /p "toggle=Activate Aimbot? (y/n): "
        if /i "!toggle!"=="y" set "aimbot_active=1"
    )
) else (
    echo %GREEN%Downloading Aimbot...%RESET%
    
    REM Download animation
    set "fill=#"
    set "empty=-"
    for /l %%i in (1,1,100) do (
        cls
        echo %GREEN%Downloading Aimbot...%RESET%
        set /a "speed1=(!random! %% 50) + 1"
        echo %GREEN%Speed: !speed1! KB/s%RESET%
        set /a "filled=%%i/10"
        set "progressbar="
        for /l %%j in (1,1,!filled!) do set "progressbar=!progressbar!%fill%"
        for /l %%j in (!filled!,1,9) do set "progressbar=!progressbar!%empty%"
        echo %GREEN%[!progressbar!] %%i%%%RESET%
        REM Adjust delay based on premium status
        if !premium! EQU 1 (
            timeout /t 1 /nobreak >nul
        ) else (
            timeout /t 2 /nobreak >nul
        )
    )
    
    echo %GREEN%Aimbot installed successfully!%RESET%
    set "aimbot_installed=1"
    set "aimbot_active=1"
    echo %GREEN%Aimbot activated!%RESET%
)
pause
goto menu

:Wallhack
cls
if !firmware_downloaded! EQU 0 (
    echo %RED%Error: Firmware not installed properly%RESET%
    echo %RED%Please install firmware first%RESET%
    pause
    goto menu
)
if !wallhack_installed! EQU 1 (
    echo %GREEN%Wallhack is installed%RESET%
    if !wallhack_active! EQU 1 (
        echo Current status: ACTIVE
        set /p "toggle=Deactivate Wallhack? (y/n): "
        if /i "!toggle!"=="y" set "wallhack_active=0"
    ) else (
        echo Current status: INACTIVE
        set /p "toggle=Activate Wallhack? (y/n): "
        if /i "!toggle!"=="y" set "wallhack_active=1"
    )
) else (
    echo %GREEN%Downloading Wallhack...%RESET%
    
    REM Download animation
    set "fill=#"
    set "empty=-"
    for /l %%i in (1,1,100) do (
        cls
        echo %GREEN%Downloading Wallhack...%RESET%
        set /a "speed1=(!random! %% 50) + 1"
        echo %GREEN%Speed: !speed1! KB/s%RESET%
        set /a "filled=%%i/10"
        set "progressbar="
        for /l %%j in (1,1,!filled!) do set "progressbar=!progressbar!%fill%"
        for /l %%j in (!filled!,1,9) do set "progressbar=!progressbar!%empty%"
        echo %GREEN%[!progressbar!] %%i%%%RESET%
        REM Adjust delay based on premium status
        if !premium! EQU 1 (
            timeout /t 1 /nobreak >nul
        ) else (
            timeout /t 2 /nobreak >nul
        )
    )
    
    echo %GREEN%Wallhack installed successfully!%RESET%
    set "wallhack_installed=1"
    set "wallhack_active=1"
    echo %GREEN%Wallhack activated!%RESET%
)
pause
goto menu

:Triggerbot
cls
if !firmware_downloaded! EQU 0 (
    echo %RED%Error: Firmware not installed properly%RESET%
    echo %RED%Please install firmware first%RESET%
    pause
    goto menu
)
if !triggerbot_installed! EQU 1 (
    echo %GREEN%Triggerbot is installed%RESET%
    if !triggerbot_active! EQU 1 (
        echo Current status: ACTIVE
        set /p "toggle=Deactivate Triggerbot? (y/n): "
        if /i "!toggle!"=="y" set "triggerbot_active=0"
    ) else (
        echo Current status: INACTIVE
        set /p "toggle=Activate Triggerbot? (y/n): "
        if /i "!toggle!"=="y" set "triggerbot_active=1"
    )
) else (
    echo %GREEN%Downloading Triggerbot...%RESET%
    
    REM Download animation
    set "fill=#"
    set "empty=-"
    for /l %%i in (1,1,100) do (
        cls
        echo %GREEN%Downloading Triggerbot...%RESET%
        set /a "speed1=(!random! %% 50) + 1"
        echo %GREEN%Speed: !speed1! KB/s%RESET%
        set /a "filled=%%i/10"
        set "progressbar="
        for /l %%j in (1,1,!filled!) do set "progressbar=!progressbar!%fill%"
        for /l %%j in (!filled!,1,9) do set "progressbar=!progressbar!%empty%"
        echo %GREEN%[!progressbar!] %%i%%%RESET%
        REM Adjust delay based on premium status
        if !premium! EQU 1 (
            timeout /t 1 /nobreak >nul
        ) else (
            timeout /t 2 /nobreak >nul
        )
    )
    
    echo %GREEN%Triggerbot installed successfully!%RESET%
    set "triggerbot_installed=1"
    set "triggerbot_active=1"
    echo %GREEN%Triggerbot activated!%RESET%
)
pause
goto menu

:ESP
cls
if !firmware_downloaded! EQU 0 (
    echo %RED%Error: Firmware not installed properly%RESET%
    echo %RED%Please install firmware first%RESET%
    pause
    goto menu
)
if !esp_installed! EQU 1 (
    echo %GREEN%ESP is installed%RESET%
    if !esp_active! EQU 1 (
        echo Current status: ACTIVE
        set /p "toggle=Deactivate ESP? (y/n): "
        if /i "!toggle!"=="y" set "esp_active=0"
    ) else (
        echo Current status: INACTIVE
        set /p "toggle=Activate ESP? (y/n): "
        if /i "!toggle!"=="y" set "esp_active=1"
    )
) else (
    echo %GREEN%Downloading ESP...%RESET%
    
    REM Download animation
    set "fill=#"
    set "empty=-"
    for /l %%i in (1,1,100) do (
        cls
        echo %GREEN%Downloading ESP...%RESET%
        set /a "speed1=(!random! %% 50) + 1"
        echo %GREEN%Speed: !speed1! KB/s%RESET%
        set /a "filled=%%i/10"
        set "progressbar="
        for /l %%j in (1,1,!filled!) do set "progressbar=!progressbar!%fill%"
        for /l %%j in (!filled!,1,9) do set "progressbar=!progressbar!%empty%"
        echo %GREEN%[!progressbar!] %%i%%%RESET%
        REM Adjust delay based on premium status
        if !premium! EQU 1 (
            timeout /t 1 /nobreak >nul
        ) else (
            timeout /t 2 /nobreak >nul
        )
    )
    
    echo %GREEN%ESP installed successfully!%RESET%
    set "esp_installed=1"
    set "esp_active=1"
    echo %GREEN%ESP activated!%RESET%
)
pause
goto menu

:InstallAll
cls
if !firmware_downloaded! EQU 0 (
    echo %RED%Error: Firmware not installed properly%RESET%
    echo %RED%Please install firmware first%RESET%
    pause
    goto menu
)

echo %GREEN%Starting batch installation of all hacks...%RESET%
timeout /t 2 /nobreak >nul

if !aimbot_installed! EQU 0 (
    call :DownloadHack "Aimbot" aimbot
)
if !wallhack_installed! EQU 0 (
    call :DownloadHack "Wallhack" wallhack
)
if !triggerbot_installed! EQU 0 (
    call :DownloadHack "Triggerbot" triggerbot
)
if !esp_installed! EQU 0 (
    call :DownloadHack "ESP" esp
)

echo %GREEN%All available hacks have been installed!%RESET%
pause
goto menu

:DownloadHack
REM Parameter 1: Hack name (e.g. "Aimbot")
REM Parameter 2: Variable prefix (e.g. aimbot)
echo %GREEN%Downloading %~1...%RESET%
set "fill=#"
set "empty=-"
for /l %%i in (1,1,100) do (
    cls
    echo %GREEN%Downloading %~1...%RESET%
    set /a "speed1=(!random! %% 50) + 1"
    echo %GREEN%Speed: !speed1! KB/s%RESET%
    set /a "filled=%%i/10"
    set "progressbar="
    for /l %%j in (1,1,!filled!) do set "progressbar=!progressbar!%fill%"
    for /l %%j in (!filled!,1,9) do set "progressbar=!progressbar!%empty%"
    echo %GREEN%[!progressbar!] %%i%%%RESET%
    REM Adjust delay based on premium status
    if !premium! EQU 1 (
        timeout /t 1 /nobreak >nul
    ) else (
        timeout /t 2 /nobreak >nul
    )
)
echo %GREEN%%~1 installed successfully!%RESET%
set "%~2_installed=1"
set "%~2_active=1"
echo %GREEN%%~1 activated!%RESET%
timeout /t 2 /nobreak >nul
exit /b