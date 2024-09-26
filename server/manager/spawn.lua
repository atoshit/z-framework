Z.Event.Register('z-spawn:loadPlayer', function()
    local source = source
    local license = GetPlayerIdentifierByType(source, 'license')

    MySQL.fetch('SELECT `position` FROM `players` WHERE `license` = ?', {license}, function(result)
        if result[1] then
            local position = json.decode(result[1].position)

            if position then
                Z.Event.TriggerClient('z-spawn:loadPlayer', source, position.x, position.y, position.z, position.h)
            else
                Z.Event.TriggerClient('z-spawn:loadPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
            end
        else
            Z.Event.TriggerClient('z-spawn:loadPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
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