local QBCore = exports['qb-core']:GetCoreObject()

CreateThread(function()
    exports.ox_target:addBoxZone({
        coords = vec3(127.5, -1280.5, 29.3),
        size = vec3(1, 1, 2),
        rotation = 270.0,
        options = {
            {
                name = 'blackmarket_npc',
                icon = 'fas fa-mask',
                label = 'Talk to Black Market Dealer',
                onSelect = function()
                    TriggerEvent('corruptcop:client:OpenDealer')
                end,
                canInteract = function(entity, distance, coords, name, bone)
                    local PlayerData = QBCore.Functions.GetPlayerData()
                    return PlayerData.job.name == 'corruptcop'
                end
            }
        }
    })
end)

RegisterNetEvent('corruptcop:client:OpenDealer', function()
    local options = {
        {
            title = 'Buy Fentanyl Pill - $1500',
            icon = 'capsules',
            onSelect = function()
                TriggerServerEvent('corruptcop:dealer:buy', 'fentanyl_pill', 1500)
            end
        },
        {
            title = 'Buy Refined Opium - $1250',
            icon = 'vial',
            onSelect = function()
                TriggerServerEvent('corruptcop:dealer:buy', 'refined_opium', 1250)
            end
        },
        {
            title = 'Buy Body Bag - $750',
            icon = 'briefcase-medical',
            onSelect = function()
                TriggerServerEvent('corruptcop:dealer:buy', 'bodybag', 750)
            end
        },
        {
            title = 'Buy Burner Phone - $100',
            icon = 'mobile-alt',
            onSelect = function()
                TriggerServerEvent('corruptcop:dealer:buy', 'burner_phone', 100)
            end
        },
        {
            title = 'Buy Fake Badge - $2000',
            icon = 'id-badge',
            onSelect = function()
                TriggerServerEvent('corruptcop:dealer:buy', 'fake_badge', 2000)
            end
        },
        {
            title = 'Sell Cartel Loot',
            icon = 'money-bill-wave',
            onSelect = function()
                TriggerServerEvent('corruptcop:dealer:sell', 'cartel_loot')
            end
        }
    }

    lib.registerContext({ id = 'blackmarket_dealer_menu', title = 'Black Market', options = options })
    lib.showContext('blackmarket_dealer_menu')
end)
