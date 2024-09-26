local Player = {}

local function loadPlayerModule()
    local fileContent = LoadResourceFile(GetCurrentResourceName(), 'server/class/_player.lua')
    if fileContent then
        Player = load(fileContent)()
    else
        Z.IO.Error("Impossible de charger player.lua")
    end
end

loadPlayerModule()

local PlayerManager = {}
PlayerManager.__index = PlayerManager

local players = {}

function PlayerManager:GetPlayer(source)
    if players[source] then
        return players[source]
    else
        local player = Player:new(source)
        players[source] = player
        return player
    end
end

function PlayerManager:RemovePlayer(source)
    players[source] = nil
end

AddEventHandler('playerDropped', function()
    local source = source
    PlayerManager:RemovePlayer(source)
end)

return PlayerManager
