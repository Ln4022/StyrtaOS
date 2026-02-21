-- STYRTA OS Core v1.2 (Fixed Lock)

local file = fs.open("system/config","r")

if not file then
    print("Brak config!")
    sleep(2)
    os.shutdown()
end

local username = file.readLine() or ""
local pin = file.readLine() or ""
local theme = tonumber(file.readLine()) or colors.cyan

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

local attempts = 0
local unlocked = false

while not unlocked do
    term.clear()

    center(3,"STYRTA OS",theme)
    center(5,"Ekran blokady",colors.lightGray)

    term.setCursorPos(math.floor(w/2)-6,8)
    term.setTextColor(colors.white)
    write("Wpisz PIN: ")

    local input = read("*")

    if input == pin and pin ~= "" then
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

term.clear()
center(math.floor(h/2),"Odblokowano",colors.lime)
sleep(1)

shell.run("apps/launcher")
