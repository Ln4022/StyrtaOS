-- STYRTA OS Launcher v1.0

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)

print("STYRTA OS v1.0")
print("")
print("1 - Informacje o systemie")
print("2 - Restart")
print("")
write("Wybierz opcje: ")

local wybor = read()

if wybor == "1" then
    term.clear()
    term.setCursorPos(1,1)
    print("STYRTA OS")
    print("Wersja: 1.0.0")
    print("")
    print("System dziala poprawnie.")
    print("")
    print("Nacisnij enter...")
    read()
    shell.run("apps/launcher.lua")

elseif wybor == "2" then
    os.reboot()
else
    shell.run("apps/launcher.lua")
end
