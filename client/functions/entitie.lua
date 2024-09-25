--- Request model
--- @param model string Model name
function Z.Functions.requestModel(model)
    if not IsModelInCdimage(model) or not IsModelValid(model) then
        Z.IO.Warn('(Z.Functions.requestModel) Model not found: ' .. model)
        return false
    end

    RequestModel(model)

    while not HasModelLoaded(model) do
        Ctz.Wait(100)
    end

    Z.IO.Trace('(Z.Functions.requestModel) Model loaded: ' .. model)
    return true
end

--- Set Player Model
--- @param model string Model name
function Z.Functions.setPlayerModel(player, model)
    if Z.Functions.requestModel(model) then
        SetPlayerModel(player, model)
        SetModelAsNoLongerNeeded(model)
        Z.IO.Trace('(Z.Functions.setPlayerModel) Player model set: ' .. model)
        return true
    end
end

--- Set Entity Coordinates
--- @param entity number Entity ID
--- @param x number X coordinate
--- @param y number Y coordinate
--- @param z number Z coordinate
--- @param deadFlag boolean Whether to disable physics for dead peds, too, and not just living peds.
--- @param ragdollFlag boolean A special flag used for ragdolling peds.
--- @param clearArea boolean Whether to clear any entities in the target area.
function Z.Functions.setEntityCoords(entity, x, y, z, deadFlag, ragdollFlag, clearArea)
    if not DoesEntityExist(entity) then
        Z.IO.Warn('(Z.Functions.setEntityCoords) Entity does not exist: ' .. entity)
        return false
    end

    SetEntityCoords(entity, x, y, z, false, deadFlag, ragdollFlag, clearArea)
    return true
end

--- Set Entity Heading
--- @param entity number Entity ID
--- @param heading number Heading
function Z.Functions.setEntityHeading(entity, heading)
    if not DoesEntityExist(entity) then
        Z.IO.Warn('(Z.Functions.setEntityHeading) Entity does not exist: ' .. entity)
        return false
    end

    SetEntityHeading(entity, heading)
    return true
end