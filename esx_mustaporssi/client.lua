ESX = exports['es_extended']:getSharedObject()

local function luoNPC(sijainti, pedModel)
    local npcHash = GetHashKey(pedModel)
    RequestModel(npcHash)
    while not HasModelLoaded(npcHash) do
        Wait(1)
    end

    local npc = CreatePed(4, npcHash, sijainti.x, sijainti.y, sijainti.z - 1, sijainti.w, false, true)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    FreezeEntityPosition(npc, true)

    return npc
end

local function npcHeiluttaa(npc)
    if Config.KaytaAnimaatioita then 
        RequestAnimDict("gestures@m@standing@casual")
        while not HasAnimDictLoaded("gestures@m@standing@casual") do
            Wait(10)
        end
        TaskPlayAnim(npc, "gestures@m@standing@casual", "gesture_hello", 8.0, -8.0, 2000, 0, 0, false, false, false)
        Wait(1000)
        ClearPedTasksImmediately(npc)
    end
end

local function pelaajaJaNpcAnimaatio(pelaaja, npc)
    if Config.KaytaAnimaatioita then 
        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do
            Wait(10)
        end
        TaskPlayAnim(pelaaja, "mp_common", "givetake1_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(1000)

        RequestAnimDict("mp_common")
        while not HasAnimDictLoaded("mp_common") do
            Wait(10)
        end
        TaskPlayAnim(npc, "mp_common", "givetake2_a", 8.0, -8.0, -1, 0, 0, false, false, false)
        Wait(3000)
        ClearPedTasksImmediately(npc)
    end
end

local function setupKauppa(kauppaConfig)
    local npc = luoNPC(kauppaConfig.NpcSijainti, kauppaConfig.PedModel)

    exports.ox_target:addLocalEntity(npc, {
        {
            name = kauppaConfig.label,
            icon = kauppaConfig.icon, 
            label = kauppaConfig.label, 
            onSelect = function(data)
                local valinnat = {}
                npcHeiluttaa(npc)
                for _, tavara in ipairs(kauppaConfig.Tavarat) do
                    local kuvaPolku = 'nui://ox_inventory/web/images/' .. tavara.name .. '.png'

                    local iconColor = tavara.likanenRaha and '#FF0000' or '#00FF00'

                    table.insert(valinnat, {
                        title = tavara.label .. " - $" .. tavara.hinta,
                        description = "Osta " .. tavara.label .. " hintaan $" .. tavara.hinta,
                        event = 'esx_mustaporssi:osta',
                        args = {item = tavara, kauppaLabel = kauppaConfig.label, npc = npc},
                        image = kuvaPolku,
                        icon = 'fas fa-money-bill-wave', --jos haluut niin tästä voi vaihtaa sen iconin mikä siinä contextissa on
                        iconColor = iconColor 
                    })
                end

                lib.registerContext({
                    id = kauppaConfig.label .. '_menu',
                    title = kauppaConfig.label,
                    options = valinnat
                })

                lib.showContext(kauppaConfig.label .. '_menu')
            end
        }
    })
end

RegisterNetEvent('esx_mustaporssi:osta')
AddEventHandler('esx_mustaporssi:osta', function(data)
    local tavara = data.item
    local kauppaLabel = data.kauppaLabel
    local npc = data.npc
    local pelaajaPed = PlayerPedId()

    local pelaajanRahat = 0

    if tavara.likanenRaha then
        pelaajanRahat = exports.ox_inventory:Search('count', 'black_money') or 0
    else
        pelaajanRahat = exports.ox_inventory:Search('count', 'money') or 0
    end

    if pelaajanRahat >= tavara.hinta then
        local dialog = lib.alertDialog({
            header = 'Varmistus',
            content = 'Haluatko varmasti ostaa ' .. tavara.label .. ' hintaan $' .. tavara.hinta .. '?',
            centered = true,
            cancel = true
        })

        if dialog == 'confirm' then
            TriggerServerEvent('esx_mustaporssi:poistaRahat', tavara.hinta, tavara.likanenRaha)
            pelaajaJaNpcAnimaatio(pelaajaPed, npc)
            TriggerServerEvent('esx_mustaporssi:suoritaOsto', tavara.name, tavara.hinta, tavara.label, kauppaLabel)
        end
    else
ESX.ShowNotification('Virhe: ~s~Sinulla ei ole tarpeeksi rahaa!')
    end
end)

CreateThread(function()
    for _, kauppaConfig in pairs(Config.Kaupat) do
        setupKauppa(kauppaConfig)
    end
end)
