//
/* You may copy+paste this file and use it as it is.
 *
 * If you make changes to your about:config while the program is running, the
 * changes will be overwritten by the user.js when the application restarts.
 *
 * To make lasting changes to preferences, you will have to edit the user.js.
 */

/****************************************************************************
 * Betterfox                                                                *
 * "Ad meliora"                                                             *
 * version: 144                                                             *
 * url: https://github.com/yokoffing/Betterfox                              *
 ****************************************************************************/

/****************************************************************************
 * SECTION: FASTFOX                                                         *
 ****************************************************************************/
/** GENERAL ***/
user_pref("gfx.content.skia-font-cache-size", 32);

/** GFX ***/
user_pref("gfx.canvas.accelerated.cache-items", 32768);
user_pref("gfx.canvas.accelerated.cache-size", 4096);
user_pref("webgl.max-size", 16384);

/** DISK CACHE ***/
user_pref("browser.cache.disk.enable", false);

/** MEMORY CACHE ***/
user_pref("browser.cache.memory.capacity", 131072);
user_pref("browser.cache.memory.max_entry_size", 20480);
user_pref("browser.sessionhistory.max_total_viewers", 4);
user_pref("browser.sessionstore.max_tabs_undo", 10);

/** MEDIA CACHE ***/
user_pref("media.memory_cache_max_size", 262144);
user_pref("media.memory_caches_combined_limit_kb", 1048576);
user_pref("media.cache_readahead_limit", 600);
user_pref("media.cache_resume_threshold", 300);

/** IMAGE CACHE ***/
user_pref("image.cache.size", 10485760);
user_pref("image.mem.decode_bytes_at_a_time", 65536);

/** NETWORK ***/
user_pref("network.http.max-connections", 1800);
user_pref("network.http.max-persistent-connections-per-server", 10);
user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5);
user_pref("network.http.request.max-start-delay", 5);
user_pref("network.http.pacing.requests.enabled", false);
user_pref("network.dnsCacheEntries", 10000);
user_pref("network.dnsCacheExpiration", 3600);
user_pref("network.ssl_tokens_cache_capacity", 10240);

/** SPECULATIVE LOADING ***/
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.places.speculativeConnect.enabled", false);
user_pref("network.prefetch-next", false);
user_pref("network.predictor.enabled", false);

/****************************************************************************
 * SECTION: SECUREFOX                                                       *
 ****************************************************************************/
/** TRACKING PROTECTION ***/
user_pref("browser.contentblocking.category", "strict");
user_pref("privacy.trackingprotection.allow_list.baseline.enabled", true);
user_pref("browser.download.start_downloads_in_tmp_dir", true);
user_pref("browser.helperApps.deleteTempFileOnExit", true);
user_pref("browser.uitour.enabled", false);
user_pref("privacy.globalprivacycontrol.enabled", true);

/** OCSP & CERTS / HPKP ***/
user_pref("security.OCSP.enabled", 0);
user_pref("security.csp.reporting.enabled", false);

/** SSL / TLS ***/
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("browser.xul.error_pages.expert_bad_cert", true);
user_pref("security.tls.enable_0rtt_data", false);

/** DISK AVOIDANCE ***/
user_pref("browser.privatebrowsing.forceMediaMemoryCache", true);
user_pref("browser.sessionstore.interval", 60000);

/** SHUTDOWN & SANITIZING ***/
user_pref("privacy.history.custom", true);
user_pref("browser.privatebrowsing.resetPBM.enabled", true);

/** SEARCH / URL BAR ***/
user_pref("browser.urlbar.trimHttps", true);
user_pref("browser.urlbar.untrimOnUserInteraction.featureGate", true);
user_pref("browser.search.separatePrivateDefault.ui.enabled", true);
user_pref("browser.search.suggest.enabled", false);
user_pref("browser.urlbar.quicksuggest.enabled", false);
user_pref("browser.urlbar.groupLabels.enabled", false);
user_pref("browser.formfill.enable", false);
user_pref("network.IDN_show_punycode", true);

/** PASSWORDS ***/
user_pref("signon.formlessCapture.enabled", false);
user_pref("signon.privateBrowsingCapture.enabled", false);
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("editor.truncate_user_pastes", false);

/** MIXED CONTENT + CROSS-SITE ***/
user_pref("security.mixed_content.block_display_content", true);
user_pref("pdfjs.enableScripting", false);

/** EXTENSIONS ***/
user_pref("extensions.enabledScopes", 5);

/** HEADERS / REFERERS ***/
user_pref("network.http.referer.XOriginTrimmingPolicy", 2);

/** CONTAINERS ***/
user_pref("privacy.userContext.ui.enabled", true);

/** SAFE BROWSING ***/
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

/** MOZILLA ***/
user_pref("permissions.default.desktop-notification", 2);
user_pref("permissions.default.geo", 2);
user_pref("geo.provider.network.url", "https://beacondb.net/v1/geolocate");
user_pref("browser.search.update", false);
user_pref("permissions.manager.defaultsUrl", "");
user_pref("extensions.getAddons.cache.enabled", false);

/** TELEMETRY ***/
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true);
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("datareporting.usage.uploadEnabled", false);

/** EXPERIMENTS ***/
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

/** CRASH REPORTS ***/
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);

/****************************************************************************
 * SECTION: PESKYFOX                                                        *
 ****************************************************************************/
/** MOZILLA UI ***/
user_pref("browser.privatebrowsing.vpnpromourl", "");
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons", false);
user_pref("browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features", false);
user_pref("browser.preferences.moreFromMozilla", false);
user_pref("browser.aboutConfig.showWarning", false);
user_pref("browser.aboutwelcome.enabled", false);
user_pref("browser.profiles.enabled", true);

/** THEME ADJUSTMENTS ***/
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("browser.compactmode.show", true);
user_pref("browser.privateWindowSeparation.enabled", false); // WINDOWS

/** AI ***/
user_pref("browser.ml.enable", false);
user_pref("browser.ml.chat.enabled", false);
user_pref("browser.ml.chat.menu", false);
user_pref("browser.tabs.groups.smart.enabled", false);
user_pref("browser.ml.linkPreview.enabled", false);

/** FULLSCREEN NOTICE ***/
user_pref("full-screen-api.transition-duration.enter", "0 0");
user_pref("full-screen-api.transition-duration.leave", "0 0");
user_pref("full-screen-api.warning.timeout", 0);

/** URL BAR ***/
user_pref("browser.urlbar.trending.featureGate", false);

/** NEW TAB PAGE ***/
user_pref("browser.newtabpage.activity-stream.default.sites", "");
user_pref("browser.newtabpage.activity-stream.showSponsoredTopSites", false);
user_pref("browser.newtabpage.activity-stream.feeds.section.topstories", false);
user_pref("browser.newtabpage.activity-stream.showSponsored", false);
user_pref("browser.newtabpage.activity-stream.showSponsoredCheckboxes", false);

/** DOWNLOADS ***/
user_pref("browser.download.manager.addToRecentDocs", false);

/** PDF ***/
user_pref("browser.download.open_pdf_attachments_inline", true);

/** TAB BEHAVIOR ***/
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.menu.showViewImageInfo", true);
user_pref("findbar.highlightAll", true);
user_pref("layout.word_select.eat_space_to_next_word", false);

/****************************************************************************
 * START: MY OVERRIDES                                                      *
 ****************************************************************************/
// visit https://github.com/yokoffing/Betterfox/wiki/Common-Overrides
// visit https://github.com/yokoffing/Betterfox/wiki/Optional-Hardening
// Enter your personal overrides below this line:

user_pref("browser.startup.homepage", 'https://www.google.com/search?ncr&hl=en&gl=us');
user_pref("browser.uidensity", 1);
user_pref("browser.toolbars.bookmarks.visibility", 'always');
user_pref("general.autoScroll", true);

/* --- */

// This is a curated, state-of-the-art configuration for a modern
// Arch Linux (Wayland/NVIDIA/144Hz) system. It prioritizes
// maximum performance and responsiveness, sometimes at the
// expense of privacy-tweak-induced slowdowns.

// =============================================================================
// == 1. HARDWARE ACCEL (Wayland/NVIDIA/144Hz)
// =============================================================================
// These are the most critical tweaks for your specific hardware.

// Enforce WebRender, the separate compositor, and general layer acceleration
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.compositor", true);
user_pref("layers.acceleration.force-enabled", true);

// Enable VA-API hardware video decoding (requires env vars)
user_pref("media.ffmpeg.vaapi.enabled", true);

// Enable RDD process for video (improves stability)
user_pref("media.rdd-process.enabled", true);

// Force-enable DMABuf for zero-copy texture sharing (Wayland perf win)
user_pref("widget.dmabuf.force-enabled", true);

// CRITICAL for 144Hz + Hyprland: Uncap Firefox's framerate.
// This lets your Wayland compositor (Hyprland) manage vsync perfectly.
// It prevents stutter and ensures a true 144Hz experience.
user_pref("layout.frame_rate", 0);

// =============================================================================
// == 2. BLEEDING-EDGE GPU & RENDERING
// =============================================================================

// Enable persistent shader caching. This uses your fast NVMe drive
// to store compiled shaders, *dramatically* reducing stutter and
// speeding up page rendering on subsequent visits.
user_pref("gfx.webrender.precache-shaders", true);
user_pref("gfx.webrender.program-binary-disk-cache", true);

// Enable the successor to WebGL for next-gen web apps
user_pref("dom.webgpu.enabled", true);
user_pref("gfx.webgpu.force-enabled", true);

// Hardware acceleration for other rendering components
user_pref("gfx.webrender.blob-images", true);
user_pref("gfx.canvas.azure.accelerated", true);
user_pref("svg.context-properties.content.enabled", true);

// Enable the modern JXL image format
user_pref("image.jxl.enabled", true);

// =============================================================================
// == 3. AGGRESSIVE CACHING & PERFORMANCE (Performance > Privacy)
// =============================================================================
// Betterfox disables disk cache for privacy. We re-enable it.
// Your NVMe is *far* faster than re-downloading assets.

// OVERRIDE: Enable the disk cache
user_pref("browser.cache.disk.enable", true);
// OVERRIDE: Set a fixed, large 1GB disk cache
user_pref("browser.cache.disk.smart_size.enabled", false);
user_pref("browser.cache.disk.capacity", 1048576); // 1GB

// OVERRIDE: Set memory cache to auto-tune based on your 16GB RAM
user_pref("browser.cache.memory.capacity", -1);
// Set a large 512MB cache for decoded images
user_pref("image.cache.memory.capacity", 524288); // 512MB

// NEW: Enable compression for the JavaScript Bytecode Cache.
// Uses a bit of CPU to compress/decompress, but results in
// smaller cache files and faster startup. '3' is a balanced default.
user_pref("browser.cache.jsbc_compression_level", 3);

// =============================================================================
// == 4. SPECULATIVE LOADING (Performance > Privacy)
// =============================================================================
// Betterfox disables all link-prediction. We re-enable it.
// This makes navigation feel *significantly* faster.

// OVERRIDE: Re-enable DNS prefetching
user_pref("network.dns.disablePrefetch", false);
user_pref("network.dns.disablePrefetchFromHTTPS", false);
// OVERRIDE: Re-enable link prefetch/prerender
user_pref("network.prefetch-next", true);
// OVERRIDE: Re-enable the network predictor
user_pref("network.predictor.enabled", true);
user_pref("network.predictor.enable-prefetch", true);
// OVERRIDE: Re-enable speculative connections
user_pref("browser.urlbar.speculativeConnect.enabled", true);
user_pref("browser.places.speculativeConnect.enabled", true);

// =============================================================================
// == 5. MODERN WEB PLATFORM (Responsiveness & Compatibility)
// =============================================================================

// NEW: Enable the Prioritized Task Scheduling API.
// This is a major responsiveness win, allowing the browser to
// prioritize user-facing tasks (like scrolling) over background work.
user_pref("dom.enable_web_task_scheduling", true);

// Enable common web design features often disabled by hardening
user_pref("layout.css.backdrop-filter.enabled", true);

// Enable bleeding-edge CSS features (on Nightly)
user_pref("layout.css.anchor-positioning.enabled", true);
user_pref("layout.css.module-scripts.enabled", true);

// Enable modern, secure Sanitizer API
user_pref("dom.security.sanitizer.enabled", true);

// =============================================================================
// == 6. UI RESPONSIVENESS & QOL
// =============================================================================

// NEW: Disable UI animations for an "instant" feel
user_pref("toolkit.cosmeticAnimations.enabled", false);
user_pref("ui.prefersReducedMotion", 1);

// NEW: Load bookmarks and context-menu searches in the background
// This makes the UI feel faster as it doesn't wait for the load.
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("browser.search.context.loadInBackground", true);

// Enable tab unloading (suspending) to save memory
user_pref("browser.tabs.unloadOnLowMemory", true);
user_pref("browser.suspend_inactive_tabs", true);

// NEW: Auto-handle cookie banners
user_pref("cookiebanners.service.mode", 1);
user_pref("cookiebanners.service.mode.privateBrowsing", 1);

// Security: Disable scripts in the built-in PDF viewer
user_pref("pdfjs.enableScripting", false);

// Allow userChrome.css customizations
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// =============================================================================
// == 7. MODERN NETWORKING (Security & Speed)
// =============================================================================

// Enforce HTTP/3 (QUIC) for lower latency
user_pref("network.http.http3.enabled", true);

// NEW: Enforce Encrypted Client Hello (ECH)
// This is a modern privacy feature that hides the server name (SNI)
// during the initial TLS handshake. It's likely default on
// Nightly, but good to enforce.
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.dns.use_https_rr_as_altsvc", true);

// Enforce HTTPS-Only mode
user_pref("dom.security.https_only_mode", true);

// DNS over HTTPS
user_pref("network.trr.mode", 3);
user_pref("network.trr.custom_uri", "https://127.0.0.1:8300/dns-query");
user_pref("network.trr.uri", "https://127.0.0.1:8300/dns-query");


/* COMMON OVERRIDES */
user_pref("browser.newtabpage.activity-stream.showWeather", true);

// PREF: enable container tabs
user_pref("privacy.userContext.enabled", true);


/* --- */

/****************************************************************************
 * SECTION: SMOOTHFOX                                                       *
 ****************************************************************************/
// visit https://github.com/yokoffing/Betterfox/blob/main/Smoothfox.js
// Enter your scrolling overrides below this line:

/****************************************************************************************
 * OPTION: NATURAL SMOOTH SCROLLING V3 [MODIFIED]                                      *
 ****************************************************************************************/
// credit: https://github.com/AveYo/fox/blob/cf56d1194f4e5958169f9cf335cd175daa48d349/Natural%20Smooth%20Scrolling%20for%20user.js
// recommended for 120hz+ displays
// largely matches Chrome flags: Windows Scrolling Personality and Smooth Scrolling
user_pref("apz.overscroll.enabled", true); // DEFAULT NON-LINUX
user_pref("general.smoothScroll", true); // DEFAULT
user_pref("general.smoothScroll.msdPhysics.continuousMotionMaxDeltaMS", 12);
user_pref("general.smoothScroll.msdPhysics.enabled", true);
user_pref("general.smoothScroll.msdPhysics.motionBeginSpringConstant", 600);
user_pref("general.smoothScroll.msdPhysics.regularSpringConstant", 650);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaMS", 25);
user_pref("general.smoothScroll.msdPhysics.slowdownMinDeltaRatio", "2");
user_pref("general.smoothScroll.msdPhysics.slowdownSpringConstant", 250);
user_pref("general.smoothScroll.currentVelocityWeighting", "1");
user_pref("general.smoothScroll.stopDecelerationWeighting", "1");
user_pref("mousewheel.default.delta_multiplier_y", 300); // 250-400; adjust this number to your liking



/****************************************************************************
 * END: BETTERFOX                                                           *
 ****************************************************************************/
