Ctz.CreateThread(function()
    local playerId = PlayerId()

    Z.Function.togglePvp(Config.TogglePvp, playerId)
    Z.Function.toggleNpcDrops(Config.ToggleNpcDrops, playerId)
    Z.Function.toggleNpcHealthRegeneration(Config.ToggleNpcHealthRegeneration, playerId)
    Z.Function.toggleDefaultWantedLevel(Config.ToggleDefaultWantedLevel, playerId)
    Z.Function.toggleDispatchService(Config.ToggleDispatchService, playerId)
    Z.Function.toggleScenarios(Config.ToggleScenarios)

    AddTextEntry('FE_THDR_GTAO', ("%s %s ~w~ | %s"):format(Config.Color.default, Config.ServerName, GetPlayerName(playerId)))
    ReplaceHudColour(116, Config.Color.rgba.r, Config.Color.rgba.g, Config.Color.rgba.b, Config.Color.rgba.a)
end)