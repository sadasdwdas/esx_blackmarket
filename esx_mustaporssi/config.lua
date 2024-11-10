Config = {}

Config.KaytaAnimaatioita = true 

Config.Kaupat = {
    PistooliKauppa = {
        label = "Pistooli tukku", 
        labeltarget = "Puhu Simolle", 
        icon = "fas fa-gun",
        NpcSijainti = vec4(159.0797, -985.5057, 30.0919, 229.7686),
        PedModel = 'mp_m_shopkeep_01',
        Tyot = {},
        Tavarat = {
            {name = 'WEAPON_PISTOL', label = 'Pistooli', hinta = 25, likanenRaha = false},
            {name = 'WEAPON_PISTOL_MK2', label = 'Musketti', hinta = 225, likanenRaha = true},
        }
    },
    RynkkyTukku = {
        label = "Rynkky tukku", 
        labeltarget = "Puhu Reimolle", 
        icon = "fa-solid fa-person-rifle",
        NpcSijainti = vec4(157.7660, -986.8801, 30.0919, 245.5465),
        PedModel = 'mp_m_shopkeep_01',
        Tyot = {},
        Tavarat = {
            {name = 'WEAPON_ASSAULTRIFLE', label = 'Rynnäkkökivääri', hinta = 500, likanenRaha = false},
            {name = 'WEAPON_CARBINERIFLE', label = 'Karbiinikivääri', hinta = 750, likanenRaha = false},
        }
    },
erakeskusKauppa = {
    label = "Eräkeskus", 
    labeltarget = "Puhu Pasille", 
    icon = "fa-sharp fa-regular fa-paw-simple",
    NpcSijainti = vec4(93.3062, -1591.2389, 31.1436, 229.6833),
    PedModel = 'cs_joeminuteman',
    Tyot = {"police", "erakeskus"},
    Tavarat = {
        {name = 'WEAPON_HUNTINGRIFLE', label = 'Metsästyskivääri', hinta = 30000, likanenRaha = false},
        {name = 'ammo-sniper', label = '7.62X51', hinta = 100, likanenRaha = false},
        {name = 'WEAPON_KNIFE', label = 'Puukko', hinta = 5000, likanenRaha = false},
    }
}
}
