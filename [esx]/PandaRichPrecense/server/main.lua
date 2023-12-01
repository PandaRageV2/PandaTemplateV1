
RegisterServerEvent('DiscordRPC:UpdatePresence')
AddEventHandler('DiscordRPC:UpdatePresence', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local data = {
		['PlayerName'] = GetPlayerName(_source),
		['IdentityName'] = xPlayer.getName(),
		['Job'] = {jobName = xPlayer.getJob().name, jobGrade = xPlayer.getJob().grade_label, jobLabel = xPlayer.getJob().label},
		['ActivePlayers'] = GetNumPlayerIndices()
	}

    TriggerClientEvent('DiscordRPC:SetPresence',_source,data)
end)
