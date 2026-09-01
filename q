<!DOCTYPE html>
<html lang="ru">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Звуковой Гримуар — архив аудиозаписей</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Baloo+2:wght@500;700;800&family=Quicksand:wght@400;500;600;700&display=swap" rel="stylesheet">
<style>
  :root{
    --bg: #140a26;
    --bg-deep: #0c0518;
    --card: #1f1240;
    --card-edge: #33205e;
    --pink: #ff3ea5;
    --cyan: #46e8d0;
    --gold: #ffc93c;
    --lavender: #d8c6f5;
    --text: #f3ecff;
    --text-dim: #b6a4d9;
    --player-h: 88px;
  }

  *{ box-sizing: border-box; }

  html,body{
    margin:0;
    padding:0;
    background: radial-gradient(120% 140% at 50% -10%, #241448 0%, var(--bg) 45%, var(--bg-deep) 100%);
    color: var(--text);
    font-family: 'Quicksand', sans-serif;
    min-height: 100%;
  }

  body{
    padding-bottom: calc(var(--player-h) + 24px);
    overflow-x: hidden;
  }

  /* ---------- background twinkle field ---------- */
  #twinkleField{
    position: fixed;
    inset: 0;
    z-index: 0;
    pointer-events: none;
    overflow: hidden;
  }
  .twinkle{
    position: absolute;
    border-radius: 50%;
    opacity: .35;
    animation: twinkle-pulse ease-in-out infinite;
  }
  @keyframes twinkle-pulse{
    0%, 100% { opacity: .12; transform: scale(0.7); }
    50% { opacity: .8; transform: scale(1.15); }
  }

  /* ---------- cursor sparkle trail ---------- */
  #sparkleCanvas{
    position: fixed;
    inset: 0;
    z-index: 5;
    pointer-events: none;
  }

  /* ---------- layout ---------- */
  .wrap{
    position: relative;
    z-index: 1;
    max-width: 760px;
    margin: 0 auto;
    padding: 64px 20px 20px;
  }

  .hero{
    text-align: center;
    margin-bottom: 40px;
  }

  .hero .glyphs{
    font-size: 22px;
    letter-spacing: .3em;
    color: var(--gold);
    opacity: .8;
    margin-bottom: 6px;
  }

  h1{
    font-family: 'Baloo 2', sans-serif;
    font-weight: 800;
    font-size: clamp(34px, 7vw, 54px);
    margin: 0 0 12px;
    line-height: 1.05;
    background: linear-gradient(100deg, var(--pink) 0%, var(--gold) 45%, var(--cyan) 100%);
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    filter: drop-shadow(0 0 18px rgba(255, 62, 165, .25));
  }

  .hero p{
    color: var(--text-dim);
    font-size: 17px;
    max-width: 46ch;
    margin: 0 auto;
    line-height: 1.5;
  }

  /* ---------- genre tabs ---------- */
  nav.tabs{
    display: flex;
    flex-wrap: wrap;
    gap: 10px;
    justify-content: center;
    margin-bottom: 34px;
  }

  .tab-btn{
    font-family: 'Baloo 2', sans-serif;
    font-weight: 700;
    font-size: 15px;
    color: var(--text);
    background: var(--card);
    border: 2px solid var(--card-edge);
    border-radius: 999px;
    padding: 9px 20px;
    cursor: pointer;
    transition: transform .15s ease, border-color .15s ease, box-shadow .15s ease;
  }
  .tab-btn:hover{
    transform: translateY(-2px) rotate(-1deg);
    border-color: var(--pink);
  }
  .tab-btn:focus-visible{
    outline: 3px solid var(--cyan);
    outline-offset: 2px;
  }
  .tab-btn.active{
    background: linear-gradient(120deg, var(--pink), var(--gold));
    color: #1a0e33;
    border-color: transparent;
    box-shadow: 0 6px 20px rgba(255, 62, 165, .35);
  }

  /* ---------- track list ---------- */
  ul.track-list{
    list-style: none;
    margin: 0;
    padding: 0;
    display: flex;
    flex-direction: column;
    gap: 12px;
  }

  li.track{
    display: flex;
    align-items: center;
    gap: 14px;
    background: var(--card);
    border: 2px solid var(--card-edge);
    border-radius: 18px;
    padding: 12px 16px;
    cursor: pointer;
    transition: border-color .15s ease, transform .1s ease, box-shadow .15s ease;
  }
  li.track:nth-child(3n+1){ border-top-left-radius: 6px; }
  li.track:nth-child(3n+2){ border-bottom-right-radius: 6px; }

  li.track:hover{
    border-color: var(--cyan);
    transform: translateX(2px);
  }
  li.track:focus-visible{
    outline: 3px solid var(--cyan);
    outline-offset: 2px;
  }
  li.track.playing{
    border-color: var(--pink);
    box-shadow: 0 0 0 1px var(--pink), 0 8px 24px rgba(255, 62, 165, .25);
  }

  .play-btn{
    flex: none;
    width: 42px;
    height: 42px;
    border-radius: 50%;
    border: none;
    background: linear-gradient(135deg, var(--pink), var(--gold));
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    color: #1a0e33;
  }
  .play-btn svg{ width: 16px; height: 16px; }

  .track-info{
    flex: 1;
    min-width: 0;
    display: flex;
    flex-direction: column;
    gap: 3px;
  }
  .track-title{
    font-family: 'Baloo 2', sans-serif;
    font-weight: 700;
    font-size: 16px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  .track-genre{
    font-size: 13px;
    color: var(--text-dim);
  }
  .track-duration{
    flex: none;
    font-size: 13px;
    color: var(--text-dim);
  }

  .empty-state{
    text-align: center;
    color: var(--text-dim);
    padding: 40px 20px;
    font-size: 15px;
  }

  /* ---------- player bar ---------- */
  .player{
    position: fixed;
    left: 0; right: 0; bottom: 0;
    height: var(--player-h);
    z-index: 10;
    background: rgba(20, 10, 38, .92);
    backdrop-filter: blur(10px);
    border-top: 2px solid var(--card-edge);
    display: flex;
    align-items: center;
    gap: 16px;
    padding: 0 20px;
  }

  .now-playing{
    flex: none;
    width: 180px;
    min-width: 0;
    display: flex;
    flex-direction: column;
    gap: 2px;
  }
  .now-playing strong{
    font-family: 'Baloo 2', sans-serif;
    font-size: 15px;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }
  .now-playing span{
    font-size: 12px;
    color: var(--text-dim);
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
  }

  .controls{
    flex: 1;
    display: flex;
    align-items: center;
    gap: 12px;
    min-width: 0;
  }

  #playPause{
    flex: none;
    width: 44px;
    height: 44px;
    border-radius: 50%;
    border: none;
    background: linear-gradient(135deg, var(--cyan), var(--pink));
    color: #1a0e33;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
  }
  #playPause svg{ width: 17px; height: 17px; }

  #seek{
    flex: 1;
    -webkit-appearance: none;
    appearance: none;
    height: 6px;
    border-radius: 999px;
    background: linear-gradient(90deg, var(--pink), var(--cyan));
    outline: none;
  }
  #seek::-webkit-slider-thumb{
    -webkit-appearance: none;
    width: 15px; height: 15px;
    border-radius: 50%;
    background: var(--gold);
    border: 2px solid var(--bg-deep);
    cursor: pointer;
  }
  #seek::-moz-range-thumb{
    width: 15px; height: 15px;
    border-radius: 50%;
    background: var(--gold);
    border: 2px solid var(--bg-deep);
    cursor: pointer;
  }

  #time{
    flex: none;
    font-size: 12px;
    color: var(--text-dim);
    width: 92px;
    text-align: right;
  }

  @media (max-width: 560px){
    .now-playing{ width: 100px; }
    #time{ width: 74px; font-size: 11px; }
    .player{ gap: 10px; padding: 0 12px; }
  }

  @media (prefers-reduced-motion: reduce){
    .twinkle{ animation: none; opacity: .2; }
    .tab-btn:hover, li.track:hover{ transform: none; }
  }
</style>
</head>
<body>

<div id="twinkleField" aria-hidden="true"></div>
<canvas id="sparkleCanvas" aria-hidden="true"></canvas>

<div class="wrap">
  <header class="hero">
    <div class="glyphs">✦ ⋆ ✧</div>
    <h1>Звуковой Гримуар</h1>
    <p>Личный архив аудиозаписей — как книга заклинаний, только вместо заклинаний звуки. Выберите главу и нажмите на запись.</p>
  </header>

  <nav class="tabs" id="tabs"></nav>

  <main>
    <ul class="track-list" id="trackList"></ul>
  </main>
</div>

<footer class="player">
  <div class="now-playing">
    <strong id="nowTitle">Выберите запись</strong>
    <span id="nowGenre">&nbsp;</span>
  </div>
  <div class="controls">
    <button id="playPause" aria-label="Играть или поставить на паузу">
      <svg id="playIcon" viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
      <svg id="pauseIcon" viewBox="0 0 24 24" fill="currentColor" style="display:none"><path d="M6 5h4v14H6zM14 5h4v14h-4z"/></svg>
    </button>
    <input type="range" id="seek" value="0" min="0" max="100" step="0.1" aria-label="Перемотка">
    <span id="time">0:00 / 0:00</span>
  </div>
</footer>

<audio id="audioEl" preload="none"></audio>

<script>
  /* =====================================================================
     СПИСОК ЗАПИСЕЙ
     Список треков теперь хранится не здесь, а в отдельном файле
     tracks.json (лежит рядом с index.html). Он загружается ниже
     через fetch(). Чтобы добавить свои записи — редактируйте tracks.json,
     этот файл трогать не нужно.
  ===================================================================== */
  let TRACKS = [];

  /* ---------------------------------------------------------------- */

  const tabsEl = document.getElementById('tabs');
  const listEl = document.getElementById('trackList');
  const audioEl = document.getElementById('audioEl');
  const playPauseBtn = document.getElementById('playPause');
  const playIcon = document.getElementById('playIcon');
  const pauseIcon = document.getElementById('pauseIcon');
  const seekEl = document.getElementById('seek');
  const timeEl = document.getElementById('time');
  const nowTitleEl = document.getElementById('nowTitle');
  const nowGenreEl = document.getElementById('nowGenre');

  let activeGenre = 'Все';
  let currentIndex = null;
  let isSeeking = false;

  function uniqueGenres(){
    return [...new Set(TRACKS.map(t => t.genre))];
  }

  function formatTime(sec){
    if (!isFinite(sec) || sec < 0) return '0:00';
    const m = Math.floor(sec / 60);
    const s = Math.floor(sec % 60).toString().padStart(2, '0');
    return `${m}:${s}`;
  }

  function renderTabs(){
    const genres = ['Все', ...uniqueGenres()];
    tabsEl.innerHTML = '';
    genres.forEach(g => {
      const btn = document.createElement('button');
      btn.className = 'tab-btn' + (g === activeGenre ? ' active' : '');
      btn.textContent = g;
      btn.setAttribute('aria-pressed', g === activeGenre ? 'true' : 'false');
      btn.addEventListener('click', () => {
        activeGenre = g;
        renderTabs();
        renderList();
      });
      tabsEl.appendChild(btn);
    });
  }

  function renderList(){
    listEl.innerHTML = '';
    const filtered = TRACKS
      .map((t, i) => ({ ...t, index: i }))
      .filter(t => activeGenre === 'Все' || t.genre === activeGenre);

    if (filtered.length === 0){
      const empty = document.createElement('div');
      empty.className = 'empty-state';
      empty.textContent = 'В этой главе пока пусто — добавьте записи в tracks.json.';
      listEl.appendChild(empty);
      return;
    }

    filtered.forEach(t => {
      const li = document.createElement('li');
      li.className = 'track' + (t.index === currentIndex ? ' playing' : '');
      li.tabIndex = 0;
      li.setAttribute('role', 'button');
      li.setAttribute('aria-label', `Играть «${t.title}»`);

      const authorLine = t.author ? `${t.genre} · ${t.author}` : t.genre;

      li.innerHTML = `
        <button class="play-btn" tabindex="-1" aria-hidden="true">
          <svg viewBox="0 0 24 24" fill="currentColor"><path d="M8 5v14l11-7z"/></svg>
        </button>
        <div class="track-info">
          <span class="track-title">${t.title}</span>
          <span class="track-genre">${authorLine}</span>
        </div>
        <span class="track-duration">${t.duration || '--:--'}</span>
      `;

      const play = () => playTrack(t.index);
      li.addEventListener('click', play);
      li.addEventListener('keydown', e => {
        if (e.key === 'Enter' || e.key === ' '){ e.preventDefault(); play(); }
      });

      listEl.appendChild(li);
    });
  }

  function playTrack(index){
    const track = TRACKS[index];
    if (!track) return;
    currentIndex = index;
    audioEl.src = track.file;
    audioEl.play().catch(() => { /* ждём взаимодействия пользователя */ });
    nowTitleEl.textContent = track.title;
    nowGenreEl.textContent = track.author ? `${track.genre} · ${track.author}` : track.genre;
    renderList();
  }

  playPauseBtn.addEventListener('click', () => {
    if (currentIndex === null) return;
    if (audioEl.paused) audioEl.play(); else audioEl.pause();
  });

  audioEl.addEventListener('play', () => {
    playIcon.style.display = 'none';
    pauseIcon.style.display = '';
  });
  audioEl.addEventListener('pause', () => {
    playIcon.style.display = '';
    pauseIcon.style.display = 'none';
  });

  audioEl.addEventListener('timeupdate', () => {
    if (isSeeking) return;
    const pct = audioEl.duration ? (audioEl.currentTime / audioEl.duration) * 100 : 0;
    seekEl.value = pct;
    timeEl.textContent = `${formatTime(audioEl.currentTime)} / ${formatTime(audioEl.duration)}`;
  });

  seekEl.addEventListener('input', () => { isSeeking = true; });
  seekEl.addEventListener('change', () => {
    if (audioEl.duration){
      audioEl.currentTime = (seekEl.value / 100) * audioEl.duration;
    }
    isSeeking = false;
  });

  audioEl.addEventListener('error', () => {
    if (currentIndex === null) return;
    nowGenreEl.textContent = 'файл не найден — проверьте путь в TRACKS';
  });

  audioEl.addEventListener('ended', () => {
    playIcon.style.display = '';
    pauseIcon.style.display = 'none';
  });

  /* ---------------------------------------------------------------- */
  /* Загрузка списка треков из tracks.json */
  async function loadTracks(){
    try {
      const res = await fetch('tracks.json');
      if (!res.ok) throw new Error('HTTP ' + res.status);
      TRACKS = await res.json();
    } catch (err) {
      listEl.innerHTML = '';
      const empty = document.createElement('div');
      empty.className = 'empty-state';
      empty.innerHTML = 'Не удалось загрузить <code>tracks.json</code>.<br>' +
        'Если вы открыли файл напрямую двойным щелчком (адрес начинается с <code>file://</code>), ' +
        'браузер блокирует такую загрузку из соображений безопасности — ' +
        'запустите локальный сервер (например, <code>npx serve</code> или <code>python3 -m http.server</code>) ' +
        'или выложите сайт на GitHub Pages / Cloudflare Pages (см. README.md).';
      listEl.appendChild(empty);
      tabsEl.innerHTML = '';
      return;
    }
    renderTabs();
    renderList();
  }

  loadTracks();

  /* ---------------------------------------------------------------- */
  /* фоновые мерцающие звёзды */
  const twinkleField = document.getElementById('twinkleField');
  const twinkleColors = ['#ffc93c', '#46e8d0', '#ff3ea5'];
  const reduceMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  for (let i = 0; i < 46; i++){
    const dot = document.createElement('div');
    dot.className = 'twinkle';
    const size = 1 + Math.random() * 2.5;
    dot.style.width = `${size}px`;
    dot.style.height = `${size}px`;
    dot.style.left = `${Math.random() * 100}%`;
    dot.style.top = `${Math.random() * 100}%`;
    dot.style.background = twinkleColors[i % twinkleColors.length];
    dot.style.animationDuration = `${3 + Math.random() * 4}s`;
    dot.style.animationDelay = `${Math.random() * 4}s`;
    twinkleField.appendChild(dot);
  }

  /* ---------------------------------------------------------------- */
  /* мерцающий след за курсором — единственный акцентный эффект */
  if (!reduceMotion && window.matchMedia('(pointer: fine)').matches){
    const canvas = document.getElementById('sparkleCanvas');
    const ctx = canvas.getContext('2d');
    let particles = [];
    let w, h;

    function resize(){
      w = canvas.width = window.innerWidth;
      h = canvas.height = window.innerHeight;
    }
    resize();
    window.addEventListener('resize', resize);

    const sparkleColors = ['#ff3ea5', '#ffc93c', '#46e8d0', '#d8c6f5'];
    let lastSpawn = 0;

    window.addEventListener('mousemove', e => {
      const now = performance.now();
      if (now - lastSpawn < 30) return;
      lastSpawn = now;
      particles.push({
        x: e.clientX,
        y: e.clientY,
        r: 1.5 + Math.random() * 2,
        vy: -0.3 - Math.random() * 0.4,
        life: 1,
        color: sparkleColors[Math.floor(Math.random() * sparkleColors.length)]
      });
      if (particles.length > 120) particles.shift();
    });

    function tick(){
      ctx.clearRect(0, 0, w, h);
      particles.forEach(p => {
        p.y += p.vy;
        p.life -= 0.02;
        ctx.globalAlpha = Math.max(p.life, 0);
        ctx.fillStyle = p.color;
        ctx.beginPath();
        ctx.arc(p.x, p.y, p.r, 0, Math.PI * 2);
        ctx.fill();
      });
      ctx.globalAlpha = 1;
      particles = particles.filter(p => p.life > 0);
      requestAnimationFrame(tick);
    }
    tick();
  }
</script>

</body>
</html>
