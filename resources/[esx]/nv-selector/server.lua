ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('nv:selector:show', function()

    local src = source

    xPlayer = ESX.GetPlayerFromId(src)

    Data = {}

    Data.position = json.decode(GetChar(src).position)

    Data.jail = false

    Data.job = xPlayer.job.name

    TriggerClientEvent('nv:selector:show', src, Data)

end)

GetChar = function(src)

    xPlayer = ESX.GetPlayerFromId(src)

    local result = MySQL.Sync.fetchAll('SELECT * FROM `users` WHERE `identifier` = \'' .. xPlayer.identifier .. '\'', {})

    if result[1] then

        return result[1]

    else

        return nil

    end

end