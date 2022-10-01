------------------------CREDITS------------------------
--------        Script made by Deltarix        --------
--   Copyright 2021 Deltarix. All rights reserved    --
-------------------------------------------------------

ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Open the menu
--[[
RegisterCommand('ems', function(source)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name == Config.Permission then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.getIdentifier()
        }, function(user)
            if user[1] then
                local charname = user[1].firstname.. ' ' ..user[1].lastname
                MySQL.Async.fetchAll('SELECT * FROM drx_emsmdt_calls', {}, function(calls)
                    TriggerClientEvent('OpenMDT', src, charname, user[1].emsstatus, calls)
                end)
            else
                TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.UserNotFound, length = '5000', style = {}})
            end
        end)
    end
end)
--
]]

RegisterServerEvent('OpenMDT2')
AddEventHandler('OpenMDT2', function()

    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if xPlayer.job.name == Config.Permission then
        MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.getIdentifier()
        }, function(user)
            if user[1] then
                local charname = user[1].firstname.. ' ' ..user[1].lastname
                MySQL.Async.fetchAll('SELECT * FROM drx_emsmdt_calls', {}, function(calls)
                    TriggerClientEvent('OpenMDT', src, charname, user[1].emsstatus, calls)
                end)
            else
                --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.UserNotFound, length = '5000', style = {}})
                xPlayer.showNotification(Config.Notifications.UserNotFound)
            end
        end)
    end
end)


-- Change status on self
RegisterServerEvent('drx_emsmdt:chooseStatus')
AddEventHandler('drx_emsmdt:chooseStatus', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('UPDATE users SET emsstatus = @emsstatus WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier(),
        ['@emsstatus'] = data.status
    })
end)

-- Create call event (type, message, location, coords)
RegisterServerEvent('drx_emsmdt:newCall')
AddEventHandler('drx_emsmdt:newCall', function(type, message, location, coords)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
        ['@identifier'] = xPlayer.getIdentifier()
    }, function(result)
        if result[1] then
            MySQL.Async.insert('INSERT INTO drx_emsmdt_calls (identifier, type, message, date, location, coords, charname, phonenumber) VALUES (@identifier, @type, @message, @date, @location, @coords, @charname, @phonenumber)', {
                ['@identifier'] = xPlayer.getIdentifier(),
                ['@type'] = type,
                ['@message'] = message,
                ['@date'] = os.date('%d-%m-%Y'),
                ['@location'] = location,
                ['@coords'] = json.encode(coords),
                ['@charname'] = result[1].firstname.. ' ' ..result[1].lastname,
                ['@phonenumber'] = result[1].phonenumber
            })
            --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.CallSubmitted, length = '5000', style = {}})
            xPlayer.showNotification(Config.Notifications.CallSubmitted)

            Wait(100)
            local users = ESX.GetPlayers()
            for k,v in pairs(users) do
                local xPlayers = ESX.GetPlayerFromId(v)
                if xPlayers.job.name == Config.Permission then
                    MySQL.Async.fetchAll('SELECT * FROM drx_emsmdt_calls', {}, function(calls)
                        TriggerClientEvent('drx_emsmdt:updateCallList', v, calls)
                    end)
                    MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
                        ['@identifier'] = xPlayers.getIdentifier()
                    }, function(status)
                        if status[1].emsstatus == 'Available' then
                            --TriggerClientEvent('mythic_notify:client:SendAlert', v, { type = 'inform', text = Config.Notifications.NewCall.. ' ' ..location, length = '5000', style = {}})
                            xPlayer.showNotification(Config.Notifications.NewCall.. ' ' ..location)
                        end
                    end)
                end
            end
        else
            print('[drx_emsmdt] - User does not exist in database, something is wrong with the database or the user')
        end
    end)
end)

-- User delete call from database and refresh ui for all with permission
RegisterServerEvent('drx_emsmdt:deleteCall')
AddEventHandler('drx_emsmdt:deleteCall', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('DELETE FROM drx_emsmdt_calls WHERE incident = @incident', {
        ['@incident'] = data.incident
    })
    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.DeleteCall.. '' ..data.incident, length = '5000', style = {}})
    xPlayer.showNotification(Config.Notifications.DeleteCall.. '' ..data.incident)
    Wait(100)
    local users = ESX.GetPlayers()
    for k,v in pairs(users) do
        local xPlayers = ESX.GetPlayerFromId(v)
        if xPlayers.job.name == Config.Permission then
            MySQL.Async.fetchAll('SELECT * FROM drx_emsmdt_calls', {}, function(calls)
                TriggerClientEvent('drx_emsmdt:updateCallList', v, calls)
            end)
        end
    end
end)

-- User responds to patient
RegisterServerEvent('drx_emsmdt:responCall')
AddEventHandler('drx_emsmdt:responCall', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local target = ESX.GetPlayerFromIdentifier(data.identifier)
    if data.msg ~= nil then
        if target then
            --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.RespondedCall.. '' ..data.incident, length = '5000', style = {}})
            --TriggerClientEvent('mythic_notify:client:SendAlert', target.source, { type = 'inform', text = Config.Notifications.ReceivedRespond.. ' #' ..data.incident.. ' ' ..data.msg, length = '5000', style = {}})
            xPlayer.showNotification(Config.Notifications.RespondedCall.. '' ..data.incident)
            xPlayer.showNotification(Config.Notifications.ReceivedRespond.. ' #' ..data.incident.. ' ' ..data.msg)
        else
            --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.NoTarget, length = '5000', style = {}})
            xPlayer.showNotification(Config.Notifications.NoTarget)
        end
    else
        --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.NoMessage, length = '5000', style = {}})
        xPlayer.showNotification(Config.Notifications.NoMessage)
    end
end)

-- User searches in database, and sends the info back to ui
RegisterServerEvent('drx_emsmdt:searchDatabase')
AddEventHandler('drx_emsmdt:searchDatabase', function(data)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM users WHERE firstname LIKE @searchInput OR lastname LIKE @searchInput', {
        ['@searchInput'] = string.lower('%'..data.searchInput..'%')
	}, function(result)
        local searchResults = {}
        for k,v in ipairs(result) do
            table.insert(searchResults, v)
        end
        TriggerClientEvent('drx_emsmdt:returnDatabaseSearch', src, searchResults)
    end)
end)

-- User selected a patient, let's send all info from drx_emsmdt_database about that patient to user
RegisterServerEvent('drx_emsmdt:fetchPersonDatabase')
AddEventHandler('drx_emsmdt:fetchPersonDatabase', function(data)
    local src = source
    MySQL.Async.fetchAll('SELECT * FROM drx_emsmdt_database WHERE identifier = @identifier', {
        ['@identifier'] = data.identifier
    }, function(database)
        TriggerClientEvent('drx_emsmdt:returnPersonDatabase', src, database, data.firstname, data.lastname, data.phonenumber)
    end)
end)

-- User created a new case record on patient, submit it to the database and then update the users ui with the updated database information
RegisterServerEvent('drx_emsmdt:submitNewCase')
AddEventHandler('drx_emsmdt:submitNewCase', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.insert('INSERT INTO drx_emsmdt_database (`identifier`, `patientName`, `author`, `title`, `desc`) VALUES (@identifier, @patientName, @author, @title, @desc)', {
        ['@identifier'] = data.identifier,
        ['@patientName'] = data.firstname.. ' ' ..data.lastname,
        ['@author'] = data.author,
        ['@title'] = data.title,
        ['@desc'] = data.desc
    })

    Wait(100)
    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.NewCase, length = '5000', style = {}})
    xPlayer.showNotification(Config.Notifications.NewCase)
    MySQL.Async.fetchAll('SELECT * FROM drx_emsmdt_database WHERE identifier = @identifier', {
        ['@identifier'] = data.identifier
    }, function(database)
        TriggerClientEvent('drx_emsmdt:updatePersonDatabase', src, database)
    end)
end)

-- User requests to delete case, let's comit it and update the users ui with the updated information
RegisterServerEvent('drx_emsmdt:deletePersonCase')
AddEventHandler('drx_emsmdt:deletePersonCase', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('DELETE FROM drx_emsmdt_database WHERE id = @id', {
        ['@id'] = data.id
    }, function(success)
        if success then
            xPlayer.showNotification(Config.Notifications.DeletedCase.. '' ..data.id)
            --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.DeletedCase.. '' ..data.id, length = '5000', style = {}})
            MySQL.Async.fetchAll('SELECT * FROM drx_emsmdt_database WHERE identifier = @identifier', {
                ['@identifier'] = data.identifier
            }, function(database)
                TriggerClientEvent('drx_emsmdt:updatePersonDatabase', src, database)
            end)
        end
    end)
end)

-- User is saving title and description on a case that exists, save it and update the users ui with the updated information (May not be required, but doing it to make sure information is always updated)
RegisterServerEvent('drx_emsmdt:saveViewCase')
AddEventHandler('drx_emsmdt:saveViewCase', function(data)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute('UPDATE drx_emsmdt_database SET `title` = @title, `desc` = @desc WHERE id = @id', {
        ['@id'] = data.id,
        ['@title'] = data.title,
        ['@desc'] = data.desc
    })

    Wait(100)
    --TriggerClientEvent('mythic_notify:client:SendAlert', src, { type = 'inform', text = Config.Notifications.SavedCase.. '' ..data.id, length = '5000', style = {}})
    xPlayer.showNotification(Config.Notifications.SavedCase.. '' ..data.id)
    MySQL.Async.fetchAll('SELECT * FROM drx_emsmdt_database WHERE identifier = @identifier', {
        ['@identifier'] = data.identifier
    }, function(database)
        TriggerClientEvent('drx_emsmdt:updatePersonDatabase', src, database)
    end)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1800000) -- in MS
        MySQL.Async.fetchAll('DELETE FROM drx_emsmdt_calls', {
        }, function()
            
        end)
  
    end
  end)