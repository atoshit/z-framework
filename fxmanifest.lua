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
    'shared/libs/event.lua',
    'shared/libs/callback.lua',
}

server_scripts {
    -- MySQL
    '@oxmysql/lib/MySQL.lua',

    -- Manager
    'server/manager/*.lua',

    -- Class
    'server/class/*.lua',
}

client_scripts {
    -- Manager
    'client/manager/*.lua',

    -- Class
    'client/class/*.lua',
}

exports {
    -- Event
    'Z.Event.Register',
    'Z.Event.Trigger',
    'Z.Event.TriggerServer',

    -- Callback
    'Z.Callback.RegisterClient',
    'Z.Callback.UnregisterClient',
    'Z.Callback.TriggerClient',
    'Z.Callback.TriggerServer'
}

server_exports {
    -- Event
    'Z.Event.Register',
    'Z.Event.Trigger',
    'Z.Event.TriggerClient',

    -- Callback
    'Z.Callback.RegisterServer',
    'Z.Callback.UnregisterServer',
    'Z.Callback.TriggerClient',
    'Z.Callback.TriggerServer'
}