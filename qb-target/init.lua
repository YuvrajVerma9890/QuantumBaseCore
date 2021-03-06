function Load(name)
	local resourceName = GetCurrentResourceName()
	local chunk = LoadResourceFile(resourceName, ('data/%s.lua'):format(name))
	if chunk then
		local err
		chunk, err = load(chunk, ('@@%s/data/%s.lua'):format(resourceName, name), 't')
		if err then
			error(('\n^1 %s'):format(err), 0)
		end
		return chunk()
	end
end

-------------------------------------------------------------------------------
-- Settings
-------------------------------------------------------------------------------

Config = {}

-- It's possible to interact with entities through walls so this should be low
Config.MaxDistance = 7.0

-- Enable debug options
Config.Debug = false

-- Supported values: true, false
Config.Standalone = false

-- Enable outlines around the entity you're looking at
Config.EnableOutline = false

-- Whether to have the target as a toggle or not
Config.Toggle = false

-- The color of the outline in rgb, the first value is red, the second value is green and the last value is blue. Here is a link to a color picker to get these values: https://htmlcolorcodes.com/color-picker/
Config.OutlineColor = {255, 255, 255}

-- Enable default options (Toggling vehicle doors)
Config.EnableDefaultOptions = true

-- Disable the target eye whilst being in a vehicle
Config.DisableInVehicle = false

-- Key to open the target eye, here you can find all the names: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKey = 'LMENU' -- Left Alt

-- Control for key press detection on the context menu, it's the Right Mouse Button by default, controls are found here https://docs.fivem.net/docs/game-references/controls/
Config.MenuControlKey = 238

-------------------------------------------------------------------------------
-- Target Configs
-------------------------------------------------------------------------------

-- These are all empty for you to fill in, refer to the .md files for help in filling these in

Config.CircleZones = {

}

Config.BoxZones = {


-- CQC-Mugshot
['CQCMugshot'] = {
		name = 'CQCMugshot',
		coords = vector3(-556.26, -132.99, 33.75),
		debugPoly = false,
		length = 0.50,
		width = 0.65,
		heading = 131.24,
		maxZ = 34.30,
		minZ = 33.75,
		options = {
			{
				icon = 'fas fa-camera',
				label = 'Take Suspects Mugshots',
				job = {
					['police'] = 0,
					['sast'] = 0,
				},
				event = 'cqc-mugshot:client:takemugshot',
				type = 'client'
			},
		},
		distance = 2.0,
	},

}

Config.PolyZones = {

}

Config.TargetBones = {

}

Config.TargetModels = {

["burgershotgarage"] = {
			models = {
				"ig_floyd"
			},
			options = {
				{
					type = "client",
					event = "garage:BurgerShotGarage",
					icon = "fas fa-car",
					label = "BurgerShot Garage",
					job = "burgershot",
				},
			},
			distance = 2.5,
		},
-- QB Rental
  ["VehicleRental"] = {
      models = {
          `a_m_y_business_03`,
      },
      options = {
          {
              type = "client",
              event = "qb-rental:client:openMenu",
              icon = "fas fa-car",
              label = "Rent Vehicle",
              MenuType = "vehicle"
          },
      },
      distance = 3.0
  },
  ["AircraftRental"] = {
      models = {
          `s_m_y_airworker`,
      },
      options = {
          {
              type = "client",
              event = "qb-rental:client:openMenu",
              icon = "fas fa-plane",
              label = "Rent Aircraft",
              MenuType = "aircraft"
          },
      },
      distance = 3.0
  },
  ["Boatrental"] = {
      models = {
          `mp_m_boatstaff_01`,
      },
      options = {
          {
              type = "client",
              event = "qb-rental:client:openMenu",
              icon = "fas fa-ship",
              label = "Rent Boat",
              MenuType = "boat"
          },
      },
      distance = 3.0
  },		
		
		
		["burgershotgarage"] = {
			models = {
				"ig_floyd"
			},
			options = {
				{
					type = "client",
					event = "garage:BurgerShotGarage",
					icon = "fas fa-car",
					label = "BurgerShot Garage",
					job = "burgershot",
				}
			},
			distance = 2.5,
		},


		
}

Config.GlobalPedOptions = {

}

Config.GlobalVehicleOptions = {

}

Config.GlobalObjectOptions = {

}

Config.GlobalPlayerOptions = {

}

Config.Peds = {

[1] = {
	model = "ig_mrs_thornhill",
	coords = vector4(2436.83, 4958.85, 46.81, 10.2),
	minusOne = true,
	freeze = true,
	invincible = true,
	blockevents = true,
	target = {
		options = {
			{
				type = "client",
				event = "grandma:client:healing",
				icon = "fas fa-band-aid",
				label = "Request Healing",
			},
		},
		distance = 1.5,
	},
	currentpednumber = 0,
},

}

-------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------
local function JobCheck() return true end
local function GangCheck() return true end
local function ItemCount() return true end
local function CitizenCheck() return true end

CreateThread(function()
	local state = GetResourceState('qb-core')
	if state ~= 'missing' then
		if state ~= 'started' then
			local timeout = 0
			repeat
				timeout += 1
				Wait(0)
			until GetResourceState('qb-core') == 'started' or timeout > 100
		end
		Config.Standalone = false
	end
	if Config.Standalone then
		local firstSpawn = false
		local event = AddEventHandler('playerSpawned', function()
			SpawnPeds()
			firstSpawn = true
		end)
		-- Remove event after it has been triggered
		while true do
			if firstSpawn then
				RemoveEventHandler(event)
				break
			end
			Wait(1000)
		end
	else
		local QBCore = exports['qb-core']:GetCoreObject()
		local PlayerData = QBCore.Functions.GetPlayerData()

		ItemCount = function(item)
			for _, v in pairs(PlayerData.items) do
				if v.name == item then
					return true
				end
			end
			return false
		end

		JobCheck = function(job)
			if type(job) == 'table' then
				job = job[PlayerData.job.name]
				if job and PlayerData.job.grade.level >= job then
					return true
				end
			elseif job == 'all' or job == PlayerData.job.name then
				return true
			end
			return false
		end

		GangCheck = function(gang)
			if type(gang) == 'table' then
				gang = gang[PlayerData.gang.name]
				if gang and PlayerData.gang.grade.level >= gang then
					return true
				end
			elseif gang == 'all' or gang == PlayerData.gang.name then
				return true
			end
			return false
		end

		CitizenCheck = function(citizenid)
			return citizenid == PlayerData.citizenid or citizenid[PlayerData.citizenid]
		end

		RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
			PlayerData = QBCore.Functions.GetPlayerData()
			SpawnPeds()
		end)

		RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
			PlayerData = {}
			DeletePeds()
		end)

		RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
			PlayerData.job = JobInfo
		end)

		RegisterNetEvent('QBCore:Client:OnGangUpdate', function(GangInfo)
			PlayerData.gang = GangInfo
		end)

		RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
			PlayerData = val
		end)
	end
end)

function CheckOptions(data, entity, distance)
	if distance and data.distance and distance > data.distance then return false end
	if data.job and not JobCheck(data.job) then return false end
	if data.gang and not GangCheck(data.gang) then return false end
	if data.item and not ItemCount(data.item) then return false end
	if data.citizenid and not CitizenCheck(data.citizenid) then return false end
	if data.canInteract and not data.canInteract(entity, distance, data) then return false end
	return true
end