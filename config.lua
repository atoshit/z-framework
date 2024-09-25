local Config <const> = {
    ServerName = "Z Framework",
    Debug = false,

    Color = {
        rgba = {r = 238, g = 172, b = 1, a = 255}, -- Yellow (https://htmlcolorcodes.com/fr/)
        hex = "#eeac01" -- Yellow (https://htmlcolorcodes.com/fr/)
    },

    Start = {
        spawn = {x = -221.74, y = -1053.19, z = 30.13, h = 164.00},
        cash = 5000, -- number or nil
        bank = 5000, -- number or nil
        item = {}, -- table or nil
        weapon = nil, -- table or nil
    }
}

_ENV.Config = Config