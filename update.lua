-- STYRTA OS Update Script v2.1

local baseURL = "https://raw.githubusercontent.com/Ln4022/StyrtaOS/main/"

local files = {
    "startup",
    "update.lua",
    "version.txt",
    "system/core.lua",
    "apps/launcher.lua",
    "apps/sms.lua"
}

print("Aktualizacja StyrtaOS...")
sleep(1)

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
