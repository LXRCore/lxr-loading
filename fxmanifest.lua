--[[
    ██╗     ██╗  ██╗██████╗       ██╗      ██████╗  █████╗ ██████╗ ██╗███╗   ██╗ ██████╗
    ██║     ╚██╗██╔╝██╔══██╗      ██║     ██╔═══██╗██╔══██╗██╔══██╗██║████╗  ██║██╔════╝
    ██║      ╚███╔╝ ██████╔╝█████╗██║     ██║   ██║███████║██║  ██║██║██╔██╗ ██║██║  ███╗
    ██║      ██╔██╗ ██╔══██╗╚════╝██║     ██║   ██║██╔══██║██║  ██║██║██║╚██╗██║██║   ██║
    ███████╗██╔╝ ██╗██║  ██║      ███████╗╚██████╔╝██║  ██║██████╔╝██║██║ ╚████║╚██████╔╝
    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝      ╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚═╝╚═╝  ╚═══╝ ╚═════╝

    🐺 LXR Core - Loading screen

    Brand:       LXRCore — Lux Empire eXperience RedM Core
    Product:     wolves.land / The Land of Wolves
    Developer:   iBoss21 / LXRCore
    Website:     https://www.lxrcore.com
    Discord:     https://discord.gg/GAhk8cgXe9
    GitHub:      https://github.com/LXRCore

    © 2026 iBoss21 / LXRCore | lxrcore.com | All Rights Reserved
]]

fx_version '3.0.0'
game 'rdr3'
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'
lua54 'yes'

name 'lxr-loading'
author 'iBoss21 / LXRCore'
description 'LXRCore v3 loading screen on the LXR UI Kit'
version '1.0.0'
repository 'https://github.com/LXRCore/lxr-loading'

shared_scripts {
    'shared/locale.lua',
    'locales/*.lua',
    'config.lua',
}

client_script 'client/main.lua'

-- the page is up from the first frame of the connection; the client script decides when it goes
loadscreen 'html/index.html'
loadscreen_manual_shutdown 'yes'
loadscreen_cursor 'no'

files {
    'html/index.html',
    'html/lxr-ui.css',
    'html/style.css',
    'html/app.js',
    'html/fonts/*.woff2',
    'html/img/*.png',
}

dependency 'lxr-core'
