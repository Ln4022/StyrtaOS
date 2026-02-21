-- STYRTA OS Updater v1.0

local user = "Ln4022"
local repo = "StyrtaOS"
local branch = "main"

local baseURL = "https://raw.githubusercontent.com/"..user.."/"..repo.."/"..branch.."/"

local files = {
    "startup",
    "system/core.lua",
    "apps/launcher.lua",
    "update.lua",
    "version.txt"
}

print("Aktualizacja StyrtaOS...")
sleep(1)

for i,file in ipairs(files) do
    print("Pobieranie: "..file)
    shell.run("wget", baseURL..file, file)
end

print("")
print("Aktualizacja zakonczona!")
sleep(1)

os.reboot()
