'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "/main.dart.js": "c5b4aa449fc6f1e20338aa5594a3a65b",
"/main.dart.js.deps": "f1d6dd6d8b12eaf7f3f9c6522189cadf",
"/assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"/assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"/assets/AssetManifest.json": "4da0b1509e3f7270d968376ce9fde628",
"/assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"/assets/LICENSE": "366549f3b4ebd0e4a6db99912cfd5808",
"/assets/manifest.json": "e3dcdb4ea7055ca1e1019b8e345ac832",
"/assets/docs/assets/manifest.json": "e3dcdb4ea7055ca1e1019b8e345ac832",
"/assets/docs/assets/docs/assets/manifest.json": "fc3d040b3c7a1025ec7e332632852c54",
"/assets/images/icon.png": "9aa9904da323f5f4e807002b28e0c6f4",
"/index.html": "4cdbb5bdca5863890c06867d6f842275"
};

self.addEventListener('activate', function (event) {
  event.waitUntil(
    caches.keys().then(function (cacheName) {
      return caches.delete(cacheName);
    }).then(function (_) {
      return caches.open(CACHE_NAME);
    }).then(function (cache) {
      return cache.addAll(Object.keys(RESOURCES));
    })
  );
});

self.addEventListener('fetch', function (event) {
  event.respondWith(
    caches.match(event.request)
      .then(function (response) {
        if (response) {
          return response;
        }
        return fetch(event.request, {
          credentials: 'include'
        });
      })
  );
});
