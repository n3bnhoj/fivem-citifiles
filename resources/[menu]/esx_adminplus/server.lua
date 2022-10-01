ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local onTimer       = {}
local savedCoords   = {}
local warnedPlayers = {}
local deadPlayers   = {}

RegisterCommand("admin", function(source, args, rawCommand)
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		TriggerClientEvent('chatMessage', xPlayer.source, _U('your_rank', xPlayer.getGroup()))
	end
end, false)

RegisterCommand("tpm", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("esx_admin:tpm", xPlayer.source)
		end
	end
end, false)


RegisterCommand("togglenoclipx", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("nocliperon", source)
		end
	end
end, false)

--[[
ESX.RegisterCommand('forceskin', 'admin', function(source, args, user)

	local _source = source
	local target = tonumber(args[1])
	local xPlayer = ESX.GetPlayerFromId(target)
	
	if target and xPlayer ~= nil then
		TriggerClientEvent('esx_skin:openSaveableMenu', target)
	else
		TriggerClientEvent('chatMessage', _source, "SYSTEM:", {255, 0, 0}, "Invalid arguments.")
		return
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficient Permissions.' } })
end, {help = '/forceskin (ID) - Force someone to change his skin'})
	
]]
RegisterCommand("forceskin", function(source, args, rawCommand)	-- /bring [ID]
	local _source = source
	
	if source ~= 0 then
	
	
		local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission2(xPlayer) then
	    	if args[1] and tonumber(args[1]) then
				local target = tonumber(args[1])
				  if target and xPlayer ~= nil then
					TriggerClientEvent('esx_skin:openSaveableMenu', target)
				else
					TriggerClientEvent('chatMessage', _source, "SYSTEM:", {255, 0, 0}, "Invalid arguments.")
					return
				end
	    	else
	      		TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input', 'Forceskin'))
	    	end
	  	end
	end
end, false)




RegisterCommand("coords", function(source, args, rawCommand)	-- /coords		print exact ped location in console/F8
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			print(GetEntityCoords(GetPlayerPed(source)))
		end
	end
end, false)

RegisterCommand("players", function(source, args, rawCommand)	-- players		show online players | console only
	isPlayerOnline = false
	if source == 0 then
		local xAll = ESX.GetPlayers()
		print("^2"..#xAll.." ^3online player(s)^0")
		for i=1, #xAll, 1 do
			local xPlayer = ESX.GetPlayerFromId(xAll[i])
			print("^4[ ^2ID : ^3"..xPlayer.source.." ^0| ^2Name : ^3"..xPlayer.getName().." ^0 | ^2Group : ^3"..xPlayer.getGroup().." ^4]^0\n")
			isPlayerOnline = true
		end
		if not isPlayerOnline then
			print(_U('no_online'))
		end
	end
end, false)

--[[RegisterCommand("report", function(source, args, rawCommand)	-- /report [MESSAGE]		send report message to all online admins
  	local xPlayer = ESX.GetPlayerFromId(source)
	if onTimer[source] and onTimer[source] > GetGameTimer() then
		local timeLeft = (onTimer[source] - GetGameTimer()) / 1000
		TriggerClientEvent('chatMessage', xPlayer.source, _U('report_cooldown', tostring(ESX.Math.Round(timeLeft))))
		return
	end
	if args[1] then
    	local message = string.sub(rawCommand, 8)
    	local xAll = ESX.GetPlayers()
    	for i=1, #xAll, 1 do
      		local xTarget = ESX.GetPlayerFromId(xAll[i])
      		if havePermission(xTarget) then		-- you can exclude some ranks to NOT reciveing reports
        		if xPlayer.source ~= xTarget.source then
		    		TriggerClientEvent('chatMessage', xTarget.source, _U('report', xPlayer.getName(), xPlayer.source, message))
        		end
      		end
		end
		TriggerClientEvent('chatMessage', xPlayer.source, _U('report', xPlayer.getName(), xPlayer.source, message))
		onTimer[source] = GetGameTimer() + (Config.reportCooldown * 1000)
	else
		TriggerClientEvent('chatMessage', xPlayer.source, _U('invalid_input', 'REPORT'))
	end
end, false)]]--
------------ announcement -------------
RegisterCommand("announce", function(source, args, rawCommand)	-- /announce [MESSAGE]
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if args[1] then
			local message = string.sub(rawCommand, 10)
			if xPlayer then
				if havePermission(xPlayer) then
					TriggerClientEvent('chatMessage',-1 , _U('admin_announce', xPlayer.getName(), message))
				end
			end
		else
    		TriggerClientEvent('chatMessage', xPlayer.source, _U('invalid_input', 'ANNOUNCMENT'))
	 	end
	end
end, false)
------------ Console Say -------------
RegisterCommand("say", function(source, args, rawCommand)	-- say [message]		only for server console
	if source == 0 then
		if args[1] then
			local message = string.sub(rawCommand, 4)
			print("^1SERVER Announcement ^0: "..message)
			TriggerClientEvent('chatMessage',-1 , _U('server_announce', message))
		else
			print(_U('invalid_input'))
		end
	end
end, false)
---------- Bring / Bringback ----------
RegisterCommand("bring", function(source, args, rawCommand)	-- /bring [ID]
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer) then
	    	if args[1] and tonumber(args[1]) then
	      		local targetId = tonumber(args[1])
	      		local xTarget = ESX.GetPlayerFromId(targetId)
	      		if xTarget then
	        		local targetCoords = xTarget.getCoords()
	        		local playerCoords = xPlayer.getCoords()
	        		savedCoords[targetId] = targetCoords
	        		xTarget.setCoords(playerCoords)
	        		TriggerClientEvent("chatMessage", xPlayer.source, _U('bring_adminside', args[1]))
	        		TriggerClientEvent("chatMessage", xTarget.source, _U('bring_playerside'))
	      		else
	        		TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'BRING'))
	      		end
	    	else
	      		TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input', 'BRING'))
	    	end
	  	end
	end
end, false)

RegisterCommand("bringback", function(source, args, rawCommand)	-- /bringback [ID] will teleport player back where he was before /bring
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			local playerCoords = savedCoords[targetId]
        			if playerCoords then
          			xTarget.setCoords(playerCoords)
          			TriggerClientEvent("chatMessage", xPlayer.source, _U('bringback_admin', 'BRINGBACK', args[1]))
          			TriggerClientEvent("chatMessage", xTarget.source,  _U('bringback_player', 'BRINGBACK'))
          			savedCoords[targetId] = nil
        		else
          			TriggerClientEvent("chatMessage", xPlayer.source, _U('noplace_bring'))
        			end
      			else
        			TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'BRINGBACK'))
      			end
    		else
      			TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input', 'BRINGBACK'))
    		end
  		end
	end
end, false)

---------- goto/goback ----------
RegisterCommand("goto", function(source, args, rawCommand)	-- /goto [ID]
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			local targetCoords = xTarget.getCoords()
        			local playerCoords = xPlayer.getCoords()
        			savedCoords[source] = playerCoords
        			xPlayer.setCoords(targetCoords)
        			TriggerClientEvent("chatMessage", xPlayer.source, _U('goto_admin', args[1]))
					TriggerClientEvent("chatMessage", xTarget.source,  _U('goto_player'))
      			else
        			TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'GOTO'))
      			end
    		else
      			TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input', 'GOTO'))
    		end
  		end
	end
end, false)

RegisterCommand("goback", function(source, args, rawCommand)	-- /goback will teleport you back where you was befor /goto
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer) then
	    	local playerCoords = savedCoords[source]
	    	if playerCoords then
	      		xPlayer.setCoords(playerCoords)
				TriggerClientEvent("chatMessage", xPlayer.source, _U('goback'))
	      		savedCoords[source] = nil
	    	else
	      		TriggerClientEvent("chatMessage", xPlayer.source, _U('goback_error'))
	    	end
	  	end
	end
end, false)

---------- Noclip --------
RegisterCommand("noclip", function(source, args, rawCommand)	-- /goback will teleport you back where you was befor /goto
	if source ~= 0 then
	  	local xPlayer = ESX.GetPlayerFromId(source)
	  	if havePermission(xPlayer) then
	    	TriggerClientEvent("esx_admin:noclip", xPlayer.source)
	  	end
	end
end, false)
---------- kill ----------
RegisterCommand("kill", function(source, args, rawCommand)	-- /kill [ID]
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			if args[1] and tonumber(args[1]) then
				local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
					TriggerClientEvent("esx_admin:killPlayer", xTarget.source)
        			TriggerClientEvent("chatMessage", xPlayer.source, _U('kill_admin', targetId))
					TriggerClientEvent('chatMessage', xTarget.source, _U('kill_by_admin'))
      			else
        			TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'KILL'))
      			end
    		else
      			TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input', 'KILL'))
    		end
  		end
	end
end, false)

---------- freeze/unfreeze ---------
RegisterCommand("freeze", function(source, args, rawCommand)	-- /freeze [ID]
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			TriggerClientEvent("esx_admin:freezePlayer", xTarget.source, 'freeze')
					TriggerClientEvent("chatMessage", xPlayer.source, _U('freeze_admin', args[1]))
					TriggerClientEvent("chatMessage", xTarget.source, _U('freeze_player'))
      			else
        			TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'FREEZE'))
      			end
    		else
		      	TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input', 'FREEZE'))
    		end
  		end
	end
end, false)

RegisterCommand("unfreeze", function(source, args, rawCommand)	-- /unfreeze [ID]
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        			TriggerClientEvent("esx_admin:freezePlayer", xTarget.source, 'unfreeze')
					TriggerClientEvent("chatMessage", xPlayer.source, _U('unfreeze_admin', args[1]))
					TriggerClientEvent("chatMessage", xTarget.source, _U('unfreeze_player'))
      			else
        			TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'UNFREEZE'))
      			end
    		else
      			TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input', 'UNFREEZE'))
    		end
  		end
	end
end, false)


RegisterCommand('heal', function(source, args, rawCommand)
  
if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
      			if xTarget then
        	TriggerClientEvent("esx_ambulancejob:heal", xTarget.source, 'big')
				
			TriggerClientEvent('mythic_hospital:client:ResetLimbs', xTarget.source)
			TriggerClientEvent('mythic_hospital:client:RemoveBleed', xTarget.source)
			TriggerClientEvent('esx_admin:healPlayer', xTarget.source)
      			else
        			TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online'))
      			end
    		else
      		--	TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input'))
    		end
  		end
	end
end, false)


RegisterCommand('healall', function(source, args, rawCommand)
  local xPlayer = ESX.GetPlayerFromId(source)
	 if havePermission(xPlayer) then
	    local xPlayers = ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayerx = ESX.GetPlayerFromId(xPlayers[i])
		TriggerClientEvent("esx_ambulancejob:heal", xPlayerx.source, 'big')
		TriggerClientEvent('mythic_hospital:client:ResetLimbs', xPlayerx.source)
		TriggerClientEvent('mythic_hospital:client:RemoveBleed', xPlayerx.source)
		TriggerClientEvent('esx_admin:healPlayer', xPlayerx.source)
     end
    end
end, true)





RegisterCommand("bringall", function(source, args, rawCommand)	-- /bring [ID]
	 local xPlayer = ESX.GetPlayerFromId(source)
	 if havePermission(xPlayer) then
	 local xPlayers = ESX.GetPlayers()
	 for i=1, #xPlayers, 1 do
        local xPlayerx = ESX.GetPlayerFromId(xPlayers[i])
	
		
					local targetCoords = xPlayerx.getCoords()
	        		local playerCoords = xPlayer.getCoords()
	        		savedCoords[xPlayerx] = targetCoords
	        		xPlayerx.setCoords(playerCoords)
	        		
     end
    end
end, false)





RegisterCommand("reviveall", function(source, args, rawCommand)	-- reviveall (can be used from console)
	canRevive = false
	if source == 0 then
		canRevive = true
	else
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			canRevive = true
		end
	end
	if canRevive then
		for i,data in pairs(deadPlayers) do
			TriggerClientEvent('esx_ambulancejob:revive', i)
				TriggerClientEvent('esx_admin:healPlayer', i)
		end
	end
end, false)

RegisterCommand("a", function(source, args, rawCommand)	-- /a command for adminchat
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			if args[1] then
				local message = string.sub(rawCommand, 3)
				local xAll = ESX.GetPlayers()
				for i=1, #xAll, 1 do
					local xTarget = ESX.GetPlayerFromId(xAll[i])
					if havePermission(xTarget) then
						TriggerClientEvent('chatMessage', xTarget.source, _U('adminchat', xPlayer.getName(), xPlayer.getGroup(), message))
					end
				end
			else
				TriggerClientEvent('chatMessage', xPlayer.source, _U('invalid_input', 'AdminChat'))
			end
		end
	end
end, false)



--[[
RegisterCommand("addcuffandkey", function(source)	-- /a command for adminchat

	local xPlayer = ESX.GetPlayerFromId(source)
	randomkey = math.random(1111,10000)
			if havePermission(xPlayer) then
				local item_meta = {}
				item_meta.type = randomkey
				item_meta.cuffandkey = randomkey
				xPlayer.addInventoryItem('handcuffkey', 2, item_meta)
				xPlayer.addInventoryItem('handcuff', 1, item_meta)
			end
end)
]]

RegisterCommand("warn", function(source, args, rawCommand)	-- /warn [ID] , will warn player and kick if execeed max warns
	if source ~= 0 then
  		local xPlayer = ESX.GetPlayerFromId(source)
  		if havePermission(xPlayer) then
    		if args[1] and tonumber(args[1]) then
					if source == tonumber(args[1]) then
						TriggerClientEvent("chatMessage", xPlayer.source, _U('selfwarn'))
					else
      					local targetId = tonumber(args[1])
      					local xTarget = ESX.GetPlayerFromId(targetId)
      					if xTarget then
							if havePermission(xTarget) then
								TriggerClientEvent("chatMessage", xPlayer.source, _U('adminwarn'))
								TriggerClientEvent("chatMessage", xTarget.source, _U('adminwarn_to', args[1],xPlayer.getName(), xPlayer.getGroup()))
							else
								local warnCount = warnedPlayers[targetId] or 1
								if warnCount >= Config.warnMax then
									DropPlayer(targetId, _U('warnkick'))
									TriggerClientEvent("chatMessage", xPlayer.source, _U('playerkicked', args[1], warnCount, Config.warnMax))
									warnedPlayers[targetId] = nil
								else
									TriggerClientEvent("chatMessage", xPlayer.source, _U('playerwarned', args[1], warnCount, Config.warnMax))
									TriggerClientEvent("chatMessage", xTarget.source, _U('gotwarn', warnCount, Config.warnMax))
									warnedPlayers[targetId] = warnCount + 1
								end
							end
      					else
        				TriggerClientEvent("chatMessage", xPlayer.source, _U('not_online', 'WARN'))
      				end
				end
    		else
      			TriggerClientEvent("chatMessage", xPlayer.source, _U('invalid_input', 'WARN'))
    		end
  		end
	end
end, false)


RegisterCommand("playerblip", function(source, args, rawCommand)	-- /tpm		teleport to waypoint
	if source ~= 0 then
		local xPlayer = ESX.GetPlayerFromId(source)
		if havePermission(xPlayer) then
			TriggerClientEvent("esx_admin:playerblip", xPlayer.source)
		end
	end
end, false)

------------ functions and events ------------
RegisterNetEvent('esx:onPlayerDeath')
AddEventHandler('esx:onPlayerDeath', function(data)
	deadPlayers[source] = data
end)

RegisterNetEvent('esx:onPlayerSpawn')
AddEventHandler('esx:onPlayerSpawn', function()
	if deadPlayers[source] then
		deadPlayers[source] = nil
	end
end)

AddEventHandler('esx:playerDropped', function(playerId, reason)
	-- empty tables when player no longer online
	if onTimer[playerId] then
		onTimer[playerId] = nil
	end
    if savedCoords[playerId] then
    	savedCoords[playerId] = nil
    end
	if warnedPlayers[playerId] then
		warnedPlayers[playerId] = nil
	end
	if deadPlayers[playerId] then
		deadPlayers[playerId] = nil
	end
end)

function havePermission(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument

	local playerGroup = xPlayer.getGroup()
	for k,v in pairs(Config.adminRanks) do
		if v == playerGroup then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

function havePermission2(xPlayer, exclude)	-- you can exclude rank(s) from having permission to specific commands 	[exclude only take tables]
	if exclude and type(exclude) ~= 'table' then exclude = nil;print("^3[esx_admin] ^1ERROR ^0exclude argument is not table..^0") end	-- will prevent from errors if you pass wrong argument

	local playerGroup2 = xPlayer.getGroup()
	for k,v in pairs(Config.adminRanks2) do
		if v == playerGroup2 then
			if not exclude then
				return true
			else
				for a,b in pairs(exclude) do
					if b == v then
						return false
					end
				end
				return true
			end
		end
	end
	return false
end

--[[
RegisterServerEvent('esx_admin:VehicleManagement')
AddEventHandler('esx_admin:VehicleManagement', function(plate, props)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local perms = xPlayer.getGroup()
	local result
	
    if perms == 'admin'  then                
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE plate = @plate', {
			['@plate'] = plate
		}, function (result)
			
		
			
                if result[1] == nil then
                    MySQL.Async.fetchAll('INSERT INTO owned_vehicles (owner, plate, vehicle, category) VALUES (@owner, @plate, @vehicle, @category)',
                    {
                        ['@owner'] = xPlayer.identifier,
                        ['@plate'] = plate,
                        ['@vehicle'] = json.encode(props),
						['@category'] = 'custom'
                      
                    })
				end
				end)	
				
			
		
   	 end
end)]]
--[[
local bucketOccupied = {}
local virtualWorld = 0

function sendPlayerToUniverse(source, bucket)
    local entity = GetPlayerPed(source)
    if bucketOccupied[bucket] then

    else
        SetEntityRoutingBucket(entity, bucket)
    end
end

RegisterServerEvent('teleportC')
AddEventHandler('teleportC', function(worldchannel)
	    
		local source_ = source
		local xPlayer = ESX.GetPlayerFromId(source_)
		--virtualWorld = virtualWorld + 1
		--if virtualWorld >= 1000 then
		--	virtualWorld = 1
		--end
	
		SetPlayerRoutingBucket(source_, worldchannel)
		--xPlayer.setCoords(myoldcoords)				
		savedCoords[xPlayer] = nil
		
end)



RegisterServerEvent('teleport')
AddEventHandler('teleport', function(myoldcoords)
	local source_ = source
    SetPlayerRoutingBucket(source_, virtualWorld)
		local xPlayer = ESX.GetPlayerFromId(source_)
		
				if xPlayer then
				  local targetCoords = xPlayer.getCoords()
				 
				  savedCoords[xPlayer] = targetCoords
				  local source_ = source
				  SetPlayerRoutingBucket(source_, 0)
		
		end
		
end)
]]

--[[
function sendPlayerToUniverse2(source, bucket)
    local entity = GetPlayerPed(source)
    if bucketOccupied[bucket] then

    else
        SetEntityRoutingBucket(entity, bucket)
    end
end

RegisterNetEvent(triggerName('enterVirtualWorld'))
AddEventHandler(triggerName('enterVirtualWorld'), function(_source)
    local source_ = source
    virtualWorld = virtualWorld + 1
    if virtualWorld >= 64 then
        virtualWorld = 1
    end
    SetPlayerRoutingBucket(source_, virtualWorld)
end)

RegisterNetEvent(triggerName('leaveVirtualWorld'))
AddEventHandler(triggerName('leaveVirtualWorld'), function(_source)
    local source_ = source
    SetPlayerRoutingBucket(source_, 0)
end)]]

