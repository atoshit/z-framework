local Player = {}
Player.__index = Player

function Player:new(source)
    local instance = setmetatable({}, Player)
    instance.source = source
    instance.license = GetPlayerIdentifierByType(source, 'license')
    instance.name = GetPlayerName(source)
    return instance
end

function Player:getSource()
    return self.source
end

function Player:getLicense()
    return self.license
end

function Player:getName()
    return self.name
end

return Player