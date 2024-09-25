Ctz.CreateThread(function()
    while true do
        SetDiscordAppId(Config.DiscordPresence.appId)
        SetDiscordRichPresenceAsset(Config.largeImage)
        SetDiscordRichPresenceAssetText(Config.largeText)

        if SetDiscordRichPresenceAction then
            SetDiscordRichPresenceAction(0, Config.DiscordPresence.button.label, Config.DiscordPresence.button.url)
        end

        Wait(Config.DiscordPresence.waitTime)
    end
end)