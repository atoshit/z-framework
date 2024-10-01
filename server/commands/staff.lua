RegisterCommand('addweapon', function(source, args, rawCommand)
    local player = Z.getPlayer(1)
    player.addWeapon('WEAPON_ASSAULTRIFLE', 100)
end)