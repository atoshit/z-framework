Z.RegisterServerCallback('z-framework:inventory:getPlayerItems', function(source, cb)
    local player = Z.getPlayer(source)
    if not player then
        Z.Io.Error("Player not found.")
        return
    end
    cb(player.getInventory())
end)