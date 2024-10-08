--- Spawn Player
--- @param x number X coordinate
--- @param y number Y coordinate
--- @param z number Z coordinate
--- @param h number Heading
local function spawnPlayer(x, y, z, h, firstConnection)
    repeat
        Ctz.Wait(100)
    until DoesEntityExist(PlayerPedId())

    Z.Function.setPlayerModel(PlayerId(), 'mp_m_freemode_01')
    Z.Function.setEntityCoords(PlayerPedId(), x, y, z, false, false, false)
    Z.Function.setEntityHeading(PlayerPedId(), h)
    Z.Function.loadingHide()

    if DoesEntityExist(PlayerPedId()) then
        SetPedDefaultComponentVariation(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
        Z.Io.Trace('Player spawned successfully at coords: ' .. x .. ', ' .. y .. ', ' .. z)
        TriggerEvent('z-framework:playerSpawned', x, y, z, h, firstConnection)
        TriggerServerEvent('z-framework:playerSpawned', x, y, z, h, firstConnection)
    else
        Z.Io.Warn('Player failed to spawn at coords: ' .. x .. ', ' .. y .. ', ' .. z)
    end
end

Z.Event.Register('z-spawn:spawnPlayer', function(x, y, z, h, firstConnection)
    spawnPlayer(x, y, z, h, firstConnection)

end)

Ctz.CreateThread(function()
    Z.Event.TriggerServer('z-spawn:loadPlayer')
end)