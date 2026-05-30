{{flutter_js}}
{{flutter_build_config}}

(function () {
  var overlay = document.getElementById('loading-overlay');

  function dismissOverlay() {
    if (!overlay) return;
    overlay.classList.add('fade-out');
    overlay.addEventListener('transitionend', function handler() {
      overlay.removeEventListener('transitionend', handler);
      if (overlay.parentNode) overlay.parentNode.removeChild(overlay);
    });
  }

  _flutter.loader.load({
    onEntrypointLoaded: async function (engineInitializer) {
      // HTML renderer: no CanvasKit WASM to download or warm up.
      // Sliders and text are identical; eliminates the post-first-frame jank.
      var appRunner = await engineInitializer.initializeEngine({
        renderer: 'html',
      });

      // Register before runApp() to avoid a race on fast/cached loads.
      window.addEventListener('flutter-first-frame', function onFirstFrame() {
        window.removeEventListener('flutter-first-frame', onFirstFrame);
        dismissOverlay();
      });

      await appRunner.runApp();
    },
  });
})();
