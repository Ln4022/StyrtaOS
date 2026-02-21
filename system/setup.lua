-- STYRTA OS First Setup

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)

local w,h = term.getSize()

local function center(y,text,color)
    term.setTextColor(color or colors.white)
    term.setCursorPos(math.floor((w-#text)/2)+1,y)
    term.write(text)
end

center(3,"STYRTA OS",colors.cyan)
center(5,"Pierwsza konfiguracja",colors.lightGray)

-- Nazwa uzytkownika
term.setCursorPos(3,8)
term.setTextColor(colors.white)
write("Podaj nazwe uzytkownika: ")
local username = read()

-- PIN
term.setCursorPos(3,10)
write("Ustaw PIN (4 cyfry): ")
local pin = read("*")

-- Wybor koloru
term.setCursorPos(3,12)
write("Wybierz kolor motywu:")
term.setCursorPos(3,13)
print("1 - Cyan")
print("2 - Lime")
print("3 - Orange")
term.setCursorPos(3,16)
write("Opcja: ")
local wybor = read()

local theme = colors.cyan
if wybor == "2" then theme = colors.lime end
if wybor == "3" then theme = colors.orange end

-- Zapis konfiguracji
local file = fs.open("system/config","w")
file.writeLine(username)
file.writeLine(pin)
file.writeLine(theme)
file.close()

term.clear()
center(math.floor(h/2),"Konfiguracja zakonczona!",colors.lime)
sleep(2)

shell.run("system/core.lua")
