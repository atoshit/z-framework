Z.Event.Register('z-spawn:loadPlayer', function()
    local source = source
    local license = GetPlayerIdentifierByType(source, 'license')

    MySQL.fetch('SELECT * FROM `players` WHERE `license` = ?', {license}, function(result)
        if result[1] then
            if result[1].license ~= license or result[1].name ~= GetPlayerName(source) then
                MySQL.execute('UPDATE `players` SET `license` = ?, `name` = ? WHERE `license` = ?', {license, GetPlayerName(source), license})
            end

            local position = json.decode(result[1].position)

            if position then
                Z.Event.TriggerClient('z-spawn:spawnPlayer', source, position.x, position.y, position.z, position.h)
            else
                Z.Event.TriggerClient('z-spawn:spawnPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
            end
        else
            MySQL.execute('INSERT INTO `players` (`license`, `name`, `position`) VALUES (?, ?)', {license, GetPlayerName(source), json.encode({x = Config.Start.spawn.x, y = Config.Start.spawn.y, z = Config.Start.spawn.z, h = Config.Start.spawn.h})})
            Z.Event.TriggerClient('z-spawn:spawnPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
        end
    end)
end)

AddEventHandler('playerDropped', function()
    local source = source
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
    local h = GetEntityHeading(GetPlayerPed(source))

    MySQL.execute('UPDATE `players` SET `position` = ? WHERE `license` = ?', {json.encode({x = x, y = y, z = z, h = h}), GetPlayerIdentifierByType(source, 'license')})
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, playerId in ipairs(GetPlayers()) do
            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(playerId)))
            local h = GetEntityHeading(GetPlayerPed(playerId))

            MySQL.execute('UPDATE `players` SET `position` = ? WHERE `license` = ?', {json.encode({x = x, y = y, z = z, h = h}), GetPlayerIdentifierByType(playerId, 'license')})
        end
    else
        return
    end
end)