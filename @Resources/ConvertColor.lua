-- Convert RGB to HEX
function rgbToHex(r, g, b)
    r = math.floor(r)
    g = math.floor(g)
    b = math.floor(b)
    return string.format("#%02X%02X%02X", r, g, b)
end

-- Function to get color from calling skin based on CSN
function getCallerColor()
    local rgbaString = SKIN:GetVariable("RGBA")
    local oldColorValue = rgbaString or "75,28,28,255"
    
    SKIN:Bang('!SetVariable', 'OldColor', oldColorValue)
    
    local r, g, b, a = rgbaString:match("([^,]+),([^,]+),([^,]+),([^,]+)")
    if not a then
        r, g, b = rgbaString:match("([^,]+),([^,]+),([^,]+)")
        a = 255
    end
    return tonumber(r) or 75, tonumber(g) or 28, tonumber(b) or 28, tonumber(a) or 255
end

function verifyRGB(r, g, b, tmp)
    if not (r) then
        SKIN:Bang('!SetVariable', 'R', tmp)
        SKIN:Bang('!UpdateMeasure', 'InvalidCheck')
        return false
    elseif not (g) then
        SKIN:Bang('!SetVariable', 'G', tmp)
        SKIN:Bang('!UpdateMeasure', 'InvalidCheck')
        return false
    elseif not (b) then
        SKIN:Bang('!SetVariable', 'B', tmp)
        SKIN:Bang('!UpdateMeasure', 'InvalidCheck')
        return false
    end
    return true
end

function verifyHSV(h, s, v, tmp)
    if not (h) then
        SKIN:Bang('!SetVariable', 'H', tmp)
        SKIN:Bang('!UpdateMeasure', 'InvalidCheck')
        return false
    elseif not (s) then
        SKIN:Bang('!SetVariable', 'S', tmp)
        SKIN:Bang('!UpdateMeasure', 'InvalidCheck')
        return false
    elseif not (v) then
        SKIN:Bang('!SetVariable', 'V', tmp)
        SKIN:Bang('!UpdateMeasure', 'InvalidCheck')
        return false
    end
    return true
end

function verifyRGBA(r, g, b, a)
    if not (r and g and b and a) then
        SKIN:Bang('!UpdateMeasure', 'InvalidCheck')
        return false
    end
    return true
end

-- Convert RGB to HSV
function rgbToHsv(r, g, b)
    if not r or not g or not b or r == "" or g == "" or b == "" then
        return
    end
    r, g, b = r / 255, g / 255, b / 255
    local max = math.max(r, g, b)
    local min = math.min(r, g, b)
    local h, s, v

    local d = max - min
    v = max

    if max == 0 then
        s = 0
    else
        s = d / max
    end

    if max == min then
        h = 0
    else
        if max == r then
            h = (60 * ((g - b) / d) + 360) % 360
        elseif max == g then
            h = (60 * ((b - r) / d) + 120) % 360
        else
            h = (60 * ((r - g) / d) + 240) % 360
        end
    end

    return h, s * 100, v * 100
end

-- Convert HSV to RGB
function hsvToRgb(h, s, v)
    h = h / 60
    s = s / 100
    v = v / 100
    local i, f, p, q, t

    if s == 0 then
        return v * 255, v * 255, v * 255
    end

    i = math.floor(h)
    f = h - i
    p = v * (1 - s)
    q = v * (1 - (s * f))
    t = v * (1 - (s * (1 - f)))

    if i == 0 then
        return v * 255, t * 255, p * 255
    elseif i == 1 then
        return q * 255, v * 255, p * 255
    elseif i == 2 then
        return p * 255, v * 255, t * 255
    elseif i == 3 then
        return p * 255, q * 255, v * 255
    elseif i == 4 then
        return t * 255, p * 255, v * 255
    else
        return v * 255, p * 255, q * 255
    end
end

-- Function to convert Hex to RGB
function hexToRgb(hex)
    local pattern = "^(#?%x%x%x%x%x%x)$"
    local match = hex:match(pattern)

    if match then
        return tonumber("0x" .. match:sub(1, 2)), tonumber("0x" .. match:sub(3, 4)), tonumber("0x" .. match:sub(5, 6))
    else
        return nil, "Invalid hex format"
    end
end

-- Function to Round
function math.round(num)
    return math.floor(num + 0.5)
end

-- Function to update Variables
function updateVariables(r, g, b, a, h, s, v, hex)
    SKIN:Bang('!SetVariable', 'R', math.round(r))
    SKIN:Bang('!SetVariable', 'G', math.round(g))
    SKIN:Bang('!SetVariable', 'B', math.round(b))
    SKIN:Bang('!SetVariable', 'A', math.round(a))
    SKIN:Bang('!SetVariable', 'H', math.round(h))
    SKIN:Bang('!SetVariable', 'S', math.round(s))
    SKIN:Bang('!SetVariable', 'V', math.round(v))
    SKIN:Bang('!SetVariable', 'HexColor', hex)
    SKIN:Bang('!SetVariable', 'RGBA', math.round(r) .. "," .. math.round(g) .. "," .. math.round(b) .. "," .. math.round(a))
    SKIN:Bang('!SetVariable', 'HSV', math.round(h) .. "," .. math.round(s) .. "," .. math.round(v))
    SKIN:Bang('!UpdateMeasureGroup', 'Values')
    SKIN:Bang('!UpdateMeterGroup', 'Values')
end

-- Main function
function Update()
    local convert = SKIN:GetVariable("Convert")

    if convert == "INITIALIZE" then
        local r, g, b, a = getCallerColor()
        local h, s, v = rgbToHsv(r, g, b)
        local hex = rgbToHex(r, g, b)
        updateVariables(r, g, b, a, h, s, v, hex)

    elseif convert == "ColorPick" then
        local rgbString = SKIN:GetVariable("ColorPi")
        local r, g, b = rgbString:match("([^,]+),([^,]+),([^,]+)")
        local a = SKIN:GetVariable("A") or 255
        local h, s, v = rgbToHsv(r, g, b)
        local hex = rgbToHex(r, g, b)
        updateVariables(r, g, b, a, h, s, v, hex)

    elseif convert == "RGB" then
        local r = SKIN:GetVariable("R")
        local g = SKIN:GetVariable("G")
        local b = SKIN:GetVariable("B")
        local a = SKIN:GetVariable("A") or 255
        local tmp = SKIN:GetVariable("tmp2")
        if not verifyRGB(r, g, b, tmp) then
            return
        end
        r = math.max(0, math.min(255, r))
        g = math.max(0, math.min(255, g))
        b = math.max(0, math.min(255, b))
        local h, s, v = rgbToHsv(r, g, b)
        local hex = rgbToHex(r, g, b)
        updateVariables(r, g, b, a, h, s, v, hex)

    elseif convert == "HSV" then
        local h = SKIN:GetVariable("H")
        local s = SKIN:GetVariable("S")
        local v = SKIN:GetVariable("V")
        local a = SKIN:GetVariable("A") or 255
        local tmp = SKIN:GetVariable("tmp2")
        if not verifyHSV(h, s, v, tmp) then
            return
        end
        h = math.max(0, math.min(359.9, h))
        s = math.max(0, math.min(100, s))
        v = math.max(0, math.min(100, v))
        local r, g, b = hsvToRgb(h, s, v)
        local hex = rgbToHex(r, g, b)
        updateVariables(r, g, b, a, h, s, v, hex)

    elseif convert == "HEX" then
        local hexColor = SKIN:GetVariable("HexColor")
        local r, g, b, err = hexToRgb(hexColor)
        if r then
            local a = SKIN:GetVariable("A") or 255
            local h, s, v = rgbToHsv(r, g, b)
            local hex = rgbToHex(r, g, b)
            updateVariables(r, g, b, a, h, s, v, hex)
        else
            SKIN:Bang('!UpdateMeasure', 'InvalidCheck')
        end

    elseif convert == "RGBA" then
        local r = SKIN:GetVariable("R")
        local g = SKIN:GetVariable("G")
        local b = SKIN:GetVariable("B")
        local a = SKIN:GetVariable("A")
        if not verifyRGBA(r, g, b, a) then
            return
        end
        r = math.max(0, math.min(255, r))
        g = math.max(0, math.min(255, g))
        b = math.max(0, math.min(255, b))
        a = math.max(0, math.min(255, a))
        local h, s, v = rgbToHsv(r, g, b)
        local hex = rgbToHex(r, g, b)
        updateVariables(r, g, b, a, h, s, v, hex)

    elseif convert == "REVERTCOLOR" then
        local oldColor = SKIN:GetVariable("OldColor")
        local r, g, b, a = oldColor:match("([^,]+),([^,]+),([^,]+),([^,]+)")
        if not a then
            r, g, b = oldColor:match("([^,]+),([^,]+),([^,]+)")
            a = 255
        end
        local h, s, v = rgbToHsv(r, g, b)
        local hex = rgbToHex(r, g, b)
        updateVariables(r, g, b, a, h, s, v, hex)

    elseif convert == "REVERT" then
        local csn = SKIN:GetVariable("CSN")
        local colorName = csn:match("#%*(.-)%*#")
        local oldColor = SKIN:GetVariable("OldColor")
        local r, g, b, a = oldColor:match("([^,]+),([^,]+),([^,]+),([^,]+)")
        if not a then
            r, g, b = oldColor:match("([^,]+),([^,]+),([^,]+)")
            a = 255
        end
        local h, s, v = rgbToHsv(r, g, b)
        local hex = rgbToHex(r, g, b)
        updateVariables(r, g, b, a, h, s, v, hex)
        -- Используем функцию из ColorSelector_Start.lua для записи цвета
        SKIN:Bang('!CommandMeasure', 'ColorSelectorScript', 'RevertColor()')
    end
end