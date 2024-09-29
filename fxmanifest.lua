fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

author 'Atoshi'
description 'A simple framework for FiveM'
version '1.0.5'

-- zUI
ui_page "zUI/web/build/index.html"

files {
    -- zUI
    "zUI/theme.json",
    "zUI/web/build/index.html",
    "zUI/web/build/**/*",

    -- Water
    'addons/water.xml',
    'addons/weapons.meta'
}

shared_scripts {
    'config.lua',
    'init.lua',
    'exports.lua',

    -- Enums
    'shared/enums/color.lua',

    -- Libs
    'shared/libs/io.lua',
    'shared/libs/event.lua'
}

server_scripts {
    -- MySQL
    '@oxmysql/lib/MySQL.lua',

    -- zUI
    "zUI/version.lua",

    -- Functions
    'server/functions/*.lua',

    -- Class
    'server/class/*.lua',

    -- Manager
    'server/manager/*.lua',

    -- Commands
    'server/commands/*.lua',
}

client_scripts {
    -- zUI
    "zUI/init.lua",
    "zUI/menu.lua",
    "zUI/methods/*.lua",
    "zUI/functions/*.lua",
    "zUI/items/*.lua",

    -- Functions
    'client/functions/*.lua',

    -- Manager
    'client/manager/*.lua',

    -- Class
    'client/class/*.lua',

    -- Modules
    'client/modules/menu/*.lua',
}

exports {
    -- Event
    'Z.Event.Register',
    'Z.Event.Trigger',
    'Z.Event.TriggerServer'
}

server_exports {
    -- Event
    'Z.Event.Register',
    'Z.Event.Trigger',
    'Z.Event.TriggerClient'
}