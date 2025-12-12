# Инструкция по добавлению новой временной зоны (TimeZone_N)

## Обзор

В этой документации описывается процесс добавления новой временной зоны (TimeZone_N) в скин GoogleCalendar для Rainmeter. Временная зона позволяет выделить определенный интервал времени на сетке календаря для визуальной группировки событий.

## Содержание

**ПОДГОТОВКА**

1. Изменения в Variables.ini
2. Добавление локализованных строк
3. Изменения в .ini файле скина

**ОТОБРАЖЕНИЕ**  Изменения в `OmniCal_Skin.lua`

1. Добавьте код для обработки фона TimeZone_N в UpdateDay()

**РЕЖИМ "НАСТРОЙКА"**  Изменения в `OmniCal_Skin.lua`

1. Добавьте код для подсветки меток времени в UpdateSettingsMarkers()

2. Добавьте функцию переключения TimeZone_N

3. Добавьте функции для обработки ввода

**Проверка и тестирование**

**Примечания**

---

## ПОДГОТОВКА

### Изменения в Variables.ini

1. Добавьте следующие переменные в секцию временных зон (замените N на номер новой временной зоны):

```ini
;—— ФОН ДЛЯ ДНЕВНОГО ВРЕМЕНИ TimeZone_N В СУТКАХ (Background for daytime hours TimeZone_N) ———————————————————————————————
    ; Включить выделение TimeZone_N в сутках (Enable highlighting of TimeZone_N hours):
    ; Варианты (Options): 1, 0
    TimeZone_N=0
    ; С какого часа начинать выделение TimeZone_N времени в сутках (From which hour to start highlighting daytime hours):
    ; Формат (Format): Ч (H); 0Ч (0H); ЧЧ (HH); ЧЧ:ММ (HH:MM); ЧЧ,ММ (HH,MM); ЧЧ.ММ (HH.MM); ЧЧ-ММ (HH-MM);
    TimeZone_N_Start =8
    TimeZone_N_End =12
```

#### Добавление локализованных строк

Добавьте строки для локализации названия временной зоны в начало файла Variables.ini, секция [ПОДПИСИ (Labels)]:

```ini
    TimeZone_N_RU="Зона времени N"
    TimeZone_N_EN="Time zone N"
```

### Добавление переменных в Variables_Theme_*.ini

Добавьте настройки цвета для новой временной зоны в файлы темы (для каждой темы):

##### В Variables_Theme_Dark.ini

```ini
; Цвета зон времени (TimeZone colors)
ColorTimeZone_1N=60,40,70,40
```

##### В Variables_Theme_Light.ini

```ini
; Цвета зон времени (TimeZone colors)
ColorTimeZone_1N=240,230,250,80
```

### Изменения в .ini файле скина

#### 1. Добавьте меры для ввода времени начала и конца временной зоны

В секцию с InputText мерами (после аналогичных мер других TimeZone):

```ini
[InputTimeZone_N_Start]
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
Y=140
W=36
H=18
InputLimit=0
FocusDismiss=1
TopMost=0
Hidden=1
Command1=[!SetVariable TempInput "$UserInput$"][!CommandMeasure LuaScript "HandleInputTimeZoneNStart()"]
Group=Group_InputStartHour

[InputTimeZone_N_End]
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
Y=160
W=36
H=18
InputLimit=0
FocusDismiss=1
TopMost=0
Hidden=1
Command1=[!SetVariable TempInput "$UserInput$"][!CommandMeasure LuaScript "HandleInputTimeZoneNEnd()"]
Group=Group_InputStartHour
```

#### 2. Добавьте элементы управления в панель настроек

Найдите секцию с элементами управления для других временных зон (TimeZone_1, TimeZone_2, ...) и добавьте следующие элементы:

```ini
[TimeZone_N_txt]
Meter=String
X=-120r
Y=25r
FontSize=8
FontColor=#SettingsPanelTxtFontColor#
FontFace=#FontName#
FontWeight=600
Text=[#TimeZone_N_[#Language]]
AntiAlias=1
Hidden=1
Group=SettingsPanel
DynamicVariables=1

[TimeZone_N_Button]
Meter=Button
ButtonImage=#@#Images\switch_#TimeZone_N#.png
X=120r
Y=-3r
DynamicVariables=1
LeftMouseUpAction=[!CommandMeasure LuaScript "Toggle_TimeZone_N()"]
Group=SettingsPanel
Hidden=1
```

#### 3. Добавьте метр для фона временной зоны

Найдите метры для фона других временных зон (MeterDayBg1, MeterDayBg2, ...) и добавьте метр:

```ini
[MeterDayBgN]
Meter=Shape
X=(#LeftMargin#)
Y=0
W=#LineWidth#
H=1
DynamicVariables=1
Shape=Rectangle 0,0,#LineWidth#,1 | Fill Color #ColorTimeZone_1N# | StrokeWidth 0
```

## ОТОБРАЖЕНИЕ

Изменения в `OmniCal_Skin.lua`

### 1. Добавьте код для обработки фона TimeZone_N в UpdateDay()

Найдите блок кода для TimeZone_2 или TimeZone_3 и добавьте аналогичный блок для TimeZone_N:

```lua
-- ===== Фон для TimeZone_N: вычислить Y и H =====
-- Прочитать TimeZone_N_Start и TimeZone_N_End
local dayStartRawN = SKIN:GetVariable('TimeZone_N_Start')
local dayEndRawN = SKIN:GetVariable('TimeZone_N_End')
local dayStartMinN = ParseTimeToMinutes(dayStartRawN)
local dayEndMinN = ParseTimeToMinutes(dayEndRawN)

if dayStartMinN and dayEndMinN then
    -- Использовать GetYForTime для расчета Y независимо от gridStartHour, позволяя зонам переноситься через полночь
    local yStartN = GetYForTime(dayStartRawN)
    local yEndN = GetYForTime(dayEndRawN)
    if yStartN and yEndN and yStartN < yEndN then
        local yN = yStartN
        local heightN = yEndN - yStartN
        if heightN > 0 then
            local fillN = SKIN:GetVariable('ColorTimeZone_1N') or '64,105,99,75'
            local shapeN = string.format('Rectangle %d,%d,%d,%d | Fill Color %s| StrokeWidth 1 | Stroke Color %s', leftMargin, yN, lineWidth, heightN, fillN, fillN)
            SKIN:Bang('!SetOption', 'MeterDayBgN', 'Shape', shapeN)
            SKIN:Bang('!SetOption', 'MeterDayBgN', 'Hidden', '0')
            SKIN:Bang('!UpdateMeter', 'MeterDayBgN')
        else
            SKIN:Bang('!SetOption', 'MeterDayBgN', 'Hidden', '1')
        end
    else
        -- Конфигурация невалидна или Y не в порядке -> скрыть фон
        SKIN:Bang('!SetOption', 'MeterDayBgN', 'Hidden', '1')
    end
else
    -- конфигурация отсутствует или невалидна -> скрыть фон
    SKIN:Bang('!SetOption', 'MeterDayBgN', 'Hidden', '1')
end

-- Принудительно управлять видимостью MeterDayBgN по флагу TimeZone_N:
-- Если TimeZone_N == 1 -> показывать MeterDayBgN, иначе скрывать.
local tzN = tonumber(SKIN:GetVariable('TimeZone_N')) or 0
if tzN == 1 then
    SKIN:Bang('!SetOption', 'MeterDayBgN', 'Hidden', '0')
else
    SKIN:Bang('!SetOption', 'MeterDayBgN', 'Hidden', '1')
end
SKIN:Bang('!UpdateMeter', 'MeterDayBgN')
```

## РЕЖИМ "НАСТРОЙКА"

Изменения в `OmniCal_Skin.lua`

### 1. Добавьте код для подсветки меток времени в UpdateSettingsMarkers()

Найдите блок кода для TimeZone_2 или TimeZone_3 в функции UpdateSettingsMarkers() и добавьте аналогичный блок:

```lua
-- Выделить Time_XX для TimeZone_N_Start и TimeZone_N_End, если TimeZone_N включен
local timeZoneNEnabled = SKIN:GetVariable('TimeZone_N') or '0'
if timeZoneNEnabled == '1' then
    local dayStartNRaw = SKIN:GetVariable('TimeZone_N_Start')
    local dayEndNRaw = SKIN:GetVariable('TimeZone_N_End')
    local dayStartNMin = ParseTimeToMinutes(dayStartNRaw)
    local dayEndNMin = ParseTimeToMinutes(dayEndNRaw)
    local dayStartN = nil
    local dayEndN = nil
    if dayStartNMin then dayStartN = math.floor(dayStartNMin / 60) end
    if dayEndNMin then dayEndN = math.floor(dayEndNMin / 60) end
    dayStartN = dayStartN or 8
    dayEndN = dayEndN or 12
    -- Коррекция для психологического режима дня (Correction for psychological day mode)
    if isPsychologicalDay then
        if dayStartN and dayStartN < startHour then dayStartN = dayStartN + 24 end
        if dayEndN and dayEndN < startHour then dayEndN = dayEndN + 24 end
    end
    if dayStartN >= 0 then
        local meterDayStartN = string.format('Time_%02d', dayStartN)
        if SKIN:GetMeter(meterDayStartN) then
            SKIN:Bang('!SetOption', meterDayStartN, 'FontWeight', '900')
            SKIN:Bang('!SetOption', meterDayStartN, 'FontColor', SKIN:GetVariable('DayStartColor'))  -- Цвет для TimeZone_N_Start
            SKIN:Bang('!SetOption', meterDayStartN, 'LeftMouseUpAction', '[!CommandMeasure InputTimeZone_N_Start "ExecuteBatch All"]')
            -- Установить координаты InputTimeZone_N_Start над Time_XX
            local timeYStartN = SKIN:GetMeter(meterDayStartN):GetY()
            SKIN:Bang('!SetOption', 'InputTimeZone_N_Start', 'Y', tostring(timeYStartN))
            SKIN:Bang('!UpdateMeter', meterDayStartN)
        end
    end
    if dayEndN >= 0 and dayEndN ~= dayStartN then
        local meterDayEndN = string.format('Time_%02d', dayEndN)
        if SKIN:GetMeter(meterDayEndN) then
            SKIN:Bang('!SetOption', meterDayEndN, 'FontWeight', '900')
            SKIN:Bang('!SetOption', meterDayEndN, 'FontColor', SKIN:GetVariable('DayEndColor'))  -- Цвет для TimeZone_N_End
            SKIN:Bang('!SetOption', meterDayEndN, 'LeftMouseUpAction', '[!CommandMeasure InputTimeZone_N_End "ExecuteBatch All"]')
            -- Установить координаты InputTimeZone_N_End над Time_XX
            local timeYEndN = SKIN:GetMeter(meterDayEndN):GetY()
            SKIN:Bang('!SetOption', 'InputTimeZone_N_End', 'Y', tostring(timeYEndN))
            SKIN:Bang('!UpdateMeter', meterDayEndN)
        end
    end
end
```

### 2. Добавьте функцию переключения TimeZone_N

Найдите аналогичные функции для других TimeZone и добавьте новую:

```lua
-- Переключить TimeZone_N (Toggle TimeZone_N)
-- Группа: [ Настройки скина ]
-- Описание: Переключает TimeZone_N между 0 и 1, управляет выделением меток и обновляет фон
function Toggle_TimeZone_N()
    local currentTimeZone_N = SKIN:GetVariable('TimeZone_N') or '0'
    local newTimeZone_N = (currentTimeZone_N == '1') and '0' or '1'

    -- Записать новое значение в файл Variables.ini
    SKIN:Bang('!WriteKeyValue Variables TimeZone_N "' .. newTimeZone_N .. '" "#@#Variables.ini"')

    -- Обновить переменную времени выполнения
    SKIN:Bang('!SetVariable TimeZone_N "' .. newTimeZone_N .. '"')

    -- Управление выделением меток для TimeZone_N_Start и TimeZone_N_End
    local dayStartRaw = SKIN:GetVariable('TimeZone_N_Start')
    local dayEndRaw = SKIN:GetVariable('TimeZone_N_End')
    local dayStartMin = ParseTimeToMinutes(dayStartRaw)
    local dayEndMin = ParseTimeToMinutes(dayEndRaw)
    local dayStart = nil
    local dayEnd = nil
    if dayStartMin then dayStart = math.floor(dayStartMin / 60) end
    if dayEndMin then dayEnd = math.floor(dayEndMin / 60) end

    -- Коррекция для психологического режима дня
    local startHour = tonumber(SKIN:GetVariable('startHour')) or 8
    local endHour = tonumber(SKIN:GetVariable('endHour')) or 4
    local isPsychologicalDay = false
    if startHour > endHour then isPsychologicalDay = true elseif startHour == endHour then endHour = 24 end
    if isPsychologicalDay then
        if dayStart and dayStart < startHour then dayStart = dayStart + 24 end
        if dayEnd and dayEnd < startHour then dayEnd = dayEnd + 24 end
    end

    if newTimeZone_N == '1' then
        -- Включить выделение
        if dayStart then
            local meterStart = string.format('Time_%02d', dayStart)
            if SKIN:GetMeter(meterStart) then
                SKIN:Bang('!SetOption', meterStart, 'FontWeight', '900')
                SKIN:Bang('!SetOption', meterStart, 'FontColor', SKIN:GetVariable('DayStartColor'))
                SKIN:Bang('!SetOption', meterStart, 'LeftMouseUpAction', '[!CommandMeasure InputTimeZone_N_Start "ExecuteBatch All"]')
                -- Установить координаты InputTimeZone_N_Start над Time_XX
                local timeYStart = SKIN:GetMeter(meterStart):GetY()
                SKIN:Bang('!SetOption', 'InputTimeZone_N_Start', 'Y', tostring(timeYStart))
                SKIN:Bang('!UpdateMeter', meterStart)
            end
        end
        if dayEnd then
            local meterEnd = string.format('Time_%02d', dayEnd)
            if SKIN:GetMeter(meterEnd) then
                SKIN:Bang('!SetOption', meterEnd, 'FontWeight', '900')
                SKIN:Bang('!SetOption', meterEnd, 'FontColor', SKIN:GetVariable('DayEndColor'))
                SKIN:Bang('!SetOption', meterEnd, 'LeftMouseUpAction', '[!CommandMeasure InputTimeZone_N_End "ExecuteBatch All"]')
                -- Установить координаты InputTimeZone_N_End над Time_XX
                local timeYEnd = SKIN:GetMeter(meterEnd):GetY()
                SKIN:Bang('!SetOption', 'InputTimeZone_N_End', 'Y', tostring(timeYEnd))
                SKIN:Bang('!UpdateMeter', meterEnd)
            end
        end
    else
        -- Выключить выделение
        if dayStart then
            local meterStart = string.format('Time_%02d', dayStart)
            if SKIN:GetMeter(meterStart) then
                SKIN:Bang('!SetOption', meterStart, 'FontWeight', '400')
                SKIN:Bang('!SetOption', meterStart, 'FontColor', '#ColorTxtH1#')
                SKIN:Bang('!UpdateMeter', meterStart)
            end
        end
        if dayEnd then
            local meterEnd = string.format('Time_%02d', dayEnd)
            if SKIN:GetMeter(meterEnd) then
                SKIN:Bang('!SetOption', meterEnd, 'FontWeight', '400')
                SKIN:Bang('!SetOption', meterEnd, 'FontColor', '#ColorTxtH1#')
                SKIN:Bang('!UpdateMeter', meterEnd)
            end
        end
    end

    -- Обновить фон дня
    pcall(UpdateDay)

    -- Обновить время последнего действия (Update last action time)
    LastActionTime = os.time()
end
```

### 3. Добавьте изменения в Toggle_Settings()

Найдите блок кода для TimeZone_1 в функции Toggle_Settings() и добавьте аналогичный блок для TimeZone_N:

```lua
-- Выделить Time_XX для TimeZone_N_Start и TimeZone_N_End, если TimeZone_N включен
local timeZoneNEnabled = SKIN:GetVariable('TimeZone_N') or '0'
if timeZoneNEnabled == '1' then
    local dayStartNRaw = SKIN:GetVariable('TimeZone_N_Start')
    local dayEndNRaw = SKIN:GetVariable('TimeZone_N_End')
    local dayStartNMin = ParseTimeToMinutes(dayStartNRaw)
    local dayEndNMin = ParseTimeToMinutes(dayEndNRaw)
    local dayStartN = nil
    local dayEndN = nil
    if dayStartNMin then dayStartN = math.floor(dayStartNMin / 60) end
    if dayEndNMin then dayEndN = math.floor(dayEndNMin / 60) end
    dayStartN = dayStartN or 8
    dayEndN = dayEndN or 12
    -- Коррекция для психологического режима дня (Correction for psychological day mode)
    if isPsychologicalDay then
        if dayStartN and dayStartN < startHour then dayStartN = dayStartN + 24 end
        if dayEndN and dayEndN < startHour then dayEndN = dayEndN + 24 end
    end
    if dayStartN >= 0 then
        local meterDayStartN = string.format('Time_%02d', dayStartN)
        if SKIN:GetMeter(meterDayStartN) then
            SKIN:Bang('!SetOption', meterDayStartN, 'FontWeight', '900')
            SKIN:Bang('!SetOption', meterDayStartN, 'FontColor', SKIN:GetVariable('DayStartColor'))  -- Цвет для TimeZone_N_Start
            SKIN:Bang('!SetOption', meterDayStartN, 'LeftMouseUpAction', '[!CommandMeasure InputTimeZone_N_Start "ExecuteBatch All"]')
            -- Установить координаты InputTimeZone_N_Start над Time_XX
            local timeYStartN = SKIN:GetMeter(meterDayStartN):GetY()
            SKIN:Bang('!SetOption', 'InputTimeZone_N_Start', 'Y', tostring(timeYStartN))
            SKIN:Bang('!UpdateMeter', meterDayStartN)
        end
    end
    if dayEndN >= 0 and dayEndN ~= dayStartN then
        local meterDayEndN = string.format('Time_%02d', dayEndN)
        if SKIN:GetMeter(meterDayEndN) then
            SKIN:Bang('!SetOption', meterDayEndN, 'FontWeight', '900')
            SKIN:Bang('!SetOption', meterDayEndN, 'FontColor', SKIN:GetVariable('DayEndColor'))  -- Цвет для TimeZone_N_End
            SKIN:Bang('!SetOption', meterDayEndN, 'LeftMouseUpAction', '[!CommandMeasure InputTimeZone_N_End "ExecuteBatch All"]')
            -- Установить координаты InputTimeZone_N_End над Time_XX
            local timeYEndN = SKIN:GetMeter(meterDayEndN):GetY()
            SKIN:Bang('!SetOption', 'InputTimeZone_N_End', 'Y', tostring(timeYEndN))
            SKIN:Bang('!UpdateMeter', meterDayEndN)
        end
    end
end
```

### 4. Добавьте функции для обработки ввода

Найдите аналогичные функции для других TimeZone и добавьте новые:

```lua
-- Обработать ввод для `TimeZone_N_Start` (Handle input for TimeZone_N_Start)
-- Группа: [ Настройки скина ]
-- Описание: Обрабатывает ввод для TimeZone_N_Start и обновляет фон дня
function HandleInputTimeZoneNStart()
    local val = SKIN:GetVariable('TempInput') or ''
    if not val or val == '' then return end
    local s = tostring(val):match('^%s*(.-)%s*$')
    -- попробовать распарсить в компоненты
    local h, m = ParseTimeComponents(s)
    if not h then return end
    -- сохранить в виде строки H[:MM] в Variables.ini, использовать формат "H:MM" если есть минуты
    local outVal = (m and m > 0) and string.format('%d:%02d', h, m) or tostring(h)

    -- Проверка валидности: Y нового TimeZone_N_Start должна быть >= Y startHour и < Y TimeZone_N_End
    local startHour = tonumber(SKIN:GetVariable('startHour')) or 8
    local startHourStr = string.format('%d:00', startHour)
    local yStartHour = GetYForTime(startHourStr)

    local dayEndRaw = SKIN:GetVariable('TimeZone_N_End') or '22:00'
    local yDayEnd = GetYForTime(dayEndRaw)

    local yNewDayStart = GetYForTime(outVal)

    if not yNewDayStart or not yStartHour or not yDayEnd then return end
    if yNewDayStart < yStartHour or yNewDayStart >= yDayEnd then return end

    -- Если проверка прошла, сохранить изменения
    SKIN:Bang('!WriteKeyValue Variables TimeZone_N_Start "'..outVal..'" "#@#Variables.ini"')
    SKIN:Bang('!SetVariable TimeZone_N_Start "'..outVal..'"')
    SKIN:Bang('!SetVariable TempInput ""')
    pcall(UpdateDay)  -- Обновить фон дня
    if UpdateSettingsMarkers then pcall(UpdateSettingsMarkers) end
    -- Обновить время последнего действия (Update last action time)
    LastActionTime = os.time()
    SKIN:Bang('!Redraw')
end

-- Обработать ввод для `TimeZone_N_End` (Handle input for TimeZone_N_End)
-- Группа: [ Настройки скина ]
-- Описание: Обрабатывает ввод для TimeZone_N_End и обновляет фон дня
function HandleInputTimeZoneNEnd()
    local val = SKIN:GetVariable('TempInput') or ''
    if not val or val == '' then return end
    local s = tostring(val):match('^%s*(.-)%s*$')
    local h, m = ParseTimeComponents(s)
    if not h then return end
    local outVal = (m and m > 0) and string.format('%d:%02d', h, m) or tostring(h)

    -- Проверка валидности: Y нового TimeZone_N_End должна быть <= Y endHour и > Y TimeZone_N_Start
    local endHour = tonumber(SKIN:GetVariable('endHour')) or 4
    local endHourStr = string.format('%d:00', endHour)
    local yEndHour = GetYForTime(endHourStr)

    local dayStartRaw = SKIN:GetVariable('TimeZone_N_Start') or '8:00'
    local yDayStart = GetYForTime(dayStartRaw)

    local yNewDayEnd = GetYForTime(outVal)

    if not yNewDayEnd or not yEndHour or not yDayStart then return end
    if yNewDayEnd > yEndHour or yNewDayEnd <= yDayStart then return end

    -- Если проверка прошла, сохранить изменения
    SKIN:Bang('!WriteKeyValue Variables TimeZone_N_End "'..outVal..'" "#@#Variables.ini"')
    SKIN:Bang('!SetVariable TimeZone_N_End "'..outVal..'"')
    SKIN:Bang('!SetVariable TempInput ""')
    pcall(UpdateDay)  -- Обновить фон дня
    if UpdateSettingsMarkers then pcall(UpdateSettingsMarkers) end
    -- Обновить время последнего действия (Update last action time)
    LastActionTime = os.time()
    SKIN:Bang('!Redraw')
end
```

## Проверка и тестирование

1. Перезагрузите скин после внесения всех изменений
2. Проверьте режим настроек и убедитесь, что:
   - Переключатель TimeZone_N отображается и работает
   - При включении TimeZone_N отображается соответствующий фон на сетке
   - При клике на метки времени открываются поля ввода начала/конца
   - Можно редактировать время начала и конца временной зоны
   - Проверьте обработку диапазона через полночь (когда TimeZone_N_End < TimeZone_N_Start)
   - Проверьте работу временной зоны в обоих режимах дня (normal/psychological)
   - Проверьте зоны, начинающиеся до startHour или заканчивающиеся после endHour (фон должен отображаться корректно)

## Примечания

- Обязательно следуйте формату комментариев: -- коментарий по-русски (Comment in english)
- Имена переменных цветов для фона: `ColorTimeZone_1N` (а не TimeZone_N_Color) - это важное отличие от документации
- При добавлении нескольких временных зон, убедитесь, что Y-координаты элементов правильно рассчитываются (обычно +25r от предыдущего элемента)
- В обработчиках ввода (`HandleInputTimeZoneNStart/End`) используется валидация по Y-координатам, а не по числовым значениям часов
- Функция проверки валидности учитывает существование метки времени `Time_##` и использует `GetYForTime()` для проверки границ
- Зоны времени теперь могут быть установлены в любом месте сетки, включая перенос через полночь, благодаря использованию `GetYForTime()` вместо привязки к `gridStartHour`