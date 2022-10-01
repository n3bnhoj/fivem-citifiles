------------------------CREDITS------------------------
--------        Script made by Deltarix        --------
--   Copyright 2021 Deltarix. All rights reserved    --
-------------------------------------------------------

function Open(charProfiles, playerInfo, drxWarrants, drxDispatches, drxProfiles)
    SetNuiFocus(true, true)
    SendNUIMessage({
        -- users
        identifier = playerInfo[1].identifier,
        vrpcharname = playerInfo[1].firstname.. ' ' ..playerInfo[1].lastname,
        phonenumber = playerInfo[1].phonenumber,
        dateofbirth = playerInfo[1].dateofbirth,
        -- drx_mdt_dispatch
        drxDispatches = drxDispatches,
        -- drx_mdt_warrants
        drxWarrants = drxWarrants,
        -- drx_mdt_profiles
        drxProfiles = drxProfiles,
        identifier = charProfiles[1].identifier,
        charname = charProfiles[1].charname,
        policegroup = charProfiles[1].policegroup,
        rank = charProfiles[1].rank,
        badgenumber = charProfiles[1].badgenumber,
        duty = charProfiles[1].duty,
        image = charProfiles[1].image,
        open = true,
    })
end

function Close()
    SetNuiFocus(false, false)
    SendNUIMessage({
        close = true
    })
end