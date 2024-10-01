Z.Event.Register('z-spawn:loadPlayer', function()
    local source = source
    local license = GetPlayerIdentifierByType(source, 'license')
    local isNewPlayer = false

    MySQL.single('SELECT * FROM `players` WHERE `license` = ?', {license}, function(result)
        if result then
            local playerData = {
                bank = result.bank,
                inventory = json.decode(result.inventory) or {},
                weapons = json.decode(result.weapons) or {},
                rank = result.rank,
                firstName = result.firstname,
                lastName = result.lastname,
                age = result.age,
                sex = result.sex
            }
            Z.addPlayer(source, playerData)

            local playerInfo = {
                license = license,
                name = GetPlayerName(source),
                tokens = json.encode(GetPlayerTokens(source)),
                endpoint = tostring(GetPlayerEndpoint(source)),
                discord = GetPlayerIdentifierByType(source, 'discord'):gsub("^discord:", "")
            }

            if result.license ~= playerInfo.license or result.name ~= playerInfo.name or result.endpoint ~= playerInfo.endpoint or result.discord ~= playerInfo.discord then
                MySQL.update('UPDATE `players` SET `license` = ?, `name` = ?, `tokens` = ?, `endpoint` = ?, `discord` = ? WHERE `license` = ?', 
                    {playerInfo.license, playerInfo.name, playerInfo.tokens, playerInfo.endpoint, playerInfo.discord, result.license})
            end

            local position = json.decode(result.position) or Config.Start.spawn
            Z.Event.TriggerClient('z-spawn:spawnPlayer', source, position.x, position.y, position.z, position.h, isNewPlayer)

            Ctz.Wait(1000)
            Z.getPlayer(source).restoreWeapons()
        else
            isNewPlayer = true
            Z.addPlayer(source, {inventory = {}, weapons = {}})
            local defaultPosition = json.encode({x = Config.Start.spawn.x, y = Config.Start.spawn.y, z = Config.Start.spawn.z, h = Config.Start.spawn.h})
            MySQL.insert('INSERT INTO `players` (`license`, `tokens`, `endpoint`, `discord`, `name`, `position`, `inventory`, `weapons`) VALUES (?, ?, ?, ?, ?, ?, ?, ?)', 
                {license, json.encode(GetPlayerTokens(source)), tostring(GetPlayerEndpoint(source)), 
                GetPlayerIdentifierByType(source, 'discord'):gsub("^discord:", ""), GetPlayerName(source), 
                defaultPosition, '{}', '{}'})
            Z.Event.TriggerClient('z-spawn:spawnPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h, isNewPlayer)
        end

        TriggerClientEvent('z-framework:playerLoaded', -1, isNewPlayer)
        TriggerEvent('z-framework:playerLoaded')
    end)
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    local player = Z.getPlayer(source)
    if not player then return end

    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)
    local position = json.encode({x = coords.x, y = coords.y, z = coords.z, h = heading})

    MySQL.update('UPDATE `players` SET `position` = ? WHERE `license` = ?', {position, player.getIdentifier()})

    if player.updateData() then
        Z.removePlayer(source)
    end

    local message = ('Prénom: %s \n Nom: %s \n Rank: %s \n Position: %s \n License: %s \n Discord: <@%s> \n IP: %s \n Raison: %s')
        :format(player.getFirstName(), player.getLastName(), player.getRank(), position, 
                player.getIdentifier(), player.getDiscord(), player.getEndpoint(), reason)
    Z.Function.sendDiscordLog(Config.Logs.Leave, 16711680, 'Déconnexion', message, 'Z-Framework')
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, playerId in ipairs(GetPlayers()) do
            local ped = GetPlayerPed(playerId)
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            local position = json.encode({x = coords.x, y = coords.y, z = coords.z, h = heading})
            local license = GetPlayerIdentifierByType(playerId, 'license')

            MySQL.update('UPDATE `players` SET `position` = ? WHERE `license` = ?', {position, license})
        end
    end
end)