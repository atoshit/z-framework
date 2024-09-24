local Config <const> = {
    ServerName = "Z Framework",
    Debug = false,

    Color = {
        rgba = {r = 238, g = 172, b = 1, a = 255}, -- Yellow (https://htmlcolorcodes.com/fr/)
        hex = "#eeac01" -- Yellow (https://htmlcolorcodes.com/fr/)
    },

    Start = {
        spawn = {x = 0, y = 0, z = 0, h = 0},
        cash = 5000, -- number or nil
        bank = 5000, -- number or nil
        item = {}, -- table or nil
        weapon = nil, -- table or nil
    }
}

_ENV.Config = Config