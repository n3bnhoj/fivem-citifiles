# ------------------------CREDITS------------------------ #
# --------        Script made by Deltarix        -------- #
# --   Copyright 2021 Deltarix. All rights reserved    -- #
# ------------------------------------------------------- #

Requirements:
- mysql-async
- mythic_notify
- esx_vehicleshop
- esx_license
- esx-qalle-jail
- esx legacy

Installation:
- Insert drx.sql into your database.
- Drag drx_mdt into your resource folder and start it in your configuration file.

Remember:
- If you use a multi character script, then remember to add the identifiers to it.

# Permanent Discord Invite: https://discord.gg/njBM5fVWcf (For support, and to get updates)
# Youtube Channel: https://www.youtube.com/c/Deltarix


notify

	local data = {displayCode = '211', description = 'Robbery', isImportant = 0, recipientList = {'police'}, length = '60000', infoM = 'fa-info-circle', info = 'Vangelico Jewelry Store'}
		local dispatchData = {dispatchData = data, caller = 'Alarm', coords = vector3(-628.3124, -235.0861, 38.0570)}
		TriggerServerEvent('wf-alerts:svNotify', dispatchData)

		local coords = GetEntityCoords(PlayerPedId(-1))
		local location = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords[1], coords[2], coords[3]))
		local details = 'Vangelico Jewelry Store'
		TriggerServerEvent('drx_mdt:newDispatch', details, location, coords)