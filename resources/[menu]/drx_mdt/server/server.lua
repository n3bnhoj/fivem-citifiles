------------------------CREDITS------------------------
--------        Script made by Deltarix        --------
--   Copyright 2021 Deltarix. All rights reserved    --
-------------------------------------------------------
RegisterServerEvent('drx_mdt:openmdt')
AddEventHandler('drx_mdt:openmdt', function(src)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for k,v in pairs(Config.Permission) do
        if xPlayer.job.name == v then
            MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.getIdentifier()
            }, function(result)
                if result[1] == nil then
                   -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.Register, length = '5000', style = {}})
                    xPlayer.showNotification(Config.Notifications.Register)
                else
                    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles WHERE identifier = @identifier ', {['identifier'] = xPlayer.getIdentifier()}, function(char)
                        charProfiles = {} if (char[1] ~= nil) then for i=1, #char, 1 do table.insert(charProfiles, {identifier = char[i].identifier,rank = char[i].rank,charname = char[i].charname,policegroup = char[i].policegroup,badgenumber = char[i].badgenumber,duty = char[i].duty,image = char[i].image,}) end end end)
                    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier ', {['identifier'] = xPlayer.getIdentifier()}, function(player)
                        playerInfo = {} if (player[1] ~= nil) then for i=1, #player, 1 do table.insert(playerInfo, {identifier = identifier,firstname = player[i].firstname,lastname = player[i].lastname,phonenumber = player[i].phonenumber,dateofbirth = player[i].dateofbirth,}) end end end)
                    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_warrants', {}, function(warrants)
                        drxWarrants = {} for k,v in pairs(warrants) do v.warrants = json.decode(v.warrants) table.insert(drxWarrants, v) end end)
                    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_dispatch', {}, function(drxDispatches)
                        MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles', {}, function(drxProfiles)
                            TriggerClientEvent('drx_mdt:openMDT', src, charProfiles, playerInfo, drxWarrants, drxDispatches, drxProfiles)
                        end)
                    end)
                end
            end)
        end
    end
end)

RegisterServerEvent('drx_mdt:openmdt2')
AddEventHandler('drx_mdt:openmdt2', function(src)
  
local src = source
local xPlayer = ESX.GetPlayerFromId(src)
for k,v in pairs(Config.Permission) do
    if xPlayer.job.name == v then
        MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.getIdentifier()
        }, function(result)
            if result[1] == nil then
               -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.Register, length = '5000', style = {}})
             --  ESX.ShowNotification(Config.Notifications.Register, "info", 3000)
               xPlayer.showNotification(Config.Notifications.Register)
               
            else
                MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles WHERE identifier = @identifier ', {['identifier'] = xPlayer.getIdentifier()}, function(char)
                    charProfiles = {} if (char[1] ~= nil) then for i=1, #char, 1 do table.insert(charProfiles, {identifier = char[i].identifier,rank = char[i].rank,charname = char[i].charname,policegroup = char[i].policegroup,badgenumber = char[i].badgenumber,duty = char[i].duty,image = char[i].image,}) end end end)
                MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier ', {['identifier'] = xPlayer.getIdentifier()}, function(player)
                    playerInfo = {} if (player[1] ~= nil) then for i=1, #player, 1 do table.insert(playerInfo, {identifier = identifier,firstname = player[i].firstname,lastname = player[i].lastname,phonenumber = player[i].phonenumber,dateofbirth = player[i].dateofbirth,}) end end end)
                MySQL.Async.fetchAll('SELECT * FROM drx_mdt_warrants', {}, function(warrants)
                    drxWarrants = {} for k,v in pairs(warrants) do v.warrants = json.decode(v.warrants) table.insert(drxWarrants, v) end end)
                MySQL.Async.fetchAll('SELECT * FROM drx_mdt_dispatch', {}, function(drxDispatches)
                    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles', {}, function(drxProfiles)
                        TriggerClientEvent('drx_mdt:openMDT', src, charProfiles, playerInfo, drxWarrants, drxDispatches, drxProfiles)
                    end)
                end)
            end
        end)
    end
end
end)

RegisterCommand(Config.Command, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for k,v in pairs(Config.Permission) do
        if xPlayer.job.name == v then
            MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.getIdentifier()
            }, function(result)
                if result[1] == nil then
                    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.Register, length = '5000', style = {}})
                    xPlayer.showNotification(Config.Notifications.Register)
                else
                    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles WHERE identifier = @identifier ', {['identifier'] = xPlayer.getIdentifier()}, function(char)
                        charProfiles = {} if (char[1] ~= nil) then for i=1, #char, 1 do table.insert(charProfiles, {identifier = char[i].identifier,rank = char[i].rank,charname = char[i].charname,policegroup = char[i].policegroup,badgenumber = char[i].badgenumber,duty = char[i].duty,image = char[i].image,}) end end end)
                    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier ', {['identifier'] = xPlayer.getIdentifier()}, function(player)
                        playerInfo = {} if (player[1] ~= nil) then for i=1, #player, 1 do table.insert(playerInfo, {identifier = identifier,firstname = player[i].firstname,lastname = player[i].lastname,phonenumber = player[i].phonenumber,dateofbirth = player[i].dateofbirth,}) end end end)
                    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_warrants', {}, function(warrants)
                        drxWarrants = {} for k,v in pairs(warrants) do v.warrants = json.decode(v.warrants) table.insert(drxWarrants, v) end end)
                    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_dispatch', {}, function(drxDispatches)
                        MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles', {}, function(drxProfiles)
                            TriggerClientEvent('drx_mdt:openMDT', src, charProfiles, playerInfo, drxWarrants, drxDispatches, drxProfiles)
                        end)
                    end)
                end
            end)
        end
    end
end)

RegisterCommand(Config.RegisterCommand, function(source, args)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    for k,v in pairs(Config.Permission) do
        if xPlayer.job.name == v then
            TriggerEvent('drx_mdt:RegisterAccess', src)
        end
    end
end)

-- If police has no information, then assign it to drx_mdt_profiles
RegisterServerEvent('drx_mdt:RegisterAccess')
AddEventHandler('drx_mdt:RegisterAccess', function(src)
    local src = src
    local xPlayer = ESX.GetPlayerFromId(src)

    for k,v in pairs(Config.Permission) do
        if xPlayer.job.name == v then
            MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles WHERE identifier = @identifier', {
                ['@identifier'] = xPlayer.getIdentifier()
            }, function(result)
                local actualResult = result
        
                if (actualResult[1] == nil) then
                    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
                        ['@identifier'] = xPlayer.getIdentifier()
                    }, function(identityResult)
    
                      --  TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.Registered, length = '5000', style = {}})
                        xPlayer.showNotification(Config.Notifications.Registered)
                        MySQL.Async.insert('INSERT INTO drx_mdt_profiles (identifier, rank, charname, policegroup, badgenumber, duty, image) VALUES (@identifier, @rank, @charname, @policegroup, @badgenumber, @duty, @image)', {
                            ['@identifier'] = xPlayer.getIdentifier(),
                            ['@rank'] = 'user',
                            ['@charname'] = identityResult[1].firstname.. ' ' ..identityResult[1].lastname,
                            ['@policegroup'] = Config.AssignPolicegroup,
                            ['@badgenumber'] = Config.AssignBadgenumber,
                            ['@duty'] = 'Off duty',
                            ['@image'] = Config.AssignImage,
                        })
                    end)
                else
                    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.AlreadyRegistered, length = '5000', style = {}})
                    xPlayer.showNotification(Config.Notifications.AlreadyRegistered)
                end
            end)
        end
    end
end)

-- Fetching drx_mdt_profiles
ESX.RegisterServerCallback('drx_mdt:profiles', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles', {
    }, function(drxProfiles)
        cb(drxProfiles)
    end)
end)

--## CRIMINAL RECORDS PAGE ##--
RegisterServerEvent('drx_mdt:searchPerson')
AddEventHandler('drx_mdt:searchPerson', function(searchInput)
    local src = source

    MySQL.Async.fetchAll('SELECT * FROM users WHERE LOWER(`firstname`) LIKE @searchInput OR LOWER(`lastname`) LIKE @searchInput OR phonenumber LIKE @searchInput', {
		['@searchInput'] = string.lower('%'..searchInput..'%')
	}, function(result)

        local searchResults = {}
        for k,v in ipairs(result) do
            v.charname = v.firstname.. ' ' ..v.lastname
            table.insert(searchResults, v)
        end


        TriggerClientEvent('drx_mdt:returnSearchPerson', src, searchResults)
    end)
end)

RegisterServerEvent('drx_mdt:fetchSelectPerson')
AddEventHandler('drx_mdt:fetchSelectPerson', function(data)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = data.identifier
    }, function(v)
        local charname = v[1].firstname.. ' ' ..v[1].lastname
        TriggerClientEvent('drx_mdt:returnSelectPerson', src, charname, v[1].dateofbirth, v[1].phonenumber, v[1].sex, v[1].height, v[1].note, v[1].image, v[1].wanted)
    end)
end)

RegisterServerEvent('drx_mdt:uploadPersonImage')
AddEventHandler('drx_mdt:uploadPersonImage', function(identifier, image)
    MySQL.Async.execute('UPDATE users SET image = @image WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
        ['@image'] = image
    })
end)

RegisterServerEvent('drx_mdt:saveNotes')
AddEventHandler('drx_mdt:saveNotes', function(identifier, note)
    MySQL.Async.execute('UPDATE users SET note = @note WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
        ['@note'] = note
    })
end)

RegisterServerEvent('drx_mdt:fetchLicenses')
AddEventHandler('drx_mdt:fetchLicenses', function(data)
    local src = source
    
	MySQL.Async.fetchAll('SELECT * FROM user_licenses WHERE owner = @owner', {
        ['@owner'] = data.identifier
	}, function(result)
		TriggerClientEvent('drx_mdt:returnLicenses', src, result)
	end)
end)

RegisterServerEvent('drx_mdt:removeLicenses')
AddEventHandler('drx_mdt:removeLicenses', function(data)
    local src = source
    MySQL.Async.execute('DELETE FROM user_licenses WHERE type = @type AND owner = @owner', {
        ['@type'] = data.licenseType,
        ['@owner'] = data.identifier
    })
end)

RegisterServerEvent('drx_mdt:markPersonWanted')
AddEventHandler('drx_mdt:markPersonWanted', function(data)
    local src = source
    if data.wanted == 'No' then
        MySQL.Async.execute('UPDATE users SET wanted = @wanted WHERE identifier = @identifier', {
            ['@identifier'] = data.identifier,
            ['@wanted'] = 'Yes'
        })
    elseif data.wanted == 'Yes' then
        MySQL.Async.execute('UPDATE users SET wanted = @wanted WHERE identifier = @identifier', {
            ['@identifier'] = data.identifier,
            ['@wanted'] = 'No'
        })
    end
    Wait(20)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = data.identifier,
    }, function(v)
        TriggerClientEvent('drx_mdt:returnWantedStatus', src, v[1].wanted)
    end)
end)

RegisterServerEvent('drx_mdt:newCharge')
AddEventHandler('drx_mdt:newCharge', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    data.jailTime = tonumber(data.jailTime)
    xPlayer.showNotification(Config.Notifications.newCharge.. ' ' ..data.victim.. ' ' ..Config.Notifications.newCharge2)
   -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.newCharge.. ' ' ..data.victim.. ' ' ..Config.Notifications.newCharge2, length = '5000', style = {}})
    MySQL.Async.insert('INSERT INTO drx_mdt_charges (identifier, title, incident, victim, author, charges, fine, jailTime, date) VALUES (@identifier, @title, @incident, @victim, @author, @charges, @fine, @jailTime, @date)', {
        ['@identifier'] = data.identifier,
		['@title'] = data.title,
        ['@incident'] = data.incident,
		['@victim'] = data.victim,
		['@author'] = data.author,
		['@charges'] = json.encode(data.charges),
		['@date'] = os.date('%m-%d-%Y %H:%M:%S', os.time()),
		['@fine'] = data.fine,
		['@jailTime'] = data.jailTime,
    })
end)

RegisterServerEvent('drx_mdt:fetchCharges')
AddEventHandler('drx_mdt:fetchCharges', function(identifier)
    local src = source
    
	MySQL.Async.fetchAll('SELECT * FROM drx_mdt_charges WHERE identifier = @identifier', {
        ['@identifier'] = identifier
	}, function(result)
        
        local ChargeResult = {}
		for k,v in pairs(result) do
			v.charges = json.decode(v.charges)
			table.insert(ChargeResult, v)
		end
        
		TriggerClientEvent('drx_mdt:returnCharges', src, ChargeResult)
	end)
end)

RegisterServerEvent('drx_mdt:sentenceTarget')
AddEventHandler('drx_mdt:sentenceTarget', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if ESX.GetPlayerFromIdentifier(data.identifier) then
        local target = ESX.GetPlayerFromIdentifier(data.identifier)
        MySQL.Async.execute('UPDATE drx_mdt_charges SET sentenced = @sentenced WHERE id = @id AND identifier = @identifier', {
            ['@id'] = data.id,
            ['@identifier'] = data.identifier,
            ['@sentenced'] = 'Yes'
        })
        data.fine = tonumber(data.fine)
        if data.fine > 0 then
            if Config.Billing then
                TriggerEvent('esx_billing:sendBill', target.source, 'society_police', 'Police', data.fine)
            else
                local bankBalance = target.getAccounts('bank').bank
                newBalance = bankBalance - data.fine
                target.setAccountMoney('bank', newBalance)
            end
            xPlayer.showNotification( Config.Notifications.Fined.. '' ..data.fine)
            --TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = Config.Notifications.Fined.. '' ..data.fine, length = '5000', style = {}})
        end
        
        data.jailTime = tonumber(data.jailTime)
        if data.jailTime > 0 then
            TriggerEvent('StartJailSystem', target.source, data.jailTime)
            xPlayer.showNotification(Config.Notifications.Jailed.. ' ' ..data.jailTime.. ' ' ..Config.Notifications.Jailed2)
           -- TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = Config.Notifications.Jailed.1. ' ' ..data.jailTime.. ' ' ..Config.Notifications.Jailed2, length = '5000', style = {}})
        end
    else
        xPlayer.showNotification(Config.Notifications.NotOnline)
        --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.NotOnline, length = '5000', style = {}})
    end
end)

RegisterServerEvent('drx_mdt:deleteCharge')
AddEventHandler('drx_mdt:deleteCharge', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    data.id = tonumber(data.id)
    MySQL.Async.execute('DELETE FROM drx_mdt_charges WHERE id = @id', {
        ['@id'] = data.id
    })
    xPlayer.showNotification(Config.Notifications.ChargeDeleted)
    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = Config.Notifications.ChargeDeleted, length = '5000', style = {}})
end)

RegisterServerEvent('drx_mdt:editCharge')
AddEventHandler('drx_mdt:editCharge', function(data)
    local src = source
    data.id = tonumber(data.id)
    MySQL.Async.execute('UPDATE drx_mdt_charges SET title = @title, incident = @incident, fine = @fine, jailTime = @jailTime WHERE id = @id', {
        ['@id'] = data.id,
        ['@title'] = data.title,
        ['@incident'] = data.details,
        ['@fine'] = data.fine,
        ['@jailTime'] = data.jailTime
    })
end)
--## CRIMINAL RECORDS PAGE ##--

--## SEARCH VEHICLE PAGE ##--
RegisterServerEvent('drx_mdt:searchVehicle')
AddEventHandler('drx_mdt:searchVehicle', function(searchVehicle)
    local src = source

    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE LOWER(plate) LIKE @searchVehicle', {
		['@searchVehicle'] = string.lower('%'..searchVehicle..'%')
	}, function(result)
        local VehicleResults = {}
        for k,v in ipairs(result) do
            table.insert(VehicleResults, v)
        end

        TriggerClientEvent('drx_mdt:returnSearchVehicle', src, VehicleResults)
    end)
end)

RegisterServerEvent('drx_mdt:fetchSelectVehicle')
AddEventHandler('drx_mdt:fetchSelectVehicle', function(data)
    local src = source

    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = data.owner
    }, function(result)
        local charname = result[1].firstname.. ' ' ..result[1].lastname

        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
            ['@owner'] = data.owner,
            ['@plate'] = data.plate
        }, function(vehicleData)

            for k,v in pairs(vehicleData) do
                local Colors = Config.Colors
                local data = json.decode(v.vehicle)
                modelHash = data.model
                if data.color1 then
                    color = Colors[tostring(data.color1)]
                    if Colors[tostring(data.color2)] then
                        color = Colors[tostring(data.color2)] .. ' on ' .. Colors[tostring(data.color1)]
                    end
                end
            end
            TriggerClientEvent('drx_mdt:returnSelectVehicle', src, charname, modelHash, vehicleData[1].plate, vehicleData[1].type, color, vehicleData[1].stolen, vehicleData[1].image)
        end)
    end)
end)

RegisterServerEvent('drx_mdt:changeVehicleImage')
AddEventHandler('drx_mdt:changeVehicleImage', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if data.image > Config.ImageChangeLink then
        MySQL.Async.execute('UPDATE owned_vehicles SET image = @image WHERE owner = @owner AND plate = @plate', {
            ['@owner'] = data.owner,
            ['@plate'] = data.plate,
            ['@image'] = data.image
        })
        xPlayer.showNotification(Config.Notifications.VehImageSaved)
       -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'success', text = Config.Notifications.VehImageSaved, length = '5000', style = {}})
    else
        xPlayer.showNotification(Config.Notifications.NotImgur)
       -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.NotImgur, length = '5000', style = {}})
    end
end)

RegisterServerEvent('drx_mdt:markVehicleStolen')
AddEventHandler('drx_mdt:markVehicleStolen', function(data)
    local src = source
    if data.stolen == 'No' then
        MySQL.Async.execute('UPDATE owned_vehicles SET stolen = @stolen WHERE owner = @owner AND plate = @plate', {
            ['@owner'] = data.owner,
            ['@plate'] = data.plate,
            ['@stolen'] = 'Yes'
        })
    elseif data.stolen == 'Yes' then
        MySQL.Async.execute('UPDATE owned_vehicles SET stolen = @stolen WHERE owner = @owner AND plate = @plate', {
            ['@owner'] = data.owner,
            ['@plate'] = data.plate,
            ['@stolen'] = 'No'
        })
    end
    Wait(20)
    MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND plate = @plate', {
        ['@owner'] = data.owner,
        ['@plate'] = data.plate
    }, function(veh)
        TriggerClientEvent('drx_mdt:returnStolenStatus', src, veh[1].stolen)
    end)
end)

RegisterServerEvent('drx_mdt:removeWarrant')
AddEventHandler('drx_mdt:removeWarrant', function(data)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
	MySQL.Async.execute('DELETE FROM `drx_mdt_warrants` WHERE `id` = @id', {
		['@id'] = data.id
	}, function()
		TriggerClientEvent('drx_mdt:updateWarrants', src)
	end)
    xPlayer.showNotification(Config.Notifications.WarrantRemoved)
    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.WarrantRemoved, length = '5000', style = {}})
end)
--## SEARCH VEHICLE PAGE ##--

--## DISPATCH PAGE ##--
ESX.RegisterServerCallback('drx_mdt:fetchDispatch', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_dispatch', {
    }, function(drxDispatches)
        cb(drxDispatches)
    end)
end)

RegisterServerEvent('drx_mdt:newDispatch')
AddEventHandler('drx_mdt:newDispatch', function(details, location, coords)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)
        local caller = result[1].firstname.. ' ' ..result[1].lastname
        local date = os.date('%m-%d-%Y %H:%M:%S', os.time())
        if caller and details and date and location then
            if string.len(details) < Config.MaxChars and string.len(details) > Config.MinChars then
                MySQL.Async.insert('INSERT INTO drx_mdt_dispatch (identifier, caller, details, date, location, coords) VALUES (@identifier, @caller, @details, @date, @location, @coords)', {
                    ['@identifier'] = xPlayer.getIdentifier(),
                    ['@caller'] = 'Unknown',
                    ['@details'] = details,
                    ['@date'] = date,
                    ['@location'] = location,
                    ['@coords'] = json.encode(coords)
                })
                for k,v in pairs(Config.Permission) do
                    local xPlayers = ESX.GetExtendedPlayers('job', v)
                    for _, xPlayer in pairs(xPlayers) do
                        TriggerClientEvent('drx_mdt:updateDispatches', v)
                    end
                end
            else
                xPlayer.showNotification( Config.Notifications.LessDetails)
               -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.LessDetails, length = '5000', style = {}})
            end
        else
            xPlayer.showNotification( Config.Notifications.MoreDetails)
            --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.MoreDetails, length = '5000', style = {}})
        end
    end)
end)

RegisterServerEvent('drx_mdt:newDispatch2')
AddEventHandler('drx_mdt:newDispatch2', function(details, location, coords)
    local src = source
 
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)
        local caller = result[1].firstname.. ' ' ..result[1].lastname
        local date = os.date('%m-%d-%Y %H:%M:%S', os.time())
        if caller and details and date and location then
            if string.len(details) < Config.MaxChars and string.len(details) > Config.MinChars then
                MySQL.Async.insert('INSERT INTO drx_mdt_dispatch (identifier, caller, details, date, location, coords) VALUES (@identifier, @caller, @details, @date, @location, @coords)', {
                    ['@identifier'] = xPlayer.getIdentifier(),
                    ['@caller'] = caller,
                    ['@details'] = '911 - '..details,
                    ['@date'] = date,
                    ['@location'] = location,
                    ['@coords'] = json.encode(coords)
                })
                for k,v in pairs(Config.Permission) do
                    local xPlayers = ESX.GetExtendedPlayers('job', v)
                    for _, xPlayer in pairs(xPlayers) do
                        TriggerClientEvent('drx_mdt:updateDispatches', v)
                    end
                end
            else
                xPlayer.showNotification( Config.Notifications.LessDetails)
               -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.LessDetails, length = '5000', style = {}})
            end
        else
            xPlayer.showNotification( Config.Notifications.MoreDetails)
           -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.MoreDetails, length = '5000', style = {}})
        end
    end)
end)

RegisterServerEvent('drx_mdt:respondDispatch')
AddEventHandler('drx_mdt:respondDispatch', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local targetSource = ESX.GetPlayerFromIdentifier(data.identifier)
    if data.respond ~= nil and string.len(data.respond) > 0 then
        MySQL.Async.execute('UPDATE drx_mdt_dispatch SET respond = @respond WHERE id = @id', {
            ['@id'] = data.id,
            ['@respond'] = data.respond
        })
        for k,v in pairs(Config.Permission) do
            local xPlayers = ESX.GetExtendedPlayers('job', v)
            for _, xPlayer in pairs(xPlayers) do
                TriggerClientEvent('drx_mdt:updateDispatches', v)
            end
        end
        xPlayer.showNotification(Config.Notifications.Responded)
        xPlayer.showNotification(data.respond)
        --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.Responded, length = '5000', style = {}})
        --TriggerClientEvent('mythic_notify:client:SendAlert', targetSource.source, { type = 'inform', text = data.respond, length = '5000', style = {}})
    else
        xPlayer.showNotification(Config.Notifications.MoreRespond)
      --  TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.MoreRespond, length = '5000', style = {}})
    end
end)

RegisterServerEvent('drx_mdt:deleteDispatch')
AddEventHandler('drx_mdt:deleteDispatch', function(data)
    MySQL.Async.execute('DELETE FROM drx_mdt_dispatch WHERE id = @id', {
        ['@id'] = data.id
    })
    for k,v in pairs(Config.Permission) do
        local xPlayers = ESX.GetExtendedPlayers('job', v)
        for _, xPlayer in pairs(xPlayers) do
            TriggerClientEvent('drx_mdt:updateDispatches', v)
        end
    end
end)
--## DISPATCH PAGE ##--

--## WARRANTS PAGE ##--
ESX.RegisterServerCallback('drx_mdt:fetchWarrants', function(source, cb)
    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_warrants', {
    }, function(result)

        local drxWarrants = {}
        for k,v in pairs(result) do
            v.warrants = json.decode(v.warrants)
            table.insert(drxWarrants, v)
        end
        cb(drxWarrants)
    end)
end)

RegisterServerEvent('drx_mdt:newWarrant')
AddEventHandler('drx_mdt:newWarrant', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local date = os.date('%d-%m-%Y %H:%M:%S', os.time())
    if data.type == 'veh' then
        MySQL.Async.insert('INSERT INTO drx_mdt_warrants (identifier, title, incident, victim, author, model, plate, warrants, date, type) VALUES (@identifier, @title, @incident, @victim, @author, @model, @plate, @warrants, @date, @type)', {
            ['@identifier'] = data.identifier,
            ['@title'] = data.title,
            ['@incident'] = data.incident,
            ['@victim'] = data.victim,
            ['@author'] = data.author,
            ['@model'] = data.model,
            ['@plate'] = data.plate,
            ['@warrants'] = json.encode(data.warrants),
            ['@date'] = date,
            ['@type'] = 'veh',
        }, function()
        end)
    elseif data.type == 'person' then
        MySQL.Async.insert('INSERT INTO drx_mdt_warrants (identifier, title, incident, victim, author, date, warrants, type) VALUES (@identifier, @title, @incident, @victim, @author, @date, @warrants, @type)', {
            ['@identifier'] = data.identifier,
            ['@title'] = data.title,
            ['@incident'] = data.incident,
            ['@victim'] = data.victim,
            ['@author'] = data.author,
            ['@date'] = date,
            ['@warrants'] = json.encode(data.warrants),
            ['@type'] = 'person',
        }, function()
        end)
    end

    TriggerClientEvent('drx_mdt:updateWarrants', src)
    TriggerClientEvent('drx_mdt:updateAllWarrants', src)
    xPlayer.showNotification(Config.Notifications.WarrantAdded)
   -- TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.WarrantAdded, length = '5000', style = {}})
end)

RegisterServerEvent('drx_mdt:deleteWarrant')
AddEventHandler('drx_mdt:deleteWarrant', function(data)
    local src = source
    MySQL.Async.execute('DELETE FROM drx_mdt_warrants WHERE id = @id', {
        ['@id'] = data.id
    })
    for k,v in pairs(Config.Permission) do
        local xPlayers = ESX.GetExtendedPlayers('job', v)
        for _, xPlayer in pairs(xPlayers) do
            TriggerClientEvent('drx_mdt:updateAllWarrants', v)
        end
    end
end)
--## WARRANTS PAGE ##--

--## PROFILE PAGE ##--
-- Change duty on self at drx_mdt_profiles
RegisterServerEvent('drx_mdt:changeDuty')
AddEventHandler('drx_mdt:changeDuty', function(duty)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if duty == 'Off duty' then
        MySQL.Async.execute('UPDATE drx_mdt_profiles SET duty = @duty WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.getIdentifier(),
            ['@duty'] = 'On duty'
        })
        local users = ESX.GetPlayers()
        for k,v in pairs(users) do
            local xPlayers = ESX.GetPlayerFromId(v)
            if xPlayers.getGroup(Config.Permission) then
                TriggerClientEvent('drx_mdt:updateDutyAll', v)
            end
        end
        TriggerClientEvent('drx_mdt:updateDuty', src, 'On duty')
        --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.OnDuty, length = '5000', style = {}})
        xPlayer.showNotification(Config.Notifications.OnDuty)
    elseif duty == 'On duty' then
        MySQL.Async.execute('UPDATE drx_mdt_profiles SET duty = @duty WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.getIdentifier(),
            ['@duty'] = 'Off duty'
        })
        TriggerClientEvent('drx_mdt:updateDutyAll', src)
        TriggerClientEvent('drx_mdt:updateDuty', src, 'Off duty')
        xPlayer.showNotification(Config.Notifications.OffDuty)
        --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.OffDuty, length = '5000', style = {}})
    end
end)

-- Change image on self at drx_mdt_profiles
RegisterServerEvent('drx_mdt:changeImage')
AddEventHandler('drx_mdt:changeImage', function(image)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if image >= Config.ImageChangeLink then
        MySQL.Async.execute('UPDATE drx_mdt_profiles SET image = @image WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.getIdentifier(),
            ['@image'] = image
        })
    else
        xPlayer.showNotification(Config.Notifications.NoLink)
        --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'error', text = Config.Notifications.NoLink, length = '5000', style = {}})
    end
end)


-- Admin comit data to another user into drx_mdt_profiles
RegisterServerEvent('drx_mdt:changeComitData')
AddEventHandler('drx_mdt:changeComitData', function(identifierData, rankData, policegroupData, badgenumberData, imageData)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll('SELECT * FROM drx_mdt_profiles WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)

        if result[1] ~= nil then
            if result[1].identifier == xPlayer.getIdentifier() and result[1].rank == 'boss' then
                MySQL.Async.execute('UPDATE drx_mdt_profiles SET policegroup = @policegroup, badgenumber = @badgenumber, image = @image WHERE identifier = @identifier', {
                    ['@identifier'] = identifierData,
                    ['@policegroup'] = policegroupData,
                    ['@badgenumber'] = badgenumberData,
                    ['@image'] = imageData
                })
                TriggerClientEvent('drx_mdt:updateDutyAll', src)
                xPlayer.showNotification(Config.Notifications.DataComited)
                --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.DataComited, length = '5000', style = {}})
            end
        end
    end)
end)


-- Admin delete user from database
RegisterServerEvent('drx_mdt:deleteData')
AddEventHandler('drx_mdt:deleteData', function(identifierData)
    local src = source
    xPlayer = tonumber(identifierData)

    MySQL.Async.execute('DELETE FROM drx_mdt_profiles WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer
    })
    TriggerClientEvent('drx_mdt:updateDutyAll', src)
    xPlayer.showNotification(Config.Notifications.DataDeleted)
    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.DataDeleted, length = '5000', style = {}})
end)
--## PROFILE PAGE ##--



--- delete dispatch


RegisterServerEvent('drx_mdt:deletedispatch')
AddEventHandler('drx_mdt:deletedispatch', function()

    MySQL.Async.fetchAll('DELETE FROM drx_mdt_dispatch', {
    }, function()
        
    end)
end)
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1800000) -- in MS
        MySQL.Async.fetchAll('DELETE FROM drx_mdt_dispatch', {
        }, function()
            
        end)
  
    end
  end)