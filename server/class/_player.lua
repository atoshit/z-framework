--- Player Class
--- @class Z.Player
--- @field identifier string The player's identifier.
--- @field getIdentifier fun():string Get the player's identifier.
--- @field name string The player's name.
--- @field getName fun():string Get the player's name.
--- @field firstName string The player's first name.
--- @field getFirstName fun():string Get the player's first name.
--- @field setFirstName fun(firstName:string):void Set the player's first name.
--- @field lastName string The player's last name.
--- @field getLastName fun():string Get the player's last name.
--- @field setLastName fun(lastName:string):void Set the player's last name.
--- @field age number The player's age.
--- @field getAge fun():number Get the player's age.
--- @field setAge fun(age:number):void Set the player's age
--- @field sex string Sex of the player.
--- @field getSex fun():string Get the sex
--- @field setSex fun(age:string):void Set the sex
Z.Players = {}

--- Create Player
--- @param source number The player's server ID.
--- @return table
function Z.createPlayer(source, data)
    local player = {
        identifier = GetPlayerIdentifier(source, 0),
        name = GetPlayerName(source),
        rank = data.rank or "user",
        firstName = data.firstName or "Unknown",
        lastName = data.lastName or "Unknown",
        age = data.age or 21,
        sex = data.sex or "Homme",
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

    function player:setFirstName(firstName)
        self.firstName = firstName
    end

    --- Set First Name of the player
    --- @param firstName string First Name of the player.
    function player:setFirstName(firstName)
        if not firstName then
            return Z.IO.Error("Argument 'firstName' is missing.")
        end

        self.firstName = firstName
    end

    function player:getLastName()
        return self.lastName
    end

    --- Set Last Name of the player
    --- @param lastName string Last Name of the player.
    function player:setLastName(lastName)
        if not lastName then
            return Z.IO.Error("Argument 'lastName' is missing.")
        end

        self.lastName = lastName
    end

    function player:getAge()
        return self.age
    end

    --- Set Age of the player
    --- @param age number Age of the player.
    function player:setAge(age)
        if not age then
            return Z.IO.Error("Argument 'age' is missing.")
        end

        self.age = age
    end

    function player:getSex()
        return self.sex
    end

    --- Set Sex of the player
    --- @param sex string Sex of the player.
    function player:setSex(sex)
        if not sex or sex ~= "Homme" or sex ~= "Femme" then
            return Z.IO.Error("Argument 'sex' is missing or invalid.")
        end

        self.sex = sex
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