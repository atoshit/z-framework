--- Disables NPC weapon pickups for the player.
--- @param playerId number The ID of the player to disable NPC drops for.
function Z.Function.toggleNpcDrops(state, playerId)
    local weaponPickups = {
        `PICKUP_WEAPON_CARBINERIFLE`,
        `PICKUP_WEAPON_PISTOL`,
        `PICKUP_WEAPON_PUMPSHOTGUN`
    }
    for _, pickup in ipairs(weaponPickups) do
        ToggleUsePickupsForPlayer(playerId, pickup, state)
    end
    Z.Io.Trace("(Z.Function.toggleNpcDrops) Npc drops: ", state)
end

--- Disables NPC health regeneration for the player.
--- @param playerId number The ID of the player to disable NPC health regeneration for.
function Z.Function.toggleNpcHealthRegeneration(state, playerId)
    if state then
        SetPlayerHealthRechargeMultiplier(playerId, 1.0)
    else
        SetPlayerHealthRechargeMultiplier(playerId, 0.0)
    end
    Z.Io.Trace("(Z.Function.toggleNpcHealthRegeneration) Npc health regeneration: ", state)
end

--- Disables the default wanted level for the player.
--- @param playerId number The ID of the player to disable the default wanted level for.
function Z.Function.toggleDefaultWantedLevel(state, playerId)
    if state then
        SetMaxWantedLevel(5)
    else
        ClearPlayerWantedLevel(playerId)
        SetMaxWantedLevel(0)
    end
    Z.Io.Trace("(Z.Function.toggleDefaultWantedLevel) Default wanted level: ", state)
end

--- Disables police dispatch for the player.
--- @param playerId number The ID of the player to disable dispatch for.
function Z.Function.toggleDispatchService(state, playerId)
    SetDispatchCopsForPlayer(playerId, state)
    Z.Io.Trace("(Z.Function.toggleDispatchService) Dispatch service: ", state)
end

--- Disables various world scenarios.
function Z.Function.toggleScenarios(state)
    local scenarios = {
        "WORLD_VEHICLE_ATTRACTOR", "WORLD_VEHICLE_AMBULANCE", "WORLD_VEHICLE_BICYCLE_BMX",
        "WORLD_VEHICLE_BICYCLE_BMX_BALLAS", "WORLD_VEHICLE_BICYCLE_BMX_FAMILY", "WORLD_VEHICLE_BICYCLE_BMX_HARMONY",
        "WORLD_VEHICLE_BICYCLE_BMX_VAGOS", "WORLD_VEHICLE_BICYCLE_MOUNTAIN", "WORLD_VEHICLE_BICYCLE_ROAD",
        "WORLD_VEHICLE_BIKE_OFF_ROAD_RACE", "WORLD_VEHICLE_BIKER", "WORLD_VEHICLE_BOAT_IDLE",
        "WORLD_VEHICLE_BOAT_IDLE_ALAMO", "WORLD_VEHICLE_BOAT_IDLE_MARQUIS", "WORLD_VEHICLE_BROKEN_DOWN",
        "WORLD_VEHICLE_BUSINESSMEN", "WORLD_VEHICLE_HELI_LIFEGUARD", "WORLD_VEHICLE_CLUCKIN_BELL_TRAILER",
        "WORLD_VEHICLE_CONSTRUCTION_SOLO", "WORLD_VEHICLE_CONSTRUCTION_PASSENGERS", "WORLD_VEHICLE_DRIVE_PASSENGERS",
        "WORLD_VEHICLE_DRIVE_PASSENGERS_LIMITED", "WORLD_VEHICLE_DRIVE_SOLO", "WORLD_VEHICLE_FIRE_TRUCK",
        "WORLD_VEHICLE_EMPTY", "WORLD_VEHICLE_MARIACHI", "WORLD_VEHICLE_MECHANIC",
        "WORLD_VEHICLE_MILITARY_PLANES_BIG", "WORLD_VEHICLE_MILITARY_PLANES_SMALL", "WORLD_VEHICLE_PARK_PARALLEL",
        "WORLD_VEHICLE_PARK_PERPENDICULAR_NOSE_IN", "WORLD_VEHICLE_PASSENGER_EXIT", "WORLD_VEHICLE_POLICE_BIKE",
        "WORLD_VEHICLE_POLICE_CAR", "WORLD_VEHICLE_POLICE", "WORLD_VEHICLE_POLICE_NEXT_TO_CAR",
        "WORLD_VEHICLE_QUARRY", "WORLD_VEHICLE_SALTON", "WORLD_VEHICLE_SALTON_DIRT_BIKE",
        "WORLD_VEHICLE_SECURITY_CAR", "WORLD_VEHICLE_STREETRACE", "WORLD_VEHICLE_TOURBUS",
        "WORLD_VEHICLE_TOURIST", "WORLD_VEHICLE_TANDL", "WORLD_VEHICLE_TRACTOR",
        "WORLD_VEHICLE_TRACTOR_BEACH", "WORLD_VEHICLE_TRUCK_LOGS", "WORLD_VEHICLE_TRUCKS_TRAILERS",
        "WORLD_VEHICLE_DISTANT_EMPTY_GROUND", "WORLD_HUMAN_PAPARAZZI"
    }
    for _, scenario in ipairs(scenarios) do
        SetScenarioTypeEnabled(scenario, state)
    end
    Z.Io.Trace("(Z.Function.toggleScenarios) Scenarios: ", state)
end

--- Toggle PVP
--- @param state boolean The state to set PVP to
function Z.Function.togglePvp(state)
    SetCanAttackFriendly(PlayerPedId(), state, false)
    NetworkSetFriendlyFireOption(state)
    Z.Io.Trace("(Z.Function.togglePvp) Pvp: ", state)
end