---
sidebar_position: 1
---

# Events

### QBCore:Client:OnPlayerLoaded

This event is triggered once the player spawns after selecting a character and location to spawn, you can put all your code here to execute once the player has loaded and is spawned.

```lua
-- Example of a load event
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = QBCore.Functions.GetPlayerData()
    someVariable = true
    spawned = true
    -- And all other things that you need to execute or want to change
end)
```

### QBCore:Client:OnPlayerUnload

This event is triggered once a player disconnects or logs out using the `logout` command, in this event you can put many things to do whilst unloading a player.

```lua
-- Example of an unload event
RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    PlayerData = {}
    someVariable = false
    spawned = false
    -- And all other things that you need to execute or want to change
end)
```

### QBCore:Client:PvpHasToggled

This is the event to toggle pvp with the `togglepvp` command.

### QBCore:Command:TeleportToPlayer

This event almost has the same code as the TeleportToCoords one but takes a table instead of 3 arguments, this is used for the `tp` command to teleport to a specific player, this will teleport the local player to another players coords with a vehicle if the local player is in one.

### QBCore:Command:TeleportToCoords

This event is most commonly used for the `tp` command to teleport to specific x, y and z coords, with a vehicle if the local player is in one.

### QBCore:Command:GoToMarker

This is the event used for the `tpm` command, this will find the blip of your waypoint, then check through all available heights and spawn the local player there once it has found ground, it also teleports the vehicle the local player is in if they're in one.

### QBCore:Command:SpawnVehicle

This is the event to spawn vehicles, this is used to spawn vehicles from the server side, most commonly used by the `car` command. This spawns a vehicle, then warps the local player in the vehicle and gives the local player the keys to the car.

### QBCore:Command:DeleteVehicle

This is the event to delete vehicles, this is currently only used by the `dv` command in qb-core. This will delete the vehicle the local player is in, but if the player is not in a vehicles, it will delete all the vehicles in a 5.0 GTA Unit radius from the local player.

### QBCore:Client:OnJobUpdate

This event triggers when the job object of the PlayerData is updated, with this the event also sends the new job data.

```lua
-- Example of a job update event
RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    if JobInfo.name == 'police' then
        -- New job is police so do some things with police here
    end
end)
```

### QBCore:Client:OnGangUpdate

This event triggers when the gang object of the PlayerData is updated, with this the event also sends the new gang data.

```lua
-- Example of a gang update event
RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
    if GangInfo.name == 'ballas' then
        -- New gang is ballas so do some things with ballas here
    end
end)
```

### QBCore:Client:OnPermissionUpdate

This event triggers when the permission of the player has updated, with this the event also sends the new permission that the player has got.

```lua
-- Example of a permission update event
RegisterNetEvent('QBCore:Client:OnPermissionUpdate', function(permission)
    playerPermission = permission
    -- Do some stuff with permission change
end)
```

### QBCore:Player:SetPlayerData

This event sets the data of the PlayerData object, you can use this event to keep your PlayerData updated in your resource as this event is called each time any PlayerData gets updated.

```lua
-- Update the PlayerData with the new values
RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)
```

### QBCore:Player:UpdatePlayerData

This event updates the PlayerData when a player logs out or disconnects, you can use this event to do something with PlayerData on logout or disconnect but that is not recommended as `QBCore:Client:OnPlayerUnload` already exists for that.

```lua
RegisterNetEvent('QBCore:Player:UpdatePlayerData', function()
    -- Do something when the PlayerData gets updated for the last time
end)
```

### QBCore:Notify

This is an alias to `QBCore.Functions.Notify`, this event is most commonly used to trigger a notification from the server side.

```lua
RegisterNetEvent('QBCore:Notify', function(text, type, length)
    QBCore.Functions.Notify(text, type, length)
end)
```

### QBCore:Client:TriggerCallback

This is the event that's called to trigger a callback, you don't have to do anything with this, because this is called via the function `QBCore.Functions.TriggerCallback` and you should use that to trigger callbacks.

### QBCore:Client:UseItem

This is the event that's called when an item gets used.

```lua
RegisterNetEvent('QBCore:Client:UseItem', function(item)
    -- Do something on item use
end)
```

### QBCore:Client:OnSharedUpdate

This is event gets triggered whenever a shared table of qb-core gets updated through the functions to update it, this is for a specific table and value. This event can be used to update your resources' shared along with the shared of the core

```lua
RegisterNetEvent('QBCore:Client:OnSharedUpdate', function(tableName, key, value)
    QBCore.Shared[tableName][key] = value
end)
```

### QBCore:Client:OnSharedUpdateMultiple

This event does the same as `QBCore:Client:OnSharedUpdate`, but this one is able to update multiple keys of a table at once. This event can be used to update your resources' shared along with the shared of the core

```lua
RegisterNetEvent('QBCore:Client:OnSharedUpdateMultiple', function(tableName, values)
    for key, value in pairs(values) do
        QBCore.Shared[tableName][key] = value
    end
end)
```
