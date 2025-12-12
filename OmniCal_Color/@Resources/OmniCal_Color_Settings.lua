-- OmniCal_Color_Settings.lua
-- Скрипт для обработки пользовательских вводов в панели настроек цветов
-- (Script for handling user inputs in the color settings panel)

-- Отладка:
    -- if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent() | HandleInputFontSizeEvent called with input: " .. tostring(input))
    -- if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
    --     print("~~~~~~OCS: OmniCal_Color_Settings.lua initialized")
    -- end

function Initialize()
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~OCS: OmniCal_Color_Settings.lua initialized")
    end
    --Отключаем подсказки СЕРВИС при запуске панели настроек цвета (Disable SERVICE tooltips on color settings panel init)
    SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHiddenSuccess', '1', '#@#Variables_ColorSettings.ini')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHiddenErr', '1', '#@#Variables_ColorSettings.ini')
    SKIN:Bang('!WriteKeyValue', 'Variables', 'ServisHidden', '1', '#@#Variables_ColorSettings.ini')
end

-- Функция для обработки ввода FontSizeEvent ~ (Function to handle FontSizeEvent input)
function HandleInputFontSizeEvent()
    -- Читаем введённое значение из временной переменной ~ (Read input value from temp variable)
    local input = SKIN:GetVariable('TempInputFontSize', '')
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent() | HandleInputFontSizeEvent called with input: " .. tostring(input))
    end
    -- Преобразуем в число ~ (Convert to number)
    local fontSize = tonumber(input)
    
    -- Валидация: размер шрифта должен быть целым числом от 6 до 20 ~ (Validation: font size must be integer between 6 and 20)
    if not fontSize then
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent() | ERROR: Invalid input - not a number")
        end
        return
    end
    
    if fontSize < 6 or fontSize > 20 then
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent() | ERROR: Font size out of range (6-20)")
        end
        return
    end
    
    if math.floor(fontSize) ~= fontSize then
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent() | ERROR: Font size must be an integer")
        end
        return
    end
    
    -- Получаем путь к Variables.ini ~ (Get path to Variables.ini)
    local variablesPath = SKIN:ReplaceVariables('#@#Variables.ini')
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent() | Writing FontSizeEvent=" .. fontSize .. " to " .. variablesPath)
    end

    -- Записываем в файл ~ (Write to file)
    SKIN:Bang('!WriteKeyValue', 'Variables', 'FontSizeEvent', tostring(fontSize), '#@#Variables.ini')
    
    -- Обновляем переменную в текущем скине ~ (Update variable in current skin)
    SKIN:Bang('!SetVariable', 'FontSizeEvent', tostring(fontSize))
    
    -- Обновляем отображение ~ (Update display)
    SKIN:Bang('!UpdateMeter', 'FontSizeEvent_Input_Label')
    SKIN:Bang('!Redraw')
    
    -- Обновляем переменную в основном скине ~ (Update variable in main skin)
    SKIN:Bang('!SetVariable', 'FontSizeEvent', tostring(fontSize), 'GoogleCalendar')
    
    -- Перерендерим события через Lua ~ (Re-render events via Lua)
    -- SKIN:Bang('!CommandMeasure', 'OmniCal_Events_Renderer_lua', 'Process()', 'GoogleCalendar')
    -- выдает ошибку
    -- все работает и без этого

    
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent() | FontSizeEvent updated succesOCSully to: " .. fontSize)
    end

end

-- Функция для обработки ввода FontSizeEvent_Faded ~ (Function to handle FontSizeEvent_Faded input)
function HandleInputFontSizeEvent_Faded()
    -- Читаем введённое значение из временной переменной ~ (Read input value from temp variable)
    local input = SKIN:GetVariable('TempInputFontSizeFaded', '')
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent_Faded() | Called with input: " .. tostring(input))
    end
    
    -- Преобразуем в число ~ (Convert to number)
    local fontSize = tonumber(input)
    
    -- Валидация: размер шрифта должен быть целым числом от 6 до 20 ~ (Validation: font size must be integer between 6 and 20)
    if not fontSize then
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent_Faded() | ERROR: Invalid input - not a number")
        end
        return
    end
    
    if fontSize < 6 or fontSize > 20 then
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent_Faded() | ERROR: Font size out of range (6-20)")
        end
        return
    end
    
    if math.floor(fontSize) ~= fontSize then
        if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
            print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent_Faded() | ERROR: Font size must be an integer")
        end
        return
    end
    
    -- Получаем путь к Variables.ini ~ (Get path to Variables.ini)
    local variablesPath = SKIN:ReplaceVariables('#@#Variables.ini')
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent_Faded() | Writing FontSizeEvent_Faded=" .. fontSize .. " to " .. variablesPath)
    end

    -- Записываем в файл ~ (Write to file)
    SKIN:Bang('!WriteKeyValue', 'Variables', 'FontSizeEvent_Faded', tostring(fontSize), '#@#Variables.ini')
    
    -- Обновляем переменную в текущем скине ~ (Update variable in current skin)
    SKIN:Bang('!SetVariable', 'FontSizeEvent_Faded', tostring(fontSize))
    
    -- Обновляем отображение ~ (Update display)
    SKIN:Bang('!UpdateMeter', 'FontSizeEventFaded_Input_Label')
    SKIN:Bang('!Redraw')
    
    -- Обновляем переменную в основном скине ~ (Update variable in main skin)
    SKIN:Bang('!SetVariable', 'FontSizeEvent_Faded', tostring(fontSize), 'GoogleCalendar')
    
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~OCS: OmniCal_Color_Settings.lua | HandleInputFontSizeEvent_Faded() | FontSizeEvent_Faded updated successfully to: " .. fontSize)
    end

end


    -- Группа: [ Настройки скина / Календари ]
    -- Функция для переключения применения встроенного цвета события для Календаря 1 (Toggle embedded event color for Calendar 1)
    function Toggle_ApplyEmbeddedBGcolorCal_1()
        local currentValue = SKIN:GetVariable('applyEmbeddedBGcolorCal_1') or '0'
        local newValue = (currentValue == '1') and '0' or '1'
        
        -- Записать новое значение в файл Variables.ini (Write new value to Variables.ini)
        SKIN:Bang('!WriteKeyValue Variables applyEmbeddedBGcolorCal_1 "' .. newValue .. '" "#@#Variables.ini"')
        
        -- Обновить переменную в текущем скине (Update variable in current skin)
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_1 "' .. newValue .. '"')
        
        -- Обновить переменную в основном скине (Update variable in main skin)
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_1 "' .. newValue .. '" GoogleCalendar')

        -- Обновить изображение кнопки в панели настроек цвета (Update button image in color settings panel)
        SKIN:Bang('!SetOption EventButton_1 ButtonImage "#@#Images\\\\switch_' .. newValue .. '.png"')
        SKIN:Bang('!UpdateMeter EventButton_1')

        -- Перерендерить события для применения изменений (Re-render events to apply changes)
        SKIN:Bang('!CommandMeasure OmniCal_Events_lua "MeterGroup()" GoogleCalendar')
        
        -- Обновить время последнего действия (Update last action time)
        LastActionTime = os.time()
        
        -- Перерисовать скин (Redraw skin)
        SKIN:Bang('!Redraw')
    end

    -- Функция для переключения применения встроенного цвета события для Календаря 2 (Toggle embedded event color for Calendar 2)
    function Toggle_ApplyEmbeddedBGcolorCal_2()
        local currentValue = SKIN:GetVariable('applyEmbeddedBGcolorCal_2') or '0'
        local newValue = (currentValue == '1') and '0' or '1'
        
        SKIN:Bang('!WriteKeyValue Variables applyEmbeddedBGcolorCal_2 "' .. newValue .. '" "#@#Variables.ini"')
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_2 "' .. newValue .. '"')
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_2 "' .. newValue .. '" GoogleCalendar')
        SKIN:Bang('!SetOption EventButton_2 ButtonImage "#@#Images\\\\switch_' .. newValue .. '.png"')
        SKIN:Bang('!UpdateMeter EventButton_2')
        
        SKIN:Bang('!CommandMeasure OmniCal_Events_lua "MeterGroup()" GoogleCalendar')
        LastActionTime = os.time()
        SKIN:Bang('!Redraw')
    end

    -- Функция для переключения применения встроенного цвета события для Календаря 3 (Toggle embedded event color for Calendar 3)
    function Toggle_ApplyEmbeddedBGcolorCal_3()
        local currentValue = SKIN:GetVariable('applyEmbeddedBGcolorCal_3') or '0'
        local newValue = (currentValue == '1') and '0' or '1'
        
        SKIN:Bang('!WriteKeyValue Variables applyEmbeddedBGcolorCal_3 "' .. newValue .. '" "#@#Variables.ini"')
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_3 "' .. newValue .. '"')
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_3 "' .. newValue .. '" GoogleCalendar')
        SKIN:Bang('!SetOption EventButton_3 ButtonImage "#@#Images\\\\switch_' .. newValue .. '.png"')
        SKIN:Bang('!UpdateMeter EventButton_3')
        
        SKIN:Bang('!CommandMeasure OmniCal_Events_lua "MeterGroup()" GoogleCalendar')
        LastActionTime = os.time()
        SKIN:Bang('!Redraw')
    end

    -- Функция для переключения применения встроенного цвета события для Календаря 4 (Toggle embedded event color for Calendar 4)
    function Toggle_ApplyEmbeddedBGcolorCal_4()
        local currentValue = SKIN:GetVariable('applyEmbeddedBGcolorCal_4') or '0'
        local newValue = (currentValue == '1') and '0' or '1'
        
        SKIN:Bang('!WriteKeyValue Variables applyEmbeddedBGcolorCal_4 "' .. newValue .. '" "#@#Variables.ini"')
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_4 "' .. newValue .. '"')
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_4 "' .. newValue .. '" GoogleCalendar')
        SKIN:Bang('!SetOption EventButton_4 ButtonImage "#@#Images\\\\switch_' .. newValue .. '.png"')
        SKIN:Bang('!UpdateMeter EventButton_4')
        
        SKIN:Bang('!CommandMeasure OmniCal_Events_lua "MeterGroup()" GoogleCalendar')
        LastActionTime = os.time()
        SKIN:Bang('!Redraw')
    end

    -- Функция для переключения применения встроенного цвета события для Календаря 5 (Toggle embedded event color for Calendar 5)
    function Toggle_ApplyEmbeddedBGcolorCal_5()
        local currentValue = SKIN:GetVariable('applyEmbeddedBGcolorCal_5') or '0'
        local newValue = (currentValue == '1') and '0' or '1'
        
        SKIN:Bang('!WriteKeyValue Variables applyEmbeddedBGcolorCal_5 "' .. newValue .. '" "#@#Variables.ini"')
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_5 "' .. newValue .. '"')
        SKIN:Bang('!SetVariable applyEmbeddedBGcolorCal_5 "' .. newValue .. '" GoogleCalendar')
        SKIN:Bang('!SetOption EventButton_5 ButtonImage "#@#Images\\\\switch_' .. newValue .. '.png"')
        SKIN:Bang('!UpdateMeter EventButton_5')
        
        SKIN:Bang('!CommandMeasure OmniCal_Events_lua "MeterGroup()" GoogleCalendar')
        LastActionTime = os.time()
        SKIN:Bang('!Redraw')
    end

    
-- Группа: [ Настройки скина / Тема ]
-- Функция для переключения темы из панели настроек цвета (Toggle theme from color settings panel)
function Toggle_Theme_FromColorSettings()
    -- Получить текущее значение темы (Get current theme value)
    local currentTheme = SKIN:GetVariable('Theme', 'Dark')
    
    -- Переключить на противоположное значение (Toggle to opposite value)
    local newTheme = (currentTheme == 'Dark') and 'Light' or 'Dark'
    
    -- Записать новое значение в Variables.ini (Write new value to Variables.ini)
    SKIN:Bang('!WriteKeyValue', 'Variables', 'Theme', newTheme, '#@#Variables.ini')
    
    -- Обновить переменную в текущем скине (Update variable in current skin)
    SKIN:Bang('!SetVariable', 'Theme', newTheme)
    
    -- Обновить переменную в основном скине (Update variable in main skin)
    SKIN:Bang('!SetVariable', 'Theme', newTheme, 'GoogleCalendar')
    
    -- Обновить отображение темы в панели (Update theme display in panel)
    SKIN:Bang('!UpdateMeter', 'Theme_mode')
    
    -- Перезагрузить панель настроек цвета для применения новой темы (Refresh color settings panel to apply new theme)
    SKIN:Bang('!Refresh')
    
    if tonumber(SKIN:GetVariable('DebugMode_ColorSettings')) == 1 then 
        print("~~~~~~OCS: Theme switched from " .. currentTheme .. " to " .. newTheme)
    end
end