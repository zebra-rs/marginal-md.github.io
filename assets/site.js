/* Marginal site — theme switch.
   The head of each page applies the saved theme (or ?theme=) before paint;
   this file wires the header toggle and keeps the light/dark <picture>
   sources and the button label in step. */
(function () {
  'use strict';
  var root = document.documentElement;
  var mq = window.matchMedia ? window.matchMedia('(prefers-color-scheme: dark)') : null;

  function current() {
    var t = root.getAttribute('data-theme');
    if (t === 'light' || t === 'dark') return t;
    return mq && mq.matches ? 'dark' : 'light';
  }

  function pictures() {
    var forced = root.getAttribute('data-theme');
    var media = forced === 'dark' ? 'all' : forced === 'light' ? 'not all' : '(prefers-color-scheme: dark)';
    var sources = document.querySelectorAll('picture > source[data-dark]');
    for (var i = 0; i < sources.length; i++) sources[i].setAttribute('media', media);
  }

  function labels() {
    var text = 'Switch to ' + (current() === 'dark' ? 'light' : 'dark') + ' theme';
    var buttons = document.querySelectorAll('.theme-toggle');
    for (var i = 0; i < buttons.length; i++) {
      buttons[i].setAttribute('aria-label', text);
      buttons[i].setAttribute('title', text);
    }
  }

  function set(theme) {
    root.setAttribute('data-theme', theme);
    try { localStorage.setItem('theme', theme); } catch (e) {}
    pictures();
    labels();
  }

  document.addEventListener('click', function (e) {
    var button = e.target.closest ? e.target.closest('.theme-toggle') : null;
    if (!button) return;
    set(current() === 'dark' ? 'light' : 'dark');
  });

  if (mq && mq.addEventListener) mq.addEventListener('change', labels);
  pictures();
  labels();
})();
