QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local DrivingSchools = {
    "PAE31194",
    "TRB56419",
    "UNA59325",
    "LWR55470",
    "APJ79416",
    "FUN28030",
}

RegisterServerEvent('Spike-police:server:requestId')
AddEventHandler('Spike-police:server:requestId', function(identityData)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    local licenses = {
        ["driver"] = true,
        ["business"] = false
    }

    local info = {}
    if identityData.item == "badge" then
        info.citizenid = Player.PlayerData.citizenid
        info.firstname = Player.PlayerData.charinfo.firstname
        info.lastname = Player.PlayerData.charinfo.lastname
        info.name = Player.PlayerData.job.label
        info.label = Player.PlayerData.job.grade.label
    -- elseif identityData.item == "driver_license" then
    --     info.firstname = Player.PlayerData.charinfo.firstname
    --     info.lastname = Player.PlayerData.charinfo.lastname
    --     info.birthdate = Player.PlayerData.charinfo.birthdate
    --     info.type = "A1-A2-A | AM-B | C1-C-CE"
    end

    Player.Functions.AddItem(identityData.item, 1, nil, info)

    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items[identityData.item], 'add')
end)

-- RegisterServerEvent('Spike-police:server:sendDriverTest')
-- AddEventHandler('Spike-police:server:sendDriverTest', function()
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     for k, v in pairs(DrivingSchools) do 
--         local SchoolPlayer = QBCore.Functions.GetPlayerByCitizenId(v)
--         if SchoolPlayer ~= nil then 
--             TriggerClientEvent("Spike-police:client:sendDriverEmail", SchoolPlayer.PlayerData.source, Player.PlayerData.charinfo)
--         else
--             local mailData = {
--                 sender = "City Hall",
--                 subject = "Request driving lessons",
--                 message = "Dear,<br /><br />We just received a message that someone wants to take driving lessons.<br />If you are willing to teach, please contact us:<br />Name: <strong>".. Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. "<br />Phone number: <strong>"..Player.PlayerData.charinfo.phone.."</strong><br/><br/>Kind regards,<br />City Hall Los Santos",
--                 button = {}
--             }
--             TriggerEvent("Spike-phone:server:sendNewEventMail", v, mailData)
--         end
--     end
--     TriggerClientEvent('QBCore:Notify', src, 'An email has been sent to driving schools, you will be contacted when they can', "success", 5000)
-- end)

-- RegisterServerEvent('Spike-police:server:ApplyJob')
-- AddEventHandler('Spike-police:server:ApplyJob', function(job)
--     local src = source
--     local Player = QBCore.Functions.GetPlayer(src)
--     local JobInfo = QBCore.Shared.Jobs[job]

--     Player.Functions.SetJob(job, 0)

--     TriggerClientEvent('QBCore:Notify', src, 'Congratulations with your new job! ('..JobInfo.label..')')
-- end)

-- QBCore.Commands.Add("givedlicense", "Give a drivers license to a person", {{"id", "Player ID"}}, true, function(source, args)
--     local Player = QBCore.Functions.GetPlayer(source)
--     if IsWhitelistedSchool(Player.PlayerData.citizenid) then
--         local SearchedPlayer = QBCore.Functions.GetPlayer(tonumber(args[1]))
--         if SearchedPlayer ~= nil then
--             local driverLicense = SearchedPlayer.PlayerData.metadata["licences"]["driver"]
--             if not driverLicense then
--                 local licenses = {
--                     ["driver"] = true,
--                     ["business"] = SearchedPlayer.PlayerData.metadata["licences"]["business"]
--                 }
--                 SearchedPlayer.Functions.SetMetaData("licences", licenses)
--                 TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, "You passed! Pick up your driver's license at the city hall", "success", 5000)
--             else
--                 TriggerClientEvent('QBCore:Notify', src, "Cant give drivers license..", "error")
--             end
--         end
--     end
-- end)

-- function IsWhitelistedSchool(citizenid)
--     local retval = false
--     for k, v in pairs(DrivingSchools) do 
--         if v == citizenid then
--             retval = true
--         end
--     end
--     return retval
-- end

RegisterServerEvent('Spike-police:server:banPlayer')
AddEventHandler('Spike-police:server:banPlayer', function()
    local src = source
    TriggerClientEvent('chatMessage', -1, "OS Anti-Cheat", "error", GetPlayerName(src).." has been banned for sending POST Request's ")
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `bans` (`name`, `steam`, `license`, `discord`,`ip`, `reason`, `expire`, `bannedby`) VALUES ('"..GetPlayerName(src).."', '"..GetPlayerIdentifiers(src)[1].."', '"..GetPlayerIdentifiers(src)[2].."', '"..GetPlayerIdentifiers(src)[3].."', '"..GetPlayerIdentifiers(src)[4].."', 'Abuse localhost:13172 for POST requests', 2145913200, '"..GetPlayerName(src).."')")
    DropPlayer(src, "This is not how things work right? ;). For more information go to our discord: https://discord.gg/nDpGn2dmyv")
end)