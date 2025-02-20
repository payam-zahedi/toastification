'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "5d471d5f61c355a43007557b90744327",
"version.json": "765abfddd0dfc95feed49182b233da19",
"index.html": "8e81168c048335e5f501b07f18bc0b04",
"/": "8e81168c048335e5f501b07f18bc0b04",
"main.dart.js": "d5174cf0e5556490ca32e16c762ae734",
"sqlite3.wasm": "fa7637a49a0e434f2a98f9981856d118",
"flutter.js": "4b2350e14c6650ba82871f60906437ea",
"icons/favicon-16x16.png": "c2177fdcfed0c4b3c87d1456f213753d",
"icons/favicon.ico": "e4519f2b852c75f4e04c97c14c4e584f",
"icons/apple-icon.png": "effca59aea8d80791031863ac701f61c",
"icons/apple-icon-144x144.png": "89f3c119b1b430b670a3898ec961cdca",
"icons/android-icon-192x192.png": "589df1faebc62f8bd13933a012a29be1",
"icons/apple-icon-precomposed.png": "effca59aea8d80791031863ac701f61c",
"icons/apple-icon-114x114.png": "0b29890d82d9ee2b24fabd6983e19168",
"icons/ms-icon-310x310.png": "4a5ecd6080a93698c6503486e4692211",
"icons/ms-icon-144x144.png": "89f3c119b1b430b670a3898ec961cdca",
"icons/apple-icon-57x57.png": "4c35c7479179147f44f5c2c3fda1e5a3",
"icons/apple-icon-152x152.png": "f60f673a363d82d8db75df5f954cef6e",
"icons/ms-icon-150x150.png": "b1b70204ece7c1ae3b9eb6ac6d4360e6",
"icons/android-icon-72x72.png": "1b41ef926833226b1c0e967d6b29174e",
"icons/android-icon-96x96.png": "38a84d02fd9833b99aee0784ee8553ef",
"icons/android-icon-36x36.png": "3069231152a72ca4fa634965cc9c4a04",
"icons/apple-icon-180x180.png": "d8f0460ccc9dac5d836a17d8b2e67bf8",
"icons/favicon-96x96.png": "38a84d02fd9833b99aee0784ee8553ef",
"icons/android-icon-48x48.png": "a88bf7ba97878223028eaed1c93e2daf",
"icons/apple-icon-76x76.png": "53cc82116ee3f58227e68f555cdfbbaa",
"icons/apple-icon-60x60.png": "fde0e09b055400f78e8e04e9ddf1eed7",
"icons/android-icon-144x144.png": "89f3c119b1b430b670a3898ec961cdca",
"icons/apple-icon-72x72.png": "1b41ef926833226b1c0e967d6b29174e",
"icons/apple-icon-120x120.png": "cd26dca0c13ceb4dc3d35ab244f213a6",
"icons/favicon-32x32.png": "14d0f24b3062c9b0c1a75e44393aeac5",
"icons/ms-icon-70x70.png": "a13df21697774e7fb355f7e14648a715",
"manifest.json": "18c40e5295a9a6710aaca8f6f3d6b755",
"drift_worker.dart.js": "553fc7ecf77c015fbd55dbe8c3d08b67",
"assets/AssetManifest.json": "2b5657118e8c9623251c02db750db51b",
"assets/NOTICES": "e9c67d5ea625cb8b65ba3cb52d365a27",
"assets/FontManifest.json": "cdb6071e0673e404dcd4f3236b4f4d12",
"assets/AssetManifest.bin.json": "2f091d3e041fcd5e138194dc4c0bcfdb",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "4769f3245a24c1fa9965f113ea85ec2a",
"assets/packages/iconsax_flutter/fonts/FlutterIconsax.ttf": "76bd55cc08e511bb603cc53003b81051",
"assets/packages/flex_color_picker/assets/opacity.png": "49c4f3bcb1b25364bb4c255edcaaf5b2",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "d470823896264f6eae40be08a5697373",
"assets/fonts/PlusJakartaDisplay-Regular.otf": "a81ce9b45769e9a0227e6949a9b4b9c8",
"assets/fonts/PlusJakartaDisplay-Medium.otf": "1f27f846a2a8e5c0b3162e3fb1d78865",
"assets/fonts/MaterialIcons-Regular.otf": "e7069dfd19b331be16bed984668fe080",
"assets/fonts/PlusJakartaDisplay-Bold.otf": "1e5642fdde54004e7ac175ceb48b9a1f",
"assets/assets/img/logo-black.png": "7a16ec0e03fabd3d5e268cf807485292",
"assets/assets/img/logo-img.svg": "7e1092f1a6939fbbc3adfe8d6eafbee4",
"assets/assets/img/header.png": "f4b42583f7da6fc92639c13963a5dc6a",
"assets/assets/img/logo.png": "9787b56968ffe49b4720329f3dede579",
"assets/assets/img/logo-text.svg": "7e95427570ff2cfacc2000b26393c090",
"canvaskit/skwasm.js": "ac0f73826b925320a1e9b0d3fd7da61c",
"canvaskit/skwasm.js.symbols": "96263e00e3c9bd9cd878ead867c04f3c",
"canvaskit/canvaskit.js.symbols": "efc2cd87d1ff6c586b7d4c7083063a40",
"canvaskit/skwasm.wasm": "828c26a0b1cc8eb1adacbdd0c5e8bcfa",
"canvaskit/chromium/canvaskit.js.symbols": "e115ddcfad5f5b98a90e389433606502",
"canvaskit/chromium/canvaskit.js": "b7ba6d908089f706772b2007c37e6da4",
"canvaskit/chromium/canvaskit.wasm": "ea5ab288728f7200f398f60089048b48",
"canvaskit/canvaskit.js": "26eef3024dbc64886b7f48e1b6fb05cf",
"canvaskit/canvaskit.wasm": "e7602c687313cfac5f495c5eac2fb324",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
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
