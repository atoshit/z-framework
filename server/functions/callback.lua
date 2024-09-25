local callbackResponses = {}
local currentRequestId = math.mininteger
local callbacks = {}

local function LogError(text, ...)
    Z.IO.Error(text:format(...))
end

function Z.Callback.Register(name, callback)
    callbacks[name] = callback
    Z.IO.Trace(("Callback %s registered"):format(name))
end

exports('Z.Callback.Register', function(name, callback)
    Z.Callback.Register(name, callback)
end)

function Z.Callback.Remove(name)
    callbacks[name] = nil
    Z.IO.Trace(("Callback %s removed"):format(name))
end

exports('Z.Callback.Remove', function(name)
    Z.Callback.Remove(name)
end)

function Z.Callback.TriggerWithTimeout(name, playerId, timeout, ...)
    local requestId = currentRequestId
    currentRequestId = currentRequestId + 1
    if (currentRequestId >= math.maxinteger) then
        currentRequestId = math.mininteger
    end

    TriggerClientEvent("Z-Callback:HandleClientCallback", playerId, name, requestId, { ... })

    local requestName = name .. tostring(requestId)

    callbackResponses[requestName] = true

    local endTime = GetGameTimer() + timeout
    while (callbackResponses[requestName] == true) do
        Wait(0)

        if (GetGameTimer() > endTime) then
            callbackResponses[requestName] = "ERROR"

            LogError("ClientCallback \"%s\" timed out after %sms!", name, timeout)

            break
        end
    end

    if (callbackResponses[requestName] == "ERROR") then return end

    local data = callbackResponses[requestName]
    callbackResponses[requestName] = nil
    return table.unpack(data)
end

exports('Z.Callback.TriggerWithTimeout', function(name, playerId, timeout, ...)
    Z.Callback.TriggerWithTimeout(name, playerId, timeout, ...)
end)

function Z.Callback.Trigger(name, playerId, ...)
    local result = Z.Callback.TriggerWithTimeout(name, playerId, 5000, ...)
    Z.IO.Trace(("Trigger for %s completed"):format(name))
    return result
end

exports('Z.Callback.Trigger', function(name, playerId, ...)
    Z.Callback.Trigger(name, playerId, ...)
end)

function Z.Callback.TriggerWithTimeoutAsync(name, playerId, timeout, callback, ...)
    local args = { ... }
    CreateThread(function()
        local result = Z.Callback.TriggerWithTimeout(name, playerId, timeout, table.unpack(args))
        callback(result)
    end)
end

exports('Z.Callback.TriggerWithTimeoutAsync', function(name, playerId, timeout, callback, ...)
    Z.Callback.TriggerWithTimeoutAsync(name, playerId, timeout, callback, ...)
end)

function Z.Callback.TriggerAsync(name, playerId, callback, ...)
    local args = { ... }
    CreateThread(function()
        local result = Z.Callback.Trigger(name, playerId, table.unpack(args))
        callback(result)
        Z.IO.Trace(("TriggerAsync for %s completed"):format(name))
    end)
end

exports('Z.Callback.TriggerAsync', function(name, playerId, callback, ...)
    Z.Callback.TriggerAsync(name, playerId, callback, ...)
end)

RegisterServerEvent("Z-Callback:RequestServerCallback", function(name, requestId, data)
    if (callbacks[name] == nil) then
        LogError("ServerCallback \"%s\" does not exist!", name)
        TriggerClientEvent("Z-Callback:ServerCallbackDoesNotExist", source, name, requestId)
        return
    end

    local returnData = table.pack(pcall(callbacks[name], source, table.unpack(data)))
    if (not returnData[1]) then
        LogError(returnData[2] and "ServerCallback \"%s\" error: %s" or "ServerCallback \"%s\" ran into an error!", name, returnData[2])
        TriggerClientEvent("Z-Callback:ServerCallbackError", source, name, requestId, returnData[2])
        return
    end

    table.remove(returnData, 1)
    TriggerClientEvent("Z-Callback:HandleServerCallbackResponse", source, name .. tostring(requestId), returnData)
    Z.IO.Trace(("Z-Callback:sc for %s completed"):format(name))
end)

RegisterNetEvent("Z-Callback:ClientCallbackDoesNotExist", function(name, requestId)
    local requestName = name .. tostring(requestId)
    if (callbackResponses[requestName] == nil) then return end
    callbackResponses[requestName] = "ERROR"
    LogError("ServerCallback \"%s\" does not exist!", name)
    Z.IO.Trace(("Z-Callback:ccDoesNotExist for %s completed"):format(name))
end)

RegisterNetEvent("Z-Callback:ClientCallbackError", function(name, requestId, errorMessage)
    local requestName = name .. tostring(requestId)
    if (callbackResponses[requestName] == nil) then return end
    callbackResponses[requestName] = "ERROR"
    LogError(errorMessage and "ClientCallback \"%s\" error: %s" or "ClientCallback \"%s\" ran into an error!", name, errorMessage)
    Z.IO.Trace(("Z-Callback:ccError for %s completed"):format(name))
end)
