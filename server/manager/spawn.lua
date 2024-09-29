Z.Event.Register('z-spawn:loadPlayer', function()
    local source = source
    local license = GetPlayerIdentifierByType(source, 'license')

    MySQL.fetch('SELECT * FROM `players` WHERE `license` = ?', {license}, function(result)
        local r = result[1]

        if r then

            Z.addPlayer(source, {
                bank = r.bank,
                inventory = json.decode(r.inventory) or {},
                rank = r.rank,
                firstName = r.firstname,
                lastName = r.lastname,
                age = r.age,
                sex = r.sex
            })

            if r.license ~= license or r.name ~= GetPlayerName(source) or r.endpoint ~= tostring(GetPlayerEndpoint(source)) or r.discord ~= GetPlayerIdentifierByType(source, 'discord'):gsub("^discord:", "") then
                MySQL.execute('UPDATE `players` SET `license` = ?, `name` = ?, `tokens` = ?, `endpoint` = ?, `discord` = ?  WHERE `license` = ?', {license, GetPlayerName(source), json.encode(GetPlayerTokens(source)), tostring(GetPlayerEndpoint(source)), GetPlayerIdentifierByType(source, 'discord'):gsub("^discord:", ""), r.license})
            end

            local position = json.decode(r.position)

            if position then
                Z.Event.TriggerClient('z-spawn:spawnPlayer', source, position.x, position.y, position.z, position.h)
            else
                Z.Event.TriggerClient('z-spawn:spawnPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
            end
        else
            Z.addPlayer(source, {inventory = {}})
            MySQL.execute('INSERT INTO `players` (`license`, `tokens`, `endpoint`, `discord`, `name`, `position`, `inventory`) VALUES (?, ?, ?, ?, ?, ?, ?)', {license, json.encode(GetPlayerTokens(source)), tostring(GetPlayerEndpoint(source)), GetPlayerIdentifierByType(source, 'discord'):gsub("^discord:", ""), GetPlayerName(source), json.encode({x = Config.Start.spawn.x, y = Config.Start.spawn.y, z = Config.Start.spawn.z, h = Config.Start.spawn.h}), json.encode{}})
            Z.Event.TriggerClient('z-spawn:spawnPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
        end
    end)

    TriggerClientEvent('z-framework:playerLoaded', -1)
    TriggerEvent('z-framework:playerLoaded')
end)

AddEventHandler('playerDropped', function(reason)
    local source = source
    local player = Z.getPlayer(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local h = GetEntityHeading(GetPlayerPed(source))

    MySQL.execute('UPDATE `players` SET `position` = ? WHERE `license` = ?', {json.encode({x = coords.x, y = coords.y, z = coords.z, h = h}), GetPlayerIdentifierByType(source, 'license')})

    local save = player.updateData()

    local message = ('Prénom: %s \n Nom: %s \n Rank: %s \n Position: %s \n License: %s \n Discord: <@%s> \n IP: %s \n Raison: %s'):format(player.getFirstName(), player.getLastName(), player.getRank(), ('x: %s, y: %s, z: %s, h: %s'):format(coords.x, coords.y, coords.z, h), player.getIdentifier(), player.getDiscord(), player.getEndpoint(), reason)
    Z.Function.sendDiscordLog(Config.Logs.Leave, 16711680, 'Déconnexion', message, 'Z-Framework')

    if save then
        Z.removePlayer(source)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, playerId in pairs(GetPlayers()) do
            local coords = GetEntityCoords(GetPlayerPed(playerId))
            local h = GetEntityHeading(GetPlayerPed(playerId))

            MySQL.execute('UPDATE `players` SET `position` = ? WHERE `license` = ?', {json.encode({x = coords.x, y = coords.y, z = coords.z, h = h}), GetPlayerIdentifierByType(playerId, 'license')})
        end
    else
        return
    end
end)