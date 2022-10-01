local presetFreq = nil
local radioProp = nil
local volumeState = nil
local uiOpened = false
local voice = exports['pma-voice']



-- Functions
local function openRadio()
	if uiOpened then return end
	uiOpened = true

	setNuiFocusAdvanced(true, true)
	SetCursorLocation(0.917, 0.873)
	SendNUIMessage({ action = 'open' })

	-- Disarms the player when using the radio. Only for ox_inventory.
	TriggerEvent('ox_inventory:disarm')

	local model = `prop_cs_hand_radio`
	requestModel(model)
	radioProp = CreateObject(model, 0.0, 0.0, 0.0, true, true, true)
	local ped = PlayerPedId()
	AttachEntityToEntity(radioProp, ped, GetPedBoneIndex(ped, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 0, true)
	SetModelAsNoLongerNeeded(model)

	local dict = getRadioDict(ped)
	requestAnimDict(dict)
	TaskPlayAnim(ped, dict, 'cellphone_text_in', 4.0, -1, -1, 50, 0, false, false, false)
	RemoveAnimDict(dict)
end

local function removeRadioProp()
	if not radioProp then return end
	DetachEntity(radioProp)
	DeleteEntity(radioProp)
	radioProp = nil
end

local function joinRadio(channel)
	if not channel then return end
	channel = round(tonumber(channel), ac.decimalStep)

	if channel <= ac.maximumFrequencies and channel > 0 then
		voice:setVoiceProperty('radioEnabled', true)
		voice:setRadioChannel(channel)
		notify('success', locale('channel_join', channel))
	else
		notify('error', locale('channel_unavailable'))
	end
end

local function leaveRadio()
	voice:removePlayerFromRadio()
	voice:setVoiceProperty('radioEnabled', false)
end




-- NUI callbacks
RegisterNUICallback('close', function()
	setNuiFocusAdvanced(false, false)

	if presetFreq then
		presetFreq = nil
	end

	local ped = PlayerPedId()
	local dict = getRadioDict(ped)
    StopAnimTask(ped, dict, 'cellphone_text_in', 1.0)
    Wait(100)
    requestAnimDict(dict)
    TaskPlayAnim(ped, dict, 'cellphone_text_out', 7.0, -1, -1, 50, 0, false, false, false)
    Wait(200)
    StopAnimTask(ped, dict, 'cellphone_text_out', 1.0)
	RemoveAnimDict(dict)

	removeRadioProp()
	uiOpened = false
end)

RegisterNUICallback('join', function(data)
	joinRadio(data?.channel)
end)

RegisterNUICallback('leave', function()
	leaveRadio()
	notify('success', locale('channel_disconnect'))
end)

RegisterNUICallback('volume_up', function()
	local volume = volumeState and volumeState * 0.01 or voice:getRadioVolume()

	if volumeState then
		volumeState = nil
		notify('inform', locale('volume_unmute'), 1000)
	end

	if volume <= 0.9 then
		local newVolume = math.floor((volume + 0.1) * 100)
		voice:setRadioVolume(newVolume)
		notify('inform', locale('volume_up', newVolume), 1500, 'volume-high')
	else
		notify('error', locale('volume_max'), 2500)
	end
end)

RegisterNUICallback('volume_down', function()
	local volume = volumeState and volumeState * 0.01 or voice:getRadioVolume()

	if volumeState then
		volumeState = nil
		notify('inform', locale('volume_unmute'), 1000)
	end

	if volume >= 0.2 then
		local newVolume = math.floor((volume - 0.1) * 100)
		voice:setRadioVolume(newVolume)
		notify('inform', locale('volume_down', newVolume), 1500, 'volume-low')
	else
		notify('error', locale('volume_min'), 2500)
	end
end)

RegisterNUICallback('volume_mute', function()
	if volumeState then
		voice:setRadioVolume(volumeState)
		volumeState = nil
		notify('success', locale('volume_unmute'), 5000, 'volume-high')
	else
		volumeState = math.floor(voice:getRadioVolume() * 100)
		voice:setRadioVolume(0)
		notify('error', locale('volume_mute'), 5000, 'volume-xmark')
	end
end)

RegisterNUICallback('preset_join', function(data, cb)
	if not data?.preset then return end
	local preset = GetResourceKvpString('ac_radio:preset_'.. data.preset)
	if preset then
		joinRadio(preset)
		cb(preset)
	else
		notify('error', locale('preset_not_found'))
	end
end)

RegisterNUICallback('preset_request', function(data)
	if data?.channel then
		notify('inform', locale('preset_choose'), 10000)
		presetFreq = data.channel
	end
end)

RegisterNUICallback('preset_set', function(data)
	if not presetFreq then return end

	if not data?.preset then
		notify('error', locale('preset_invalid'))
	else
		SetResourceKvp('ac_radio:preset_'.. data.preset, presetFreq)
		notify('success', locale('preset_set', presetFreq))
		presetFreq = nil
	end
end)



-- Commands and handlers
if ac.useCommand then
	TriggerEvent('chat:addSuggestion', '/radio', locale('command_open'))
	RegisterCommand('radio', function()
		openRadio()
	end)

	if ac.commandKey then
		RegisterKeyMapping('radio', locale('keymap_open'), 'keyboard', ac.commandKey)
	end
end

TriggerEvent('chat:addSuggestion', '/radio:clear', locale('command_clear'))
RegisterCommand('radio:clear', function()
	for i=1, 2 do DeleteResourceKvp('ac_radio:preset_'..i) end
	notify('success', locale('preset_clear'))
end)

RegisterNetEvent('ac_radio:openRadio', openRadio)
exports('openRadio', openRadio)
exports('leaveRadio', leaveRadio)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		removeRadioProp()
		leaveRadio()
		if uiOpened then
			SetNuiFocus(false, false)
			SetNuiFocusKeepInput(false)
		end
	end
end)
