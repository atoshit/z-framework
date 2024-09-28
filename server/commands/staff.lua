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
