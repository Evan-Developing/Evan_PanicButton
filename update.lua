local script = GetCurrentResourceName()

local function checkVersion(err, responseText, headers)
    local curVersion = LoadResourceFile(script, "version")
    if curVersion == nil then
        print("[^1"..script.."^7] Version file not found!")
        return
    end
    
    local version = string.gsub(curVersion, "%s+", "")
    if responseText == nil then
        print("[^1"..script.."^7] Check for script update ^1FAILED^7")
        return
    end

    responseText = string.gsub(responseText, "%s+", "")
    
    print("curVersion: " .. tostring(version))

    if version ~= responseText and tonumber(version) < tonumber(responseText) then
        print("^1----------------------------------------------------------------------------------^7")
        print("[^3"..script.."^7] is outdated, latest version is: ^2"..responseText.."^7, installed version: ^1"..version.."^7!\nupdate from https://github.com/Evan-Developing/Evan_PanicButton/tree/main")
        print("^1----------------------------------------------------------------------------------^7")
    elseif tonumber(version) > tonumber(responseText) then
        print("^3----------------------------------------------------------------------------------^7")
        print("[^3"..script.."^7] git version is: ^2"..responseText.."^7, installed version: ^1"..version.."^7!")
        print("^3----------------------------------------------------------------------------------^7")
    else
        print("[^2"..script.."^7] is up to date (^2"..version.."^7) ")
    end
end

Citizen.CreateThread(function()
    PerformHttpRequest("https://raw.githubusercontent.com/Evan-Developing/Evan_PanicButton/main/version", checkVersion, "GET")
end)
