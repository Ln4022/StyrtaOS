-- STYRTA OS Installer v2.0

local user = "Ln4022"
local repo = "StyrtaOS"
local branch = "main"

local baseURL = "https://raw.githubusercontent.com/"..user.."/"..repo.."/"..branch.."/"

local files = {
    "startup",
    "system/core.lua",
    "apps/launcher.lua",
    "apps/sms.lua",
    "apps/inbox.lua",
    "update.lua",
    "version.txt"
}

print("Instalacja StyrtaOS...")
sleep(1)

if not fs.exists("system") then fs.makeDir("system") end
if not fs.exists("apps") then fs.makeDir("apps") end
if not fs.exists("data") then fs.makeDir("data") end

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
