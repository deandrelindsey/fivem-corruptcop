local QBCore = exports['qb-core']:GetCoreObject()
local alertDisabled = {}

RegisterServerEvent('corruptcop:toggleAlerts', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    alertDisabled[src] = true
    TriggerClientEvent('QBCore:Notify', src, 'Police alerts disabled for 30 minutes.', 'success')

    SetTimeout(1800000, function()
        alertDisabled[src] = nil
        TriggerClientEvent('QBCore:Notify', src, 'Police alerts re-enabled.', 'error')
    end)
end)

RegisterServerEvent('corruptcop:bribe', function()
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    if not player then return end

    local cash = player.Functions.GetMoney('cash')
    if cash >= Config.CorruptCop.bribeCost then
        player.Functions.RemoveMoney('cash', Config.CorruptCop.bribeCost, "bribe-police")
        TriggerClientEvent('QBCore:Notify', src, 'Bribe successful. Your record is clean... for now.', 'success')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough cash to bribe.', 'error')
    end
end)
