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

    'shared/enums/color.lua',
    'shared/libs/io.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua'
}