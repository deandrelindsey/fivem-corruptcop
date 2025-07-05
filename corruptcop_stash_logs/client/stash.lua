local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    local locker = CreateObject(`prop_ld_int_safe_01`, 113.5, -1297.0, 28.3, false, true, true)
    SetEntityHeading(locker, 0.0)
    FreezeEntityPosition(locker, true)

    exports['qb-target']:AddBoxZone("corruptcop_vipstash", vector3(113.5, -1297.0, 29.3), 1.5, 1.5, {
        name = "corruptcop_vipstash",
        heading = 0,
        debugPoly = false,
        minZ = 28.9,
        maxZ = 30.5
    }, {
        options = {
            {
                icon = "fas fa-box",
                label = "Access VIP Locker",
                job = "corruptcop",
                action = function()
                    local PlayerData = QBCore.Functions.GetPlayerData()
                    local stashName = "corruptcop_" .. PlayerData.citizenid
                    TriggerServerEvent("inventory:server:OpenInventory", "stash", stashName, {
                        maxweight = 100000000,
                        slots = 100,
                    })
                    TriggerEvent("inventory:client:SetCurrentStash", stashName)
                end
            }
        },
        distance = 1.5
    })
end)
