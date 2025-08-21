@echo off
title Emergency Fix - Restore Windows Key
color 0C

echo.
echo ==========================================
echo   🚨 EMERGENCY FIX - Restore Windows Key
echo ==========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Administrator privileges detected
) else (
    echo ❌ Administrator privileges required!
    echo.
    echo 🛡️  This fix requires administrator privileges to:
    echo    • Modify Windows Registry
    echo    • Remove keyboard blocking entries
    echo.
    echo Restarting with administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo 🔍 Checking for Windows key blocking...

REM Check if Scancode Map exists
reg query "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" >nul 2>&1
if %errorLevel% == 0 (
    echo ❌ FOUND: Windows key blocking detected in registry
    echo.
    echo 🔧 Removing keyboard blocking entry...
    
    REM Delete the Scancode Map entry
    reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Keyboard Layout" /v "Scancode Map" /f >nul 2>&1
    
    if %errorLevel% == 0 (
        echo ✅ Registry entry removed successfully
        echo.
        echo ⚠️  IMPORTANT: RESTART REQUIRED!
        echo.
        echo 🔄 Windows key blocking has been removed from registry,
        echo    but you MUST restart your computer for changes to take effect.
        echo.
        choice /C YN /M "Restart computer now (Y/N)"
        if errorlevel 2 goto manual_restart
        if errorlevel 1 goto auto_restart
        
        :auto_restart
        echo.
        echo 🔄 Restarting computer in 10 seconds...
        echo    Press Ctrl+C to cancel
        timeout /t 10
        shutdown /r /t 0
        goto end
        
        :manual_restart
        echo.
        echo ⚠️  Please restart your computer manually to restore Windows key functionality
        goto end
        
    ) else (
        echo ❌ Failed to remove registry entry
        echo.
        echo 🔧 Manual fix required:
        echo    1. Open Registry Editor (regedit.exe) as Administrator
        echo    2. Navigate to: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout
        echo    3. Delete the "Scancode Map" value
        echo    4. Restart your computer
        goto end
    )
) else (
    echo ✅ No Windows key blocking found in registry
    echo.
    echo 🤔 If Windows key is still not working, try:
    echo    1. Restart your computer
    echo    2. Check if any other software is blocking it
    echo    3. Try pressing Fn + Windows key (on some laptops)
    echo    4. Check Windows Settings → Gaming → Game Mode
    goto end
)

:end
echo.
echo 📞 If you still have issues:
echo    • Check client.log for errors
echo    • Ensure no other NetCafe clients are running
echo    • Contact technical support
echo.
pause
