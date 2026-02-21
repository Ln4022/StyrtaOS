-- STYRTA OS GUI Launcher v1.2

-- Wczytanie config
local file = fs.open("system/config","r")
local username = file.readLine()
local pin = file.readLine()
local theme = tonumber(file.readLine()) or colors.cyan
file.close()

local w,h = term.getSize()

local function drawTopBar()
    term.setBackgroundColor(theme)
    term.setTextColor(colors.black)
    term.setCursorPos(1,1)
    term.clearLine()
    term.write(" STYRTA OS  |  "..username)
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

    drawTopBar()

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

    -- Informacje
    if inside(x,y,3,4,w-4,3) then
        term.setBackgroundColor(colors.black)
        term.clear()
        term.setCursorPos(2,3)
        print("STYRTA OS")
        print("")
        print("User: "..username)
        print("")
        print("Kliknij aby wrocic")
        os.pullEvent("mouse_click")
        drawUI()
    end

    -- Ustawienia (na razie placeholder)
    if inside(x,y,3,8,w-4,3) then
        term.setBackgroundColor(colors.black)
        term.clear()
        term.setCursorPos(2,3)
        print("Ustawienia (w budowie)")
        print("")
        print("Kliknij aby wrocic")
        os.pullEvent("mouse_click")
        drawUI()
    end

    -- Restart
    if inside(x,y,3,12,w-4,3) then
        os.reboot()
    end
end
