-- STYRTA OS Core v1.1 (Lockscreen)

local file = fs.open("system/config","r")
local username = file.readLine()
local pin = file.readLine()
local theme = tonumber(file.readLine())
file.close()

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)

local w,h = term.getSize()

local function center(y,text,color)
    term.setTextColor(color or colors.white)
    term.setCursorPos(math.floor((w-#text)/2)+1,y)
    term.write(text)
end

-- LOCK SCREEN
local attempts = 0
local unlocked = false

while not unlocked do
    term.setBackgroundColor(colors.black)
    term.clear()

    center(3,"STYRTA OS",theme)
    center(5,"Ekran blokady",colors.lightGray)

    term.setCursorPos(math.floor(w/2)-6,8)
    term.setTextColor(colors.white)
    write("Wpisz PIN: ")

    local input = read("*")

    if input == pin then
        unlocked = true
    else
        attempts = attempts + 1
        center(10,"Bledny PIN!",colors.red)
        sleep(1)

        if attempts >= 3 then
            center(12,"Za duzo prob!",colors.red)
            sleep(2)
            os.shutdown()
        end
    end
end

-- Po odblokowaniu
term.clear()
center(math.floor(h/2),"Odblokowano",colors.lime)
sleep(1)

shell.run("apps/launcher")
