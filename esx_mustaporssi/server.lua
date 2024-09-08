ESX = exports['es_extended']:getSharedObject()

local discordWebhookURL = "" --tähän teijän oma webhookki

RegisterNetEvent('esx_mustaporssi:suoritaOsto')
AddEventHandler('esx_mustaporssi:suoritaOsto', function(itemNimi, itemHinta, itemLabel, kauppaNimi)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    local addedItem = exports.ox_inventory:AddItem(xPlayer.source, itemNimi, 1)
    
    if addedItem then
        TriggerClientEvent('esx:showNotification', source, 'Ostit ' .. itemLabel .. ' hintaan $' .. itemHinta)

        local webhookData = {
            {
                ["color"] = 3447003,
                ["title"] = "Blackmarket",
                ["description"] = "**Steam Nimi:** " .. GetPlayerName(source) ..
                                  "\n**License:** " .. xPlayer.identifier ..
                                  "\n**Kauppa:** " .. kauppaNimi ..
                                  "\n**Item:** " .. itemLabel .. " (" .. itemNimi .. ")" .. 
                                  "\n**Hinta:** $" .. itemHinta,
                ["footer"] = {
                    ["text"] = os.date("%Y-%m-%d %H:%M:%S")
                }
            }
        }

        PerformHttpRequest(discordWebhookURL, function(err, text, headers) end, 'POST', json.encode({username = "Asekauppa Logit", embeds = webhookData}), { ['Content-Type'] = 'application/json' })
    else
        xPlayer.addMoney(itemHinta)
        TriggerClientEvent('esx:showNotification', source, 'Tapahtui virhe tavaran lisäämisessä, rahat annettiin takaisin.')
    end
end)

RegisterNetEvent('esx_mustaporssi:poistaRahat')
AddEventHandler('esx_mustaporssi:poistaRahat', function(hinta, likanenRaha)
    local xPlayer = ESX.GetPlayerFromId(source)

    if likanenRaha then
        local blackMoney = exports.ox_inventory:Search(xPlayer.source, 'count', 'black_money') or 0
        if blackMoney >= hinta then
            exports.ox_inventory:RemoveItem(xPlayer.source, 'black_money', hinta)
            TriggerClientEvent('esx:showNotification', source, 'Sinulta veloitettiin $' .. hinta .. ' likaista rahaa.')
        else
            TriggerClientEvent('esx:showNotification', source, 'Sinulla ei ole tarpeeksi likaista rahaa!')
        end
    else
        local cleanMoney = exports.ox_inventory:Search(xPlayer.source, 'count', 'money') or 0
        if cleanMoney >= hinta then
            exports.ox_inventory:RemoveItem(xPlayer.source, 'money', hinta)
            TriggerClientEvent('esx:showNotification', source, 'Sinulta veloitettiin $' .. hinta .. ' käteistä.')
        else
            TriggerClientEvent('esx:showNotification', source, 'Sinulla ei ole tarpeeksi rahaa!')
        end
    end
end)


