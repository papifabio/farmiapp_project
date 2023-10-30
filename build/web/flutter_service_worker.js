'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "a55e7ed182015890caab782a94e5e2a5",
"assets/AssetManifest.json": "f4003f9447df4e030b204febe8b16e4b",
"assets/assets/images/avatar.png": "163ac3f4120d46ab73b71733450d484d",
"assets/assets/images/Delivery.png": "acce578db64791fde11caf45131861af",
"assets/assets/images/login.png": "e1a29eed7d794709e6ee6885ad9b5a6e",
"assets/assets/images/menu.png": "64222503abba3dc1cfb71399ed963a55",
"assets/assets/login/images/ellipse-1.png": "a540cfd9887fde79ec58e35626af2a26",
"assets/assets/login/images/ellipse-2.png": "a540cfd9887fde79ec58e35626af2a26",
"assets/assets/login/images/ellipse-3.png": "a540cfd9887fde79ec58e35626af2a26",
"assets/assets/login/images/ellipse-4.png": "a540cfd9887fde79ec58e35626af2a26",
"assets/assets/login/images/ellipse-5.png": "a540cfd9887fde79ec58e35626af2a26",
"assets/assets/login/images/lista-cWF.png": "192e729aaeed842cef0595bf40289460",
"assets/assets/login/images/lista.png": "192e729aaeed842cef0595bf40289460",
"assets/assets/login/images/rectangle-10.png": "b75aecaf9e70a9b1760497e33bcd6db1",
"assets/assets/login/images/rectangle-12.png": "647d39b1fcba0fc98d531bd553b6a027",
"assets/assets/login/images/rectangle-13.png": "faae5dcc174dcdeda5c8395b0f2a98f6",
"assets/assets/login/images/rectangle-14.png": "99d57e318919efe6d09da0fd6fe58415",
"assets/assets/login/images/rectangle-16.png": "647d39b1fcba0fc98d531bd553b6a027",
"assets/assets/login/images/rectangle-17-zgT.png": "99d57e318919efe6d09da0fd6fe58415",
"assets/assets/login/images/rectangle-17.png": "50b2625b95cc289ddf6cdb073b5c35ad",
"assets/assets/login/images/rectangle-19.png": "be1b02b1b076b3e1566d9a158b0f350d",
"assets/assets/login/images/rectangle-23.png": "faae5dcc174dcdeda5c8395b0f2a98f6",
"assets/assets/login/images/rectangle-26.png": "647d39b1fcba0fc98d531bd553b6a027",
"assets/assets/login/images/rectangle-27.png": "50b2625b95cc289ddf6cdb073b5c35ad",
"assets/assets/login/images/rectangle-28-RSB.png": "647d39b1fcba0fc98d531bd553b6a027",
"assets/assets/login/images/rectangle-29-wxX.png": "be1b02b1b076b3e1566d9a158b0f350d",
"assets/assets/login/images/rectangle-29-xxj.png": "4911a61044c7c1d5f4b0bc5f184be82a",
"assets/assets/login/images/rectangle-30.png": "b3f1cb8283ba6d5f6eca72de5934828b",
"assets/assets/login/images/rectangle-31.png": "faae5dcc174dcdeda5c8395b0f2a98f6",
"assets/assets/login/images/rectangle-33.png": "99d57e318919efe6d09da0fd6fe58415",
"assets/assets/login/images/rectangle-38.png": "647d39b1fcba0fc98d531bd553b6a027",
"assets/assets/login/images/rectangle-39.png": "647d39b1fcba0fc98d531bd553b6a027",
"assets/assets/login/images/rectangle-40.png": "4911a61044c7c1d5f4b0bc5f184be82a",
"assets/assets/login/images/rectangle-41.png": "b3f1cb8283ba6d5f6eca72de5934828b",
"assets/assets/login/images/rectangle-57.png": "8cfb57cc60bc96eae6a6c0a1d1195bc6",
"assets/assets/login/images/rectangle-61-JdH.png": "c0db5e58b463111e7925c990ea81579e",
"assets/assets/login/images/rectangle-61.png": "647d39b1fcba0fc98d531bd553b6a027",
"assets/assets/login/images/rectangle-64.png": "634716524c993d2f09350a3024e4ca14",
"assets/assets/login/images/rectangle-65.png": "647d39b1fcba0fc98d531bd553b6a027",
"assets/assets/login/images/rectangle-66.png": "4911a61044c7c1d5f4b0bc5f184be82a",
"assets/assets/login/images/rectangle-67.png": "b3f1cb8283ba6d5f6eca72de5934828b",
"assets/assets/login/images/rectangle-7.png": "de30f6795388dda44a3d3bfc3c0d1bc4",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/fonts/MaterialIcons-Regular.otf": "1efde9bb473687fbc2a7a695afb9158f",
"assets/NOTICES": "eca9d0a696770a321de252bb4c0d39c8",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "42df12e09ecc0d5a4a34a69d7ee44314",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "be0e3b33510f5b7b0cc76cc4d3e50048",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "1a074e8452fe5e0d02b112e22cdcf455",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "d6712a578053450b527d7f4b1802271f",
"/": "d6712a578053450b527d7f4b1802271f",
"main.dart.js": "344ed928e96359209c6c20f4483a602d",
"manifest.json": "c05b280ad02dae7f1580cf6d8709e2f1",
"version.json": "f50f26b7e324c334fd4502106da47f3a"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
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
        // Claim client to enable caching on first launch
        self.clients.claim();
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
      // Claim client to enable caching on first launch
      self.clients.claim();
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
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
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
