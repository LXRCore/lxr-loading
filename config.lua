--[[
    ██╗     ██╗  ██╗██████╗       ██╗      ██████╗  █████╗ ██████╗ ██╗███╗   ██╗ ██████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██║     ██╔═══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║   ██║███████║██║  ██║██║██╔██╗ ██║██║  ███╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║   ██║██╔══██║██║  ██║██║██║╚██╗██║██║   ██║
    ███████╗██╔╝ ██╗██║  ██║      ███████╗╚██████╔╝██║  ██║██████╔╝██║██║ ╚████║╚██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝

    LXR Core - Loading screen

    What the player sees between "Connect" and the character room: the wolf,
    the server's name and tagline, a line of the land, and a progress bar fed
    by the game's own load events. No music, no third-party assets, no build
    step — the LXR UI Kit and one PNG.

    Brand:       LXRCore — Lux Empire eXperience RedM Core
    Product:     wolves.land / The Land of Wolves
    Developer:   iBoss21 / LXRCore
    Website:     https://www.lxrcore.com
    Discord:     https://discord.gg/ZHMKVYyhBa (development)
    GitHub:      https://github.com/LXRCore

    Version: 1.0.0
    Performance Target: 0.00 ms (one client thread while the screen is up, nothing after)

    © 2026 iBoss21 / LXRCore | lxrcore.com | All Rights Reserved
]]

Config = Config or {}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ LANGUAGE ██████████████████████████████████████████████
-- ████████████████████████████████████████████████████████████████████████████████
Config.Lang = 'en'

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ WHEN THE SCREEN GOES ══════════════════════════════════
-- ████████████████████████████████████████████████████████████████████████████████
-- 'session'  the screen fades once the network session is up and the game has spawned the ped
--            (the character room opens right after, so the player never sees the world)
-- 'event'    the screen stays until something triggers `lxr-loading:client:hide` (a creator,
--            a cinematic intro, anything) — `timeoutSeconds` is the safety net
Config.Hide = {
    mode           = 'session',
    holdSeconds    = 1.5,        -- linger after the game is ready so the bar reaches the end
    fadeMs         = 900,
    timeoutSeconds = 120,        -- 'event' mode only: hide anyway after this
}

-- ████████████████████████████████████████████████████████████████████████████████
-- ████████████████████████ WHAT IT SAYS ══════════════════════════════════════════
-- ████████████████████████████████████████████████████████████████████████████████
-- The name, tagline and discord come from lxr-core's brand (server.cfg: lxr_tagline, lxr_discord).
-- The rotating lines are `lines.*` in locales/ — add as many as you like.
Config.Lines = {
    everySeconds = 6,            -- how long one line stays
    shuffle      = true,
}
Config.Show = {
    percent  = true,             -- the number next to the bar
    phase    = true,             -- what the game is doing, in plain words (locales `phase.*`)
    discord  = true,
    version  = true,             -- "LXRCore v3" in the corner
}
