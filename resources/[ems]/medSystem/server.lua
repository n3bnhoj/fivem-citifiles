ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('medSystem:print')
AddEventHandler('medSystem:print', function(req, pulse, area, blood, x, y, z, bleeding)

	local _source = source
	
	local xPlayer =  ESX.GetPlayerFromId(_source)
	Wait(100)
	local name = getIdentity(_source)
	TriggerClientEvent('medSystem:near', req ,x ,y ,z , pulse, blood, name.firstname, name.lastname, area, bleeding)	

	--[[
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			TriggerClientEvent('medSystem:near', xPlayers[i] ,x ,y ,z , pulse, blood, name.firstname, name.lastname, area, bleeding)	
		end
	 ]]
end)


RegisterServerEvent('medSystem:checkBP')
AddEventHandler('medSystem:checkBP', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'ambulance' then
		TriggerClientEvent('medSystem:send', target, source)
	end

end)


function getIdentity(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
		}
	else
		return nil
	end
end
