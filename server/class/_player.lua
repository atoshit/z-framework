--- Player Class
--- @class Z.Player
--- @field identifier string The player's identifier.
--- @field getIdentifier fun():string Get the player's identifier.
--- @field name string The player's name.
--- @field getName fun():string Get the player's name.
--- @field firstName string The player's first name.
--- @field getFirstName fun():string Get the player's first name.
--- @field lastName string The player's last name.
--- @field getLastName fun():string Get the player's last name.
--- @field age number The player's age.
--- @field getAge fun():number Get the player's age.
Z.Players = {}

--- Create Player
--- @param source number The player's server ID.
--- @return table
function Z.createPlayer(source, data)
    local player = {
        identifier = GetPlayerIdentifier(source, 0),
        name = GetPlayerName(source),
        firstName = data.firstName or 'Unknown',
        lastName = data.lastName or 'Unknown',
        age = data.age or 21,
        sex = data.sex or 'Homme',
    }

    function player:getName()
        return self.name
    end

    function player:getIdentifier()
        return self.identifier
    end

    function player:getFirstName()
        return self.firstName
    end

    function player:getLastName()
        return self.lastName
    end

    function player:getAge()
        return self.age
    end

    function player:getSex()
        return self.sex
    end

    return player
end

--- Add Player
--- @param source number The player's server ID.
function Z.addPlayer(source, data)
    local player = Z.createPlayer(source, data)
    Z.Players[source] = player
end

--- Get Player
--- @param source number The player's server ID.
--- @return table Return the player.
function Z.getPlayer(source)
    return Z.Players[source]
end

--- Remove Player
--- @param source number The player's server ID.
function Z.removePlayer(source)
    Z.Players[source] = nil
end