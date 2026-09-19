/* LXR-LOADING — the loading screen | © 2026 iBoss21 / LXRCore
   Game → page: { eventName: 'loadProgress', loadFraction } · 'startInitFunction' { type } · 'startInitFunctionOrder' { type, order, count }
                · 'initFunctionInvoking' { type, name, idx } · 'startDataFileEntries' { count } · 'performMapLoadFunction' { idx } · 'onLogLine' { message }
   Client script → page (SendLoadingScreenMessage): { action: 'brand', name, tagline, discord, lang, locale, show } · { action: 'ready' } · { action: 'hide', ms }
   Nothing here talks back; the page is display only. */
(function () {
  const $ = (id) => document.getElementById(id);
  let L = {}, lines = [], lineAt = 0, lineTimer = null, every = 6000, shuffle = true;
  let frac = 0, phase = 'init', ready = false;
  const t = (k, fb) => (L[k] !== undefined ? L[k] : (fb !== undefined ? fb : k.split('.').pop()));

  function setFraction(f) {
    frac = Math.max(frac, Math.min(1, f || 0));
    const pct = Math.round(frac * 100);
    $('fill').style.width = pct + '%';
    $('percent').textContent = pct + '%';
  }
  function setPhase(p) { if (p !== phase) { phase = p; $('phase').textContent = t('phase.' + p); } }

  // ── the rotating line ──
  function nextLine() {
    if (!lines.length) return;
    const el = $('line');
    el.classList.add('is-swap');
    setTimeout(() => { el.textContent = lines[lineAt % lines.length]; lineAt++; el.classList.remove('is-swap'); }, 450);
  }
  // The client script (and its brand / locale message) only runs once the game has loaded — the whole load bar
  // would pass with an empty line. So the page reads the resource's own config and locale at its first frame:
  // one source of truth (locales/*.lua), parsed here with a regex; the brand message later replaces it.
  async function bootLocale() {
    try {
      const cfg = await fetch('../config.lua').then((r) => r.text());
      const lang = (cfg.match(/Config\.Lang\s*=\s*'([a-z]{2})'/) || [])[1] || 'en';
      const pace = (cfg.match(/everySeconds\s*=\s*(\d+)/) || [])[1]; if (pace) every = Number(pace) * 1000;
      const lua = await fetch('../locales/' + lang + '.lua').then((r) => r.text());
      const out = {};
      let section = '';
      for (const raw of lua.split('\n')) {
        const line = raw.replace(/--.*$/, '');
        const sec = line.match(/^\s*([a-z_]+)\s*=\s*\{/); if (sec) { section = sec[1]; continue; }
        const kv = line.match(/^\s*([a-z_0-9]+)\s*=\s*'((?:[^'\\]|\\.)*)'/);
        if (kv && section) out[section + '.' + kv[1]] = kv[2].replace(/\\'/g, "'");
      }
      if (Object.keys(out).length && !Object.keys(L).length) {
        L = out; document.body.classList.toggle('lang-ka', lang === 'ka');
        $('kicker').textContent = t('ui.kicker'); $('hint').textContent = t('ui.hint');
        startLines();
      }
    } catch (e) { /* no page-side locale: the brand message brings it */ }
  }
  bootLocale();
  function startLines() {
    clearInterval(lineTimer);
    lines = Object.keys(L).filter((k) => k.startsWith('lines.')).sort().map((k) => L[k]);
    if (shuffle) for (let i = lines.length - 1; i > 0; i--) { const j = Math.floor(Math.random() * (i + 1)); [lines[i], lines[j]] = [lines[j], lines[i]]; }
    lineAt = 0; $('line').textContent = lines[0] || ''; lineAt = 1;
    lineTimer = setInterval(nextLine, every);
  }

  function applyBrand(m) {
    if (m.locale) L = m.locale;
    document.body.classList.toggle('lang-ka', m.lang === 'ka');
    $('title').textContent = m.name || $('title').textContent || 'LXRCore';
    $('tagline').textContent = m.tagline || '';
    $('kicker').textContent = t('ui.kicker');
    $('hint').textContent = t('ui.hint');
    $('version').textContent = (m.show && m.show.version === false) ? '' : t('ui.version');
    $('discord').textContent = (m.show && m.show.discord === false) ? '' : (m.discord ? t('ui.discord') + ' · ' + m.discord : '');
    if (m.show && m.show.percent === false) $('percent').style.display = 'none';
    if (m.show && m.show.phase === false) $('phase').style.display = 'none';
    if (m.lines) { every = (m.lines.everySeconds || 6) * 1000; shuffle = m.lines.shuffle !== false; }
    setPhase(phase);
    startLines();
  }

  window.addEventListener('message', (e) => {
    const m = e.data || {};
    // the game's own load events
    if (m.eventName === 'loadProgress') setFraction(m.loadFraction);
    else if (m.eventName === 'startInitFunction') setPhase(m.type === 'INIT_BEFORE_MAP_LOADED' ? 'init' : m.type === 'INIT_AFTER_MAP_LOADED' ? 'map' : m.type === 'INIT_SESSION' ? 'session' : phase);
    else if (m.eventName === 'startDataFileEntries') setPhase('data');
    else if (m.eventName === 'onLogLine' && /script|resource/i.test(m.message || '')) setPhase('scripts');
    // the resource's own messages
    else if (m.action === 'brand') applyBrand(m);
    else if (m.action === 'ready') { ready = true; setFraction(1); setPhase('done'); $('phase').textContent = t('ui.ready'); $('app').classList.add('is-ready'); }
    else if (m.action === 'hide') { $('app').classList.add('is-out'); clearInterval(lineTimer); }
  });

  // defaults until the client script speaks (fonts and layout stay right even with no brand yet)
  $('title').textContent = 'The Land of Wolves';
  $('kicker').textContent = 'The year is 1899';
  $('phase').textContent = 'Waking the engine';
  if (window.__LXR_MOCK__) { const mk = window.__LXR_MOCK__; applyBrand(mk); setFraction(mk.fraction || 0.62); setPhase('map'); }
})();
