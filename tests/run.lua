--[[ ═══════════════════════════════════════════════════════════════════════════
     LXR-LOADING — Offline tests: config sanity, locale parity, mock for the shot
     Usage (from the lxr-loading folder):  lua tests/run.lua [--mock out.js en|ka]
     © 2026 iBoss21 / LXRCore — All Rights Reserved
     ═══════════════════════════════════════════════════════════════════════════ ]]

local CORE = os.getenv('LXR_CORE_PATH') or '../lxr-core'
package.path = CORE .. '/?.lua;' .. package.path
local ok = pcall(function() require('tests.lib.fxshim') end)
if not ok then print('lxr-core shim not found at ' .. CORE) os.exit(2) end
local Shim = require('tests.lib.fxshim')
for _, f in ipairs({ 'shared/main.lua', 'shared/locale.lua', 'locales/en.lua', 'config.lua' }) do Shim.load(CORE .. '/' .. f) end
Config = nil Locale = nil
Shim.load('shared/locale.lua') Shim.load('locales/en.lua') Shim.load('locales/ka.lua') Shim.load('config.lua')

local passed, failed = 0, 0
local function test(name, fn) local okT, err = xpcall(fn, debug.traceback) if okT then passed = passed + 1 print('  ^ ok   ' .. name) else failed = failed + 1 print('  x FAIL ' .. name .. '\n' .. err) end end
local function eq(a, b, msg) if a ~= b then error((msg or 'eq') .. ': expected ' .. tostring(b) .. ' got ' .. tostring(a), 2) end end

print('lxr-loading offline tests')
test('config', function()
    assert(Config.Hide.mode == 'session' or Config.Hide.mode == 'event')
    assert(Config.Hide.fadeMs > 0 and Config.Lines.everySeconds > 0)
end)
test('lines and phases exist in both languages', function()
    local en, ka = Locale.Bundles.en, Locale.Bundles.ka
    local n = 0
    for k in pairs(en) do if k:find('^lines%.') then n = n + 1 end end
    assert(n >= 6, 'at least six lines')
    for _, p in ipairs({ 'init', 'map', 'session', 'scripts', 'data', 'done' }) do assert(en['phase.' .. p] and ka['phase.' .. p], p) end
end)
test('locale parity', function()
    local en, ka = Locale.Bundles.en, Locale.Bundles.ka
    local missing = {}
    for k in pairs(en) do if ka[k] == nil then missing[#missing + 1] = k end end
    eq(#missing, 0, 'ka missing: ' .. table.concat(missing, ', '))
end)
print(('%d passed, %d failed'):format(passed, failed))
if arg and arg[1] == '--mock' and arg[2] then
    Config.Lang = arg[3] or 'en'
    local f = assert(io.open(arg[2], 'w'))
    f:write('window.__LXR_MOCK__ = ' .. json.encode({ action = 'brand', name = 'The Land of Wolves', tagline = 'მგლების მიწა - რჩეულთა ადგილი!', discord = 'discord.gg/wolvesland', lang = Config.Lang, locale = Lang.bundle(), show = Config.Show, lines = Config.Lines, fraction = 0.62 }) .. ';\n')
    f:close()
    print('mock written to ' .. arg[2])
end
os.exit(failed == 0 and 0 or 1)
