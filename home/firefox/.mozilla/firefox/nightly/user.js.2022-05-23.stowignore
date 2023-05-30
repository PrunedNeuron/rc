/*
 * Mozilla Firefox (Nightly)
 * USER PREFERENCES
 */

/*********************
 * SECTION: General *
 *********************/

/** Defaults **/
user_pref("browser.uidensity", 1); // (0=default, 1=compact, 2=touch)
user_pref("browser.search.region", 'US');
user_pref("browser.region.update.region", "US");
user_pref("browser.toolbars.bookmarks.visibility", 'always');
user_pref("browser.startup.homepage", 'https://google.com/?gl=us');



/** Browser behavior **/
user_pref("browser.quitShortcut.disabled", true); // Don't quit on CTRL+Q
user_pref("browser.download.alwaysOpenPanel", false); // DEFAULT: true, since Firefox 98
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("browser.search.context.loadInBackground", true);
user_pref("media.hardwaremediakeys.enabled", false); // fix for duplicate firefox mpris player bug

/*********************
 * SECTION: Security *
 *********************/

/** TRACKING PROTECTION ***/
user_pref("browser.contentblocking.category", "strict");
user_pref("privacy.trackingprotection.emailtracking.enabled", true);
user_pref("urlclassifier.trackingSkipURLs", "*.reddit.com, *.twitter.com, *.twimg.com, *.tiktok.com");
user_pref("urlclassifier.features.socialtracking.skipURLs", "*.instagram.com, *.twitter.com, *.twimg.com");
user_pref("privacy.partition.always_partition_third_party_non_cookie_storage", true);
user_pref("privacy.partition.always_partition_third_party_non_cookie_storage.exempt_sessionstorage", false);
user_pref("browser.uitour.enabled", false);

/** OCSP & CERTS / HPKP ***/
user_pref("security.OCSP.enabled", 0);
user_pref("security.remote_settings.crlite_filters.enabled", true);
user_pref("security.pki.crlite_mode", 2);
user_pref("security.cert_pinning.enforcement_level", 2);

/** SSL / TLS ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("security.tls.enable_0rtt_data", false);

/** ROOT CERTIFICATE ***/
user_pref("security.enterprise_roots.enabled", true);

/** RFP ***/
user_pref("browser.startup.blankWindow", false);
user_pref("browser.display.use_system_colors", false);

/** DISK AVOIDANCE ***/
user_pref("browser.cache.disk.enable", false);
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("browser.sessionstore.privacy_level", 2);
user_pref("browser.pagethumbnails.capturing_disabled", true);

/** SHUTDOWN & SANITIZING ***/
user_pref("privacy.history.custom", true);

/** SPECULATIVE CONNECTIONS ***/
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.places.speculativeConnect.enabled", false);
user_pref("network.prefetch-next", false);
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false);

/** SEARCH / URL BAR ***/
user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
user_pref("browser.urlbar.update2.engineAliasRefresh", true);
user_pref("browser.search.suggest.enabled", true); // Set to FALSE for better security
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", true); // Set to FALSE for better security
user_pref("network.IDN_show_punycode", true);

/** HTTPS-ONLY MODE ***/
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_error_page_user_suggestions", true);

/** DNS-over-HTTPS (DOH) ***/
user_pref("network.dns.skipTRR-when-parental-control-enabled", false);
user_pref("network.trr.custom_uri", "https://127.0.0.1:3000/dns-query");
user_pref("network.trr.uri", "https://127.0.0.1:3000/dns-query");
user_pref("network.trr.mode", 2);
user_pref("network.trr.uri", "https://127.0.0.1:3000/dns-query");

/** ECH ***/
user_pref("network.dns.echconfig.enabled", true)
user_pref("network.dns.use_https_rr_as_altsvc", true)
// user_pref("network.security.esni.enabled", true) // DEPRECATED

/** PROXY / SOCKS / IPv6 ***/
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.file.disable_unc_paths", true);
user_pref("network.gio.supported-protocols", "");

/** PASSWORDS AND AUTOFILL ***/
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.privateBrowsingCapture.enabled", false);
user_pref("signon.autofillForms", false);
user_pref("signon.rememberSignons", false);
user_pref("editor.truncate_user_pastes", false);

/** ADDRESS + CREDIT CARD MANAGER ***/
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.heuristics.enabled", false);
user_pref("browser.formfill.enable", false);

/** MIXED CONTENT + CROSS-SITE ***/
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("pdfjs.enableScripting", false);
user_pref("extensions.postDownloadThirdPartyPrompt", false);
user_pref("permissions.delegation.enabled", false);

/** HEADERS / REFERERS ***/
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

/** CONTAINERS ***/
user_pref("privacy.userContext.ui.enabled", true);

/** WEBRTC ***/
user_pref("media.peerconnection.ice.proxy_only_if_behind_proxy", true);
user_pref("media.peerconnection.ice.default_address_only", true);

/** GOOGLE SAFE BROWSING ***/
user_pref("browser.safebrowsing.malware.enabled", false);
user_pref("browser.safebrowsing.phishing.enabled", false);
user_pref("browser.safebrowsing.downloads.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.blockedURIs.enabled", false);

/** MOZILLA ***/
// user_pref("identity.fxaccounts.enabled", false);
user_pref("browser.tabs.firefox-view", false);
user_pref("dom.push.enabled", false);
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
user_pref("geo.provider.ms-windows-location", false); // WINDOWS
user_pref("geo.provider.use_corelocation", false); // MAC
user_pref("geo.provider.use_gpsd", false); // LINUX
user_pref("geo.provider.use_geoclue", false); // LINUX
user_pref("permissions.manager.defaultsUrl", "");
user_pref("webchannel.allowObject.urlWhitelist", "");

/** TELEMETRY ***/
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("browser.ping-centre.telemetry", false);
user_pref("browser.tabs.crashReporting.sendReport", false);
user_pref("captivedetect.canonicalURL", "");
user_pref("default-browser-agent.enabled", false);
user_pref("network.captive-portal-service.enabled", false);
user_pref("network.connectivity-service.enabled", false);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);

/* Telemetry toolkit */
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);

/* Disallow health reporting and data submission */
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

/* Disable normandy (stats collection) telemetry */
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("beacon.enabled", false);
user_pref("breakpad.reportURL", "");


/*********************
 * SECTION: Speed up *
 *********************/

/** Disable accessibility for memory savings **/
user_pref("accessibility.force_disabled", 1); // DEFAULT: 0

/** Reduce delay when installing addons **/
user_pref("security.dialog_enable_delay", 100);

user_pref("nglayout.initialpaint.delay", 0);
user_pref("nglayout.initialpaint.delay_in_oopif", 0);
user_pref("content.notify.interval", 360000);
user_pref("browser.startup.preXulSkeletonUI", false);

/** GFX **/
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.precache-shaders", true);
user_pref("gfx.webrender.compositor", true);
user_pref("layers.gpu-process.enabled", true);
user_pref("media.hardware-video-decoding.enabled", true);
user_pref("gfx.canvas.accelerated", true);
user_pref("gfx.canvas.accelerated.cache-items", 32768);
user_pref("gfx.canvas.accelerated.cache-size", 4096);
user_pref("gfx.content.skia-font-cache-size", 80);
user_pref("image.cache.size", 10485760);
user_pref("image.mem.decode_bytes_at_a_time", 131072);
user_pref("image.mem.shared.unmap.min_expiration_ms", 120000);
user_pref("media.memory_cache_max_size", 1048576);
user_pref("media.memory_caches_combined_limit_kb", 2560000);
user_pref("media.cache_readahead_limit", 9000);
user_pref("media.cache_resume_threshold", 6000);

/** BROWSER CACHE **/
user_pref("browser.cache.memory.capacity", -1);
user_pref("browser.cache.memory.max_entry_size", 153600);

/** NETWORK **/
user_pref("network.buffer.cache.size", 262144);
user_pref("network.buffer.cache.count", 128);
user_pref("network.dnsCacheEntries", 20000);
user_pref("network.dnsCacheExpiration", 3600);
user_pref("network.dnsCacheExpirationGracePeriod", 240);
user_pref("network.ssl_tokens_cache_capacity", 32768);

/**  EXPERIMENTAL **/
user_pref("layout.css.animation-composition.enabled", true); // Enable CSS Animation Composition
user_pref("browser.startup.homepage.abouthome_cache.enabled", true); // about:home startup cache
user_pref("layout.css.grid-template-masonry-value.enabled", true); // CSS Masonry Layout
user_pref("dom.enable_web_task_scheduling", true); // Prioritized Task Scheduling API

/*************************
 * SECTION: Experimental *
 *************************/

user_pref("image.jxl.enabled", true); // Enable support for JPEG XL

/** Experimental JavaScript **/
user_pref("javascript.options.wasm_gc", true);
user_pref("javascript.options.wasm_function_references", true);
user_pref("javascript.options.experimental.shadow_realms", true);
user_pref("javascript.options.experimental.array_grouping", true);
user_pref("javascript.options.experimental.iterator_helpers", true);
user_pref("javascript.options.experimental.enable_change_array_by_copy", true);
user_pref("javascript.options.experimental.weakrefs.expose_cleanupSome", true);


/**************************
 * SECTION: Smooth Scroll *
 **************************/

user_pref("general.smoothScroll",                                       true); // DEFAULT
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
user_pref("general.smoothScroll.msdPhysics.enabled",                    true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant",  200);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant",      250);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS",         25);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio",      2);
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant",     250);
user_pref("general.smoothScroll.currentVelocityWeighting",              1);
user_pref("general.smoothScroll.stopDecelerationWeighting",             1);

/// adjust multiply factor for mousewheel - or set to false if scrolling is way too fast
user_pref("mousewheel.system_scroll_override.horizontal.factor",         200);//NSS    [200]
user_pref("mousewheel.system_scroll_override.vertical.factor",           200);//NSS    [200]
user_pref("mousewheel.system_scroll_override_on_root_content.enabled",  true);//NSS   [true]
user_pref("mousewheel.system_scroll_override.enabled",                  true);//NSS   [true]

/// adjust pixels at a time count for mousewheel - cant do more than a page at once if <100
user_pref("mousewheel.default.delta_multiplier_x",                       100);//NSS    [100]
user_pref("mousewheel.default.delta_multiplier_y",                       100);//NSS    [100]
user_pref("mousewheel.default.delta_multiplier_z",                       100);//NSS    [100]

/// Overscroll
user_pref("apz.overscroll.enabled", true); // Enables trackpad overscroll

///  this preset will reset couple extra variables for consistency
// user_pref("apz.allow_zooming",                                          true);//NSS   [true]
// user_pref("apz.force_disable_desktop_zooming_scrollbars",              false);//NSS  [false]
// user_pref("apz.paint_skipping.enabled",                                 true);//NSS   [true]
// user_pref("apz.windows.use_direct_manipulation",                        true);//NSS   [true]
// user_pref("dom.event.wheel-deltaMode-lines.always-disabled",           false);//NSS  [false]
// user_pref("general.smoothScroll.durationToIntervalRatio",                200);//NSS    [200]
// user_pref("general.smoothScroll.lines.durationMaxMS",                    150);//NSS    [150]
// user_pref("general.smoothScroll.lines.durationMinMS",                    150);//NSS    [150]
// user_pref("general.smoothScroll.other.durationMaxMS",                    150);//NSS    [150]
// user_pref("general.smoothScroll.other.durationMinMS",                    150);//NSS    [150]
// user_pref("general.smoothScroll.pages.durationMaxMS",                    150);//NSS    [150]
// user_pref("general.smoothScroll.pages.durationMinMS",                    150);//NSS    [150]
// user_pref("general.smoothScroll.pixels.durationMaxMS",                   150);//NSS    [150]
// user_pref("general.smoothScroll.pixels.durationMinMS",                   150);//NSS    [150]
// user_pref("general.smoothScroll.scrollbars.durationMaxMS",               150);//NSS    [150]
// user_pref("general.smoothScroll.scrollbars.durationMinMS",               150);//NSS    [150]
// user_pref("general.smoothScroll.mouseWheel.durationMaxMS",               200);//NSS    [200]
// user_pref("general.smoothScroll.mouseWheel.durationMinMS",                50);//NSS     [50]
// user_pref("layers.async-pan-zoom.enabled",                              true);//NSS   [true]
// user_pref("layout.css.scroll-behavior.spring-constant",                "250");//NSS    [250]
// user_pref("mousewheel.transaction.timeout",                             1500);//NSS   [1500]
// user_pref("mousewheel.acceleration.factor",                               10);//NSS     [10]
// user_pref("mousewheel.acceleration.start",                                -1);//NSS     [-1]
// user_pref("mousewheel.min_line_scroll_amount",                             5);//NSS      [5]
// user_pref("toolkit.scrollbox.horizontalScrollDistance",                    5);//NSS      [5]
// user_pref("toolkit.scrollbox.verticalScrollDistance",                      3);//NSS      [3]
