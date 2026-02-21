-- STYRTA OS Core v1.0

term.setBackgroundColor(colors.black)
term.clear()
term.setCursorPos(1,1)

print("STYRTA OS")
print("")
print("Ladowanie systemu...")
sleep(1)

shell.run("apps/launcher.lua")
