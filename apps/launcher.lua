-- STYRTA OS Launcher v1.7 (Network + SMS)

-- ===== CONFIG =====
local file = fs.open("system/config","r")
local username = file.readLine()
local pin = file.readLine()
local theme = tonumber(file.readLine()) or colors.cyan
file.close()

local w,h = term.getSize()

-- ===== SIM =====
local hasSIM = false
local simNumber = nil
local simOperator = nil
local simStatus = nil

if fs.exists("system/sim.dat") then
    local simFile = fs.open("system/sim.dat","r")
    simNumber = simFile.readLine()
    simOperator = simFile.readLine()
    simStatus = simFile.readLine()
    simFile.close()

    if simStatus == "active" then
        hasSIM = true
    end
end

-- ===== NETWORK =====
local registered = false
local netOperator = nil
local netTech = nil
local netSignal = 0

local modem = peripheral.find("modem")
if modem then
    rednet.open(peripheral.getName(modem))
end

if hasSIM and modem then
    rednet.broadcast({
        type = "register",
        number = simNumber
    }, "styrta_net")

    local id, response = rednet.receive("styrta_net", 3)

    if response and response.status == "OK" then
        registered = true
        netOperator = response.operator
        netTech = response.tech
        netSignal = response.signal
    end
end

-- ===== UI HELPERS =====
local function formatTime()
    local time = os.time()
    local hour = math.floor(time)
    local min = math.floor((time - hour) * 60)

    if hour < 10 then hour = "0"..hour end
    if min < 10 then min = "0"..min end

    return hour..":"..min
end

local function signalBars(level)
    return string.rep("|", level)
end

local function drawStatusBar()
    term.setBackgroundColor(colors.gray)
    term.setTextColor(colors.black)
    term.setCursorPos(1,1)
    term.write(string.rep(" ", w))

    local leftText = "Brak sieci"
    local rightText = ""

    if registered then
        leftText = netOperator
        rightText = netTech.." "..signalBars(netSignal)
    end

    local timeStr = formatTime()

    term.setCursorPos(2,1)
    term.write(leftText)

    if rightText ~= "" then
        term.setCursorPos(w - #rightText - 1,1)
        term.write(rightText)
    end

    local centerPos = math.floor((w - #timeStr)/2)+1
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

    drawButton(3,4,w-4,3,"SMS",colors.gray)
    drawButton(3,8,w-4,3,"Informacje",colors.gray)
    drawButton(3,12,w-4,3,"Restart",colors.red)
end

local function inside(x,y,bx,by,bw,bh)
    return x >= bx and x <= bx+bw-1 and y >= by and y <= by+bh-1
end

-- ===== START UI =====
drawUI()

while true do
    local event, p1, p2, p3 = os.pullEvent()

    -- ===== ODBIOR SMS =====
    if event == "rednet_message" then
        local message = p2

        if type(message) == "table" and message.type == "sms" then
            term.setBackgroundColor(colors.black)
            term.clear()
            drawStatusBar()
            term.setCursorPos(2,3)

            print("Nowy SMS!")
            print("")
            print("Od: "..message.from)
            print("Tresc:")
            print(message.text)
            print("")
            print("Kliknij aby wrocic")

            os.pullEvent("mouse_click")
            drawUI()
        end
    end

    -- ===== KLIK =====
    if event == "mouse_click" then
        local button = p1
        local x = p2
        local y = p3

        -- SMS
        if inside(x,y,3,4,w-4,3) then
            shell.run("apps/sms.lua")
            drawUI()
        end

        -- Informacje
        if inside(x,y,3,8,w-4,3) then
            term.setBackgroundColor(colors.black)
            term.clear()
            drawStatusBar()
            term.setCursorPos(2,3)

            print("STYRTA OS")
            print("")
            print("User: "..username)

            if hasSIM then
                print("Numer: "..simNumber)
            else
                print("Brak SIM")
            end

            if registered then
                print("Zarejestrowano w sieci")
            else
                print("Nie zarejestrowano")
            end

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
end
