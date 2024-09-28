local Config <const> = {
    ServerName = "Z Framework",
    Debug = false,

    Color = {
        rgba = {r = 238, g = 172, b = 1, a = 255}, -- Yellow (https://htmlcolorcodes.com/fr/)
        hex = "#eeac01", -- Yellow (https://htmlcolorcodes.com/fr/)
        default = "~y~" -- Yellow (https://docs.fivem.net/docs/game-references/text-formatting/)
    },

    Start = {
        spawn = {x = -221.74, y = -1053.19, z = 30.13, h = 164.00},
        cash = 5000,
        bank = 5000,
        item = {}, -- table or nil
        weapon = nil, -- table or nil
    },

    DiscordPresence = {
        appId = '1288422064188952639',
        largeImage = 'logo',
        largeText = 'developed by Atoshi',
        button = {label = 'Github', url = 'https://github.com/atoshit/z-framework'},
        waitTime = 10000
    },

    TogglePvp = true,
    ToggleNpcDrops = false,
    ToggleNpcHealthRegeneration = false,
    ToggleDefaultWantedLevel = true,
    ToggleDispatchService = true,
    ToggleScenarios = false,
    BigWater = false,

    Esc = {
        {Key = 'PM_SCR_MAP', Label = 'Carte'},
        {Key = 'PM_SCR_GAM', Label = 'Quitter'},
        {Key = 'PM_SCR_INF', Label = 'Informations'},
        {Key = 'PM_SCR_STA', Label = 'Statistiques'},
        {Key = 'PM_SCR_SET', Label = 'Paramètres'},
        {Key = 'PM_PANE_LEAVE', Label = 'Quitter ~y~Z Framework'},
        {Key = 'PM_PANE_QUIT', Label = 'Quitter ~y~FiveM~w~'},
        {Key = 'PM_SCR_GAL', Label = 'Photo'},
        {Key = 'PM_SCR_RPL', Label = 'Rockstar Editor'},
        {Key = 'PM_PANE_CFX', Label = '~y~Z Framework~w~'}
        -- ...
    }
}

_ENV.Config = Config