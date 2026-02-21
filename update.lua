-- STYRTA OS Update v2.0

local baseURL = "https://raw.githubusercontent.com/Ln4022/StyrtaOS/main/"

local files = {
    "startup",
    "system/core.lua",
    "apps/launcher.lua",
    "apps/sms.lua",
    "apps/inbox.lua",
    "update.lua",
    "version.txt"
}

print("Aktualizacja StyrtaOS...")
sleep(1)

if not fs.exists("data") then fs.makeDir("data") end

for i,file in ipairs(files) do
    print("Pobieranie: "..file)

    if fs.exists(file) then
        fs.delete(file)
    end

    shell.run("wget", baseURL..file, file)
end

print("")
print("Aktualizacja zakonczona!")
sleep(1)

os.reboot()
