--- Player Class
--- @class Z.Player
Z.Players = {}

--- Create Player
--- @param source number The player's server ID.
--- @return table The player obj.
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

    function player.getName()
        return player.name
    end

    function player.getIdentifier()
        return player.identifier
    end

    --- Get Rank of the player
    --- @return string Rank of the player.
    function player.getRank()
        return player.rank
    end

    --- Set Rank of the player
    --- @param rank string Rank of the player.
    --- @return boolean Return true if the rank is set.
    function player.setRank(rank)
        if not rank then
            Z.Io.Error("Argument 'rank' is missing.")
            return false
        end

        player.rank = rank
        return true
    end

    --- Get Bank Money of the player
    --- @return number Bank Money of the player.
    function player.getBank()
        return player.bank
    end

    --- Set Bank Money of the player
    --- @param bank number Bank Money of the player.
    --- @return boolean Return true if the bank money is set.
    function player.setBank(bank)
        if not bank then
            Z.Io.Error("Argument 'bank' is missing.")
            return false
        end

        player.bank = bank
        return true
    end

    --- Add Bank Money of the player
    --- @param bank number Bank Money of the player.
    --- @return boolean Return true if the bank money is added.
    function player.addBank(bank)
        if not bank then
            Z.Io.Error("Argument 'bank' is missing.")
            return false
        end

        player.bank = player.bank + bank
        return true
    end

    --- Add Inventory Item
    --- @param itemName string Item name.
    --- @param quantity number Item quantity.
    --- @return boolean Return true if the item is added.
    function player.addInventoryItem(itemName, quantity)
        if not itemName or not quantity then
            Z.Io.Error("Argument 'itemName' or 'quantity' is missing.")
            return false
        end

        if not player.inventory[itemName] then
            Z.Io.Trace("Item has been added to the inventory.")
            player.inventory[itemName] = quantity
            return true
        else
            Z.Io.Trace("Item has been added to the inventory.")
            player.inventory[itemName] = player.inventory[itemName] + quantity
            return true
        end
    end

    --- Remove Inventory Item
    --- @param itemName string Item name.
    --- @param quantity number Item quantity (optional).
    --- @return boolean Return true if the item is removed.
    function player.removeInventoryItem(itemName, quantity)
        if not itemName then
            Z.Io.Error("Argument 'itemName' or 'quantity' is missing.")
            return false
        end

        if not player.inventory[itemName] then
            Z.Io.Warn("Item not found in the inventory.")
            return false
        else
            if player.inventory[itemName] <= quantity  or not quantity then
                player.inventory[itemName] = nil
                return true
            end

            Z.Io.Trace("Item has been removed from the inventory.")
            player.inventory[itemName] = player.inventory[itemName] - quantity
            return true
        end
    end

    function player.getInventory()
        return player.inventory
    end

    --- Check if the player has the item
    --- @param itemName string Item name.
    --- @param quantity number Item quantity (optional).
    function player.hasItem(itemName, quantity)
        if not itemName then
            Z.Io.Error("Argument 'itemName' is missing.")
            return false
        end

        if quantity then
            if player.inventory[itemName] and player.inventory[itemName] >= quantity then
                return true
            else
                return false
            end
        else
            if player.inventory[itemName] then
                return true
            else
                return false
            end
        end
    end

    function player.clearInventory()
        player.inventory = {}
    end

    function player.getFirstName()
        return player.firstName
    end

    --- Set First Name of the player
    --- @param firstName string First Name of the player.
    --- @return boolean Return true if the first name is set.
    function player.setFirstName(firstName)
        if not firstName then
            Z.Io.Error("Argument 'firstName' is missing.")
            return false
        end

        player.firstName = firstName
        return true
    end

    function player.getLastName()
        return player.lastName
    end

    --- Set Last Name of the player
    --- @param lastName string Last Name of the player.
    --- @return boolean Return true if the last name is set.
    function player.setLastName(lastName)
        if not lastName then
            Z.Io.Error("Argument 'lastName' is missing.")
            return false
        end

        player.lastName = lastName
        return true
    end

    function player.getAge()
        return player.age
    end

    --- Set Age of the player
    --- @param age number Age of the player.
    --- @return boolean Return true if the age is set.
    function player.setAge(age)
        if not age then
            Z.Io.Error("Argument 'age' is missing.")
            return false
        end

        player.age = age
        print(player.age)
        return true
    end

    function player.getSex()
        return player.sex
    end

    --- Set Sex of the player
    --- @param sex string Sex of the player.
    --- @return boolean Return true if sex is set.
    function player.setSex(sex)
        if not sex or sex ~= "Homme" or sex ~= "Femme" then
            Z.Io.Error("Argument 'sex' is missing or invalid.")
            return false
        end

        player.sex = sex
        return true
    end

    function player.updateData()
        local rowsChanged = MySQL.Sync.execute("UPDATE players SET name = ?, bank = ?, inventory = ?, rank = ?, firstname = ?, lastname = ?, age = ?, sex = ?", {GetPlayerName(source), player.bank, json.encode(player.inventory), player.rank, player.firstName, player.lastName, player.age, player.sex})

        if rowsChanged > 0 then
            Z.Io.Trace("Player data updated.")
            return true
        else
            Z.Io.Warn("Player data not updated.")
            return false
        end
    end

    return player
end

--- Add Player
--- @param source number The player's server ID.
--- @param data table The player's data.
--- @return boolean Return true if the player is added.
function Z.addPlayer(source, data)
    if Z.Players[source] then
        Z.Io.Warn("Player already exists.")
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
