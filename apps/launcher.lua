-- STYRTA OS GUI Launcher v1.4 (SIM Ready)

-- Wczytanie config
local file = fs.open("system/config","r")
local username = file.readLine()
local pin = file.readLine()
local theme = tonumber(file.readLine()) or colors.cyan
file.close()

local w,h = term.getSize()

-- Sprawdz czy jest karta SIM
local hasSIM = fs.exists("system/sim.dat")

local function formatTime()
    local time = os.time()
    local hour = math.floor(time)
    local min = math.floor((time - hour) * 60)

    if hour < 10 then hour = "0"..hour end
    if min < 10 then min = "0"..min end

    return hour..":"..min
end

local function drawStatusBar()
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.black)
    term.setCursorPos(1,1)
    term.write(string.rep(" ", w))

    local leftText
    local rightText = ""

    if hasSIM then
        leftText = "T-Mobile"
        rightText = "5G ||||"
    else
        leftText = "Brak sieci"
    end

    local timeStr = formatTime()

    -- LEWA STRONA
    term.setCursorPos(2,1)
    term.write(leftText)

    -- PRAWA STRONA
    if rightText ~= "" then
        term.setCursorPos(w - #rightText - 1,1)
        term.write(rightText)
    end

    -- SRODEK (wycentrowany ale z zabezpieczeniem)
    local centerPos = math.floor((w - #timeStr)/2)+1

    -- jesli srodek nachodzilby na lewa czesc, przesun go
    if centerPos <= (#leftText + 3) then
        centerPos = #leftText + 4
    end

    -- jesli srodek nachodzilby na prawa czesc
    if rightText ~= "" and (centerPos + #timeStr) >= (w - #rightText - 2) then
        centerPos = (w - #rightText - 2) - #timeStr
    end

    term.setCursorPos(centerPos,1)
    term.write(timeStr)
end

local function drawButton(x,y,width,height,text,bg)
    term.setBackgroundColor(bg)
    for i=0,height-1 do
        term.setCursorPos(x,y+i)
        term.write(string.rep(" ",width))
    end

    term.setTextColor(colors.black)
    term.setCursorPos(x + math.floor((width-#text)/2), y + math.floor(height/2))
    term.write(text)
end

local function drawUI()
    term.setBackgroundColor(colors.black)
    term.clear()

    drawStatusBar()

    drawButton(3,4,w-4,3,"Informacje",colors.gray)
    drawButton(3,8,w-4,3,"Ustawienia",colors.gray)
    drawButton(3,12,w-4,3,"Restart",colors.red)
end

local function inside(x,y, bx,by,bw,bh)
    return x >= bx and x <= bx+bw-1 and y >= by and y <= by+bh-1
end

drawUI()

while true do
    local event, button, x, y = os.pullEvent("mouse_click")

    if inside(x,y,3,4,w-4,3) then
        term.setBackgroundColor(colors.black)
        term.clear()
        drawStatusBar()
        term.setCursorPos(2,3)
        print("STYRTA OS")
        print("")
        print("User: "..username)
        print("")
        print("Kliknij aby wrocic")
        os.pullEvent("mouse_click")
        drawUI()
    end

    if inside(x,y,3,8,w-4,3) then
        term.setBackgroundColor(colors.black)
        term.clear()
        drawStatusBar()
        term.setCursorPos(2,3)
        print("Ustawienia (w budowie)")
        print("")
        print("Kliknij aby wrocic")
        os.pullEvent("mouse_click")
        drawUI()
    end

    if inside(x,y,3,12,w-4,3) then
        os.reboot()
    end
end
