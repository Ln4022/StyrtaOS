-- STYRTA OS Installer v1.1

local user = "Ln4022"
local repo = "StyrtaOS"
local branch = "main"

local baseURL = "https://raw.githubusercontent.com/"..user.."/"..repo.."/"..branch.."/"

local files = {
    "startup",
    "system/core.lua",
    "apps/launcher.lua",
    "apps/sms.lua",
    "update.lua",
    "version.txt"
}

print("Instalacja StyrtaOS...")
sleep(1)

-- Tworzenie folderow
if not fs.exists("system") then fs.makeDir("system") end
if not fs.exists("apps") then fs.makeDir("apps") end

-- Pobieranie plikow
for i,file in ipairs(files) do
    print("Pobieranie: "..file)

    if fs.exists(file) then
        fs.delete(file)
    end

    shell.run("wget", baseURL..file, file)
end

print("")
print("Instalacja zakonczona!")
sleep(1)

os.reboot()
