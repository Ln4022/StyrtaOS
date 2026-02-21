-- STYRTA SMS App

local file = fs.open("system/sim.dat","r")
local myNumber = file.readLine()
file.close()

rednet.open(peripheral.getName(peripheral.find("modem")))

term.clear()
term.setCursorPos(1,1)

print("SMS")
print("")
write("Numer odbiorcy: ")
local to = read()

write("Wiadomosc: ")
local text = read()

rednet.broadcast({
    type = "sms",
    from = myNumber,
    to = to,
    text = text
}, "styrta_net")

print("")
print("Wyslano!")
sleep(1)
