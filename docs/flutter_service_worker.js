'use strict';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "main.dart.js": "c3ac203ffff05f96ecc6722d20e352a6",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "115e937bb829a890521f72d2e664b632",
"assets/fonts/MaterialIcons-Regular.ttf": "56d3ffdef7a25659eab6a68a3fbfaf16",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/FontManifest.json": "01700ba55b08a6141f33e168c4a6c22f",
"assets/LICENSE": "07a92ad238b00f713c7d782acdb1916d",
"icons/Icon-512.png": "6b084855511884ad18bdac9d7897efe3",
"icons/Icon-192.png": "46be5daed740bd4ff419f3ef19d783ca",
"index.html": "7d3907ecb9a5d5953c48a5eb6e87c04e",
"/": "7d3907ecb9a5d5953c48a5eb6e87c04e",
"manifest.json": "ddaef59f9c86332dddd38ce373b69833"
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
        return fetch(event.request);
      })
  );
});
