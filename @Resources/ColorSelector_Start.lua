-- ColorSelector_Start.lua
-- Скрипт для инициализации ColorSelector и управления цветами
-- Включает функции для запуска, подтверждения, отмены и Live Preview

function Initialize(variableName)
    -- Если функция вызвана без параметра (автоматически при загрузке скрипта), ничего не делаем
    -- (If function called without parameter (automatically on script load), do nothing)
    if not variableName or variableName == "" then
        -- Это нормально при загрузке скрипта Rainmeter (This is normal when Rainmeter loads the script)
        -- print("ColorSelector_Start.lua Error: Variable name not provided")
        return
    end

    -- Формируем строку с именем переменной в формате Rainmeter
    local csnValue = "#*" .. variableName .. "*#"

    -- Записываем CSN в ColorSelectorVariables.inc ColorSelector
    SKIN:Bang('!WriteKeyValue', 'Variables', 'CSN', csnValue, '#ROOTCONFIGPATH#\\ColorSelector\\@Resources\\ColorSelectorVariables.inc')

    -- Также устанавливаем CSN как переменную скина для немедленного доступа
    SKIN:Bang('!SetVariable', 'CSN', csnValue)

    print("ColorSelector initialized with variable: " .. variableName)
    print("CSN set to: " .. csnValue)
end

-- Функция для запуска ColorSelector с заданной переменной
function StartColorSelector(variableName, initialColor)
    -- Сначала инициализируем CSN
    Initialize(variableName)

    -- Если передан начальный цвет, записываем его
    if initialColor and initialColor ~= "" then
        SKIN:Bang('!WriteKeyValue', 'Variables', 'RGBA', initialColor, '#ROOTCONFIGPATH#\\ColorSelector\\@Resources\\ColorSelectorVariables.inc')
    end

    -- Деактивируем текущий ColorSelector (если открыт)
    SKIN:Bang('!DeactivateConfig', '#ROOTCONFIG#\\ColorSelector', 'ColorSelector.ini')

    -- Активируем ColorSelector
    SKIN:Bang('!ActivateConfig', '#ROOTCONFIG#\\ColorSelector', 'ColorSelector.ini')
end


-- Функция для чтения цвета из файла темы
function GetColorFromThemeFile(variableName)
    print("==== Start:GetColorFromThemeFile(" .. variableName .. ")")

    -- Получаем путь к файлу цветовой темы
    local colorThemePath = GetColorThemePath()
    if not colorThemePath then
        print("ERROR: ColorThemePath not found")
        return "131,134,135,255"  -- Возвращаем дефолтный цвет при ошибке
    end

    -- Преобразуем путь Rainmeter в реальный путь к файлу
    local realPath = colorThemePath:gsub("#ROOTCONFIGPATH#", SKIN:GetVariable('ROOTCONFIGPATH'))
    realPath = realPath:gsub("#@#", SKIN:GetVariable('ROOTCONFIGPATH') .. "\\@Resources")
    realPath = realPath:gsub("/", "\\")

    print("Real theme file path: " .. realPath)

    -- Читаем файл темы
    local file = io.open(realPath, 'r')
    if not file then
        print("ERROR: Cannot open theme file: " .. realPath)
        return "131,134,135,255"  -- Возвращаем дефолтный цвет при ошибке
    end

    local content = file:read('*a')
    file:close()
    print("Theme file read successfully")

    -- Ищем переменную в файле
    for line in content:gmatch("[^\r\n]+") do
        if line:match("^%s*" .. variableName .. "=") then
            local colorValue = line:match(variableName .. "=(.+)")
            print("Found color for " .. variableName .. ": " .. tostring(colorValue))
            return colorValue
        end
    end

    print("Color variable " .. variableName .. " not found in theme file")
    return "131,134,135,255"  -- Возвращаем дефолтный цвет если переменная не найдена
end

-- Универсальная функция для запуска с любой переменной
function StartWith(variableName, tooltipText)
    -- Проверяем, что передано имя переменной
    if not variableName or variableName == "" then
        print("Error: Variable name not provided to StartWith()")
        return
    end

    -- Получаем значение переменной из файла темы, а не из текущего скина
    local initialColor = GetColorFromThemeFile(variableName)

    -- Сохраняем текст подсказки в переменную ColorSelector (Saving tooltip text to ColorSelector variable)
    if tooltipText and tooltipText ~= "" then
        SKIN:Bang('!WriteKeyValue', 'Variables', 'ColorTooltip', tooltipText, '#ROOTCONFIGPATH#\\ColorSelector\\@Resources\\ColorSelectorVariables.inc')
        print("Tooltip text saved: " .. tooltipText)
    else
        -- Если подсказка не передана, сохраняем имя переменной (If no tooltip provided, save variable name)
        SKIN:Bang('!WriteKeyValue', 'Variables', 'ColorTooltip', variableName, '#ROOTCONFIGPATH#\\ColorSelector\\@Resources\\ColorSelectorVariables.inc')
        print("No tooltip provided, using variable name: " .. variableName)
    end

    -- Запускаем ColorSelector с полученными параметрами
    StartColorSelector(variableName, initialColor)
end

-- Вспомогательная функция для чтения CSN из файла
function GetVariableNameFromCSN()
    -- Сначала пробуем прочитать CSN из памяти скина
    local csn = SKIN:GetVariable("CSN")
    
    print("Debug: Raw CSN value from skin = '" .. tostring(csn) .. "'")
    
    -- Если не нашли в памяти, пробуем прочитать из файла напрямую
    if not csn or csn == "" then
        print("Debug: CSN not in skin memory, trying to read from file...")
        
        -- Создаем временную переменную для чтения из файла
        SKIN:Bang('!SetVariable', 'TempCSN', '[#ROOTCONFIGPATH#\\ColorSelector\\@Resources\\ColorSelectorVariables.inc:Variables:CSN]')
        csn = SKIN:GetVariable("TempCSN")
        
        print("Debug: CSN from file = '" .. tostring(csn) .. "'")
    end
    
    if not csn or csn == "" then
        print("Error: CSN not found")
        return nil
    end
    
    -- Извлекаем имя переменной из формата #*VariableName*#
    local varName = csn:match("#%*(.-)%*#")
    
    print("Debug: Extracted variable name = '" .. tostring(varName) .. "'")
    
    if not varName then
        print("Error: Could not extract variable name from CSN: " .. csn)
        -- Попробуем другой паттерн на случай, если формат другой
        varName = csn:match("#(.*)#")
        if varName then
            print("Debug: Alternative extraction successful: '" .. varName .. "'")
        end
    end
    
    return varName
end

-- Функция для подтверждения выбранного цвета
function ConfirmColor()
    print("==== Start:ConfirmColor()")

    -- Получаем путь к файлу цветовой темы
    local colorThemePath = GetColorThemePath()
    if colorThemePath then
        print("+++++++++++++ColorThemePath from ConfirmColor: " .. colorThemePath)
        -- Используем colorThemePath
    else
        print("+++++++++++++ColorThemePath not found")
    end
    
    
    -- Получаем имя переменной через вспомогательную функцию
    local varName = GetVariableNameFromCSN()
    if not varName then
        print("==== Error: Failed to get variable name from CSN")
        return
    end

    -- Получаем текущий цвет из RGBA
    local rgba = SKIN:GetVariable("RGBA")
    print("Debug: RGBA value = '" .. tostring(rgba) .. "'")

    -- Записываем новый цвет в основной Variables.inc
    SKIN:Bang('!WriteKeyValue', 'Variables', varName, rgba, colorThemePath)

    -- Сохраняем цвет как OldColor для возможности отката
    SKIN:Bang('!SetVariable', 'OldColor', rgba)

    -- Обновляем отображение старого цвета
    SKIN:Bang('!UpdateMeter', 'MeterOldColor')

    -- Специальная обработка для ColorTtmeTxt: обновляем FontColor всех Time_N метров
    -- Почему: В OmniCal_Skin.lua функции вроде UpdateSettingsMarkers, Toggle_SettingsOn и другие устанавливают FontColor статически через !SetOption,
    -- что переопределяет DynamicVariables=1 из OmniCal.ini и блокирует автоматическое обновление цветов при изменении переменных.
    -- Зачем: Чтобы Live Preview работал для Time метров (ColorTtmeTxt), ColorSelector должен явно устанавливать цвета через Bang,
    -- синхронизируя их с изменениями в ColorSelector, даже если Lua ранее установил статические цвета.
    -- Как: Обновляем все метры от Time_00 до Time_48 (максимум возможных метров времени, включая психологический режим).
    if varName == 'ColorTtmeTxt' then
        -- Обновляем все метры времени от 0 до 48 (Update all time meters from 0 to 48)
        for idx = 0, 48 do
            local meterName = string.format('Time_%02d', idx)
            SKIN:Bang('!SetOption', meterName, 'FontColor', '#' .. varName .. '#', '#ROOTCONFIG#')
            SKIN:Bang('!UpdateMeter', meterName, '#ROOTCONFIG#')
        end
        SKIN:Bang('!Redraw', '#ROOTCONFIG#')
    end

    print("==== Success: Color confirmed: " .. varName .. " = " .. rgba)
end

-- Функция для отмены изменений цвета
function RevertColor()

    -- Получаем путь к файлу цветовой темы
    local colorThemePath = GetColorThemePath()
    if colorThemePath then
        print("+++++++++++++ColorThemePath from ConfirmColor: " .. colorThemePath)
        -- Используем colorThemePath
    else
        print("+++++++++++++ColorThemePath not found")
    end

    -- Получаем имя переменной через вспомогательную функцию
    local varName = GetVariableNameFromCSN()
    if not varName then
        return
    end

    -- Получаем старый цвет
    local oldColor = SKIN:GetVariable("OldColor")

    -- Записываем старый цвет обратно в основной Variables.inc
    SKIN:Bang('!WriteKeyValue', 'Variables', varName, oldColor, colorThemePath)

    -- Восстанавливаем RGBA к старому цвету
    SKIN:Bang('!SetVariable', 'RGBA', oldColor)

    -- Инициализируем конвертацию для обновления всех значений
    SKIN:Bang('!SetVariable', 'Convert', 'INITIALIZE')
    SKIN:Bang('!CommandMeasure', 'ConvertColors', 'Update()')

    print("Color reverted: " .. varName .. " = " .. oldColor)
end

-- Функция для Live Preview - применение цвета (аналог IfFalseAction)
function ApplyLivePreviewColor()

    -- Получаем путь к файлу цветовой темы
    local colorThemePath = GetColorThemePath()
    if colorThemePath then
        print("+++++++++++++ColorThemePath from ConfirmColor: " .. colorThemePath)
        -- Используем colorThemePath
    else
        print("+++++++++++++ColorThemePath not found")
    end

    -- Получаем имя переменной через вспомогательную функцию
    local varName = GetVariableNameFromCSN()
    if not varName then
        return
    end

    -- Получаем текущий цвет из RGBA
    local rgba = SKIN:GetVariable("RGBA")

    -- Записываем текущий цвет в основной Variables.inc
    SKIN:Bang('!WriteKeyValue', 'Variables', varName, rgba, colorThemePath)

    -- Обновляем отображение предварительного просмотра
    SKIN:Bang('!UpdateMeter', 'MeterLivePreview')
    SKIN:Bang('!UpdateMeter', 'MeterLivePreviewLine')

    -- Обновляем все метры в основном скине и настройках для Live Preview
    SKIN:Bang('!UpdateMeter', '*', '#ROOTCONFIG#')
    SKIN:Bang('!UpdateMeter', '*', '#ROOTCONFIG#\\OmniCal_Color')
    SKIN:Bang('!Redraw', '#ROOTCONFIG#')
    SKIN:Bang('!Redraw', '#ROOTCONFIG#\\OmniCal_Color')

    -- Специальная обработка для ColorTtmeTxt, ColorBg, ColorTimeZone_1, ColorTimeZone_2, ColorTimeZone_3: обновляем соответствующие метры
    -- Почему: В OmniCal_Skin.lua и OmniCal.ini статические установки переопределяют DynamicVariables, блокируя Live Preview.
    -- Зачем: ColorSelector должен явно синхронизировать цвета через Bang для Live Preview.
    -- Как: Обновляем все метры от Time_00 до Time_48 (максимум возможных метров времени, включая психологический режим).
    if varName == 'ColorTtmeTxt' then
        -- Обновляем все метры времени от 0 до 48 (Update all time meters from 0 to 48)
        for idx = 0, 48 do
            local meterName = string.format('Time_%02d', idx)
            SKIN:Bang('!SetOption', meterName, 'FontColor', '#' .. varName .. '#', '#ROOTCONFIG#')
            SKIN:Bang('!UpdateMeter', meterName, '#ROOTCONFIG#')
        end
        SKIN:Bang('!Redraw', '#ROOTCONFIG#')
    end
    -- ColorBg, ColorTimeZone_1, ColorTimeZone_2, ColorTimeZone_3 обновляются автоматически через DynamicVariables, т.к. Shape использует переменные для координат и цветов
    -- (ColorBg, ColorTimeZone_1, ColorTimeZone_2, ColorTimeZone_3 update automatically via DynamicVariables, as Shape uses variables for coordinates and colors)

    print("Live Preview applied: " .. varName .. " = " .. rgba)
end

-- Функция для Live Preview - откат к старому цвету (аналог IfTrueAction)
function RevertLivePreviewColor()

    -- Получаем путь к файлу цветовой темы
    local colorThemePath = GetColorThemePath()
    if colorThemePath then
        print("+++++++++++++ColorThemePath from ConfirmColor: " .. colorThemePath)
        -- Используем colorThemePath
    else
        print("+++++++++++++ColorThemePath not found")
    end

    -- Получаем имя переменной через вспомогательную функцию
    local varName = GetVariableNameFromCSN()
    if not varName then
        return
    end

    -- Получаем старый цвет
    local oldColor = SKIN:GetVariable("OldColor")

    -- Записываем старый цвет обратно в основной Variables.inc
    SKIN:Bang('!WriteKeyValue', 'Variables', varName, oldColor, colorThemePath)

    -- Обновляем отображение предварительного просмотра
    SKIN:Bang('!UpdateMeter', 'MeterLivePreview')
    SKIN:Bang('!UpdateMeter', 'MeterLivePreviewLine')

    -- Обновляем все метры в основном скине и настройках для Live Preview
    SKIN:Bang('!UpdateMeter', '*', '#ROOTCONFIG#')
    SKIN:Bang('!UpdateMeter', '*', '#ROOTCONFIG#\\OmniCal_Color')
    SKIN:Bang('!Redraw', '#ROOTCONFIG#')
    SKIN:Bang('!Redraw', '#ROOTCONFIG#\\OmniCal_Color')

    -- Специальная обработка для ColorTtmeTxt: обновляем FontColor всех Time_N метров
    -- Почему: В OmniCal_Skin.lua функции вроде UpdateSettingsMarkers, Toggle_SettingsOn и другие устанавливают FontColor статически через !SetOption,
    -- что переопределяет DynamicVariables=1 из OmniCal.ini и блокирует автоматическое обновление цветов при изменении переменных.
    -- Зачем: Чтобы Live Preview работал для Time метров (ColorTtmeTxt), ColorSelector должен явно устанавливать цвета через Bang,
    -- синхронизируя их с изменениями в ColorSelector, даже если Lua ранее установил статические цвета.
    -- Как: Обновляем все метры от Time_00 до Time_48 (максимум возможных метров времени, включая психологический режим).
    if varName == 'ColorTtmeTxt' then
        -- Обновляем все метры времени от 0 до 48 (Update all time meters from 0 to 48)
        for idx = 0, 48 do
            local meterName = string.format('Time_%02d', idx)
            SKIN:Bang('!SetOption', meterName, 'FontColor', '#' .. varName .. '#', '#ROOTCONFIG#')
            SKIN:Bang('!UpdateMeter', meterName, '#ROOTCONFIG#')
        end
        SKIN:Bang('!Redraw', '#ROOTCONFIG#')
    end

    print("Live Preview reverted: " .. varName .. " = " .. oldColor)
end

-- Тестовая функция для проверки чтения CSN
function TestCSN()
    print("=== Testing CSN reading ===")
    
    local csn = SKIN:GetVariable("CSN")
    print("Raw CSN from skin: '" .. tostring(csn) .. "'")
    
    local varName = GetVariableNameFromCSN()
    print("Extracted variable name: '" .. tostring(varName) .. "'")
    
    print("=== Test completed ===")
end

-- Функция для установки пути к файлу цветовой темы
function SetColorThemePath(pathColorTheme)
    print("====     ========")
    if not pathColorTheme or pathColorTheme == "" then
        print("Error: pathColorTheme is empty or not provided")
        return
    end
    
    print("============Debug: Input pathColorTheme = '" .. pathColorTheme .. "'")
    
    -- Извлекаем имя файла из полного пути
    -- Ищем Variables_Theme_ и берём всё после него
    -- local fileName = pathColorTheme:match("Variables_Theme_.*")
    local fileName = pathColorTheme:match("Variables_Theme_.*"):gsub("\\", "\\\\")
    
    print("Debug: Extracted fileName = '" .. tostring(fileName) .. "'")
    
    -- Формируем правильный путь с переменными Rainmeter
    -- local correctPath = '#ROOTCONFIGPATH#\\@Resources\\' .. fileName
    -- local correctPath = '#ROOTCONFIGPATH#\\@Resources\\' .. fileName
    local correctPath = '#ROOTCONFIGPATH#/@Resources/' .. fileName
    
    print("Debug: Correct path = '" .. correctPath .. "'")
    
    -- Записываем правильный путь в ColorSelectorVariables.inc
    local filePath = SKIN:GetVariable('ROOTCONFIGPATH') .. '/ColorSelector/@Resources/ColorSelectorVariables.inc'
    local file = io.open(filePath, 'r')
    local content = file:read('*a')
    file:close()
    -- Заменяем значение
    content = content:gsub('ColorThemePath=.-\n', 'ColorThemePath=' .. correctPath .. '\n')
    file = io.open(filePath, 'w')
    file:write(content)
    file:close()

    -- Также устанавливаем как переменную скина для немедленного доступа
    SKIN:Bang('!SetVariable', 'ColorThemePath', correctPath)
    
    print("ColorThemePath set to: " .. correctPath)
end



function GetColorThemePath()
    print("==== Start:GetColorThemePath()")

    local rootPath = SKIN:GetVariable('ROOTCONFIGPATH')
    local filePath = rootPath .. '/ColorSelector/@Resources/ColorSelectorVariables.inc'
    
    print("File path: " .. filePath)
    
    -- Читаем файл
    local file = io.open(filePath, 'r')
    if not file then
        print("ERROR: Cannot open file: " .. filePath)
        return nil  -- Возвращаем nil если файл не найден
    end
    
    local content = file:read('*a')
    file:close()
    print("File read successfully")
    
    -- Разбиваем на строки
    local lines = {}
    for line in content:gmatch("[^\r\n]+") do
        lines[#lines + 1] = line
    end

    for i, line in ipairs(lines) do
        if line:match("^%s*ColorThemePath=") then
            local colorTheme = line:match("ColorThemePath=(.+)")
            print("============ !!!!!Found on line " .. i .. ": " .. tostring(colorTheme))
            return colorTheme  -- ВОЗВРАЩАЕМ значение
        end
    end
    
    print("ColorThemePath not found in file")
    return nil  -- Возвращаем nil если не найдено
end