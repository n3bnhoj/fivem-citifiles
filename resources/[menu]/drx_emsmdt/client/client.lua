------------------------CREDITS------------------------
--------        Script made by Deltarix        --------
--   Copyright 2021 Deltarix. All rights reserved    --
-------------------------------------------------------

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local tabletObject = nil
local callBlip = nil

-- Basic
RegisterNetEvent('OpenMDT')
AddEventHandler('OpenMDT', function(charname, status, calls)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if IsPedOnFoot(ped) or IsPedInAnyVehicle(ped, false) then
        RequestAnimDict('amb@world_human_seat_wall_tablet@female@base')
        if tabletObject == nil then
            tabletObject = CreateObject(GetHashKey('prop_cs_tablet'), GetEntityCoords(ped), 1, 1, 1)
            AttachEntityToEntity(tabletObject, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.03, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
        end
        while not HasAnimDictLoaded('amb@world_human_seat_wall_tablet@female@base') do 
            Citizen.Wait(100) 
        end
        if not IsEntityPlayingAnim(ped, 'amb@world_human_seat_wall_tablet@female@base', 'base', 3) then
            TaskPlayAnim(ped, 'amb@world_human_seat_wall_tablet@female@base', 'base', 8.0, 1.0, -1, 49, 1.0, 0, 0, 0)
        end
        Open(charname, status, calls)
    end
end)


RegisterNetEvent('OpenMDT2')
AddEventHandler('OpenMDT2', function(charname, status, calls)
    TriggerServerEvent('')
end)
RegisterNUICallback('close', function(data)
    local ped = PlayerPedId()
    DeleteEntity(tabletObject)
    ClearPedTasks(ped)
    tabletObject = nil
    SetNuiFocus(false, false)
end)

RegisterNUICallback('message', function(data)
    --exports['mythic_notify']:SendAlert(data.type, data.message)
    ESX.ShowNotification(data.typeMessage, data.message, "info", 3000)
end)

-- Basic

-- Current
RegisterNUICallback('chooseStatus', function(data)
    TriggerServerEvent('drx_emsmdt:chooseStatus', data)
end)

RegisterNUICallback('setWaypoint', function(data)
    local coords = json.decode(data.coords)
    SetNewWaypoint(coords.x, coords.y)
end)

RegisterNUICallback('responCall', function(data)
    TriggerServerEvent('drx_emsmdt:responCall', data)
end)

RegisterNUICallback('deleteCall', function(data)
    if callBlip then
        RemoveBlip(callBlip)
        callBlip = nil
    end
    DeleteWaypoint()
    TriggerServerEvent('drx_emsmdt:deleteCall', data)
end)

-- Current

-- Calls
RegisterNetEvent('drx_emsmdt:updateCallList')
AddEventHandler('drx_emsmdt:updateCallList', function(calls)
    SendNUIMessage({
        update = 'updateCalls',
        calls = calls
    })
end)

RegisterNUICallback('attachToCall', function(data)
    if not callBlip then
        local coords = json.decode(data.coords)
        callBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
        SetBlipSprite(callBlip, 304)
        SetBlipDisplay(callBlip, 2)
        SetBlipScale(callBlip, 1.2)
        SetBlipColour(callBlip, 29)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString('911 Call')
        EndTextCommandSetBlipName(callBlip)
    end
    --exports['mythic_notify']:SendAlert('inform', Config.Notifications.AttachedCall)
    ESX.ShowNotification(Config.Notifications.AttachedCall, "info", 3000)
end)

RegisterNUICallback('detachFromCall', function(data)
    if callBlip then
        RemoveBlip(callBlip)
        callBlip = nil
    end
    DeleteWaypoint()
  --  exports['mythic_notify']:SendAlert('inform', Config.Notifications.DetachCall)
    ESX.ShowNotification(Config.Notifications.DetachCall, "info", 3000)
end)

-- Calls

-- Database
RegisterNUICallback('searchDatabase', function(data)
    TriggerServerEvent('drx_emsmdt:searchDatabase', data)
end)

RegisterNetEvent('drx_emsmdt:returnDatabaseSearch')
AddEventHandler('drx_emsmdt:returnDatabaseSearch', function(results)
    SendNUIMessage({
        update = 'returnDatabaseSearch',
        searchResults = results
    })
end)

RegisterNUICallback('fetchPersonDatabase', function(data)
    TriggerServerEvent('drx_emsmdt:fetchPersonDatabase', data)
end)

RegisterNetEvent('drx_emsmdt:returnPersonDatabase')
AddEventHandler('drx_emsmdt:returnPersonDatabase', function(database, firstname, lastname, phonenumber)
    SendNUIMessage({
        update = 'returnPersonDatabase',
        database = database,
        firstname = firstname,
        lastname = lastname,
        phonenumber = phonenumber
    })
end)

RegisterNUICallback('submitNewCase', function(data)
    TriggerServerEvent('drx_emsmdt:submitNewCase', data)
end)

RegisterNetEvent('drx_emsmdt:updatePersonDatabase')
AddEventHandler('drx_emsmdt:updatePersonDatabase', function(database)
    SendNUIMessage({
        update = 'updatePersonDatabase',
        database = database
    })
end)

RegisterNUICallback('deletePersonCase', function(data)
    TriggerServerEvent('drx_emsmdt:deletePersonCase', data)
end)

RegisterNUICallback('saveViewCase', function(data)
    TriggerServerEvent('drx_emsmdt:saveViewCase', data)
end)

-- Database
