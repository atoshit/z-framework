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

            if r.license ~= license or r.name ~= GetPlayerName(source) then
                MySQL.execute('UPDATE `players` SET `license` = ?, `name` = ? WHERE `license` = ?', {license, GetPlayerName(source), license})
            end

            local position = json.decode(r.position)

            if position then
                Z.Event.TriggerClient('z-spawn:spawnPlayer', source, position.x, position.y, position.z, position.h)
            else
                Z.Event.TriggerClient('z-spawn:spawnPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
            end
        else
            Z.addPlayer(source, {inventory = {}})
            MySQL.execute('INSERT INTO `players` (`license`, `name`, `position`, `inventory`) VALUES (?, ?, ?, ?)', {license, GetPlayerName(source), json.encode({x = Config.Start.spawn.x, y = Config.Start.spawn.y, z = Config.Start.spawn.z, h = Config.Start.spawn.h}), json.encode{}})
            Z.Event.TriggerClient('z-spawn:spawnPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
        end
    end)

    TriggerClientEvent('z-framework:playerLoaded', -1)
    TriggerEvent('z-framework:playerLoaded')
end)

AddEventHandler('playerDropped', function()
    local source = source
    local player = Z.getPlayer(source)
    local coords = GetEntityCoords(GetPlayerPed(source))
    local h = GetEntityHeading(GetPlayerPed(source))

    MySQL.execute('UPDATE `players` SET `position` = ? WHERE `license` = ?', {json.encode({x = coords.x, y = coords.y, z = coords.z, h = h}), GetPlayerIdentifierByType(source, 'license')})

    local save = player.updateData()

    if save then
        Z.removePlayer(source)
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, playerId in ipairs(GetPlayers()) do
            local player = Z.getPlayer(playerId)
            local coords = GetEntityCoords(GetPlayerPed(playerId))
            local h = GetEntityHeading(GetPlayerPed(playerId))

            MySQL.execute('UPDATE `players` SET `position` = ? WHERE `license` = ?', {json.encode({x = coords.x, y = coords.y, z = coords.z, h = h}), GetPlayerIdentifierByType(playerId, 'license')})
            local save = player.updateData()

            if save then
                Z.removePlayer(source)
            end
        end
    else
        return
    end
end)