--- Player Class
--- @class Z.Player
Z.Players = {}

--- Create Player
--- @param source number The player's server ID.
--- @return table The player obj.
function Z.createPlayer(source, data)
    local player = {
        source = source,
        identifier = GetPlayerIdentifierByType(source, 'license'),
        discord = GetPlayerIdentifierByType(source, 'discord'):gsub("^discord:", ""),
        endpoint = tostring(GetPlayerEndpoint(source)),
        tokens = GetPlayerTokens(source),
        name = GetPlayerName(source),
        rank = data.rank or "user",
        bank = data.bank or 0,
        inventory = data.inventory or {},
        weapons = data.weapons or {},
        firstName = data.firstName or "Unknown",
        lastName = data.lastName or "Unknown",
        age = data.age or 21,
        sex = data.sex or "Homme",
    }

    Z.Io.Trace("Player created: " .. player.name)

    --- Get Name of the player
    --- @return string Name of the player.
    function player.getName()
        return player.name
    end

    --- Get Identifier of the player
    --- @return string Identifier of the player.
    function player.getIdentifier()
        return player.identifier
    end

    --- Get Discord of the player
    --- @return string Discord ID of the player.
    function player.getDiscord()
        return player.discord
    end

    --- Get Endpoint of the player
    --- @return string IP address of the player.
    function player.getEndpoint()
        return player.endpoint
    end

    --- Get Tokens of the player
    --- @return table Tokens of the player.
    function player.getTokens()
        return player.tokens
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
        if type(rank) ~= "string" then
            Z.Io.Error("Invalid 'rank' argument. Expected string.")
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
        if type(bank) ~= "number" then
            Z.Io.Error("Invalid 'bank' argument. Expected number.")
            return false
        end
        player.bank = bank
        return true
    end

    --- Add Bank Money of the player
    --- @param amount number Amount to add to the bank.
    --- @return boolean Return true if the bank money is added.
    function player.addBank(amount)
        if type(amount) ~= "number" then
            Z.Io.Error("Invalid 'amount' argument. Expected number.")
            return false
        end
        player.bank = player.bank + amount
        return true
    end

    --- Get First Name of the player
    --- @return string Return FirstName of the player.
    function player.getFirstName()
        return player.firstName
    end

    --- Set First Name of the player
    --- @param firstName string First Name of the player.
    --- @return boolean Return true if the first name is set.
    function player.setFirstName(firstName)
        if type(firstName) ~= "string" then
            Z.Io.Error("Invalid 'firstName' argument. Expected string.")
            return false
        end
        player.firstName = firstName
        return true
    end

    --- Get Last Name of the player
    --- @return string Return LastName of the player.
    function player.getLastName()
        return player.lastName
    end

    --- Set Last Name of the player
    --- @param lastName string Last Name of the player.
    --- @return boolean Return true if the last name is set.
    function player.setLastName(lastName)
        if type(lastName) ~= "string" then
            Z.Io.Error("Invalid 'lastName' argument. Expected string.")
            return false
        end
        player.lastName = lastName
        return true
    end

    --- Get Weapons of the player
    --- @return table Return Weapons of the player.
    function player.getWeapons()
        return player.weapons
    end

    --- Add Weapons of the player
    --- @param weaponName string Name of the weapon.
    --- @param ammoCount number Ammo count of the weapon.
    --- @return boolean Return true if the weapon is added.
    function player.addWeapon(weaponName, ammoCount)
        if type(weaponName) ~= "string" or type(ammoCount) ~= "number" then
            Z.Io.Error("Invalid arguments for addWeapon. Expected string and number.")
            return false
        end

        player.weapons[weaponName] = ammoCount
        GiveWeaponToPed(GetPlayerPed(source), GetHashKey(weaponName), ammoCount, true, false)
        return true
    end

    --- Restore Weapons of the player
    --- @return boolean Return true if the weapons are restored.
    function player.restoreWeapons()
        if not next(player.weapons) then
            return false
        end

        Z.Io.Trace("Restoring weapons for player: " .. player.name)

        for weaponName, ammoCount in pairs(player.weapons) do
            player.addWeapon(weaponName, ammoCount)
        end
        return true
    end

    --- Get Age of the player
    --- @return number Return Age of the player.
    function player.getAge()
        return player.age
    end

    --- Set Age of the player
    --- @param age number Age of the player.
    --- @return boolean Return true if the age is set.
    function player.setAge(age)
        if type(age) ~= "number" or age < 0 then
            Z.Io.Error("Invalid 'age' argument. Expected positive number.")
            return false
        end
        player.age = age
        return true
    end

    --- Get Sex of the player
    --- @return string Return Sex of the player.
    function player.getSex()
        return player.sex
    end

    --- Set Sex of the player
    --- @param sex string Sex of the player.
    --- @return boolean Return true if sex is set.
    function player.setSex(sex)
        if sex ~= "Homme" and sex ~= "Femme" then
            Z.Io.Error("Invalid 'sex' argument. Expected 'Homme' or 'Femme'.")
            return false
        end
        player.sex = sex
        return true
    end

    --- Update Player Data in the Database
    --- @return boolean Return true if data is updated successfully.
    function player.updateData()
        local success, result = pcall(function()
            return MySQL.Sync.execute("UPDATE players SET name = ?, bank = ?, inventory = ?, weapons = ?, rank = ?, firstname = ?, lastname = ?, age = ?, sex = ? WHERE license = ?", {
                player.name,
                player.bank,
                json.encode(player.inventory),
                json.encode(player.weapons),
                player.rank,
                player.firstName,
                player.lastName,
                player.age,
                player.sex,
                player.identifier
            })
        end)

        if success and result > 0 then
            Z.Io.Trace("Player data updated for " .. player.name)
            return true
        else
            Z.Io.Warn("Player data not updated for " .. player.name .. ". Error: " .. tostring(result))
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
        Z.Io.Warn("The player already exists.")
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
    if Z.Players[source] then
        Z.Players[source] = nil
        Z.Io.Trace("Player removed: " .. tostring(source))
    else
        Z.Io.Warn("Attempted to remove non-existent player: " .. tostring(source))
    end
end