---
sidebar_position: 2
---

# Functions

### QBCore.Functions.GetPlayerData

Perhaps the most used function in the framework. This functions returns the players data of the local player. It can be used with modifiers on the end starting with a "." (period).

```lua
-- Example of using PlayerData
local PlayerData = QBCore.Functions.GetPlayerData()
local onDuty = PlayerData.job.onduty
local firstname = PlayerData.charinfo.firstname
```

### QBCore.Functions.GetCoords

This function operates very similarly to how the native GetEntityCoords does but it returns the heading as well in a vector4.

```lua
-- Example of using the GetCoords function
local coords = QBCore.Functions.GetCoords()
print('Vector4:', coords)
print('Seperate:', coords.x, coords.y, coords.z, coords.w)
```

### QBCore.Functions.HasItem

Returns whether or not a player has a certain item

```lua
-- Example
local hasItem = QBCore.Functions.HasItem('weapon_pistol')
print(hasItem)
```

### QBCore.Functions.CreateBlip

A function to create blips without having to call every native to customize the blip aswell.

```lua
-- blip sprites and colours can be found here: https://docs.fivem.net/docs/game-references/blips/
-- Example
QBCore.Functions.CreateBlip(GetEntityCoords(PlayerPedId()) --[[ coords ]], 2 --[[ sprite ]], 4 --[[ display (https://docs.fivem.net/natives/?_0x9029B2F3DA924928) ]], 1.0 --[[ scale ]], 4 --[[ colour ]], true --[[ shortRange ]], 'Player Test' --[[ title ]])
```

### QBCore.Functions.RequestAnimDict

Request an animation dictionary easily.

```lua
local dict = 'amb@prop_human_seat_chair@female@legs_crossed@react_coward'
QBCore.Functions.RequestAnimDict(dict)
TaskPlayAnim(PlayerPedId(), dict, 'enter_fwd', 8.0, 8.0, 1000, 1, 1, false, false, false)
```

### QBCore.Functions.LoadModel

Load a (streamed) model to use it in natives like `CreateVehicle` or `CreateObject`.

```lua
local ped = PlayerPedId()
local model = `adder`
QBCore.Functions.LoadModel(model)
local vehicle = CreateVehicle(model, GetEntityCoords(ped), GetEntityHeading(ped), true, true)
```

### QBCore.Functions.Notify

The core notification system that is used. Has three paramters to pass which are text, notification type and how length of notification. The notifications allow for a title and a caption or just a singular message. Text can be a string or a table (refer to example below), type must be a string and length must be a number.

Current types: primary(default), success, error, police, ambulance - An unlimited amount of types can be made in qb-core/config.lua

```lua
-- Generic notification example
QBCore.Functions.Notify('This is a test', 'success', 5000)

-- Captioned notification example
QBCore.Functions.Notify({text = 'Test', caption = 'Test Caption'}, 'police', 5000)
```

### QBCore.Debug

Utility debug function to print a table to the server console in a readable way.

```lua
-- Example
local peds = {
    [1] = {'ped1', 'ped2'},
    ['another thing'] = {'ped1', 'ped2'}
}
QBCore.Debug(peds, 4) -- The second parameter is the indentation
```

### QBCore.Functions.TriggerCallback

Triggers a server callback to execute code on the server side and returns variable depending on that code.

```lua
-- Example
QBCore.Functions.TriggerCallback('callbackName', function(cb)
	-- Do stuff here
end, parameters)
```

### QBCore.Functions.Progressbar

Wrapper for progressbar export, you can trigger a progress bar with this with a set script name, label, duration (in milliseconds), you can make it usable while being dead or not, you can make it cancellable or not, you can disable specific controls (these are given by the types: `disableMovement`, `disableCarMovement`, `disableMouse` and `disableCombat`), you can make it play an animation, you can add a prop to place at a place, you can place another prop, then you have a function which will trigger when it's succesfully completed and the last parameter is a function for when it was cancelled.

```lua
-- Example
QBCore.Functions.Progressbar('some_name' --[[ name ]], 'Some Label' --[[ label ]], 10000 --[[ duration ]], false --[[ useWhileDead ]], true --[[ canCancel ]],
{ --[[ disableControls ]]
    disableMovement = false,
    disableCarMovement = false,
    disableMouse = false,
    disableCombat = false,
},
{ --[[ animation ]]
    animDict = 'amb@prop_human_seat_chair@female@legs_crossed@react_coward', --[[ animation dictionary ]]
    anim = 'enter_fwd', --[[ animation name ]]
    flags = 1, --[[ animation flags ]]
    task = nil, --[[ scenario task ]]
},
{ --[[ prop one ]]
    model = nil, --[[ prop model ]]
    bone = nil, --[[ ped bone to attach the prop to ]]
    coords = { x = 0.0, y = 0.0, z = 0.0 }, --[[ coords ]]
    rotation = { x = 0.0, y = 0.0, z = 0.0 }, --[[ rotation ]]
},
{ --[[ prop two ]]
    model = nil, --[[ prop model ]]
    bone = nil, --[[ ped bone to attach the prop to ]]
    coords = { x = 0.0, y = 0.0, z = 0.0 }, --[[ coords ]]
    rotation = { x = 0.0, y = 0.0, z = 0.0 }, --[[ rotation ]]
},
function() --[[ onFinish function ]]
    print('finished succesfully')
end,
function() --[[ onCancel function ]]
    print('cancelled progressbar')
end)
```

### QBCore.Functions.GetVehicles

Returns vehicle game pool (for backwards compatiblity) - Not worth using, just use `GetGamePool('CVehicle')`

### QBCore.Functions.GetObjects

Returns object game pool (for backwards compatiblity) - Not worth using, just use `GetGamePool('CObject')`

### QBCore.Functions.GetPlayers

Returns active players in the clients' onesync scope (for backwards compatiblity) - Not worth using, just use `GetActivePlayers()`

### QBCore.Functions.GetPeds

Returns all peds in your onesync scope with a filter of specific entities which is optional.

```lua
-- Example without filter
local peds = QBCore.Functions.GetPeds()
QBCore.Debug(peds)

-- Example with filter
local filter = {'some_ped_model', 'some_other_ped_model'}
local peds = QBCore.Functions.GetPeds(filter)
```

### QBCore.Functions.GetClosestPed

Returns the closest ped to the local player along with the distance to the player with an optional filter for specific entities.

```lua
-- We do not need to specify the coords unless you have different coords than the one of the local player

-- Example without filter
local ped, distance = QBCore.Functions.GetClosestPed()
print(ped, distance)

-- Example with filter
local filter = {'some_ped_model', 'some_other_ped_model'}
local ped, distance = QBCore.Functions.GetClosestPed(false, filter)
print(ped, distance)
```

### QBCore.Functions.IsWearingGloves

A function to check if the local player is wearing gloves or not, this is used by robberies to check if it can leave the fingerprint there or not. The indexex of all allowed gloves can be found in qb-core/shared/main.lua at the bottom

```lua
if QBCore.Functions.IsWearingGloves() then
    -- Do something when they're wearing gloves
else
    -- Do something when they're not wearing gloves
end
```

### QBCore.Functions.GetClosestPlayer

Returns the closest player index to the local player along with the distance of the closest player to the local player.

```lua
-- We do not need to specify the coords unless you have different coords than the one of the local player
-- Example
local player, distance = QBCore.Functions.GetClosestPlayer()
print(player, distance, GetPlayerPed(player))
```

### QBCore.Functions.GetPlayersFromCoords

Returns all players within a radius of specific coordinates, the coordinates and radius are optional as the coordinates are set by default if not given to the coords of the local player and the radius is by default if not given 5 GTA Units.

```lua
-- We do not need to specify the coords unless you have different coords than the one of the local player and the distance is by default 5 GTA Units
-- Example
local players = QBCore.Functions.GetPlayersFromCoords()
print(#players) -- Print the amount of players it has gotten
```

### QBCore.Functions.GetClosestVehicle

Returns the closest vehicle to the local player along with the distance to the player.

```lua
-- We do not need to specify the coords unless you have different coords than the one of the local player
-- Example
local vehicle, distance = QBCore.Functions.GetClosestVehicle()
print(vehicle, distance)
```

### QBCore.Functions.GetClosestObject

Returns the closest object to the local player along with the distance of the object to the player.

```lua
-- We do not need to specify the coords unless you have different coords than the one of the local player
-- Example
local object, distance = QBCore.Functions.GetClosestObject()
print(object, distance)
```

### QBCore.Functions.GetClosestBone

Returns the closest bone, coords and distance of the local player to that bone of the given entity, the bone is selected from the given list of bones.

```lua
-- Example
local vehicle = QBCore.Functions.GetClosestVehicle()
if not vehicle or vehicle == -1 then return end
local bone, coords, distance = QBCore.Functions.GetClosestBone(vehicle, {'hub_lm1', 'window_lr', 'seat_dside_r'})
print(bone, coords, distance)
```

### QBCore.Functions.AttachProp

Attach a prop to a ped on a given location and with a given rotation. This returns the prop handle of the spawned prop so you can use it in natives.

```lua
-- Example of spawning a medical bag in the right hand of the local player
local ped = PlayerPedId()
QBCore.Functions.AttachProp(ped --[[ ped ]], 'prop_med_bag_01b' --[[ model ]], 57005 --[[ bone id ]], 0.4 --[[ x coord ]], 0.0 --[[ y coord ]], 0.0 --[[ z coord ]], 0.0 --[[ x rotation ]], 270.0 --[[ y rotation ]], 60.0 --[[ z rotation ]], false --[[ vertex ]])
```

### QBCore.Functions.SpawnVehicle

Spawn a vehicle on the local players' client, the the necessary arguments that need to be given are the model of the vehicle and the callback.

```lua
-- Example
QBCore.Functions.SpawnVehicle('adder' --[[ model ]], function(vehicle) --[[ callback ]]
    -- Do something with the vehicle like set fuel level
end, QBCore.Functions.GetCoords() --[[ vector4 coords ]], true --[[ networked ]])
```

### QBCore.Functions.DeleteVehicle

Delete a specific vehicle through the client - Not worth using.

```lua
-- Example
local vehicle = QBCore.Functions.GetClosestVehicle()
if not vehicle or vehicle == -1 then return end
QBCore.Functions.DeleteVehicle(vehicle)
```

### QBCore.Functions.GetPlate

Returns a trimmed plate of the given vehicle.

```lua
-- Example
local vehicle = QBCore.Functions.GetClosestVehicle()
if not vehicle or vehicle == -1 then return end
print(QBCore.Functions.GetPlate(vehicle))
```

### QBCore.Functions.SpawnClear

A function to check if the given coords are obstructed or not, this is commonly used with spawning vehicles to prevent it from spawning on top of each other.

```lua
-- Example
local clear = QBCore.Functions.SpawnClear(GetEntityCoords(PlayerPedId()) --[[ vector3 coords ]], 5.0 --[[ distance (radius in GTA Units) ]])
if clear then
    -- spawn a vehicle for example
else
    QBCore.Functions.Notify('The spawn is obstructed, can\'t perform action', 'error')
end
```

### QBCore.Functions.GetVehicleProperties

Get all properties of the given vehicle.

```lua
-- Example
local vehicle = QBCore.Functions.GetClosestVehicle()
if not vehicle or vehicle == -1 then return end
QBCore.Debug(QBCore.Functions.GetVehicleProperties(vehicle))
```

### QBCore.Functions.SetVehicleProperties

Set all properties for a vehicle after getting them

```lua
-- Example
local vehicle = QBCore.Functions.GetClosestVehicle()
if not vehicle or vehicle == -1 then return end
local props = {
    plate = '753DJ03',
    bodyHealth = 500.0,
    fuelLevel = 100.0,
    dirtLevel = 0.0,
    neonEnabled = {true, true, true, true}
}
QBCore.Functions.SetVehicleProperties(vehicle, props)
```

### QBCore.Functions.LoadParticleDictionary

A function to load a particle dictionary so it can be used to spawn particles. Here is a list of [particles](https://vespura.com/fivem/particle-list/)

### QBCore.Functions.StartParticleAtCoord

A function to spawn particles at given coords. This returns the handle of the spawned particles to use in natives.

```lua
QBCore.Functions.StartParticleAtCoord('cut_chinese1' --[[ dictionary ]], 'cs_cig_smoke' --[[ particle name ]], true --[[ looped ]], GetEntityCoords(PlayerPedId()) --[[ vector3 coords ]], vector3(0.0, 0.0, 0.1) --[[ vector3 rotation ]], 1.0 --[[ scale ]], 10.0 --[[ alpha ]], {r = 255, g = 255, b = 255} --[[ colors table ]], 10000 --[[ duration ]])
```

### QBCore.Functions.StartParticleOnEntity

A function to spawn particles on an entity. This returns the handle of the spawned particles to use in natives.

```lua
QBCore.Functions.StartParticleOnEntity('cut_chinese1' --[[ dictionary ]], 'cs_cig_smoke' --[[ particle name ]], true --[[ looped ]], PlayerPedId() --[[ entity ]], 57005 --[[ bone id ]], vector3(0.0, 0.0, 0.0) --[[ vector3 offset ]], vector3(0.0, 0.0, 0.1) --[[ vector3 rotation ]], 1.0 --[[ scale ]], 10.0 --[[ alpha ]], {r = 255, g = 255, b = 255} --[[ colors table ]], false --[[ evolution (table or false) ]], 10000 --[[ duration ]])
```
