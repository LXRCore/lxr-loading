--[[ ═══════════════════════════════════════════════════════════════════════════
     LXR-LOADING — Client: feed the page, decide when it goes
     ═══════════════════════════════════════════════════════════════════════════
     The page is up from the first frame (fxmanifest `loadscreen`). This script
     starts while it shows, sends the brand and the locale, and shuts it down
     once the game is ready (`session`) or when told to (`event`).
     ═══════════════════════════════════════════════════════════════════════════
     © 2026 iBoss21 / LXRCore — All Rights Reserved
     ═══════════════════════════════════════════════════════════════════════════ ]]

local LXRCore = exports['lxr-core']:GetCoreObject()
local gone = false

local function page(msg) SendLoadingScreenMessage(json.encode(msg)) end

local function hide()
    if gone then return end
    gone = true
    page({ action = 'ready' })
    Wait(math.floor((Config.Hide.holdSeconds or 0) * 1000))
    page({ action = 'hide', ms = Config.Hide.fadeMs })
    Wait(Config.Hide.fadeMs or 0)
    ShutdownLoadingScreenNui()
    ShutdownLoadingScreen()
end

-- another resource (a creator, a cinematic) may end the screen itself
RegisterNetEvent('lxr-loading:client:hide', function() CreateThread(hide) end)
AddEventHandler('lxr-loading:client:hide', function() CreateThread(hide) end)
exports('Hide', function() CreateThread(hide) end)

CreateThread(function()
    local brand = LXRCore.Brand or {}
    page({
        action = 'brand',
        name = brand.name or GetConvar('sv_projectName', 'LXRCore'),
        tagline = brand.tagline or '',
        discord = brand.discord or '',
        lang = Config.Lang,
        locale = Lang.bundle(),
        show = Config.Show,
        lines = Config.Lines,
    })
    if Config.Hide.mode == 'event' then
        Wait((Config.Hide.timeoutSeconds or 120) * 1000)
        hide()
        return
    end
    -- 'session': the network session is up and the game has a ped for us
    while not NetworkIsSessionStarted() do Wait(100) end
    while not DoesEntityExist(PlayerPedId()) do Wait(100) end
    hide()
end)
