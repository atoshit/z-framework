Ctz.CreateThread(function()
    local playerId = PlayerId()

    Z.Function.togglePvp(Config.TogglePvp, playerId)
    Z.Function.toggleNpcDrops(Config.ToggleNpcDrops, playerId)
    Z.Function.toggleNpcHealthRegeneration(Config.ToggleNpcHealthRegeneration, playerId)
    Z.Function.toggleDefaultWantedLevel(Config.ToggleDefaultWantedLevel, playerId)
    Z.Function.toggleDispatchService(Config.ToggleDispatchService, playerId)
    Z.Function.toggleScenarios(Config.ToggleScenarios)

    if Config.BigWater == true then
        local success = LoadWaterFromPath('z-framework', 'water.xml')
    end

    AddTextEntry('FE_THDR_GTAO', ("%s %s ~w~ | %s | %s/%s"):format(Config.Color.default, Config.ServerName, GetPlayerName(playerId), #GetActivePlayers(), GetConvar('sv_maxclients', '48')))
    ReplaceHudColourWithRgba(116, Config.Color.rgba.r, Config.Color.rgba.g, Config.Color.rgba.b, Config.Color.rgba.a)
end)