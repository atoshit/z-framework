local function spawnPlayer()

end

local function loadPlayer()

end

Ctz.CreateThread(function()
    repeat
        Ctz.Wait(100)
    until NetworkIsSessionStarted() and NetworkIsPlayerActive(PlayerId())

    loadPlayer()
end)

