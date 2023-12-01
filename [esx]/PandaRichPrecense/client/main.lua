local jobGrade = ''
local job = ''
local playerName = nil
local playerLoaded = false
local firstSpawn = true

local ESX = exports["es_extended"]:getSharedObject()
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	playerLoaded = true
end)

AddEventHandler('playerSpawned', function()
 if firstSpawn then
    for _, v in pairs(Config.Buttons) do
          SetDiscordRichPresenceAction(v.index, v.name, v.url)
    end
    firstSpawn = false
 end	
end)

RegisterNetEvent('DiscordRPC:SetPresence')
AddEventHandler('DiscordRPC:SetPresence', function(data)
	local data = data
	local player = PlayerId()
	if Config.UseJobs then
		SetDiscordRichPresenceAssetSmall(Config.LargeIMG)
        SetDiscordRichPresenceAssetSmallText(data['Job'].jobLabel .. " - " .. data['Job'].jobGrade)
	end	

	SetDiscordAppId(Config.ClientID)

	SetDiscordRichPresenceAsset(Config.LargeIMG)
	if Config.UseESXIdentity then
		SetRichPresence((Config.RichPresence):format(GetPlayerServerId(player), data['IdentityName'], Config.PlayerText, data['ActivePlayers'], tostring(Config.PlayerCount)))
	else
		SetRichPresence((Config.RichPresence):format(GetPlayerServerId(player), data['PlayerName'], Config.PlayerText, data['ActivePlayers'], tostring(Config.PlayerCount)))
	end
	SetDiscordRichPresenceAssetText(Config.RichText)
end)

Citizen.CreateThread(function()
	while not playerLoaded do
		Citizen.Wait(10)
	end
	while true do
		TriggerServerEvent('DiscordRPC:UpdatePresence')
		Citizen.Wait(Config.ResourceTimer*1000)
	end
end)

