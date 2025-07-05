local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('corruptcop:dealer:buy', function(item, cost)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney("cash", cost, "corruptcop-blackmarket") then
        Player.Functions.AddItem(item, 1)
        TriggerClientEvent('QBCore:Notify', src, "Item purchased: " .. item, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "Not enough cash.", "error")
    end
end)

RegisterServerEvent('corruptcop:dealer:sell', function(item)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local ItemData = Player.Functions.GetItemByName(item)

    if ItemData and ItemData.amount > 0 then
        local payout = math.random(2500, 4000)
        Player.Functions.RemoveItem(item, 1)
        Player.Functions.AddMoney("cash", payout, "sell-cartel-loot")
        TriggerClientEvent('QBCore:Notify', src, "Sold cartel loot for $" .. payout, "success")
    else
        TriggerClientEvent('QBCore:Notify', src, "You don't have any cartel loot.", "error")
    end
end)
