C.CreateThread(function()
    repeat
        C.Wait(100)
    until NetworkIsSessionStarted() and NetworkIsPlayerActive(PlayerId())
end)