# Как добавить новый разделитель Separator_N

В данной инструкции описано, как добавить новый разделитель времени (горизонтальную линию) в сетку календаря. Мы используем Separator_1 как пример и покажем, как добавить Separator_2, Separator_3 и т.д.

## 1. Добавить переменные в Variables.ini

В файле `@Resources\Variables.ini` добавьте следующие переменные:

```ini
; —— РАЗДЕЛИТЕЛИ (Separators) ——————————————————————————————————————————————————————————————————————
    ; Разделитель N Показать/скрыть (Show/hide Separator N)
    ; Варианты (Options): 1-Показать, 0-скрыть (1-Show, 0-Hide)
    Separator_N=0
    Separator_N_Time=12:00
```

По умолчанию можно указать время без минут, например `12` вместо `12:00`. Вес разделителя задаётся в параметрах темы.

Также добавьте текстовые метки для новой переменной:

```ini
;—— ПОДПИСИ (Labels) ————————————————————————————————————————————————————————————————————————————————
    TimeSeparator_N_txt_RU="*Разделитель N"
    TimeSeparator_N_txt_EN="*Separator N"
```

В файлы с темами `Variables_Theme_Dark.ini` и `Variables_Theme_Light.ini` добавьте переменные для цветов:

```ini
; Разделитель N (Separator N)
ColorSeparator_N=255,255,255,100
; Толщина разделителя N (Separator N thickness):
Separator_N_Weight=3
```

Опционально можно добавить цвет маркера времени для разделителя:

```ini
; Цвет маркера времени для разделителя N (Time marker color for Separator N)
ColorSeparator_N_Marker=255,192,0
```

Если переменная `ColorSeparator_N_Marker` не указана, будет использоваться цвет по умолчанию - оранжево-желтый (`255,192,0`).

## 2. Добавить метр для разделителя в ini-файл

В файле `GcalendarSK3-ColorSelector.ini` добавьте метр для горизонтальной линии:

```ini
[HorizontalLine_Separator_N]
Meter=Shape
X=(#LeftMargin#-4)
Y=290
Shape=Rectangle 0,0,(#LineWidth#+4),#Separator_N_Weight#,3,3 | Fill Color #ColorSeparator_N# | StrokeWidth 0 | Stroke Color #ColorSeparator_N#
RightMouseUpAction=[!CommandMeasure "ColorSelector_Start_Script" "StartWith('ColorSeparator_N')"]
Hidden=(1 - #Separator_N#)
DynamicVariables=1
```

Значение Y будет автоматически вычислено скриптом в зависимости от времени разделителя.

## 3. Добавить меру InputText

В файле `GcalendarSK3-ColorSelector.ini` добавьте меру InputText для редактирования времени разделителя:

```ini
[InputSeparator_N_Time];──────────────────────────
Measure=Plugin
Plugin=InputText
UpdateDivider=1
DefaultValue=""
FontFace=Arial Black
FontWeight=400
FontSize=8
StringAlign=Center
FontColor=#ColorInputTxt#
SolidColor=0,0,0,150
X=0
Y=180
W=36
H=18
InputLimit=0
FocusDismiss=1
TopMost=0
Hidden=1
Command1=[!SetVariable TempInput "$UserInput$"][!CommandMeasure LuaScript "HandleInputSeparatorNTime()"]
Group=Group_InputStartHour
```

## 4. Добавить функцию-обработчик для InputText

В файле `@Resources\OmniCal_Skin.lua` добавьте функцию для обработки ввода времени:

```lua
-- Обработать ввод для `Separator_N_Time` (Handle input for Separator_N_Time)
-- Группа: [ Настройки скина ]
-- Описание: Обрабатывает ввод для Separator_N_Time и обновляет положение разделителя
function HandleInputSeparatorNTime()
    local val = SKIN:GetVariable('TempInput') or ''
    if not val or val == '' then return end
    local s = tostring(val):match('^%s*(.-)%s*$')
    local h, m = ParseTimeComponents(s)
    if not h then return end
    local outVal = (m and m > 0) and string.format('%d:%02d', h, m) or tostring(h)

    -- Проверка валидности: время разделителя должно быть в пределах видимой сетки
    local startHour = tonumber(SKIN:GetVariable('startHour')) or 8
    local endHour = tonumber(SKIN:GetVariable('endHour')) or 4
    local isPsychologicalDay = false
    if startHour > endHour then isPsychologicalDay = true elseif startHour == endHour then endHour = 24 end
    
    local hour = h
    if isPsychologicalDay and hour < startHour then hour = hour + 24 end
    
    if (isPsychologicalDay and (hour < startHour or hour > endHour + 24)) or
       (not isPsychologicalDay and (hour < startHour or hour > endHour)) then
        return
    end

    -- Если проверка прошла, сохранить изменения
    SKIN:Bang('!WriteKeyValue Variables Separator_N_Time "'..outVal..'" "#@#Variables.ini"')
    SKIN:Bang('!SetVariable Separator_N_Time "'..outVal..'"')
    SKIN:Bang('!SetVariable TempInput ""')
    pcall(UpdateDay)  -- Обновить разделитель
    if UpdateSettingsMarkers then pcall(UpdateSettingsMarkers) end
    -- Обновить время последнего действия (Update last action time)
    LastActionTime = os.time()
    SKIN:Bang('!Redraw')
end
```

## 5. Добавить функцию переключения видимости разделителя

В файле `@Resources\OmniCal_Skin.lua` добавьте функцию для переключения видимости разделителя:

```lua
-- Включить или выключить Separator_N (Toggle Separator_N on/off)
-- Группа: [ Настройки скина ]
function Toggle_Separator_N()
    local currentSeparator_N = SKIN:GetVariable('Separator_N') or '0'
    local newSeparator_N = (currentSeparator_N == '1') and '0' or '1'
    
    -- Записать новое значение в файл Variables.ini (Write new value to Variables.ini)
    SKIN:Bang('!WriteKeyValue Variables Separator_N "' .. newSeparator_N .. '" "#@#Variables.ini"')
    
    -- Обновить переменную времени выполнения (Update runtime variable)
    SKIN:Bang('!SetVariable Separator_N "' .. newSeparator_N .. '"')

    -- Получить время для разделителя (Get separator time)
    local separatorTimeRaw = SKIN:GetVariable('Separator_N_Time')
    local separatorTimeMin = ParseTimeToMinutes(separatorTimeRaw)
    local separatorTime = nil
    if separatorTimeMin then separatorTime = math.floor(separatorTimeMin / 60) end
    separatorTime = separatorTime or 12

    -- Коррекция для психологического режима дня (Correction for psychological day mode)
    local startHour = tonumber(SKIN:GetVariable('startHour')) or 8
    local endHour = tonumber(SKIN:GetVariable('endHour')) or 4
    local isPsychologicalDay = false
    if startHour > endHour then isPsychologicalDay = true elseif startHour == endHour then endHour = 24 end
    if isPsychologicalDay then
        if separatorTime and separatorTime < startHour then separatorTime = separatorTime + 24 end
    end

    if newSeparator_N == '1' then
        -- Включить выделение (Enable highlight)
        if separatorTime >= 0 then
            local meterSeparatorTime = string.format('Time_%02d', separatorTime)
            if SKIN:GetMeter(meterSeparatorTime) then
                SKIN:Bang('!SetOption', meterSeparatorTime, 'FontWeight', '900')
                SKIN:Bang('!SetOption', meterSeparatorTime, 'FontColor', SKIN:GetVariable('ColorSeparator_N_Marker') or '255,192,0')
                SKIN:Bang('!SetOption', meterSeparatorTime, 'LeftMouseUpAction', '[!CommandMeasure InputSeparator_N_Time "ExecuteBatch All"]')
                -- Установить координаты InputSeparator_N_Time над Time_XX (Set InputSeparator_N_Time coordinates above Time_XX)
                local timeSeparatorY = SKIN:GetMeter(meterSeparatorTime):GetY()
                SKIN:Bang('!SetOption', 'InputSeparator_N_Time', 'Y', tostring(timeSeparatorY))
                SKIN:Bang('!UpdateMeter', meterSeparatorTime)
            end
        end
        -- Показать разделительную линию (Show separator line)
        SKIN:Bang('!SetOption', 'HorizontalLine_Separator_N', 'Hidden', '0')
        SKIN:Bang('!UpdateMeter', 'HorizontalLine_Separator_N')
    else
        -- Выключить выделение (Disable highlight)
        if separatorTime >= 0 then
            local meterSeparatorTime = string.format('Time_%02d', separatorTime)
            if SKIN:GetMeter(meterSeparatorTime) then
                SKIN:Bang('!SetOption', meterSeparatorTime, 'FontWeight', '400')
                SKIN:Bang('!SetOption', meterSeparatorTime, 'FontColor', '#ColorTxtH1#')
                SKIN:Bang('!SetOption', meterSeparatorTime, 'LeftMouseUpAction', '')
                SKIN:Bang('!UpdateMeter', meterSeparatorTime)
            end
        end
        -- Скрыть разделительную линию (Hide separator line)
        SKIN:Bang('!SetOption', 'HorizontalLine_Separator_N', 'Hidden', '1')
        SKIN:Bang('!UpdateMeter', 'HorizontalLine_Separator_N')
    end

    -- Обновить время последнего действия (Update last action time)
    LastActionTime = os.time()
    
    -- Обновить фоны и разделители (Update backgrounds and separators)
    pcall(UpdateDay)
    
    -- Обновить маркеры в режиме настроек (Update settings markers)
    if UpdateSettingsMarkers then pcall(UpdateSettingsMarkers) end
end
```

## 6. Модифицировать функцию UpdateDay для отображения разделителя

В функции UpdateDay в файле `@Resources\OmniCal_Skin.lua` добавьте код для обработки нового разделителя:

```lua
-- Прочитать Separator_N_Time
local separatorTimeRaw = SKIN:GetVariable('Separator_N_Time')
local separatorTimeMin = ParseTimeToMinutes(separatorTimeRaw)
if separatorTimeMin then
    -- Найти подходящий Y-координату для разделителя
    local ySeparator = GetYForTime(separatorTimeRaw)
    if ySeparator then
        local separatorWeight = SKIN:GetVariable('Separator_N_Weight') or '2'
        local separatorColor = SKIN:GetVariable('ColorSeparator_N') or '255,255,255,100'
        
        SKIN:Bang('!SetOption', 'HorizontalLine_Separator_N', 'Y', tostring(ySeparator - 1))
        SKIN:Bang('!UpdateMeter', 'HorizontalLine_Separator_N')
    end
end

-- Принудительно управлять видимостью HorizontalLine_Separator_N по флагу Separator_N:
-- Если Separator_N == 1 -> показывать HorizontalLine_Separator_N, иначе скрывать.
local sepN = tonumber(SKIN:GetVariable('Separator_N')) or 0
if sepN == 1 then
    SKIN:Bang('!SetOption', 'HorizontalLine_Separator_N', 'Hidden', '0')
else
    SKIN:Bang('!SetOption', 'HorizontalLine_Separator_N', 'Hidden', '1')
end
SKIN:Bang('!UpdateMeter', 'HorizontalLine_Separator_N')
```

## 7. Модифицировать функцию UpdateSettingsMarkers для выделения метки времени

В функции UpdateSettingsMarkers в файле `@Resources\OmniCal_Skin.lua` добавьте код для выделения метки времени:

```lua
-- Выделить Time_XX для Separator_N_Time, если Separator_N включен
local separatorNEnabled = SKIN:GetVariable('Separator_N') or '0'
if separatorNEnabled == '1' then
    local separatorTimeRaw = SKIN:GetVariable('Separator_N_Time')
    local separatorTimeMin = ParseTimeToMinutes(separatorTimeRaw)
    local separatorTime = nil
    if separatorTimeMin then separatorTime = math.floor(separatorTimeMin / 60) end
    separatorTime = separatorTime or 12
    -- Коррекция для психологического режима дня
    if isPsychologicalDay then
        if separatorTime and separatorTime < startHour then separatorTime = separatorTime + 24 end
    end
    if separatorTime >= 0 then
        local meterSeparatorTime = string.format('Time_%02d', separatorTime)
        if SKIN:GetMeter(meterSeparatorTime) then
            SKIN:Bang('!SetOption', meterSeparatorTime, 'FontWeight', '900')
            SKIN:Bang('!SetOption', meterSeparatorTime, 'FontColor', SKIN:GetVariable('ColorSeparator_N_Marker') or '255,192,0')  -- Цвет для Separator_N_Time
            SKIN:Bang('!SetOption', meterSeparatorTime, 'LeftMouseUpAction', '[!CommandMeasure InputSeparator_N_Time "ExecuteBatch All"]')
            -- Установить координаты InputSeparator_N_Time над Time_XX
            local timeSeparatorY = SKIN:GetMeter(meterSeparatorTime):GetY()
            SKIN:Bang('!SetOption', 'InputSeparator_N_Time', 'Y', tostring(timeSeparatorY))
            SKIN:Bang('!UpdateMeter', meterSeparatorTime)
        end
    end
end
```

## 8. Обновить функцию Toggle_Settings для корректного отображения маркеров

Необходимо добавить вызов UpdateSettingsMarkers в функцию Toggle_Settings, чтобы маркер разделителя отображался сразу при входе в режим настроек:

```lua
function Toggle_Settings()
    -- Когда пользователь нажимает [Settings]: скрыть Settings, показать SettingsON
    ...
    
    -- Пометить режим настроек чтобы другие функции знали о том, что настройки активны
    SKIN:Bang('!SetVariable', 'SettingsMode', '1')
    -- Обновить время последнего действия (Update last action time)
    LastActionTime = os.time()
    
    -- Вызвать UpdateSettingsMarkers для отображения всех маркеров (включая Separator_N_Time)
    pcall(UpdateSettingsMarkers)
    
    -- выделить первую видимую метку часа: установить FontWeight и действия мыши
    ...
}
```

Без этого вызова маркер Separator_N_Time не будет отображаться при входе в режим настроек, даже если Separator_N включен. Пользователям придется выключать и снова включать разделитель, чтобы увидеть маркер.

## 9. Добавить элементы для разделителя в панели настроек

В файле `GcalendarSK3-ColorSelector.ini` добавьте следующие элементы для отображения разделителя в панели настроек:

```ini
[TimeSeparator_N_txt];▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂▂
Meter=String
X=-120r
Y=37r
FontSize=8
FontColor=#SettingsPanelTxtFontColor#
FontFace=#FontName#
FontWeight=600
Text=[#TimeSeparator_N_txt_[#Language]]  
AntiAlias=1
Hidden=1
Group=SettingsPanel
DynamicVariables=1


[TimeSeparator_N_Button]
Meter=Button
ButtonImage=#@#Images\switch_#Separator_N#.png
X=120r
Y=-3r
DynamicVariables=1
LeftMouseUpAction=[!CommandMeasure LuaScript "Toggle_Separator_N()"]
Group=SettingsPanel
Hidden=1
```

Затем добавьте кнопку для переключения разделителя в меню настроек:

```ini
[SettingToggle_Separator_N]
Meter=String
FontSize=#SettingsFontSize#
FontColor=#SettingsFontColor#
StringAlign=Left
X=#SettingsX#
Y=r
W=#SettingsWidth#
H=18
Text=#TimeSeparator_N_txt_#Language##
LeftMouseUpAction=[!CommandMeasure LuaScript "Toggle_Separator_N()"]
MouseOverAction=[!SetOption #CURRENTSECTION# FontColor "#SettingsFontColor_Hover#"][!UpdateMeter #CURRENTSECTION#]
MouseLeaveAction=[!SetOption #CURRENTSECTION# FontColor "#SettingsFontColor#"][!UpdateMeter #CURRENTSECTION#]
Hidden=#SettingsHidden#
AntiAlias=1
DynamicVariables=1
```

## Полный пример для копирования и замены N на номер нового разделителя

При добавлении нового разделителя, замените все вхождения `_N` на нужный номер, например `_2`, `_3` и т.д.

***

### Примечания:

1. Разделители отображаются как горизонтальные линии на сетке календаря в указанное время.
2. Для каждого разделителя вы можете настроить:
   - Время показа (через переменную Separator_N_Time)
   - Толщину линии (через переменную Separator_N_Weight)
   - Цвет линии (через переменную ColorSeparator_N)
   - Цвет маркера времени (через переменную ColorSeparator_N_Marker)
3. Разделитель можно включать/выключать через панель настроек или программно через функцию Toggle_Separator_N().
4. Время разделителя можно изменять кликом на маркере времени, который появляется при включении разделителя.
5. **Важно**: В функции Toggle_Separator_N() обязательно должны быть следующие вызовы:
   - `pcall(UpdateDay)` - для обновления положения и отображения разделителя на сетке календаря.
   - `if UpdateSettingsMarkers then pcall(UpdateSettingsMarkers) end` - для обновления маркеров в режиме настроек.
6. Координата Y для разделительной линии вычисляется динамически в функции UpdateDay на основе значения переменной Separator_N_Time, поэтому начальное значение Y в метре HorizontalLine_Separator_N не имеет значения и будет переопределено.
