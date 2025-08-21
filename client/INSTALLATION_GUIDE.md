# 🏎️ Sim Racing Academy Client - Installation Guide

## 📋 Преди Инсталацията

### Системни Изисквания:
- ✅ **Windows 10/11** (64-bit)
- ✅ **Python 3.8+** 
- ✅ **Administrator права** (задължително!)
- ✅ **Интернет връзка** към сървъра
- ✅ **Минимум 2GB RAM**

---

## 🚀 Стъпка 1: Инсталиране на Python

### Опция А: Автоматично (Препоръчително)
```bash
# Изтеглете Python от официалния сайт:
https://www.python.org/downloads/

# При инсталацията ЗАДЪЛЖИТЕЛНО отметнете:
☑️ "Add Python to PATH"
☑️ "Install for all users"
```

### Опция Б: Проверка на съществуваща инсталация
```bash
# Отворете Command Prompt и въведете:
python --version
# Трябва да видите: Python 3.8.x или по-нова версия
```

---

## 🔧 Стъпка 2: Подготовка на Client Файловете

### 1. Копирайте client папката на целевата машина:
```
C:\SimRacingAcademy\client\
├── netcafe_client.py
├── requirements.txt
├── START_CLIENT_AS_ADMIN.bat
├── config.json (ще създадете)
└── README.md
```

### 2. Създайте config.json файл:
```json
{
    "server": {
        "host": "192.168.1.100",
        "port": 8080,
        "websocket_endpoint": "/ws",
        "max_reconnect_attempts": 10,
        "fallback_hosts": ["127.0.0.1", "localhost"]
    }
}
```

> **ВАЖНО:** Сменете `192.168.1.100` с IP адреса на вашия сървър!

---

## 📦 Стъпка 3: Инсталиране на Dependencies

### Отворете Command Prompt като Administrator:
```bash
# Навигирайте до client папката:
cd C:\SimRacingAcademy\client\

# Инсталирайте dependencies:
pip install -r requirements.txt
```

### Ако pip не работи:
```bash
# Опитайте с python -m pip:
python -m pip install -r requirements.txt

# Или обновете pip първо:
python -m pip install --upgrade pip
```

---

## 🛠️ Стъпка 4: Конфигурация на Windows

### 1. Windows Defender Изключения:
```
Windows Security → Virus & threat protection → 
Exclusions → Add an exclusion → Folder → 
C:\SimRacingAcademy\client\
```

### 2. Firewall Изключения:
```
Windows Security → Firewall & network protection → 
Allow an app through firewall → 
Add: python.exe и netcafe_client.py
```

### 3. UAC Настройки (Опционално):
```
Control Panel → User Account Control → 
Set to "Never notify" (за автоматичен старт)
```

---

## 🎯 Стъпка 5: Първоначален Тест

### 1. Тест на връзката:
```bash
cd C:\SimRacingAcademy\client\
python test_connection.py
```

**Очакван резултат:**
```
🧪 Testing NetCafe Server Connection...
✅ HTTP API: {'status': 'running'}
✅ WebSocket connection successful!
🎉 ALL TESTS PASSED!
```

### 2. Тест на клиента:
```bash
# Right-click → "Run as administrator"
START_CLIENT_AS_ADMIN.bat
```

**Очакван резултат:**
- Показва се lock screen
- В system tray има зелена икона
- Status: "🟢 Ready for login"

---

## 🔐 Стъпка 6: Автоматичен Старт (Опционално)

### Метод 1: Windows Startup Folder
```bash
# Копирайте START_CLIENT_AS_ADMIN.bat в:
C:\Users\[USERNAME]\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\
```

### Метод 2: Task Scheduler
```
Task Scheduler → Create Task → 
Name: "Sim Racing Academy Client"
Trigger: At startup
Action: Start program → START_CLIENT_AS_ADMIN.bat
Settings: ☑️ Run with highest privileges
```

### Метод 3: Windows Service (Advanced)
```bash
# Използвайте NSSM (Non-Sucking Service Manager)
nssm install "SimRacingClient" "C:\SimRacingAcademy\client\START_CLIENT_AS_ADMIN.bat"
```

---

## 🧪 Стъпка 7: Финален Тест

### 1. Рестартирайте компютъра
### 2. Проверете дали клиентът стартира автоматично
### 3. Тествайте login с тест потребител
### 4. Тествайте admin shutdown функционалността

---

## ⚠️ Troubleshooting

### Проблем: "Python не се разпознава"
**Решение:** Добавете Python в PATH:
```
System Properties → Environment Variables → 
Path → Add: C:\Python39\ и C:\Python39\Scripts\
```

### Проблем: "Permission denied"
**Решение:** 
```bash
# Винаги стартирайте като Administrator
# Проверете Windows Defender изключенията
```

### Проблем: "Connection refused"
**Решение:**
```bash
# Проверете config.json - правилен ли е IP адресът?
# Работи ли сървърът?
# Блокира ли firewall-ът порта?
```

### Проблем: "Keyboard blocking не работи"
**Решение:**
```bash
# Стартирайте ЗАДЪЛЖИТЕЛНО като Administrator
# Добавете изключение в Windows Defender
# Проверете дали други security software не блокира
```

---

## 📞 Support

При проблеми:
1. ✅ Проверете `client.log` файла за грешки
2. ✅ Тествайте връзката с `test_connection.py`
3. ✅ Уверете се че сървърът работи
4. ✅ Проверете firewall настройките

---

## 🎉 Готово!

Клиентът е инсталиран и готов за използване! 

**За нормални потребители:** Компютърът ще бъде заключен докато не се логнат
**За админи:** Login ще изключи клиента и ще освободи компютъра

**Happy Gaming! 🏎️**
