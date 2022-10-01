------------------------CREDITS------------------------
--------        Script made by Deltarix        --------
--   Copyright 2021 Deltarix. All rights reserved    --
-------------------------------------------------------
RegisterNetEvent('drx_mdt:openMDT')
AddEventHandler('drx_mdt:openMDT', function(charProfiles, playerInfo, drxWarrants, drxDispatches, drxProfiles)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsIn(ped, false)
    if IsPedOnFoot(ped) or IsPedInAnyPoliceVehicle(ped) and not IsPedInFlyingVehicle(ped) then
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
        Open(charProfiles, playerInfo, drxWarrants, drxDispatches, drxProfiles)
    end
end)

if Config.DispatchCMDEnable == true then
    RegisterCommand(Config.DispatchCommand, function(source, args)
        local src = source
        local coords = GetEntityCoords(PlayerPedId(-1))
        local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords[1], coords[2], coords[3]))
        local details = ''
        for i=1, #args, 1 do
            if i > 0 then details = details .. ' '
                details = details .. args[i]
            end
        end
        TriggerServerEvent('drx_mdt:newDispatch2', details, location, coords)

        local data = {displayCode = '911', description = 'Emergency', isImportant = 0, recipientList = {'police'}, length = '5000', infoM = 'fa-info-circle', info = '911 Alert'}
		local dispatchData = {dispatchData = data, caller = 'Alarm', coords = coords}
		TriggerServerEvent('wf-alerts:svNotify', dispatchData)

    end)
end

RegisterNUICallback('close', function(data)
    local ped = PlayerPedId()
    DeleteEntity(tabletObject)
    ClearPedTasks(ped)
    tabletObject = nil
    SetNuiFocus(false, false)
end)

RegisterNUICallback('messageClient', function(data)
    --exports['mythic_notify']:SendAlert(data.typeMessage, data.message)
    
    ESX.ShowNotification(data.typeMessage, data.message, "info", 3000)
end)

-- Criminal records page
RegisterNUICallback('searchPerson', function(data)
    TriggerServerEvent('drx_mdt:searchPerson', data.searchInput)
end)

RegisterNUICallback('fetchSelectPerson', function(data)
    TriggerServerEvent('drx_mdt:fetchSelectPerson', data)
end)

RegisterNUICallback('uploadPersonImage', function(data)
    -- print(data.identifier, data.image)
    TriggerServerEvent('drx_mdt:uploadPersonImage', data.identifier, data.image)
end)

RegisterNUICallback('saveNotes', function(data)
    TriggerServerEvent('drx_mdt:saveNotes', data.identifier, data.note)
end)

RegisterNUICallback('fetchLicenses', function(data)
    TriggerServerEvent('drx_mdt:fetchLicenses', data)
end)

RegisterNUICallback('removeLicenses', function(data)
    TriggerServerEvent('drx_mdt:removeLicenses', data)
end)

RegisterNUICallback('markPersonWanted', function(data)
    TriggerServerEvent('drx_mdt:markPersonWanted', data)
end)

RegisterNUICallback('fetchCharges', function(data)
    TriggerServerEvent('drx_mdt:fetchCharges', data.identifier)
end)

RegisterNUICallback('newCharge', function(data)
    TriggerServerEvent('drx_mdt:newCharge', data)
end)

RegisterNUICallback('sentenceTarget', function(data)
    TriggerServerEvent('drx_mdt:sentenceTarget', data)
end)

RegisterNUICallback('deleteCharge', function(data)
    TriggerServerEvent('drx_mdt:deleteCharge', data)
end)

RegisterNUICallback('editCharge', function(data)
    TriggerServerEvent('drx_mdt:editCharge', data)
end)

RegisterNetEvent('drx_mdt:returnSelectPerson')
AddEventHandler('drx_mdt:returnSelectPerson', function(charname, dateofbirth, phone_number, sex, note, image, wanted)
    SendNUIMessage({
        type = 'returnSelectPerson',
        charname = charname,
        dateofbirth = dateofbirth,
        phone_number = phone_number,
        sex = sex,
        note = note,
        image = image,
        wanted = wanted
    })
end)

RegisterNetEvent('drx_mdt:returnWantedStatus')
AddEventHandler('drx_mdt:returnWantedStatus', function(wanted)
    SendNUIMessage({
        type = 'returnWantedStatus',
        wanted = wanted
    })
end)

RegisterNetEvent('drx_mdt:returnSearchPerson')
AddEventHandler('drx_mdt:returnSearchPerson', function(results)
    SendNUIMessage({
        type = 'returnSearchPerson',
        searchResults = results
    })
end)

RegisterNetEvent('drx_mdt:returnLicenses')
AddEventHandler('drx_mdt:returnLicenses', function(result)
    SendNUIMessage({
        type = 'returnLicenses',
        UserLicenses = result
    })
end)

RegisterNetEvent('drx_mdt:returnCharges')
AddEventHandler('drx_mdt:returnCharges', function(ChargeResult)
    SendNUIMessage({
        type = 'returnCharges',
        selectedCharge = ChargeResult
    })
end)

-- Search vehicle
RegisterNUICallback('searchVehicle', function(data)
    TriggerServerEvent('drx_mdt:searchVehicle', data.searchVehicle)
end)

RegisterNUICallback('fetchSelectVehicle', function(data)
    TriggerServerEvent('drx_mdt:fetchSelectVehicle', data)
end)

RegisterNUICallback('changeVehicleImage', function(data, cb)
    TriggerServerEvent('drx_mdt:changeVehicleImage', data)
end)

RegisterNUICallback('markVehicleStolen', function(data)
    TriggerServerEvent('drx_mdt:markVehicleStolen', data)
end)

RegisterNUICallback('newWarrant', function(data)
    TriggerServerEvent('drx_mdt:newWarrant', data)
end)

RegisterNUICallback('removeWarrant', function(data, cb)
    TriggerServerEvent('drx_mdt:removeWarrant', data)
end)

RegisterNetEvent('drx_mdt:returnSearchVehicle')
AddEventHandler('drx_mdt:returnSearchVehicle', function(VehicleResults)
    SendNUIMessage({
        type = 'returnSearchVehicle',
        VehicleResults = VehicleResults
    })
end)

RegisterNetEvent('drx_mdt:returnSelectVehicle')
AddEventHandler('drx_mdt:returnSelectVehicle', function(charname, modelHash, plate, type, color, stolen, image)
    local model = GetDisplayNameFromVehicleModel(modelHash)
    SendNUIMessage({
        update = 'returnSelectVehicle',
        charname = charname,
        model = model,
        plate = plate,
        type = type,
        color = color,
        stolen = stolen,
        image = image
    })
end)

RegisterNetEvent('drx_mdt:returnStolenStatus')
AddEventHandler('drx_mdt:returnStolenStatus', function(stolen)
    SendNUIMessage({
        type = 'returnStolenStatus',
        stolen = stolen
    })
end)

RegisterNetEvent('drx_mdt:updateWarrants')
AddEventHandler('drx_mdt:updateWarrants', function(data)
    SendNUIMessage({
        type = 'updateWarrants'
    })
end)

-- Dispatch page
RegisterNUICallback('locationDispatch', function(data)
    local coords = json.decode(data.coords)
    SetNewWaypoint(coords['x'], coords['y'])
end)

RegisterNUICallback('respondDispatch', function(data)
    TriggerServerEvent('drx_mdt:respondDispatch', data)
end)

RegisterNUICallback('deleteDispatch', function(data)
    TriggerServerEvent('drx_mdt:deleteDispatch', data)
end)

RegisterNetEvent('drx_mdt:updateDispatches')
AddEventHandler('drx_mdt:updateDispatches', function(drxDispatches)
    ESX.TriggerServerCallback('drx_mdt:fetchDispatch', function(drxDispatches)
        SendNUIMessage({
            type = 'updateDispatches',
            drxDispatches = drxDispatches
        })
    end)
end)

-- Warrants page
RegisterNUICallback('deleteWarrant', function(data)
    TriggerServerEvent('drx_mdt:deleteWarrant', data)
end)

RegisterNetEvent('drx_mdt:updateAllWarrants')
AddEventHandler('drx_mdt:updateAllWarrants', function(drxWarrants)
    ESX.TriggerServerCallback('drx_mdt:fetchWarrants', function(drxWarrants)
        SendNUIMessage({
            type = 'updateAllWarrants',
            drxWarrants = drxWarrants
        })
    end)
end)

-- Profile page
RegisterNUICallback('dutyStatus', function(data)
    TriggerServerEvent('drx_mdt:changeDuty', data.duty)
    print(data.duty)
end)

RegisterNUICallback('changeImage', function(data)
    TriggerServerEvent('drx_mdt:changeImage', data.image)
end)

RegisterNUICallback('changeComitData', function(data)
    TriggerServerEvent('drx_mdt:changeComitData', data.identifierData, data.rankData, data.policegroupData, data.badgenumberData, data.imageData)
end)

RegisterNUICallback('deleteData', function(data)
    TriggerServerEvent('drx_mdt:deleteData', data.identifierData)
end)

RegisterNetEvent('drx_mdt:updateDuty')
AddEventHandler('drx_mdt:updateDuty', function(duty)
    SendNUIMessage({
        type = 'updateDuty',
        duty = duty
    })
end)

RegisterNetEvent('drx_mdt:updateDutyAll')
AddEventHandler('drx_mdt:updateDutyAll', function(drxProfiles)
    ESX.TriggerServerCallback('drx_mdt:profiles', function(drxProfiles)
        SendNUIMessage({
            type = 'updateDutyAll',
            drxProfiles = drxProfiles
        })
    end)
end)