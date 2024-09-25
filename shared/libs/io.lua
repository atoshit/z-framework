--- Format console messages with color
--- @vararg any Messages to format
local function formatConsoleMsg(...)
    local args = {...}
    local colorDefault = Z.Enums.Color["Default"]
    for i = 1, #args do
        if args[i] ~= nil then
            args[i] = ("%s%s%s"):format(colorDefault, args[i], colorDefault)
        end
    end
    return table.concat(args)
end

local LogLevels = {
    TRACE = {color = Z.Enums.Color["Purple"], prefix = "TRACE"},
    DEBUG = {color = Z.Enums.Color["Purple"], prefix = "DEBUG"},
    INFO = {color = Z.Enums.Color["Cyan"], prefix = "INFO"},
    WARN = {color = Z.Enums.Color["Yellow"], prefix = "WARN"},
    ERROR = {color = Z.Enums.Color["Red"], prefix = "ERROR"}
}

--- Log a message to the console
--- @param level string The log level
--- @vararg any Messages to log
local function log(level, ...)
    if level == "DEBUG" and not Config.Debug then return end

    local args = {...}
    local levelConfig = LogLevels[level]
    args[1] = ("[%s%s%s] %s"):format(levelConfig.color, levelConfig.prefix, Z.Enums.Color["Default"], args[1])
    print(formatConsoleMsg(table.unpack(args)))
end

function Z.IO.Trace(...) log("TRACE", ...) end
function Z.IO.Debug(...) log("DEBUG", ...) end
function Z.IO.Info(...) log("INFO", ...) end
function Z.IO.Warn(...) log("WARN", ...) end
function Z.IO.Error(...) log("ERROR", ...) end

Trace = Z.IO.Trace
Debug = Z.IO.Debug
Info = Z.IO.Info
Warn = Z.IO.Warn
Error = Z.IO.Error