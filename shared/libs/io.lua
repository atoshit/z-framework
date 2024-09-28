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

function Z.Io.Trace(...) log("TRACE", ...) end
function Z.Io.Debug(...) log("DEBUG", ...) end
function Z.Io.Info(...) log("INFO", ...) end
function Z.Io.Warn(...) log("WARN", ...) end
function Z.Io.Error(...) log("ERROR", ...) end

Trace = Z.Io.Trace
Debug = Z.Io.Debug
Info = Z.Io.Info
Warn = Z.Io.Warn
Error = Z.Io.Error