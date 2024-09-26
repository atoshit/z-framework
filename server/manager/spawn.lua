local playerPositions = {}

Z.Event.Register('z-spawn:loadPlayer', function()
    local source = source
    local license = GetPlayerIdentifierByType(source, 'license')

    if playerPositions[license] then
        local position = json.decode(playerPositions[license])
        Z.Event.TriggerClient('z-spawn:loadPlayer', source, position.x, position.y, position.z, position.h)
        return
    end

    MySQL.fetch('SELECT `position` FROM `players` WHERE `license` = ?', {license}, function(result)
        local position
        if result[1] then
            position = json.decode(result[1].position)
        end

        if position then
            Z.Event.TriggerClient('z-spawn:loadPlayer', source, position.x, position.y, position.z, position.h)
        else
            Z.Event.TriggerClient('z-spawn:loadPlayer', source, Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
        end
    end)
end)

AddEventHandler('playerDropped', function()
    local source = source
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
    local h = GetEntityHeading(GetPlayerPed(source))
    local license = GetPlayerIdentifierByType(source, 'license')

    playerPositions[license] = json.encode({x = x, y = y, z = z, h = h})
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for license, position in pairs(playerPositions) do
            MySQL.execute('UPDATE `players` SET `position` = ? WHERE `license` = ?', {position, license})
        end
    end
end)

Ctz.CreateThread(function()
    while true do
        for license, position in pairs(playerPositions) do
            MySQL.execute('UPDATE `players` SET `position` = ? WHERE `license` = ?', {position, license})
        end
        Ctz.Wait(60000)
    end
end)