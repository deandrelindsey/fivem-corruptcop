local QBCore = exports['qb-core']:GetCoreObject()
local logs = {}

RegisterNetEvent("qb-inventory:server:LogItemAction", function(stash, action, item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player then return end

    local name = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname
    local cid = Player.PlayerData.citizenid
    local time = os.date("%Y-%m-%d %H:%M:%S")
    table.insert(logs, {
        time = time,
        stash = stash,
        action = action,
        item = item,
        amount = amount,
        player = name,
        cid = cid
    })
    print(string.format("[%s] %s (CID: %s) %s %dx %s from stash: %s", time, name, cid, action, amount, item, stash))
end)

QBCore.Commands.Add("stashlogs", "View recent stash activity (admin only)", {{name="stash", help="Stash name"}}, true, function(source, args)
    local stash = args[1]
    local src = source
    local results = {}
    for _, log in ipairs(logs) do
        if log.stash == stash then
            table.insert(results, string.format("[%s] %s (%s) %s %dx %s", log.time, log.player, log.cid, log.action, log.amount, log.item))
        end
    end
    if #results == 0 then
        TriggerClientEvent('chat:addMessage', src, { args = {"Logs", "No logs found for stash: " .. stash} })
    else
        for _, msg in ipairs(results) do
            TriggerClientEvent('chat:addMessage', src, { args = {"Logs", msg} })
        end
    end
end, "admin")
