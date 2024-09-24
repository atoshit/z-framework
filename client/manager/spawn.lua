local function spawnPlayer()

end

local function loadPlayer()

end

C.CreateThread(function()
    repeat
        C.Wait(100)
    until NetworkIsSessionStarted() and NetworkIsPlayerActive(PlayerId())

    loadPlayer()
end)

