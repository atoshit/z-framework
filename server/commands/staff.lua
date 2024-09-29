RegisterCommand('setrank', function(source, args)
    if source ~= 0 then
        return
    end

    if not args[1] then
        return Z.Io.Error('Argument "playerId" is missing.')
    end

    if not args[2] then
        return Z.Io.Error('Argument "rank" is missing.')
    end

    local target = Z.getPlayer(tonumber(args[1]))

    if not target then
        return Z.Io.Error('Player not found.')
    end

    if target.setRank(tostring(args[2])) then
        return Z.Io.Trace(('Rank of %s%s%s set to %s%s%s.'):format(Z.Enums.Color["Yellow"], target.getName(), Z.Enums.Color["Default"], Z.Enums.Color["Yellow"] ,target.getRank(), Z.Enums.Color["Default"]))
    end
end)

RegisterCommand('additem', function(source, args)
    if source ~= 0 then
        return
    end

    if not args[1] then
        return Z.Io.Error('Argument "playerId" is missing.')
    end

    if not args[2] then
        return Z.Io.Error('Argument "item" is missing.')
    end

    if not args[3] then
        return Z.Io.Error('Argument "quantity" is missing.')
    end

    local target = Z.getPlayer(tonumber(args[1]))

    if not target then
        return Z.Io.Error('Player not found.')
    end

    target.addInventoryItem(args[2], args[3])
end)

RegisterCommand('getinventory', function(source, args)
    if source ~= 0 then
        return
    end

    if not args[1] then
        return Z.Io.Error('Argument "playerId" is missing.')
    end

    local player = Z.getPlayer(tonumber(args[1]))

    if not player then
        return Z.Io.Error('Player not found.')
    end

    print(json.encode(player.getInventory()))
end)

RegisterCommand('clearinventory', function(source, args)
    if source ~= 0 then
        return
    end

    if not args[1] then
        return Z.Io.Error('Argument "playerId" is missing.')
    end

    local player = Z.getPlayer(tonumber(args[1]))

    if not player then
        return Z.Io.Error('Player not found.')
    end

    player.clearInventory()
end)