--- Player Class
--- @class Z.Player
--- @field identifier string The player's identifier.
---- @field name string The player's name.
--- @field getName fun():string Get the player's name.
--- @field getIdentifier fun():string Get the player's identifier.
--- @field rank string The player's rank.
--- @field getRank fun():string Get the player's rank.
--- @field setRank fun(rank:string):void Set the player's rank.
--- @field bank number The player's bank money.
--- @field getBank fun():number Get the player's bank money.
--- @field setBank fun(bank:number):void Set the player's bank money.
--- @field addBank fun(bank:number):void Add the player's bank money.
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
        bank = data.bank or 0,
        inventory = data.inventory or {},
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

    --- Get Rank of the player
    --- @return string Rank of the player.
    function player:getRank()
        return self.rank
    end

    --- Set Rank of the player
    --- @param rank string Rank of the player.
    --- @return boolean Return true if the rank is set.
    function player:setRank(rank)
        if not rank then
            Z.IO.Error("Argument 'rank' is missing.")
            return false
        end

        self.rank = rank
        return true
    end

    --- Get Bank Money of the player
    --- @return number Bank Money of the player.
    function player:getBank()
        return self.bank
    end

    --- Set Bank Money of the player
    --- @param bank number Bank Money of the player.
    --- @return boolean Return true if the bank money is set.
    function player:setBank(bank)
        if not bank then
            Z.IO.Error("Argument 'bank' is missing.")
            return false
        end

        self.bank = bank
        return true
    end

    --- Add Bank Money of the player
    --- @param bank number Bank Money of the player.
    --- @return boolean Return true if the bank money is added.
    function player:addBank(bank)
        if not bank then
            Z.IO.Error("Argument 'bank' is missing.")
            return false
        end

        self.bank = self.bank + bank
        return true
    end

    --- Add Inventory Item
    --- @param itemName string Item name.
    --- @param quantity number Item quantity.
    --- @return boolean Return true if the item is added.
    function player:addInventoryItem(itemName, quantity)
        if not itemName or not quantity then
            Z.IO.Error("Argument 'itemName' or 'quantity' is missing.")
            return false
        end

        if not self.inventory[itemName] then
            Z.IO.Trace("Item has been added to the inventory.")
            self.inventory[itemName] = quantity
            return true
        else
            Z.IO.Trace("Item has been added to the inventory.")
            self.inventory[itemName] = self.inventory[itemName] + quantity
            return true
        end
    end

    --- Remove Inventory Item
    --- @param itemName string Item name.
    --- @param quantity number Item quantity.
    --- @return boolean Return true if the item is removed.
    function player:removeInventoryItem(itemName, quantity)
        if not itemName or not quantity then
            Z.IO.Error("Argument 'itemName' or 'quantity' is missing.")
            return false
        end

        if not self.inventory[itemName] then
            Z.IO.Warn("Item not found in the inventory.")
            return false
        else
            if self.inventory[itemName] < quantity then
                Z.IO.Warn("Item quantity is less than the quantity to remove.")
                return false
            end

            Z.IO.Trace("Item has been removed from the inventory.")
            self.inventory[itemName] = self.inventory[itemName] - quantity
            return true
        end
    end

    function player:getFirstName()
        return self.firstName
    end

    --- Set First Name of the player
    --- @param firstName string First Name of the player.
    --- @return boolean Return true if the first name is set.
    function player:setFirstName(firstName)
        if not firstName then
            Z.IO.Error("Argument 'firstName' is missing.")
            return false
        end

        self.firstName = firstName
        return true
    end

    function player:getLastName()
        return self.lastName
    end

    --- Set Last Name of the player
    --- @param lastName string Last Name of the player.
    --- @return boolean Return true if the last name is set.
    function player:setLastName(lastName)
        if not lastName then
            Z.IO.Error("Argument 'lastName' is missing.")
            return false
        end

        self.lastName = lastName
        return true
    end

    function player:getAge()
        return self.age
    end

    --- Set Age of the player
    --- @param age number Age of the player.
    --- @return boolean Return true if the age is set.
    function player:setAge(age)
        if not age then
            Z.IO.Error("Argument 'age' is missing.")
            return false
        end

        self.age = age
        return true
    end

    function player:getSex()
        return self.sex
    end

    --- Set Sex of the player
    --- @param sex string Sex of the player.
    --- @return boolean Return true if sex is set.
    function player:setSex(sex)
        if not sex or sex ~= "Homme" or sex ~= "Femme" then
            Z.IO.Error("Argument 'sex' is missing or invalid.")
            return false
        end

        self.sex = sex
        return true
    end

    return player
end

--- Add Player
--- @param source number The player's server ID.
--- @param data table The player's data.
--- @return boolean Return true if the player is added.
function Z.addPlayer(source, data)
    if Z.Players[source] then
        Z.IO.Warn("Player already exists.")
        return false
    end

    local player = Z.createPlayer(source, data)
    Z.Players[source] = player
    return true
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