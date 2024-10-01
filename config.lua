local Config <const> = {
    ServerName = "Z-Framework",
    Debug = false,
    Logo = 'https://cdn.discordapp.com/attachments/1287619759537393685/1287620300342825052/Z_LOGO_96.png?ex=66fa1e5a&is=66f8ccda&hm=ebc3f430be765cafa6f84291de3f260f86061e1c3a324bc6273fc901ac8c0afa&',

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

    Menu = {
        Banner = "https://cdn.discordapp.com/attachments/1287155646860628001/1289532687903883324/Capture.PNG?ex=66f92a67&is=66f7d8e7&hm=c8fea5beb736812c82f428845dfa9381007e2168b8a6f62f2bd2a25899f409dd&",
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
    ToggleDefaultWantedLevel = false,
    ToggleDispatchService = false,
    ToggleScenarios = false,
    BigWater = false,

    Esc = {
        {Key = 'PM_SCR_MAP', Label = 'Carte'},
        {Key = 'PM_SCR_GAM', Label = 'Quitter'},
        {Key = 'PM_SCR_INF', Label = 'Informations'},
        {Key = 'PM_SCR_STA', Label = 'Statistiques'},
        {Key = 'PM_SCR_SET', Label = 'Paramètres'},
        {Key = 'PM_PANE_LEAVE', Label = 'Quitter ~y~Z-Framework'},
        {Key = 'PM_PANE_QUIT', Label = 'Quitter ~y~FiveM~w~'},
        {Key = 'PM_SCR_GAL', Label = 'Photo'},
        {Key = 'PM_SCR_RPL', Label = 'Rockstar Editor'},
        {Key = 'PM_PANE_CFX', Label = '~y~Z-Framework~w~'}
        -- ...
    },

    Logs = {
        Leave = 'https://discordapp.com/api/webhooks/1289944993536020550/DVYUHt7nT_5aQitDd-BiqJOmx5gVzsVF_YTljiKCpr2Ehm089J3xGMDBtKPsPp_AuoVk'
    },

    -- Ranks
    Ranks = {
        {name = 'user', label = 'Utilisateur', color = '~w~'},
        {name = 'mod', label = 'Administrateur', color = '~b~'},
        {name = 'admin', label = 'Administrateur', color = '~p~'},
        {name = 'superadmin', label = 'Administrateur', color = '~y~'},
        {name = 'owner', label = 'Administrateur', color = '~r~'},
        {name = 'dev', label = 'Administrateur', color = '~l~'},
    },

    -- Permissions
    Permissions = {
        ['openAdminMenu'] = {'admin', 'superadmin', 'owner', 'dev'},
        ['noclip'] = {'admin', 'superadmin', 'owner', 'dev'},
        ['giveBankMoney'] = {'admin', 'superadmin', 'owner', 'dev'},
        ['giveItem'] = {'admin', 'superadmin', 'owner', 'dev'},
        ['giveWeapon'] = {'admin', 'superadmin', 'owner', 'dev'},
        ['giveWeaponComponent'] = {'admin', 'superadmin', 'owner', 'dev'},
        ['spawnVehicle'] = {'admin', 'superadmin', 'owner', 'dev'}
    },
}

_ENV.Config = Config