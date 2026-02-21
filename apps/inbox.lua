-- STYRTA Inbox

term.clear()
term.setCursorPos(1,1)

print("INBOX")
print("")

if not fs.exists("data/inbox.db") then
    print("Brak wiadomosci.")
    sleep(2)
    return
end

local file = fs.open("data/inbox.db","r")

local messages = {}
while true do
    local line = file.readLine()
    if not line then break end
    table.insert(messages, line)
end

file.close()

if #messages == 0 then
    print("Brak wiadomosci.")
    sleep(2)
    return
end

for i,msg in ipairs(messages) do
    local from,text = msg:match("([^|]+)|(.+)")
    print(i..". Od: "..from)
end

print("")
write("Wybierz numer: ")
local choice = tonumber(read())

if choice and messages[choice] then
    local from,text = messages[choice]:match("([^|]+)|(.+)")
    term.clear()
    term.setCursorPos(1,1)

    print("SMS")
    print("")
    print("Od: "..from)
    print("")
    print(text)
    print("")
    print("Kliknij aby wyjsc")

    os.pullEvent("mouse_click")
end
