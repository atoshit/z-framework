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

exports('Z.Callback.Register', function(name, playerId, timeout, callback, ...)
    Z.Callback.Register(name, playerId, timeout, callback, ...)
end)

function Z.Callback.Remove(name)
    callbacks[name] = nil
    Z.IO.Trace(("Callback %s removed"):format(name))
end

exports('Z.Callback.Remove', function(name)
    Z.Callback.Remove(name)
end)

function Z.Callback.TriggerWithTimeout(name, timeout, ...)
    local requestId = currentRequestId
    currentRequestId = currentRequestId + 1
    if (currentRequestId >= math.maxinteger) then
        currentRequestId = math.mininteger
    end

    TriggerServerEvent("Z-Callback:RequestServerCallback", name, requestId, { ... })

    local requestName = name .. tostring(requestId)
    callbackResponses[requestName] = true

    local endTime = GetGameTimer() + timeout
    while (callbackResponses[requestName] == true) do
        Wait(0)
        if (GetGameTimer() > endTime) then
            callbackResponses[requestName] = "ERROR"
            LogError("ServerCallback \"%s\" timed out after %sms!", name, timeout)
            break
        end
    end

    if (callbackResponses[requestName] == "ERROR") then return end

    local data = callbackResponses[requestName]
    callbackResponses[requestName] = nil
    return table.unpack(data)
end

exports('Z.Callback.TriggerWithTimeout', function(name, timeout, ...)
    Z.Callback.TriggerWithTimeout(name, timeout, ...)
end)

function Z.Callback.Trigger(name, ...)
    local result = Z.Callback.TriggerWithTimeout(name, 5000, ...)
    Z.IO.Trace(("Trigger for %s completed"):format(name))
    return result
end

exports('Z.Callback.Trigger', function(name, ...)
    Z.Callback.Trigger(name, ...)
end)

function Z.Callback.TriggerWithTimeoutAsync(name, timeout, callback, ...)
    local args = { ... }
    CreateThread(function()
        local result = Z.Callback.TriggerWithTimeout(name, timeout, table.unpack(args))
        callback(result)
    end)
end

exports('Z.Callback.TriggerWithTimeoutAsync', function(name, timeout, callback, ...)
    Z.Callback.TriggerWithTimeoutAsync(name, timeout, callback, ...)
end)

function Z.Callback.TriggerAsync(name, callback, ...)
    local args = { ... }
    CreateThread(function()
        local result = Z.Callback.Trigger(name, table.unpack(args))
        callback(result)
    end)
end

exports('Z.Callback.TriggerAsync', function(name, callback, ...)
    Z.Callback.TriggerAsync(name, callback, ...)
end)

RegisterNetEvent("Z-Callback:HandleClientCallback", function(name, requestId, data)
    if (callbacks[name] == nil) then
        LogError("ClientCallback \"%s\" does not exist!", name)
        TriggerServerEvent("Z-Callback:ClientCallbackDoesNotExist", name, requestId)
        return
    end

    local returnData = table.pack(pcall(callbacks[name], table.unpack(data)))
    if (not returnData[1]) then
        LogError(returnData[2] and "ClientCallback \"%s\" error: %s" or "ClientCallback \"%s\" ran into an error!", name, returnData[2])
        TriggerServerEvent("Z-Callback:ClientCallbackError", name, requestId, returnData[2])
        return
    end

    table.remove(returnData, 1)
    TriggerServerEvent("Z-Callback:ClientCallbackResponse", name .. tostring(requestId), returnData)
    Z.IO.Trace(("Z-Callback:cc for %s completed"):format(name))
end)

RegisterNetEvent("Z-Callback:HandleServerCallbackResponse", function(requestName, data)
    if (callbackResponses[requestName] == nil) then return end
    callbackResponses[requestName] = data
    Z.IO.Trace(("Z-Callback:scResponse for %s completed"):format(requestName))
end)

RegisterNetEvent("Z-Callback:ServerCallbackDoesNotExist", function(name, requestId)
    local requestName = name .. tostring(requestId)
    if (callbackResponses[requestName] == nil) then return end
    callbackResponses[requestName] = "ERROR"
    LogError("ServerCallback \"%s\" does not exist!", name)
    Z.IO.Trace(("Z-Callback:scDoesNotExist for %s completed"):format(name))
end)

RegisterNetEvent("Z-Callback:ServerCallbackError", function(name, requestId, errorMessage)
    local requestName = name .. tostring(requestId)
    if (callbackResponses[requestName] == nil) then return end
    callbackResponses[requestName] = "ERROR"
    LogError(errorMessage and "ServerCallback \"%s\" error: %s" or "ServerCallback \"%s\" ran into an error!", name, errorMessage)
    Z.IO.Trace(("Z-Callback:scError for %s completed"):format(name))
end)