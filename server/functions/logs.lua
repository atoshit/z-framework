--- Send a log to a discord webhook
--- @param webhook string The webhook URL
--- @param color number The color of the embed
--- @param title string The title of the embed
--- @param message string The message of the embed
--- @param footer string The footer of the embed
function Z.Function.sendDiscordLog(webhook, color, title, message, footer)
    local embeds = {
        {
            ['title'] = title,
            ['description'] = message,
            ['color'] = color,
            ["footer"] = {
                ["text"] = footer,
                ["icon_url"] = Config.Logo
            },
            ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ")
        }
    }

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({embeds = embeds}), {['Content-Type'] = 'application/json'})
end