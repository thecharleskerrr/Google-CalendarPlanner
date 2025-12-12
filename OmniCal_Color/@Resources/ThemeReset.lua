-- ThemeReset.lua
-- Скрипт для сброса темы к настройкам по умолчанию
-- (Script for resetting theme to default settings)

-- Дефолтная темная тема (Default Dark Theme)
local DEFAULT_THEME_DARK = [[; Variables_Theme_Dark.ini
; UTF-8 without BOM (!!!) (UTF‑8 без BOM)
; Цвета темной темы (Colors of the dark theme)
; (NB!) Формат комментариев: Коментарий по-русски (Comment in english)

[Variables]

;—— СЕТКА ВРЕМЕНИ (Time grid) ——————————————————————————————————————————————————————————————————————
    ; Цвет фона сетки (Background color of the grid):
    ; число_1,число_2,число_3,число_4 (number_1,number_2,number_3,number_4)
    ; число_4 - прозрачность (number_4 - transparency)
    ColorBg=38,38,38,1

    ; ЦВЕТА ЛИНИЙ СЕТКИ (Grid line colors):
    ; Линия под шапкой:
    ColorLineH0=10,10,10,255
    ; Линия часа (Hour line):
    ColorLineH1=80,80,80,255
    ; Линия получаса (Half-hour line):
    ColorLineH2=45,45,45,255
    ; Основные вертикальные линии (Main vertical lines):
    ColorLineVertH0=90,90,90,255
    ; Второстепенные вертикальные линии (Secondary vertical lines):
    ColorLineVertH1=80,80,80,255


    ; Цвет заголовка с днями недели (Color of the header with days of the week):
    ColorTxtH1=120,120,120,255

    ; Цвет заголовка выходного дня (Color of the weekend header):
    ; ColorTxtH1_Weekend=216,111,55,255
    ColorTxtH1_Weekend=19,100,36,255

    ; Цвет подписей времени (Color of time labels):
    ColorTtmeTxt=130,130,130,255

    ; Разделитель 1  (Separator 1)
    ColorSeparator_1=77,77,77,255

    ; Разделитель 2 (Separator 2)
    ColorSeparator_2=77,77,77,255

;—— ФОН ДЛЯ ДНЕВНОГО ВРЕМЕНИ В СУТКАХ (Background for daytime hours) ———————————————————————————————
    ; Цвет фона для дневного времени в сутках (Background color for daytime hours):
    ColorTimeZone_1=28,28,28,200
    ColorTimeZone_2=33,37,38,255
    ColorTimeZone_3=25,32,48,100
    

;—— Линия текущего времени (Current time line) —————————————————————————————————————————————————————
    ; Цвет линии текущего времени (Color of the current time line):
    ; ColorCurrTime=0,150,255,255
    ColorCurrTime=216,111,55,255

    ; Толщина линии текущего времени (Thickness of the current time line):
    Line_CurrTimeWeight=1

;—— СОБЫТИЕ (Event) iCalendar 1 ————————————————————————————————————————————————————————————————
    ; @Resources\OmniCal_Events_Renderer.lua PlaceEventsForDay()
    ; Оформление события для 1-го календаря (Event styling for the 1st calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_1_Bg=33,150,243,100
    Cal_1_Bg_back=33,150,243,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_1_Bg_Faded=50,70,86,100
    Cal_1_Bg_Faded_back=50,70,86,100

    ; Рамка события (Event border):
    Cal_1_StrokeWidth=1
    ; Цвет рамки события (Event border color):
    Cal_1_StrokeColor=20,20,20,255

    ; Цвет текста события для Календаря 1 (Event text color for Calendar 1):
    Cal_1_ColorTxtEvent=200,200,200,255
    ; Выцветший цвет текста для прошедших событий Календаря 1 (Faded text color for past events of Calendar 1):
    Cal_1_ColorTxtEventFaded=200,200,200,120

;—— СОБЫТИЕ (Event) iCalendar 2 ————————————————————————————————————————————————————————————————
    ; Оформление события для 2-го календаря (Event styling for the 2nd calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_2_Bg=99,184,144,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_2_Bg_Faded=50,70,86,100

    ; Цвет текста события для Календаря 2 (Event text color for Calendar 2):
    Cal_2_ColorTxtEvent=200,200,200,255
    ; Выцветший цвет текста для прошедших событий Календаря 2 (Faded text color for past events of Calendar 2):
    Cal_2_ColorTxtEventFaded=200,200,200,120

;—— СОБЫТИЕ (Event) iCalendar 3 ————————————————————————————————————————————————————————————————
    ; Оформление события для 3-го календаря (Event styling for the 3rd calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_3_Bg=133,50,243,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_3_Bg_Faded=133,50,243,30

    ; Цвет текста события для Календаря 3 (Event text color for Calendar 3):
    Cal_3_ColorTxtEvent=200,200,200,255
    ; Выцветший цвет текста для прошедших событий Календаря 3 (Faded text color for past events of Calendar 3):
    Cal_3_ColorTxtEventFaded=200,200,200,120

;—— СОБЫТИЕ (Event) iCalendar 4 ————————————————————————————————————————————————————————————————
    ; Оформление события для 4-го календаря (Event styling for the 4th calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_4_Bg=150,150,150,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_4_Bg_Faded=150,150,150,30

    ; Цвет текста события для Календаря 4 (Event text color for Calendar 4):
    Cal_4_ColorTxtEvent=200,200,200,255
    ; Выцветший цвет текста для прошедших событий Календаря 4 (Faded text color for past events of Calendar 4):
    Cal_4_ColorTxtEventFaded=200,200,200,120

;—— СОБЫТИЕ (Event) iCalendar 5 ————————————————————————————————————————————————————————————————
    ; Оформление события для 5-го календаря (Event styling for the 5th calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_5_Bg=150,150,150,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_5_Bg_Faded=150,150,150,30

    ; Цвет текста события для Календаря 5 (Event text color for Calendar 5):
    Cal_5_ColorTxtEvent=200,200,200,255
    ; Выцветший цвет текста для прошедших событий Календаря 5 (Faded text color for past events of Calendar 5):
    Cal_5_ColorTxtEventFaded=200,200,200,120



;—— ВСПЛЫВАЮЩИЕ ПОДСКАЗКИ (Tooltips) —————————————————————————————————————————————————————————————
    ; Цвет текста всплывающей подсказки индикатора (Text color of the indicator tooltip):
    FontColorTooltipIndicator=75,75,75,255
    ; Фон всплывающей подсказки (Tooltip background):
    TooltipBGstr=40

;—— КНОПКА НАСТРОЕК (Settings button) —————————————————————————————————————————————————————————————
    ; Цвет кнопки Настройки при выключенном режиме настройки (Color of the Settings button when Settings mode is off):
    SettingsFontColorOff=150,150,150,60
    SettingsFontColorOn=150,150,150,200
    ; Цвет кнопки Настройки при включенном режиме настройки (Color of the Settings button when Settings mode is on):
    SettingsOnFontColorOff=0,120,212,150
    SettingsOnFontColorOn=0,117,207

    ; Цвет текста всплывающей подсказки при наведении на кнопку настроек (Tooltip text color when hovering over settings button):
    SettingsTxtFontColor=200,200,200,255
    ; Фон всплывающей подсказки при наведении на кнопку настроек (Tooltip background when hovering over settings button):
    SettingsTxtBG=32,32,32,255
    ; Цвет рамки всплывающей подсказки при наведении на кнопку настроек (Border color of the tooltip when hovering over settings button):
    SettingsBGStrokeColor=10,10,10,255

    ; Панель настроек (Settings panel)
    ; Фон панели настроек (Background of the settings panel):
    SettingsPanelBG=50,50,50,255
    ; Цвет рамки панели настроек (Border color of the settings panel):
    SettingsPanelStrokeColor=0,0,0,255
    ; Цвет текста на панели настроек (Text color on the settings panel):
    SettingsPanelTxtFontColor=175,175,175,255
    SettingsPanelTxtFontColorHLt=220,220,220,220

;—— ОКНО ВВОДА (Input window) —————————————————————————————————————————————————————————————————————
    ; Цвет текста окна ввода (для режима Настройки) (Text color of the input window (for Settings mode)):
    ColorInputTxt=200,200,200,255
    ; Цвет фона ввода при включенном режиме настройки (Input background color when Settings mode is on):
    SettingsInputBGColor=25,25,25,255

;—— ЦВЕТА ДЛЯ РЕЖИМА НАСТРОЕК (Colors for Settings mode) ————————————————————————————————————————
    ; Цвет текста настраиваемых параметров для режима настройки (Text color for Settings mode):
    DayStartColor=#SettingsOnFontColorOn#
    DayEndColor=#SettingsOnFontColorOn#
    ColorSeparator_1_Marker=216,111,55,255
    ColorSeparator_2_Marker=216,111,55,255

;—— ЦВЕТА ПАНЕЛИ НАСТРОЙКИ ТЕМЫ (Colors Settings Theme Panel) —————————————————————————————————————————————
    ;ColorSettingsPanelBG=45,45,45,255
    OmniCal_Color_Setings_FontColor=200,200,200,255

]]

-- Дефолтная светлая тема (Default Light Theme)
local DEFAULT_THEME_LIGHT = [[; Variables_Theme_Light.ini
; UTF-8 without BOM (!!!) (UTF‑8 без BOM)
; Цвета светлой темы (Colors of the light theme)
; (NB!) Формат комментариев: Коментарий по-русски (Comment in english)

[Variables]

;—— СЕТКА ВРЕМЕНИ (Time grid) ——————————————————————————————————————————————————————————————————————
    ; Цвет фона сетки (Background color of the grid):
    ; число_1,число_2,число_3,число_4 (number_1,number_2,number_3,number_4)
    ; число_4 - прозрачность (number_4 - transparency)
    ColorBg=245,245,245,255

    ; Цвета линий сетки (Grid line colors):
    ColorLineH0=10,10,10,255
    ; Линия часа (Hour line):
    ColorLineH1=80,80,80,255
    ; Линия получаса (Half-hour line):
    ColorLineH2=150,150,150,255
    ; Вертикальные линии (Vertical lines):
    ColorLineVertH1=150,150,150,255


    ; Цвет заголовка с днями недели (Color of the header with days of the week):
    ColorTxtH1=60,60,60,255

    ; Цвет заголовка выходного дня (Color of the weekend header):
    ColorTxtH1_Weekend=54,163,217,255
    
    ; Цвет подписей времени (Color of time labels):
    ColorTtmeTxt=120,120,120,255
    
    ; Разделитель 1  (Separator 1)
    ColorSeparator_1=90,90,90,255

    ; Разделитель 2 (Separator 2)
    ColorSeparator_2=90,90,90,255


;—— ФОН ДЛЯ ДНЕВНОГО ВРЕМЕНИ В СУТКАХ (Background for daytime hours) ———————————————————————————————
    ; Цвет фона для дневного времени в сутках (Background color for daytime hours):
    ColorTimeZone_1=210,210,210,255
    ColorTimeZone_2=73,117,128,21
    ColorTimeZone_3=50,100,100,100
    
;—— Линия текущего времени (Current time line) —————————————————————————————————————————————————————
    ; Цвет линии текущего времени (Color of the current time line):
    ColorCurrTime=236,92,48,200
    
    ; Толщина линии текущего времени (Thickness of the current time line):
    Line_CurrTimeWeight=1

;—— СОБЫТИЕ (Event) GoogleCalendar1 ————————————————————————————————————————————————————————————————
    ; Оформление события для 1-го календаря (Event styling for the 1st calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_1_Bg=23,115,237,150
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_1_Bg_Faded=68,111,168,150

    ; Рамка события (Event border):
    Cal_1_StrokeWidth=0
    ; Цвет рамки события (Event border color):
    Cal_1_StrokeColor=10,10,10,255

    ; Цвет текста события для Календаря 1 (Event text color for Calendar 1):
    Cal_1_ColorTxtEvent=30,30,30,255
    ; Выцветший цвет текста для прошедших событий Календаря 1 (Faded text color for past events of Calendar 1):
    Cal_1_ColorTxtEventFaded=80,80,80,255

;—— СОБЫТИЕ (Event) GoogleCalendar2 ————————————————————————————————————————————————————————————————
    ; Оформление события для 2-го календаря (Event styling for the 2nd calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_2_Bg=33,150,243,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_2_Bg_Faded=50,70,86,100

    ; Цвет текста события для Календаря 2 (Event text color for Calendar 2):
    Cal_2_ColorTxtEvent=30,30,30,255
    ; Выцветший цвет текста для прошедших событий Календаря 2 (Faded text color for past events of Calendar 2):
    Cal_2_ColorTxtEventFaded=80,80,80,255

;—— СОБЫТИЕ (Event) GoogleCalendar3 ————————————————————————————————————————————————————————————————
    ; Оформление события для 3-го календаря (Event styling for the 3rd calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_3_Bg=33,150,243,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_3_Bg_Faded=50,70,86,100

    ; Цвет текста события для Календаря 3 (Event text color for Calendar 3):
    Cal_3_ColorTxtEvent=30,30,30,255
    ; Выцветший цвет текста для прошедших событий Календаря 3 (Faded text color for past events of Calendar 3):
    Cal_3_ColorTxtEventFaded=80,80,80,255

;—— СОБЫТИЕ (Event) iCalendar 4 ————————————————————————————————————————————————————————————————
    ; Оформление события для 4-го календаря (Event styling for the 4th calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_4_Bg=133,50,243,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_4_Bg_Faded=133,50,243,30

    ; Цвет текста события для Календаря 4 (Event text color for Calendar 4):
    Cal_4_ColorTxtEvent=30,30,30,255
    ; Выцветший цвет текста для прошедших событий Календаря 4 (Faded text color for past events of Calendar 4):
    Cal_4_ColorTxtEventFaded=80,80,80,255
    
;—— СОБЫТИЕ (Event) iCalendar 5 ————————————————————————————————————————————————————————————————
    ; Оформление события для 5-го календаря (Event styling for the 5th calendar):
    ; Цвет фона для событий (Background color for events):
    Cal_5_Bg=150,150,150,100
    ; "Выцведший" вариант цвета фона для прошедших событий (Faded background color variant for past events):
    Cal_5_Bg_Faded=150,150,150,30

    ; Цвет текста события для Календаря 5 (Event text color for Calendar 5):
    Cal_5_ColorTxtEvent=30,30,30,255
    ; Выцветший цвет текста для прошедших событий Календаря 5 (Faded text color for past events of Calendar 5):
    Cal_5_ColorTxtEventFaded=80,80,80,255


;—— ВСПЛЫВАЮЩИЕ ПОДСКАЗКИ (Tooltips) —————————————————————————————————————————————————————————————
    ; Цвет текста всплывающей подсказки индикатора (Text color of the indicator tooltip):
    FontColorTooltipIndicator=60,60,60,255
    ; Фон всплывающей подсказки (Tooltip background):
    TooltipBGstr=240

;—— КНОПКА НАСТРОЕК (Settings button) —————————————————————————————————————————————————————————————
    ; Цвет кнопки Настройки при выключенном режиме настройки (Color of the Settings button when Settings mode is off):
    SettingsFontColorOff=100,100,100,80
    SettingsFontColorOn=60,60,60,220
    ; Цвет кнопки Настройки при включенном режиме настройки (Color of the Settings button when Settings mode is on):
    SettingsOnFontColorOff=0,120,212,180
    SettingsOnFontColorOn=0,120,212,255

    ; Цвет текста всплывающей подсказки при наведении на кнопку настроек (Tooltip text color when hovering over settings button):
    SettingsTxtFontColor=33,33,33,255
    ; Фон всплывающей подсказки при наведении на кнопку настроек (Tooltip background when hovering over settings button):
    SettingsTxtBG=193,193,193,255
    ; Цвет рамки всплывающей подсказки при наведении на кнопку настроек (Border color of the tooltip when hovering over settings button):
    SettingsBGStrokeColor=50,50,50,255

    ; Панель настроек (Settings panel)
    ; Фон панели настроек (Background of the settings panel):
    SettingsPanelBG=50,50,50,255
    ; Цвет рамки панели настроек (Border color of the settings panel):
    SettingsPanelStrokeColor=0,0,0,255
    ; Цвет текста на панели настроек (Text color on the settings panel):
    SettingsPanelTxtFontColor=200,200,200,255
    SettingsPanelTxtFontColorHLt=235,235,235,255

;—— ОКНО ВВОДА (Input window) —————————————————————————————————————————————————————————————————————
    ; Цвет текста окна ввода (для режима Настройки) (Text color of the input window (for Settings mode)):
    ColorInputTxt=30,30,30,255
    ; Цвет фона ввода при включенном режиме настройки (Input background color when Settings mode is on):
    SettingsInputBGColor=35,35,35,255
    
;—— ЦВЕТА ДЛЯ РЕЖИМА НАСТРОЕК (Colors for Settings mode) ————————————————————————————————————————
    ; Цвет текста настраиваемых параметров для режима настройки (Text color for Settings mode):
    DayStartColor=#SettingsOnFontColorOn#
    DayEndColor=#SettingsOnFontColorOn#
    ColorSeparator_1_Marker=216,111,55,255
    ColorSeparator_2_Marker=216,111,55,255

;—— ЦВЕТА ПАНЕЛИ НАСТРОЙКИ ТЕМЫ (Colors Settings Theme Panel) —————————————————————————————————————————————
    ;ColorSettingsPanelBG=45,45,45,255
    OmniCal_Color_Setings_FontColor=200,200,200,255

]]

-- Функция для полной замены содержимого INI-файла (Function to completely replace INI file content)
-- @param filePath: путь к файлу (поддерживает #переменные#) (file path, supports #variables#)
-- @param iniContent: полное содержимое INI-файла в виде строки (complete INI file content as string)
-- @return: true при успехе, false при ошибке (true on success, false on error)
function ReplaceIniFile(filePath, iniContent)
    -- Обработать Rainmeter-переменные в пути (Process Rainmeter variables in path)
    local resolvedPath = SKIN:ReplaceVariables(filePath)
    
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~ThemeReset: ReplaceIniFile() | Resolved path: " .. resolvedPath)
    end
    
    -- Открыть файл для записи в бинарном режиме (UTF-8 без BOM) (Open file for writing in binary mode - UTF-8 without BOM)
    local file, err = io.open(resolvedPath, "wb")
    if not file then
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~ThemeReset: ReplaceIniFile() | ERROR: Cannot open file - " .. tostring(err))
        end
        return false
    end
    
    -- Записать содержимое (Write content)
    local success, writeErr = pcall(function()
        file:write(iniContent)
    end)
    
    file:close()
    
    if not success then
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~ThemeReset: ReplaceIniFile() | ERROR: Write failed - " .. tostring(writeErr))
        end
        return false
    end
    
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~ThemeReset: ReplaceIniFile() | Success: File replaced")
    end
    
    return true
end

-- Функция сброса темы к настройкам по умолчанию (Function to reset theme to default settings)
function ResetThemeToDefault()
    local currentTheme = SKIN:GetVariable('Theme', 'Dark')
    local themeFile = '#@#Variables_Theme_' .. currentTheme .. '.ini'
    
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~ThemeReset: ResetThemeToDefault() | Current theme: " .. currentTheme)
    end
    
    -- Выбрать дефолтный блок (Select default block)
    local defaultContent = (currentTheme == 'Dark') and DEFAULT_THEME_DARK or DEFAULT_THEME_LIGHT
    
    -- Заменить файл темы (Replace theme file)
    local success = ReplaceIniFile(themeFile, defaultContent)
    
    if success then
        -- Установить триггер перезагрузки темы в основном скине (Set theme reload trigger in main skin)
        SKIN:Bang('!SetVariable', 'ReloadTheme', '1', 'GoogleCalendar')
        
        -- Показать уведомление об успехе (Show success notification)
        ShowNotification(true)
        
        -- Обновить панель настроек цвета (Refresh color settings panel)
        SKIN:Bang('!Refresh')
        
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~ThemeReset: ResetThemeToDefault() | Theme reset to default: " .. currentTheme)
        end
    else
        -- Показать уведомление об ошибке (Show error notification)
        ShowNotification(false)
        
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~ThemeReset: ResetThemeToDefault() | ERROR: Failed to reset theme")
        end
    end
end

-- Тестовая функция для проверки ошибки (Test function to check error handling)
-- ВРЕМЕННАЯ! Удалить или закоментировать после тестирования! (TEMPORARY! Remove or coment after testing!)
-- Тестовый вызов из [Row_12_Col_2_Rectangle] (OmniCal_Color\OmniCal_Color_Setings.ini) 
-- (Test call from [Row_12_Col_2_Rectangle] (OmniCal_Color\OmniCal_Color_Setings.ini))
-- function TestError()
--     ShowNotification(false)
-- end


function ShowNotification(success)
    -- Записать состояние видимости сервисного уведомления в INI (Write service notification visibility state to INI)
    SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHidden', '0', '#@#Variables_ColorSettings.ini')
    if success then
        -- Записать состояние видимости сервисного уведомления в INI (Write service notification visibility state to INI)
        SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHiddenSuccess', '0', '#@#Variables_ColorSettings.ini')
        SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisRectBG', '177,83,17', '#@#Variables_ColorSettings.ini')
        
        -- Показать текст успеха (Show success text)
        SKIN:Bang('!SetOption', 'ServTooltips_Text_Success', 'Hidden', '0')
    else
        -- Записать состояние видимости сервисного уведомления в INI (Write service notification visibility state to INI)
        SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHiddenErr', '0', '#@#Variables_ColorSettings.ini')
        SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisRectBG', '157,56,56', '#@#Variables_ColorSettings.ini')

        -- Показать текст ошибки (Show error text)
        SKIN:Bang('!SetOption', 'ServTooltips_Text_Err', 'Hidden', '0')
    end

    -- Показать фон уведомления (Show notification background)
    SKIN:Bang('!SetOption', 'ServTooltips_Rectangle', 'Hidden', '0')

    -- Показать кнопку Ok (Show Ok button)
    SKIN:Bang('!SetOption', 'ServTooltips_RectangleOk', 'Hidden', '0')
    SKIN:Bang('!SetOption', 'Tooltips_Text_Ok', 'Hidden', '0')
    
    -- Обновить метры и перерисовать скин (Update meters and redraw skin)
    SKIN:Bang('!UpdateMeter', '*')
    SKIN:Bang('!Redraw')
end


-- Функция скрытия уведомления (Function to hide notification)
function HideNotification()
    -- Записать состояние скрытия сервисного уведомления в INI (Write service notification hidden state to INI)
    SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHiddenSuccess', '1', '#@#Variables_ColorSettings.ini')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHiddenErr', '1', '#@#Variables_ColorSettings.ini')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHidden', '1', '#@#Variables_ColorSettings.ini')
    
    -- Скрыть фон уведомления (Hide notification background)
    SKIN:Bang('!SetOption', 'ServTooltips_Rectangle', 'Hidden', '1')
    
    -- Скрыть оба текста уведомления (Hide both notification texts)
    SKIN:Bang('!SetOption', 'ServTooltips_Text_Success', 'Hidden', '1')
    SKIN:Bang('!SetOption', 'ServTooltips_Text_Err', 'Hidden', '1')
    
    -- Скрыть индикатор (Hide indicator)
    SKIN:Bang('!SetOption', 'ServTooltips_RectangleOk', 'Hidden', '1')
    SKIN:Bang('!SetOption', 'Tooltips_Text_Ok', 'Hidden', '1')
    
    -- Обновить метры и перерисовать скин (Update meters and redraw skin)
    SKIN:Bang('!UpdateMeter', '*')
    SKIN:Bang('!Redraw')
end