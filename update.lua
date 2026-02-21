-- STYRTA OS Updater v2.0

local user = "Ln4022"
local repo = "StyrtaOS"
local branch = "main"

local baseURL = "https://raw.githubusercontent.com/"..user.."/"..repo.."/"..branch.."/"

local files = {
    "startup",
    "system/core.lua",
    "system/setup.lua",
    "apps/launcher.lua",
    "update.lua",
    "version.txt"
}

print("Aktualizacja StyrtaOS...")
sleep(1)

for i,file in ipairs(files) do
    print("Aktualizowanie: "..file)

    -- usuwamy stary plik jesli istnieje
    if fs.exists(file) then
        fs.delete(file)
    end

    -- pobieramy nowy
    shell.run("wget", baseURL..file, file)
end

print("")
print("Aktualizacja zakonczona!")
sleep(1)

os.reboot()
