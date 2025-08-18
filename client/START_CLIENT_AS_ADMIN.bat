@echo off
title Sim Racing Academy - Client Launcher
echo.
echo ==========================================
echo    🏎️ Sim Racing Academy - Gaming Client
echo ==========================================
echo.
echo Checking administrator privileges...

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Administrator privileges detected
    echo.
    echo Starting Sim Racing Academy Gaming Client...
    echo 🔐 Keyboard protection will be ACTIVE
    echo 📁 Folder protection will be ACTIVE
    echo.
    cd /d "%~dp0"
    echo 🚀 Starting client in background...
    start "Sim Racing Academy Client" /min python netcafe_client.py
    echo ✅ Sim Racing Academy Gaming Client started in background
    echo 📱 Check system tray for client status
    echo.
    echo 💡 Client will connect to Node.js backend on port 3001
    echo    Make sure backend is running: npm run dev:full
    echo.
    timeout /t 3 > nul
    echo 👋 Client launcher completed. You can close this window.
    pause
) else (
    echo ❌ Administrator privileges required!
    echo.
    echo 🛡️  Sim Racing Academy requires administrator privileges to:
    echo    • Block system keyboard shortcuts (Alt+Tab, Alt+F4, Windows key)
    echo    • Protect against unauthorized file access
    echo    • Ensure proper gaming session security
    echo.
    echo Restarting with administrator privileges...
    echo.
    
    REM Request administrator privileges and restart
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
) 