ESX = exports['es_extended']:getSharedObject()

local discordWebhookURL = "" --tähän teijän oma webhookki

RegisterNetEvent('esx_mustaporssi:suoritaOsto')
AddEventHandler('esx_mustaporssi:suoritaOsto', function(itemNimi, itemHinta, itemLabel, kauppaNimi)
    local xPlayer = ESX.GetPlayerFromId(source)
    local pelaajanRahat = xPlayer.getMoney()

    if pelaajanRahat >= itemHinta then
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
    else
        TriggerClientEvent('esx:showNotification', source, 'Sinulla ei ole tarpeeksi rahaa!')
    end
end)

RegisterNetEvent('esx_mustaporssi:poistaRahat')
AddEventHandler('esx_mustaporssi:poistaRahat', function(hinta, likanenRaha)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    if likanenRaha then
        local blackMoneyRemoved = exports.ox_inventory:RemoveItem(xPlayer.source, 'black_money', hinta)
        if not blackMoneyRemoved then
            TriggerClientEvent('esx:showNotification', source, 'Virhe: Likaisen rahan poisto epäonnistui.')
        end
    else
        local cleanMoneyRemoved = exports.ox_inventory:RemoveItem(xPlayer.source, 'money', hinta)
        if not cleanMoneyRemoved then
            TriggerClientEvent('esx:showNotification', source, 'Virhe: Tavallisen rahan poisto epäonnistui.')
        end
    end
end)

