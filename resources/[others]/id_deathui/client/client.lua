ESX = nil
local IsDead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function SetDisplay(bool)
    SendNUIMessage({
        type = "show",
        status = bool,
        time = GlobalState.Timer,
    })

    SendNUIMessage({action = 'starttimer', value = GlobalState.Timer})

    SendNUIMessage({action = 'showbutton'})

	SetNuiFocus(bool, bool)
end

AddEventHandler('esx:onPlayerDeath', function(data)
    SetDisplay(true, true)
    IsDead = true

    -- Respawn Player after timer is done
    Citizen.Wait(GlobalState.Timer * 60 * 1000)

    if IsDead then
        respawn()
    end
end)

AddEventHandler('playerSpawned', function(spawn)
    SetDisplay(false, false)
    IsDead = false
end)

RegisterNUICallback("button", function(data)
    SendNUIMessage({action = 'hidebutton'})

    -- You should place TriggerEvent here for sending message to all ambulance employees :)
    ExecuteCommand('911EMS I need Help Urgently')
    SetNuiFocus(false, false)
end)

function respawn()
  

	CreateThread(function()
		ESX.TriggerServerCallback('esx_ambulancejob:removeItemsAfterRPDeath', function()
          
            SetDisplay(false, false)
            SetEntityCoordsNoOffset(PlayerPedId(), GlobalState.RespawnCoords, false, false, false, true)
            NetworkResurrectLocalPlayer(GlobalState.RespawnCoords, GlobalState.RespawnHeading, true, false)
            SetPlayerInvincible(PlayerPedId(), false)
            ClearPedBloodDamage(PlayerPedId())
            TriggerServerEvent('esx_ambulancejob:setDeathStatus', false)
            TriggerServerEvent('esx:onPlayerSpawn')
            TriggerEvent('esx:onPlayerSpawn')
            TriggerEvent('playerSpawned') -- compatibility with old scripts, will be removed soon

            
	        AnimpostfxStop('DeathFailOut')
	        DoScreenFadeIn(800)
		end)
	end)
end
