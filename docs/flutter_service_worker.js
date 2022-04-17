'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/AssetManifest.json": "12f7fd5bcac08bb96d6524d231e1791d",
"assets/assets/icon.png": "463f34fe0b733d9f5195a7307115cc26",
"assets/assets/RobotoSlab-Black.ttf": "ea42831afc2b6fc44007141eb8390406",
"assets/FontManifest.json": "f7ec275b9654607d8677dde3153acf53",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "4e96a7079e5e631f0309f991e66295c3",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.png": "dd3d69005f9ca3aa0d6320dc8caccedc",
"icons/android-icon-144x144.png": "46d352c042369795a059663a3f36282a",
"icons/android-icon-192x192.png": "8ef3cad1bdb7420c6ba7b0cef517501c",
"icons/android-icon-36x36.png": "c6985b8cae2c20ed19dd5214b94f1633",
"icons/android-icon-48x48.png": "2d53ea925b22ab3fc4208d37a632bd86",
"icons/android-icon-72x72.png": "8c858c5bdd7c11ae1f52e427bdcc49d6",
"icons/android-icon-96x96.png": "3ba468ead9430314158771ed7ce93c87",
"icons/apple-icon-114x114.png": "0a9488d1eb6bd1db2a21e49be3a5cc6f",
"icons/apple-icon-120x120.png": "5008d5817e36a06cc0144d8816aa725d",
"icons/apple-icon-144x144.png": "46d352c042369795a059663a3f36282a",
"icons/apple-icon-152x152.png": "bd7c1c82b73b2c28bad6a63ad90d6608",
"icons/apple-icon-180x180.png": "7364b0df73cc71897a79c40180a0b7ae",
"icons/apple-icon-57x57.png": "84fc1b22b65ec0994b5c03f1f15fa517",
"icons/apple-icon-60x60.png": "cdf04b80224ccb3045ddb49c83661f40",
"icons/apple-icon-72x72.png": "8c858c5bdd7c11ae1f52e427bdcc49d6",
"icons/apple-icon-76x76.png": "8284976b1e9abf363ad86f0426c13dea",
"icons/apple-icon-precomposed.png": "d5aea89e356a8743ebd696402843d72e",
"icons/apple-icon.png": "d5aea89e356a8743ebd696402843d72e",
"icons/browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"icons/favicon-16x16.png": "dd3d69005f9ca3aa0d6320dc8caccedc",
"icons/favicon-32x32.png": "69308396a9107f2a48fef703a5eaa53e",
"icons/favicon-96x96.png": "3ba468ead9430314158771ed7ce93c87",
"icons/favicon.ico": "1d0248836207a99a62fa87d1dd1363ea",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"icons/ms-icon-144x144.png": "46d352c042369795a059663a3f36282a",
"icons/ms-icon-150x150.png": "f79f4f396ef4890010f9f975629f26d0",
"icons/ms-icon-310x310.png": "2b0ea972243bedebccb690bc9c6a6d81",
"icons/ms-icon-70x70.png": "94622e9cd87a06d050acb14a99033817",
"index.html": "30eb144c6de80e9ccc818a6a19e55f63",
"/": "30eb144c6de80e9ccc818a6a19e55f63",
"main.dart.js": "b6fee72b8e7c1b3fcf078f447cb9683a",
"manifest.json": "744e6565787aeec5bc7f5c8c3e15418a",
"version.json": "70b8a25bcbf4a587d288955cc9c5998c"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  // "/",
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
