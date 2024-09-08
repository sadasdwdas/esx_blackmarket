Config = {}

Config.KaytaAnimaatioita = true 

Config.Kaupat = {
    PistooliKauppa = {
        label = "Pistooli tukku", 
        icon = "fas fa-gun",
        NpcSijainti = vec4(159.0797, -985.5057, 30.0919, 229.7686),
        PedModel = 'mp_m_shopkeep_01',
        Tavarat = {
            {name = 'WEAPON_PISTOL', label = 'Pistooli', hinta = 25, likanenRaha = false},
            {name = 'WEAPON_PISTOL_MK2', label = 'Musketti', hinta = 225, likanenRaha = true},
        }
    },
    RynkkyTukku = {
        label = "Rynkky tukku", 
        icon = "fa-solid fa-person-rifle",
        NpcSijainti = vec4(157.7660, -986.8801, 30.0919, 245.5465),
        PedModel = 'mp_m_shopkeep_01',
        Tavarat = {
            {name = 'WEAPON_ASSAULTRIFLE', label = 'Rynnäkkökivääri', hinta = 500, likanenRaha = false},
            {name = 'WEAPON_CARBINERIFLE', label = 'Karbiinikivääri', hinta = 750, likanenRaha = false},
        }
    }
}
