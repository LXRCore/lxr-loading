--[[ ═══════════════════════════════════════════════════════════════════════════
     LXR-LOADING — Locale: English (canonical)
     © 2026 iBoss21 / LXRCore — All Rights Reserved
     ═══════════════════════════════════════════════════════════════════════════ ]]

Locale.Register('en', {
    ui = {
        kicker    = 'The year is 1899',
        loading   = 'Saddling up',
        ready     = 'The land is ready',
        hint      = 'You are on your way',
        discord   = 'Discord',
        version   = 'LXRCore v3',
    },
    -- what the game is doing, in plain words (keys are the game's own load phases)
    phase = {
        init      = 'Waking the engine',
        map       = 'Laying out the land',
        session   = 'Finding the others',
        scripts   = 'Opening the ledgers',
        data      = 'Reading the map',
        done      = 'Almost there',
    },
    -- one line at a time, shuffled — add as many as you like
    lines = {
        l1  = 'Nobody here knows your name yet. Keep it that way, or do not.',
        l2  = 'A dollar buys a meal, a bed and a shave. Spend it like it matters.',
        l3  = 'The law is slow and the telegraph is fast. Choose your crimes accordingly.',
        l4  = 'A horse you have not bonded with will leave you at the first gunshot.',
        l5  = 'Meat spoils, pelts rot, bread goes hard. Sell what you cannot carry.',
        l6  = 'Every door has a lock. Every lock has a story. Most of them are not yours.',
        l7  = 'The sheriff remembers faces. The bounty hunter remembers prices.',
        l8  = 'Camp fires need wood. Wood needs an axe. An axe needs a store, or a friend.',
        l9  = 'Trains leave on time. People do not.',
        l10 = 'The bank keeps your money safe from everyone except the bank.',
        l11 = 'A letter takes half an hour. A telegram takes a minute and everyone at the office reads it.',
        l12 = 'You can craft almost anything. Whether it holds is another matter.',
    },
})
