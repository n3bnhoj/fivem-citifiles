function CarMenu()
  	if not isOpened then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		local health = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)
		local model = string.lower(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
		local plate = GetVehicleNumberPlateText(vehicle)

		SetNuiFocus(true, true)
		SendNUIMessage({
		  action = "open",
		  engine = health,
		  fuel = fuel,
		  carname = UppercaseFirst(model),
		  plate = plate
		})
		isOpened = true
	else
	    SetNuiFocus(false, false)
	    SendNUIMessage({
	      action = "close"
	    })
	    isOpened = false
  	end
end

RegisterCommand('carmenu', function()
	if IsPedSittingInAnyVehicle(PlayerPedId()) then
		CarMenu()
	end
end)

RegisterKeyMapping('carmenu', '(Assets) Vehicle Control', 'keyboard', 'RBRACKET')

-----------------------------------------------------------------------------
-- Callbacks (NUI)
-----------------------------------------------------------------------------
RegisterNUICallback("exit" , function()
  	SetNuiFocus(false, false)
  	isOpened = false
end)

RegisterNUICallback('ignition', function()
	EngineControl()
end)
  
RegisterNUICallback('windows', function(data, cb)
	WindowControl(data.window, data.door)
end)

RegisterNUICallback('doors', function(data, cb)
	DoorControl(data.door)
end)

RegisterNUICallback('seatchange', function(data, cb)
	SeatControl(data.seat)
end)

RegisterNUICallback('givecarkeys', function(data, cb)
	print('yoo')
end)

RegisterNUICallback('interiorlight', function()
	InteriorLightControl()
end)

function InteriorLightControl()
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		if IsVehicleInteriorLightOn(vehicle) then
			SetVehicleInteriorlight(vehicle, false)
		else
			SetVehicleInteriorlight(vehicle, true)
		end
	end
end

RegisterNUICallback("vehdoorlock" , function()
	local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
	local plate = GetVehicleNumberPlateText(vehicle)

	if GetVehicleDoorLockStatus(vehicle) == 1 then --*Kilitleme  
		SetVehicleDoorsLocked(vehicle, 2)
		PlayVehicleDoorCloseSound(vehicle, 1)
		SetVehicleDoorShut(vehicle, 0, false)
		SetVehicleDoorShut(vehicle, 1, false)
		SetVehicleDoorShut(vehicle, 2, false)
		SetVehicleDoorShut(vehicle, 3, false)
		SetVehicleLights(vehicle, 2)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 0)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 2)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 0)
	elseif GetVehicleDoorLockStatus(vehicle) == 2 then --*Acma
		SetVehicleDoorsLocked(vehicle, 1)
		PlayVehicleDoorOpenSound(vehicle, 0)
		SetVehicleLights(vehicle, 2)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 0)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 2)
		Citizen.Wait(150)
		SetVehicleLights(vehicle, 0)
	end
end)

-----------------------------------------------------------------------------
-- Functions
-----------------------------------------------------------------------------
function DoorControl(door)
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
			SetVehicleDoorShut(vehicle, door, false)
		else
			SetVehicleDoorOpen(vehicle, door, false)
		end
	end
end

function SeatControl(seat)
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		if IsVehicleSeatFree(vehicle, seat) then
			SetPedIntoVehicle(PlayerPedId(), vehicle, seat)
		end
	end
end

function EngineControl()
  local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
 

  if vehicle ~= nil and vehicle ~= 0 and GetPedInVehicleSeat(vehicle, 0) then
      SetVehicleEngineOn(vehicle, (not GetIsVehicleEngineRunning(vehicle)), false, true)
  end
end

function WindowControl(window, door)
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		if window == 0 then
			if windowState1 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState1 = false
			else
				RollUpWindow(vehicle, window)
				windowState1 = true
			end
		elseif window == 1 then
			if windowState2 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState2 = false
			else
				RollUpWindow(vehicle, window)
				windowState2 = true
			end
		elseif window == 2 then
			if windowState3 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState3 = false
			else
				RollUpWindow(vehicle, window)
				windowState3 = true
			end
		elseif window == 3 then
			if windowState4 == true and DoesVehicleHaveDoor(vehicle, door) then
				RollDownWindow(vehicle, window)
				windowState4 = false
			else
				RollUpWindow(vehicle, window)
				windowState4 = true
			end
		end
	end
end

function FrontWindowControl()
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		if windowState1 == true or windowState2 == true then
			RollDownWindow(vehicle, 0)
			RollDownWindow(vehicle, 1)
			windowState1 = false
			windowState2 = false
		else
			RollUpWindow(vehicle, 0)
			RollUpWindow(vehicle, 1)
			windowState1 = true
			windowState2 = true
		end
	end
end

function BackWindowControl()
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		if windowState3 == true or windowState4 == true then
			RollDownWindow(vehicle, 2)
			RollDownWindow(vehicle, 3)
			windowState3 = false
			windowState4 = false
		else
			RollUpWindow(vehicle, 2)
			RollUpWindow(vehicle, 3)
			windowState3 = true
			windowState4 = true
		end
	end
end

function AllWindowControl()
	local playerPed = PlayerPedId()
	if (IsPedSittingInAnyVehicle(playerPed)) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), true)
		if windowState1 == true or windowState2 == true or windowState3 == true or windowState4 == true then
			RollDownWindow(vehicle, 0)
			RollDownWindow(vehicle, 1)
			RollDownWindow(vehicle, 2)
			RollDownWindow(vehicle, 3)
			windowState1 = false
			windowState2 = false
			windowState3 = false
			windowState4 = false
		else
			RollUpWindow(vehicle, 0)
			RollUpWindow(vehicle, 1)
			RollUpWindow(vehicle, 2)
			RollUpWindow(vehicle, 3)
			windowState1 = true
			windowState2 = true
			windowState3 = true
			windowState4 = true
		end
	end
end

function UppercaseFirst(str)
    return (str:gsub("^%l", string.upper))
end

-----------------------------------------------------------------------------
-- Commands
-----------------------------------------------------------------------------
if Config.Commands then
	-- Chat Suggestions
	TriggerEvent('chat:addSuggestion', '/engine', 'Toggle the vehicle engine state.')
	TriggerEvent('chat:addSuggestion', '/door', 'Toggle a vehicle door state.', {
		{ name = "doorId", help = "1 - Driver | 2 - Passenger | 3 - Rear Driver | 4 - Rear Passenger" }
	})
	TriggerEvent('chat:addSuggestion', '/seat', 'Swap between seats in the vehicle.', {
		{ name = "seatId", help = "1 - Driver | 2 - Passenger | 3 - Rear Driver | 4 - Rear Passenger"  }
	})
	TriggerEvent('chat:addSuggestion', '/rollwindow', 'Toggle a window state.', {
		{ name = "windowId", help ="1 - Driver | 2 - Passenger | 3 - Rear Driver | 4 - Rear Passenger" }
	})
	TriggerEvent('chat:addSuggestion', '/hood', 'Toggle the state of the vehicle hood.')
	TriggerEvent('chat:addSuggestion', '/trunk', 'Toggle the state of the vehicle trunk.')
	TriggerEvent('chat:addSuggestion', '/windowfront', 'Roll up or down the front windows (driver and passenger)')
	TriggerEvent('chat:addSuggestion', '/windowback', 'Roll up or down the rear windows (driver and passenger)')
	TriggerEvent('chat:addSuggestion', '/windowall', 'Roll up or down all vehicle windows.')


	-- Commands
	RegisterCommand("engine", function(source, args, rawCommand)
		EngineControl()
	end, false)

	RegisterCommand("door", function(source, args, rawCommand)
		local doorID = tonumber(args[1])
		if doorID ~= nil then
			if doorID == 1 then
				DoorControl(0)
			elseif doorID == 2 then
				DoorControl(1)
			elseif doorID == 3 then
				DoorControl(2)
			elseif doorID == 4 then
				DoorControl(3)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/door [doorId]")
		end
	end, false)

	RegisterCommand("seat", function(source, args, rawCommand)
		local seatID = tonumber(args[1])
		if seatID ~= nil then
			if seatID == 1 then
				SeatControl(-1)
			elseif seatID == 2 then
				SeatControl(0)
			elseif seatID == 3 then
				SeatControl(1)
			elseif seatID == 4 then
				SeatControl(2)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/seat [seat id]")
		end
	end, false)

	RegisterCommand("window", function(source, args, rawCommand)
		local windowID = tonumber(args[1])
		
		if windowID ~= nil then
			if windowID == 1 then
				WindowControl(0, 0)
			elseif windowID == 2 then
				WindowControl(1, 1)
			elseif windowID == 3 then
				WindowControl(2, 2)
			elseif windowID == 4 then
				WindowControl(3, 3)
			end
		else
			TriggerEvent("chatMessage", "Usage: ", {255, 0, 0}, "/rollwindow [windowId]")
		end
	end, false)

	RegisterCommand("hood", function(source, args, rawCommand)
		DoorControl(4)
	end, false)

	RegisterCommand("trunk", function(source, args, rawCommand)
		DoorControl(5)
	end, false)

	RegisterCommand("windowfront", function(source, args, rawCommand)
		FrontWindowControl()
	end, false)

	RegisterCommand("windowback", function(source, args, rawCommand)
		BackWindowControl()
	end, false)

	RegisterCommand("windowall", function(source, args, rawCommand)
		AllWindowControl()
	end, false)
end
