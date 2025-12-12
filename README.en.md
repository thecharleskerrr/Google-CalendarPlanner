# OmniCal - Rainmeter Google Calendar Skin

**English version** | **[Русская версия](README.md)**

![Version](https://img.shields.io/badge/version-3.5-blue)
![Rainmeter](https://img.shields.io/badge/Rainmeter-compatible-green)
![Language](https://img.shields.io/badge/language-RU%20%7C%20EN-orange)

**OmniCal** is a modern Rainmeter skin that displays events from Google Calendar and iCloud Calendar directly on your Windows desktop.

---

## 🌟 Key Features

- ✅ **Calendar Integration**: Google Calendar, iCloud Calendar, Yandex Calendar
- 📊 **4 regular calendars + 1 aggregator**: Calendar 5 combines up to 5 sub-calendars with unified styling
- 🎨 **Two Themes**: Light and Dark
- 🌐 **Localization**: Russian and English interface
- 🕒 **Day Modes**: Normal (00:00-00:00) and Psychological (customizable)
- 📅 **Flexible Time Grid**: Configure start and end of workday
- 🔔 **Event Grouping**: Completed, current, and future events
- 🎯 **Weekend Highlighting**: Customization for each day of the week
- 🔄 **Recurring Events**: Support with visual indication
- 🎨 **Embedded Event Colors**: Support for custom colors from external sources
- ⚙️ **Full Customization**: Colors, fonts, sizes, time zones

---

## 📸 Screenshots

<img width="505" height="710" alt="OmniCal_1" src="https://github.com/user-attachments/assets/5ef11da7-9fa9-4bc6-b057-eba60b85c7a9" />
<img width="505" height="710" alt="OmniCal_2" src="https://github.com/user-attachments/assets/13ce7576-c1bc-4c2a-9d68-44ca8b3bb786" />
<img width="740" height="750" alt="OmniCal_3" src="https://github.com/user-attachments/assets/31d81529-916a-4999-9168-fb90297b473a" />

---

## 🚀 Installation

### Requirements

- Windows 7 or higher
- [Rainmeter](https://www.rainmeter.net/) 4.0 or newer
- Google Calendar or iCloud Calendar account

### Installation Steps

1. **Download the project**:
   ```bash
   git clone https://github.com/Dokcc/Rainmeter-OmniCalendar.git
   ```
   Or download the ZIP archive and extract it to `Documents\Rainmeter\Skins\`.

2. **Configure variables**:
   - Go to `@Resources/`
   - Copy `Variables_URL.ini.example` and rename it to `Variables_URL.ini`
   - Open `Variables_URL.ini`, add URLs and names of your calendars (Google/iCloud/Yandex)
   - **NEW**: Calendar 5 supports up to 5 sub-calendars (`iCalendar5_1` through `iCalendar5_5`) with unified styling
   - If necessary, change other settings through the interface.

3. **Load the skin in Rainmeter**:
   - Open Rainmeter
   - Find `OmniCal` in the skins list
   - Load `OmniCal.ini`

---

### Detailed Documentation

Full documentation is located in the `@Resources/_dok/` folder:
- `Описание Скина.md` — Detailed description of features (Russian)
- `Как добавить новый календарь.md` — Adding calendars (Russian)
- `DayStartHour - Настройка начала суток.md` — Day modes configuration (Russian)
- `Поток данных.md` — Script architecture (Russian)

---

## 🛠️ Technologies

- **Rainmeter** — Desktop skin framework
- **Lua** — Scripting language for logic processing
- **Google Calendar API** — Retrieving calendar events
- **iCloud Calendar** — Support via .ics files

---

## 📁 Project Structure

```
GoogleCalendar/
├── OmniCal.ini                    # Main skin file
├── @Resources/
│   ├── Variables.ini              # Main skin settings
│   ├── Variables_URL.ini          # Calendar URLs (not committed!)
│   ├── Variables_URL.ini.example  # Template for calendar URLs
│   ├── OmniCal_Events.lua         # Main event processing script
│   ├── OmniCal_Events_Renderer.lua # Event rendering
│   ├── OmniCal_Skin.lua           # Calendar grid logic
│   ├── Variables_Theme_Dark.ini   # Dark theme
│   ├── Variables_Theme_Light.ini  # Light theme
│   ├── _dok/                      # Documentation
│   ├── Debug/                     # Debug files (not committed)
│   ├── Fonts/                     # Fonts
│   ├── Images/                    # Icons and images
│   └── Measures/                  # Helper scripts
├── ColorSelector/                 # Color picker tool
└── OmniCal_Color/                 # Color settings
```

---

## 🤝 Contributing

All suggestions and improvements are welcome!

### How to Contribute

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Commit your changes: `git commit -m 'Add new feature'`
4. Push the branch: `git push origin feature/new-feature`
5. Create a Pull Request

### Coding Guidelines

- **Comments**: Duplicate in Russian and English
  ```lua
  -- Получить события (Get events)
  ```
- **Naming**: camelCase for variables, PascalCase for functions
- **Security**: DO NOT commit API keys and tokens!

---

## 📝 License

This project is licensed under **Creative Commons Attribution-NonCommercial-ShareAlike 3.0 (CC BY-NC-SA 3.0)**.

You are free to:
- ✅ Use for personal purposes
- ✅ Modify and adapt
- ✅ Share with attribution

Not allowed:
- ❌ Commercial use
- ❌ Distribution without attribution

Learn more: [CC BY-NC-SA 3.0 License](https://creativecommons.org/licenses/by-nc-sa/3.0/)

---

## 👤 Author

**⊰SK⊱**  
GitHub: [@Dokcc](https://github.com/Dokcc)

---

## 🙏 Acknowledgments

This skin is an adapted modification of the original patch by:
- **eclectic-tech** — Original patch
- **Kaelri** — Enigma GCal (project foundation)

---

## 📞 Support

If you encounter any issues:
1. Check [Issues](https://github.com/Dokcc/Rainmeter-OmniCalendar/issues)
2. Create a new Issue with a problem description
3. Include logs from `@Resources/Debug/LOG.txt` (if applicable)

---

**Enjoy convenient planning! 🎉**
