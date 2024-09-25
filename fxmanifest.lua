fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

author 'Atoshi'
description 'A simple framework for FiveM'
version '1.0.0'

shared_scripts {
    'config.lua',
    'init.lua',

    -- Enums
    'shared/enums/color.lua',

    -- Libs
    'shared/libs/io.lua',
    'shared/libs/event.lua'
}

server_scripts {
    -- MySQL
    '@oxmysql/lib/MySQL.lua',

    -- Functions
    'server/functions/*.lua',

    -- Manager
    'server/manager/*.lua',

    -- Class
    'server/class/*.lua',
}

client_scripts {
    -- Functions
    'client/functions/*.lua',

    -- Manager
    'client/manager/*.lua',

    -- Class
    'client/class/*.lua',
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