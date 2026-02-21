-- STYRTA OS Core

local file = fs.open("system/config","r")
local username = file.readLine()
local pin = file.readLine()
local theme = tonumber(file.readLine())
file.close()

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)

term.setTextColor(theme)
print("STYRTA OS")
term.setTextColor(colors.white)
print("")
print("Witaj, "..username)
sleep(1)

shell.run("apps/launcher.lua")
