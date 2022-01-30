'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "index.html": "066aac9993cfe4ce61dc0414efdb7e1d",
"/": "066aac9993cfe4ce61dc0414efdb7e1d",
"version.json": "93ab5e9c8c81698933229176204babce",
"manifest.json": "99271c5fbfdca0e8abb34cf2a371a71b",
"main.dart.js": "85d000ed7cdc183d25636a709630d175",
"canvaskit/profiling/canvaskit.wasm": "a9610cf39260f60fbe7524a785c66101",
"canvaskit/profiling/canvaskit.js": "f3bfccc993a1e0bfdd3440af60d99df4",
"canvaskit/canvaskit.wasm": "04ed3c745ff1dee16504be01f9623498",
"canvaskit/canvaskit.js": "43fa9e17039a625450b6aba93baf521e",
"404.html": "ac65368a0327a211f3ac5b76b86e8a2b",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/favicon-96x96.png": "e4dee213f72253b649ad4be51c6f89cd",
"icons/ms-icon-70x70.png": "459f67292ca36a7c4f2b395f3ee942e9",
"icons/apple-icon-76x76.png": "d73a30026e7df830737203d1f4efdd31",
"icons/apple-icon-60x60.png": "bb00fb61bdf99e31753f311c0ca2d6cb",
"icons/Icon-192.png": "a74595e0447ffcbb3ce5142ba5fc682b",
"icons/android-icon-48x48.png": "9b4025929c14adb46274976d1563ba23",
"icons/manifest.json": "5892ea697cab46a4bdd87b8ddd297014",
"icons/apple-icon-72x72.png": "dbe477e3c9b33173cbaf25cfd430600c",
"icons/favicon-32x32.png": "a40db1d14ad74b43e0998a18a37031b6",
"icons/apple-icon-precomposed.png": "b8138bcf37735ecfc4ffe5f5f3dca867",
"icons/android-icon-144x144.png": "0f98310588b56e2a5afe82e9d8970538",
"icons/ms-icon-310x310.png": "b56fb52a7f3a5b2601e67c5ee4bbf1b7",
"icons/apple-icon-57x57.png": "a20d565df519e14cc19b83ce78a2c499",
"icons/android-icon-96x96.png": "e4dee213f72253b649ad4be51c6f89cd",
"icons/android-icon-36x36.png": "98d48a77897c20bf6104cc8cce9c169c",
"icons/apple-icon-120x120.png": "fb5e204fb8b31c019e0628eeddf0ee99",
"icons/apple-icon-152x152.png": "24329829cf60f4aaa3d9753ec9ab2560",
"icons/apple-icon-144x144.png": "0f98310588b56e2a5afe82e9d8970538",
"icons/android-icon-72x72.png": "dbe477e3c9b33173cbaf25cfd430600c",
"icons/ms-icon-150x150.png": "921b39b5020639f40f564d013a5c1a21",
"icons/apple-icon-114x114.png": "53b7042a7bbb98b9d137ad8e4a317aed",
"icons/favicon.ico": "e41579ee76662904d695c6312b7c5223",
"icons/apple-icon-180x180.png": "2976b4a9bbaa2aa3f92afe4366aa8c64",
"icons/browserconfig.xml": "93c98f9c263a2747d8e80bef42b6ffad",
"icons/ms-icon-144x144.png": "0f98310588b56e2a5afe82e9d8970538",
"icons/android-icon-192x192.png": "a74595e0447ffcbb3ce5142ba5fc682b",
"icons/favicon-16x16.png": "612a27c8e275fe66fc304d24c87e277d",
"icons/apple-icon.png": "b8138bcf37735ecfc4ffe5f5f3dca867",
"assets/FontManifest.json": "1458e6f72312fd50a116d8994e9fbfb3",
"assets/AssetManifest.json": "14c1517fc1b931b967df83089d5737aa",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/fluttertoast/assets/toastify.css": "a85675050054f179444bc5ad70ffc635",
"assets/packages/fluttertoast/assets/toastify.js": "e7006a0a033d834ef9414d48db3be6fc",
"assets/fonts/MaterialIcons-Regular.otf": "4e6447691c9509f7acdbf8a931a85ca1",
"assets/NOTICES": "717d64fd9b3bba6be00c3dd59672972f",
"assets/assets/fonts/Pacifico.ttf": "9b94499ccea3bd82b24cb210733c4b5e"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
