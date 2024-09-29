local requestId = 0
local registeredCallbacks = {}

local function validateCallbackArguments(cbName, func)
    return type(cbName) == "string" and type(func) == "function"
end

--- Trigger a server callback.
--- @param cbName string The name of the callback to trigger
--- @param func function The function to call when the callback is triggered
function Z.TriggerServerCallback(cbName, func, ...)
    if not validateCallbackArguments(cbName, func) then
        Z.Io.Error("Invalid arguments to TriggerServerCallback.")
        return
    end

    registeredCallbacks[requestId] = func

    TriggerServerEvent("z-framework:triggerServerCallback", cbName, requestId, GetInvokingResource() or "unknown", ...)

    requestId = (requestId + 1) % 2^16
end

RegisterNetEvent("z-framework:serverCallback", function(RequestId, invoker, ...)
    local callback = registeredCallbacks[RequestId]
    if not callback then
        Z.Io.Error("Callback not registered: " .. RequestId)
        return
    end

    callback(...)
    registeredCallbacks[RequestId] = nil
end)