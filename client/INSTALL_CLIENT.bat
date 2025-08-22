@echo off
title Sim Racing Academy - Client Installer
color 0A

echo.
echo ==========================================
echo   🏎️ Sim Racing Academy - Client Installer
echo ==========================================
echo.

REM Check if running as administrator
net session >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Administrator privileges detected
) else (
    echo ❌ Administrator privileges required!
    echo.
    echo 🛡️  This installer requires administrator privileges to:
    echo    • Install Python dependencies
    echo    • Configure Windows Defender exclusions
    echo    • Set up system-level keyboard hooks
    echo.
    echo Restarting with administrator privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

echo.
echo 🔍 Checking system requirements...

REM Check Python installation
python --version >nul 2>&1
if %errorLevel% == 0 (
    echo ✅ Python is installed
    python --version
) else (
    echo ❌ Python is NOT installed!
    echo.
    echo 📥 Please install Python first:
    echo    1. Go to https://www.python.org/downloads/
    echo    2. Download Python 3.8 or newer
    echo    3. During installation, check "Add Python to PATH"
    echo    4. Run this installer again
    echo.
    pause
    exit /b 1
)

echo.
echo 📦 Installing Python dependencies...
pip install -r requirements.txt
if %errorLevel% == 0 (
    echo ✅ Dependencies installed successfully
) else (
    echo ❌ Failed to install dependencies
    echo 🔄 Trying alternative method...
    python -m pip install -r requirements.txt
    if %errorLevel__ == 0 (
        echo ✅ Dependencies installed successfully (alternative method)
    ) else (
        echo ❌ Failed to install dependencies with both methods
        echo Please install manually: pip install -r requirements.txt
        pause
        exit /b 1
    )
)

echo.
echo 🔧 Checking configuration...

REM Check if config.json exists
if exist config.json (
    echo ✅ Configuration file found
) else (
    echo ⚠️  Configuration file missing
    echo 📝 Creating default config.json...
    
    echo { > config.json
    echo     "server": { >> config.json
    echo         "host": "localhost", >> config.json
    echo         "port": 8080, >> config.json
    echo         "websocket_endpoint": "/ws", >> config.json
    echo         "max_reconnect_attempts": 10, >> config.json
    echo         "fallback_hosts": ["127.0.0.1"] >> config.json
    echo     }, >> config.json
    echo     "session": { >> config.json
    echo         "cleanup_processes": true, >> config.json
    echo         "cleanup_timeout": 3 >> config.json
    echo     } >> config.json
    echo } >> config.json
    
    echo ✅ Default configuration created
    echo ⚠️  IMPORTANT: Edit config.json to set your server IP address!
)

echo.
echo 🛡️  Configuring Windows Defender exclusions...
powershell -Command "Add-MpPreference -ExclusionPath '%cd%'" 2>nul
if %errorLevel__ == 0 (
    echo ✅ Windows Defender exclusion added
) else (
    echo ⚠️  Could not add Windows Defender exclusion automatically
    echo 📝 Please add manually:
    echo    Windows Security → Exclusions → Add folder: %cd%
)

echo.
echo 🔌 Testing server connection...
python test_connection.py
if %errorLevel__ == 0 (
    echo ✅ Server connection test passed
) else (
    echo ⚠️  Server connection test failed
    echo 🔧 Please check:
    echo    1. Server is running
    echo    2. config.json has correct server IP
    echo    3. Firewall allows connections
)

echo.
echo 🚀 Creating desktop shortcut...
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\Sim Racing Academy Client.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%cd%\START_CLIENT_AS_ADMIN.bat" >> %SCRIPT%
echo oLink.WorkingDirectory = "%cd%" >> %SCRIPT%
echo oLink.Description = "Sim Racing Academy Gaming Client" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
echo ✅ Desktop shortcut created

echo.
echo 🎯 Installation Summary:
echo ========================================
echo ✅ Python dependencies installed
echo ✅ Configuration file ready
echo ✅ Windows Defender exclusion added
echo ✅ Desktop shortcut created
echo.

REM Ask about auto-start
echo 🤖 Do you want the client to start automatically with Windows?
choice /C YN /M "Enable auto-start (Y/N)"
if errorlevel 2 goto skip_autostart
if errorlevel 1 goto setup_autostart

:setup_autostart
echo.
echo 🔄 Setting up auto-start...
copy "START_CLIENT_AS_ADMIN.bat" "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\Sim Racing Academy Client.bat"
if %errorLevel__ == 0 (
    echo ✅ Auto-start enabled
) else (
    echo ⚠️  Could not enable auto-start automatically
    echo 📝 Please copy START_CLIENT_AS_ADMIN.bat to Startup folder manually
)
goto installation_complete

:skip_autostart
echo ℹ️  Auto-start skipped

:installation_complete
echo.
echo 🎉 INSTALLATION COMPLETE!
echo ========================================
echo.
echo 📋 Next Steps:
echo 1. Edit config.json to set your server IP address
echo 2. Test the client by running: START_CLIENT_AS_ADMIN.bat
echo 3. The client will show a lock screen until login
echo.
echo 🎮 For normal users: Login with your credentials
echo 🔑 For admins: Login to unlock the computer
echo.
echo 📞 Support: Check client.log file for any issues
echo.

REM Ask to start client now
choice /C YN /M "Start the client now (Y/N)"
if errorlevel 2 goto end
if errorlevel 1 goto start_client

:start_client
echo.
echo 🚀 Starting Sim Racing Academy Client...
start "Sim Racing Academy Client" /min START_CLIENT_AS_ADMIN.bat
echo ✅ Client started in background
echo 📱 Check system tray for client status
goto end

:end
echo.
echo 👋 Installation completed successfully!
echo Double-click the desktop shortcut to start the client anytime.
echo.
pause
