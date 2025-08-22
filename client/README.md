# 🏎️ Sim Racing Academy - Gaming Client

## 🚀 Quick Installation

### Option 1: Automated Installer (RECOMMENDED)
```bash
1. Right-click "INSTALL_CLIENT.bat" → "Run as administrator"
2. Follow the installation wizard
3. Edit config.json with your server IP
4. Done! 🎉
```

### Option 2: Manual Installation
```bash
1. Install Python 3.8+ (with "Add to PATH" checked)
2. pip install -r requirements.txt
3. Create config.json with server settings
4. Run START_CLIENT_AS_ADMIN.bat
```

## 📋 Quick Start

### For First-Time Setup:
1. **Run INSTALL_CLIENT.bat as Administrator**
2. **Edit config.json** - set your server IP address
3. **Start client** - Double-click desktop shortcut

### Daily Usage:
- **Normal Users:** Login with credentials to start gaming session
- **Admins:** Login to unlock computer and disable client

## 🔐 Security Features

### ✅ Gaming Session Protection:
- **🎮 Windows Key ALLOWED** - For Alt+Tab and gaming shortcuts
- **🚫 Task Manager BLOCKED** - Prevents process termination
- **📁 File Access BLOCKED** - No access to folders/system tools
- **⏰ Session Timer** - Automatic logout when time expires
- **🧹 Process Cleanup** - Automatically closes apps opened during session

### 🔒 Lock Screen Protection:
- **🛡️ All Keys BLOCKED** - Alt+F4, Escape, Windows key, etc.
- **🚫 NO CLOSE BUTTONS** - Cannot exit lock screen
- **🔐 Secure Login** - Must enter valid credentials

## 📁 Files Overview:
- `INSTALL_CLIENT.bat` - **Automated installer** 
- `START_CLIENT_AS_ADMIN.bat` - **Client launcher**
- `netcafe_client.py` - Main client application
- `config.json` - Server configuration
- `test_connection.py` - Connection tester
- `INSTALLATION_GUIDE.md` - Detailed setup guide

## 🔧 Configuration:

Edit `config.json`:
```json
{
    "server": {
        "host": "192.168.1.100",
        "port": 8080,
        "websocket_endpoint": "/ws",
        "max_reconnect_attempts": 10,
        "fallback_hosts": ["127.0.0.1"]
    },
    "session": {
        "cleanup_processes": true,
        "cleanup_timeout": 3
    }
}
```

### 🧹 Session Cleanup Options:
- **`cleanup_processes`** - Automatically close applications opened during session (default: `true`)
- **`cleanup_timeout`** - Seconds to wait before force-killing unresponsive apps (default: `3`)

## ⚠️ Requirements:
- **Windows 10/11** (64-bit)
- **Python 3.8+** 
- **Administrator rights** (mandatory!)
- **Network access** to server

## 🧪 Testing:
```bash
# Test server connection:
python test_connection.py

# Test client startup:
START_CLIENT_AS_ADMIN.bat
```

## 📞 Troubleshooting:

### Common Issues:
1. **Check `client.log`** for errors
2. **Ensure Python is in PATH**
3. **Run as Administrator** always
4. **Add Windows Defender exclusions**
5. **Check server IP** in config.json

### 🚨 Windows Key Blocked After Client Exit:
If Windows key remains blocked after closing the client:

**Quick Fix:**
```bash
1. Right-click "FIX_WINDOWS_KEY.bat" → "Run as administrator"
2. Follow the automatic fix wizard
3. Restart computer when prompted
```

**Manual Fix:**
```bash
1. Open Registry Editor (regedit.exe) as Administrator
2. Navigate to: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Keyboard Layout
3. Delete the "Scancode Map" value (if it exists)
4. Restart your computer
```

**Root Cause:** Previous versions used registry blocking as fallback when Windows Hook API failed. This has been **FIXED** in current version.

---
**🏎️ Sim Racing Academy - Professional Gaming Client** 