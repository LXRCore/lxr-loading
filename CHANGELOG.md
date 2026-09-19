# Changelog — lxr-loading

## 3.0.0 — 2026-09-19
* The lines under the title run from the first frame of the load: the page reads `config.lua` and `locales/<lang>.lua` itself (they ship as files) — before, the locale only arrived with the client script, i.e. after the game had loaded, so the whole bar passed with an empty line.
* LXRCore v3 release line: every resource ships as 3.0.0 from here (the entries below are the road to it).

## 1.0.0 — 2026-09-19
- First release: kit loading screen with brand, tagline, rotating lines (EN/KA), game-fed progress and phases, session or event shutdown.
