local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('corruptcop:client:OpenMenu', function()
    lib.registerContext({
        id = 'corruptcop_menu',
        title = 'Corrupt Cop Options',
        options = {
            {
                title = 'Toggle Police Alerts',
                description = 'Temporarily disable dispatch alerts',
                icon = 'bell-slash',
                onSelect = function()
                    TriggerServerEvent('corruptcop:toggleAlerts')
                end
            },
            {
                title = 'Bribe System',
                description = 'Pay to clear your name',
                icon = 'money-bill',
                onSelect = function()
                    TriggerServerEvent('corruptcop:bribe')
                end
            },
            {
                title = 'Clock In/Out',
                description = 'Toggle on/off duty',
                icon = 'user-shield',
                onSelect = function()
                    TriggerServerEvent('QBCore:ToggleDuty')
                end
            }
        }
    })
    lib.showContext('corruptcop_menu')
end)

CreateThread(function()
    exports.ox_target:addBoxZone({
        coords = Config.CorruptCop.npc.coords,
        size = vec3(1, 1, 2),
        rotation = Config.CorruptCop.npc.heading,
        options = {
            {
                name = 'corruptcop_npc',
                icon = 'fas fa-user-secret',
                label = 'Speak with Dirty Contact',
                onSelect = function()
                    TriggerEvent('corruptcop:client:OpenMenu')
                end,
                canInteract = function(entity, distance, coords, name, bone)
                    local PlayerData = QBCore.Functions.GetPlayerData()
                    return PlayerData.job.name == 'corruptcop'
                end
            }
        }
    })
end)
