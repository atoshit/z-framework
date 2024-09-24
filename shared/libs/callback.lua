local table_unpack = table.unpack
local debug_getinfo = debug.getinfo
local msgpack_pack = msgpack.pack
local msgpack_unpack = msgpack.unpack
local msgpack_pack_args = msgpack.pack_args
local PENDING = 0
local RESOLVING = 1
local REJECTING = 2
local RESOLVED = 3
local REJECTED = 4

--- Ensure that the object is of the expected type
--- @param obj any: The object to check
--- @param typeof string|function: The expected type
--- @param opt_typeof string|nil: The optional expected type
--- @param errMessage string|nil: The error message
local function ensure(obj, typeof, opt_typeof, errMessage)
    local objtype = type(obj)
    local di = debug_getinfo(2)
    local errMessage = errMessage or (opt_typeof == nil and (di.name .. ' expected %s, but got %s') or (di.name .. ' expected %s or %s, but got %s'))
    if typeof ~= 'function' then
        if objtype ~= typeof and objtype ~= opt_typeof then
            Z.IO.Error((errMessage):format(typeof, (opt_typeof == nil and objtype or opt_typeof), objtype))
        end
    else
        if objtype == 'table' and not rawget(obj, '__cfx_functionReference') then
            Z.IO.Error((errMessage):format(typeof, (opt_typeof == nil and objtype or opt_typeof), objtype))
        end
    end
end

if IsDuplicityVersion() then

    --- Register a new server callback
    --- @param args table: The arguments
    function Z.Callback.RegisterServer(args)
        ensure(args, 'table'); ensure(args.eventName, 'string'); ensure(args.eventCallback, 'function')
        Z.IO.Trace(('Registering server callback %s'):format(args.eventName))

        local eventCallback = args.eventCallback
        local eventName = args.eventName
        local eventData = Z.Event.Register('z-server_callback:'..eventName, function(packed, src, cb)
            local source = tonumber(source)
            if not source then
                cb(msgpack_pack_args(eventCallback(src, table_unpack(msgpack_unpack(packed)))))
            else
                Z.Event.TriggerClient(('z-client_callback_response:%s:%s'):format(eventName, src), source, msgpack_pack_args(eventCallback(source, table_unpack(msgpack_unpack(packed)))))
            end
        end)
        return eventData
    end

    --- Trigger a client callback
    --- @param args table: The arguments
    function Z.Callback.TriggerClient(args)
        ensure(args, 'table'); ensure(args.source, 'string', 'number'); ensure(args.eventName, 'string'); ensure(args.args, 'table', 'nil'); ensure(args.timeout, 'number', 'nil'); ensure(args.timedout, 'function', 'nil'); ensure(args.callback, 'function', 'nil')

        if tonumber(args.source) > 0 then
            local ticket = tostring(args.source) .. 'x' .. tostring(GetGameTimer())
            local prom = promise.new()
            local eventCallback = args.callback
            local eventData = Z.Event.Register(('z-callback:retval:%s:%s:%s'):format(args.source, args.eventName, ticket), function(packed)
                if eventCallback and prom.state == PENDING then
                    Z.IO.Trace(('Callback %s received'):format(args.eventName))
                    eventCallback(table_unpack(msgpack_unpack(packed)))
                end
                prom:resolve(table_unpack(msgpack_unpack(packed)))
                RemoveEventHandler(eventData)
            end)

            Z.Event.TriggerClient(('z-client_callback:%s'):format(args.eventName), args.source, msgpack_pack(args.args or {}), ticket)

            if args.timeout ~= nil and args.timedout then
                local timedout = args.timedout
                SetTimeout(args.timeout * 1000, function()
                    if prom.state == PENDING or prom.state == REJECTED or prom.state == REJECTING then
                        timedout(prom.state)
                        if prom.state == PENDING then prom:reject() end
                        RemoveEventHandler(eventData)
                    end
                end)
            end

            if not eventCallback then
                return Citizen.Await(prom)
            end
        else
            error 'source should be higher than 0'
        end
    end

    --- Trigger a server callback
    --- @param args table: The arguments
    function Z.Callback.TriggerServer(args)
        ensure(args, 'table'); ensure(args.source, 'string', 'number'); ensure(args.eventName, 'string'); ensure(args.args, 'table', 'nil'); ensure(args.timeout, 'number', 'nil'); ensure(args.timedout, 'function', 'nil'); ensure(args.callback, 'function', 'nil')

        local prom = promise.new()
        local eventCallback = args.callback
        local eventName = args.eventName
        Z.Event.Trigger('z-server_callback:'..eventName, msgpack_pack(args.args or {}), args.source, function(packed)
            if eventCallback and prom.state == PENDING then
                eventCallback(table_unpack(msgpack_unpack(packed)))
                Z.IO.Trace(('Callback %s received'):format(args.eventName))
            end
            prom:resolve(table_unpack(msgpack_unpack(packed)))
        end)

        if args.timeout ~= nil and args.timedout then
            local timedout = args.timedout
            SetTimeout(args.timeout * 1000, function()
                if prom.state == PENDING or prom.state == REJECTED or prom.state == REJECTING then
                    timedout(prom.state)
                    if prom.state == PENDING then prom:reject() end
                end
            end)
        end

        if not eventCallback then
            return Citizen.Await(prom)
        end
    end
else
    local SERVER_ID = GetPlayerServerId(PlayerId())

    --- Register a new client callback
    --- @param args table: The arguments
    function Z.Callback.RegisterClient(args)
        ensure(args, 'table'); ensure(args.eventName, 'string'); ensure(args.eventCallback, 'function')
        Z.IO.Trace(('Registering client callback %s'):format(args.eventName))

        local eventCallback = args.eventCallback
        local eventName = args.eventName
        local eventData = Z.Event.Register('z-client_callback:'..eventName, function(packed, ticket)
            if type(ticket) == 'function' then
                ticket(msgpack_pack_args(eventCallback(table_unpack(msgpack_unpack(packed)))))
            else
                Z.Event.TriggerServer(('z-callback_retval:%s:%s:%s'):format(SERVER_ID, eventName, ticket), msgpack_pack_args(eventCallback(table_unpack(msgpack_unpack(packed)))))
            end
        end)
        return eventData
    end

    --- Trigger a server callback
    --- @param args table: The arguments
    function Z.Callback.TriggerServer(args)
        ensure(args, 'table'); ensure(args.args, 'table', 'nil'); ensure(args.eventName, 'string'); ensure(args.timeout, 'number', 'nil'); ensure(args.timedout, 'function', 'nil'); ensure(args.callback, 'function', 'nil')

        local prom = promise.new()
        local eventCallback = args.callback
        local eventData = Z.Event.Register(('z-client_callback_response:%s:%s'):format(args.eventName, SERVER_ID), function(packed)
            if eventCallback and prom.state == PENDING then
                Z.IO.Trace(('Callback %s received'):format(args.eventName))
                eventCallback(table_unpack(msgpack_unpack(packed)))
            end
            prom:resolve(table_unpack(msgpack_unpack(packed)))
            RemoveEventHandler(eventData)
        end)

        Z.Event.TriggerServer('z-server_callback:'..args.eventName, msgpack_pack(args.args))

        if args.timeout ~= nil and args.timedout then
            local timedout = args.timedout
            SetTimeout(args.timeout * 1000, function()
                if prom.state == PENDING or prom.state == REJECTED or prom.state == REJECTING then
                    timedout(prom.state)
                    if prom.state == PENDING then prom:reject() end
                    RemoveEventHandler(eventData)
                end
            end)
        end

        if not eventCallback then
            return Citizen.Await(prom)
        end
    end

    --- Trigger a client callback
    --- @param args table: The arguments
    function Z.Callback.TriggerClient(args)
        ensure(args, 'table'); ensure(args.eventName, 'string'); ensure(args.args, 'table', 'nil'); ensure(args.timeout, 'number', 'nil'); ensure(args.timedout, 'function', 'nil'); ensure(args.callback, 'function', 'nil')

        local prom = promise.new()
        local eventCallback = args.callback
        local eventName = args.eventName
        Z.Event.Trigger('z-client_callback:'..eventName, msgpack_pack(args.args or {}), function(packed)
            if eventCallback and prom.state == PENDING then
                eventCallback(table_unpack(msgpack_unpack(packed)))
                Z.IO.Trace(('Callback %s received'):format(args.eventName))
            end
            prom:resolve(table_unpack(msgpack_unpack(packed)))
        end)

        if args.timeout ~= nil and args.timedout then
            local timedout = args.timedout
            SetTimeout(args.timeout * 1000, function()
                if prom.state == PENDING or prom.state == REJECTED or prom.state == REJECTING then
                    timedout(prom.state)
                    if prom.state == PENDING then prom:reject() end
                end
            end)
        end

        if not eventCallback then
            return Citizen.Await(prom)
        end
    end
end

--[[ Example usage:

    Z.Callback.RegisterServer({
        eventName = "getPlayerData",
        eventCallback = function(source, test)
            local test = test + 1
            return test
        end
    })

    Z.Callback.TriggerServer({
        source = 1, -- Ensure this is a valid string or number
        eventName = "getPlayerData",
        args = { 1 },
        callback = function(response)
            print("Response received:", response)
        end,
        timeout = 5,
        timedout = function()
            print("Server did not respond in time.")
        end
    })
]]