local function spawnPlayer(x, y, z, h)
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
        SetEntityVisible(PlayerPedId(), true)
        Z.IO.Trace('Player spawned successfully at coords: ' .. x .. ', ' .. y .. ', ' .. z)
    else
        Z.IO.Warn('Player failed to spawn at coords: ' .. x .. ', ' .. y .. ', ' .. z)
    end
end

local function loadPlayer()
    repeat
        Ctz.Wait(100)
    until NetworkIsPlayerActive(PlayerId())

    Z.IO.Trace('Player is active, spawning player...')

    local test = Z.Callback.Trigger("getVehiclePositionFromPlate", 1)
    print(test)

    spawnPlayer(Config.Start.spawn.x, Config.Start.spawn.y, Config.Start.spawn.z, Config.Start.spawn.h)
end

Ctz.CreateThread(function()
    repeat
        Ctz.Wait(100)
    until NetworkIsSessionStarted()

    Z.IO.Trace('Session started, loading player...')
    loadPlayer()
end)

