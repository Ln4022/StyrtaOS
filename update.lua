-- STYRTA OS Update Script v2.0

local baseURL = "https://raw.githubusercontent.com/TWOJ_LOGIN/TWOJE_REPO/main/"

local files = {
    "startup",
    "update.lua",
    "version.txt",
    "system/core.lua",
    "apps/launcher.lua",
    "apps/sms.lua"
}

for i,file in ipairs(files) do
    print("Pobieranie: "..file)

    if fs.exists(file) then
        fs.delete(file)
    end

    shell.run("wget "..baseURL..file.." "..file)
end

print("")
print("Aktualizacja zakonczona!")
