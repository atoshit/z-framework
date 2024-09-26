local function loadModule(module)
    local fileContent = LoadResourceFile(GetCurrentResourceName(), module)
    if fileContent then
        return load(fileContent)()
    else
        Z.IO.Error("Impossible de charger " .. moduleName .. ".lua")
    end
end

Z.Player = loadModule('server/class/_player.lua')
Z.PlayerManager = loadModule('server/manager/_player.lua')

function Z.GetPlayer(source)
    return Z.PlayerManager:GetPlayer(source)
end

_Z = Z
