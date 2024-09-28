local registeredEvents = {}

local CONTEXT_SERVER_TO_SERVER = "[S->S]"
local CONTEXT_CLIENT_TO_SERVER = "[C->S]"
local CONTEXT_SERVER_TO_CLIENT = "[S->C]"
local CONTEXT_CLIENT_TO_CLIENT = "[C->C]"

--- Log an event
--- @param action string The action
--- @param name string The event name
--- @param context string The event context
local function logEvent(action, name, context)
    Z.Io.Trace(("%s %s %s"):format(action, name, context))
end

--- Warn if an event is not registered
--- @param name string The event name
local function warnEvent(name)
    Z.Io.Warn(("Event %s not registered"):format(name))
end

--- Register a new event
--- @param name string The event name
--- @param cb function The callback function
function Z.Event.Register(name, cb)
    if not name or type(cb) ~= "function" then
        Z.Io.Warn("Invalid event name or callback function")
        return
    end
    if not registeredEvents[name] then
        registeredEvents[name] = true
        RegisterNetEvent(name)
        AddEventHandler(name, cb)
        logEvent("Event", name, "registered")
    else
        Z.Io.Warn(("Event %s already registered"):format(name))
    end
end

--- Trigger an event
--- @param name string The event name
--- @vararg any The event arguments
function Z.Event.Trigger(name, ...)
    if registeredEvents[name] then
        TriggerEvent(name, ...)
        logEvent("Event", name, (IsDuplicityVersion() and CONTEXT_SERVER_TO_SERVER or CONTEXT_CLIENT_TO_CLIENT))
    else
        warnEvent(name)
    end
end

if IsDuplicityVersion() then

    --- Trigger a client event
    --- @param name string The event name
    --- @param playerId number The player id
    --- @vararg any The event arguments
    function Z.Event.TriggerClient(name, playerId, ...)
        TriggerClientEvent(name, playerId, ...)
        if playerId == -1 then
            logEvent("Event", name, CONTEXT_SERVER_TO_CLIENT .. " for all players")
        else
            logEvent("Event", name, CONTEXT_SERVER_TO_CLIENT .. (" for player %s"):format(playerId))
        end
    end

else

    --- Trigger a server event
    --- @param name string The event name
    --- @vararg any The event arguments
    function Z.Event.TriggerServer(name, ...)
        TriggerServerEvent(name, ...)
        logEvent("Event", name, CONTEXT_CLIENT_TO_SERVER)
    end

end