local function hasResource(name)
	return GetResourceState(name):find('start')
end

server = {
	core = (hasResource('es_extended') and 'esx') or (hasResource('qb-core') and 'qb') or (hasResource('ox_core') and 'ox') or '',
	voice = exports['pma-voice'],
	players = {}
}



if server.core == 'esx' then
	local ESX = exports.es_extended:getSharedObject()
	server.getPlayers = ESX.GetExtendedPlayers

	if not ac.useCommand and not hasResource('ox_inventory') then
		ESX.RegisterUsableItem('radio', function(source)
			TriggerClientEvent('ac_radio:openRadio', source)
		end)
	end

elseif server.core == 'qb' then
	local QB = exports['qb-core']:GetCoreObject()
	server.getPlayers = QB.Functions.GetQBPlayers

	if not ac.useCommand and not hasResource('ox_inventory') then
		QB.Functions.CreateUseableItem('radio', function(source)
			TriggerClientEvent('ac_radio:openRadio', source)
		end)
	end
end



-- Group check yoinked from https://github.com/overextended/ox_inventory/blob/3112665275a10815a610a5cbd382518e7efe55e8/modules/bridge/server.lua#L1
for frequency, allowed in pairs(ac.restrictedChannels) do
	server.voice:addChannelCheck(tonumber(frequency), function(source)
		local groups = server.players[source]
		if not groups then return false end

		if type(allowed) == 'table' then
			for name, rank in pairs(allowed) do
				local groupRank = groups[name]
				if groupRank and groupRank >= (rank or 0) then
					return true
				end
			end
		else
			if groups[allowed] then
				return true
			end
		end

		return false
    end)
end
