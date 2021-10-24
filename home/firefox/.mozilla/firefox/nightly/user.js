/*
 * User configuration for firefox nightly
 * Modified: 1/10/2021
 */

/* Graphics */
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.compositor.force-enabled", true);
user_pref("gfx.x11-egl.force-enabled", true);
user_pref("gfx.x11-egl.force-disabled", false);
user_pref("webgl.disabled", false);
user_pref("webgl.force-enabled", true);
user_pref("webgl.msaa-force", true);
//user_pref("layers.acceleration.force-enabled", true);

// Fonts
user_pref("gfx.font_rendering.fontconfig.max_generic_substitutions", 127);
user_pref("font.name-list.emoji", "emoji");

/* Media */
user_pref("media.autoplay.default", 5);
user_pref("media.autoplay.allow-muted", false);
user_pref("media.autoplay.block-webaudio", false);
user_pref("media.autoplay.block-event", true);
user_pref("media.autoplay.blocking_policy", 2);
user_pref("media.autoplay.allow-extension-background-pages", false);
user_pref("media.ffmpeg.vaapi.enabled", true);
user_pref("media.ffmpeg.vaapi-drm-display.enabled", true);
user_pref("media.ffvpx.enabled", false);
user_pref("media.rdd-vpx.enabled", false);
user_pref("media.rdd-process.enabled", false);
user_pref("media.navigator.enabled", false);
user_pref("media.navigator.mediadatadecoder_vpx_enabled", true);
user_pref("media.hardware-video-decoding.force-enabled", true);

/* Behavior */
user_pref("general.autoScroll", true); // Enable middle mouse autoscrolling
user_pref("widget.use-xdg-desktop-portal", true); // Use KDE native file picker
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.quitShortcut.disabled", true); // Don't quit on CTRL+Q
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("layout.word_select.eat_space_to_next_word", true);
user_pref("browser.helperApps.showOpenOptionForPdfJS", true);

/* DOM */
user_pref("dom.ipc.processCount", 4); // DEFAULT: 8
user_pref("dom.event.clipboardevents.enabled", true);
user_pref("dom.event.contextmenu.enabled", false); // Don't allow right click prevention'
user_pref("dom.w3c_touch_events.enabled", 0); // prevents JS context menu from not appearing
user_pref("dom.battery.enabled", false);
user_pref("dom.netinfo.enabled", false); // disable connection info leak
user_pref("dom.telephony.enabled", false);
user_pref("dom.vr.oculus.enabled", false); // facebook-samsung VR off
user_pref("dom.vr.enabled", false);

/* Privacy */
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.sanitize.sanitizeOnShutdown", false);

// Disable OS geolocation
// user_pref("geo.enabled", false);
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_gpsd", false); // [LINUX]

// Disable telemetry
user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.opt-out", true);
user_pref("toolkit.coverage.endpoint.base", "");
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("browser.discovery.enabled", false);
user_pref(
    "breakpad.reportURL",
    "https://crash-stats.mozilla.org/report/index/"
); // Crash reports URL
user_pref("browser.tabs.crashReporting.sendReport", true); // Temporary
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("browser.ping-centre.telemetry", false);
user_pref("beacon.enabled", false);

/* Security */
user_pref("security.tls.version.enable-deprecated", false);
user_pref("security.tls.enable_0rtt_data", false); // disable SSL session tracking
user_pref("security.pki.sha1_enforcement_level", 1); // all SHA1 certs are blocked
user_pref("security.family_safety.mode", 0);
user_pref("security.pki.crlite_mode", 2);
user_pref("security.tls.unrestricted_rc4_fallback", false);
user_pref("security.mixed_content.block_display_content", true);
user_pref("security.insecure_connection_text.enabled", true);
user_pref("security.insecure_connection_text.pbmode.enabled", true);
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);
user_pref("security.ssl.disable_session_identifiers", true);
user_pref("security.tls.enable_0rtt_data", false);
user_pref("security.ssl.enable_false_start", false);

// Disable safebrowsing (sends information to third party upstream servers)
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref(
    "browser.safebrowsing.downloads.remote.block_potentially_unwanted",
    false
);
user_pref("browser.safebrowsing.downloads.remote.block_uncommon", false);
user_pref("browser.safebrowsing.allowOverride", false);

// Extensions
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.available", "off");
user_pref("extensions.formautofill.creditCards.available", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.heuristics.enabled", false);
user_pref("extensions.blocklist.enabled", true);

// Network
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetchFromHTTPS", true);
user_pref("network.dns.disablePrefetch", true);
user_pref("network.predictor.enable-prefetch", false);
user_pref("network.predictor.enabled", false);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.dns.disableIPv6", true);
user_pref("network.IDN_show_punycode", true);
user_pref("network.cookie.cookieBehavior", 4);
user_pref("network.proxy.socks_remote_dns", true);
user_pref("network.auth.subresource-http-auth-allow", 1);
user_pref("network.http.referer.XOriginTrimmingPolicy", 2); // 2=scheme+host+port

// Browser
user_pref("browser.fixup.alternate.enabled", false); // disable domain guessing
user_pref("browser.urlbar.speculativeConnect.enabled", false);
user_pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0);
user_pref("browser.formfill.enable", false); // disable form fill history
user_pref("browser.display.use_system_colors", false);
user_pref("browser.tabs.unloadOnLowMemory", true);
user_pref("browser.cache.memory.capacity", 4096);
user_pref("browser.sessionstore.privacy_level", 2); // 2 = Never store session data
user_pref("browser.sessionstore.interval", 45000); // DEFAULT: 15000 (in ms); save session to disk every 45 seconds.
user_pref("browser.sessionhistory.max_total_viewers", 5); // Keep 5 pages in memory
user_pref("browser.menu.showViewImageInfo", true);
user_pref("browser.menu.showCharacterEncoding", true);
user_pref("browser.display.focus_ring_width", 0);
user_pref("browser.cache.disk.capacity", 45000); // DEFAULT: 256000
user_pref("browser.tabs.loadInBackground", true);
user_pref("browser.safebrowsing.downloads.remote.enabled", false);

/* Other */
user_pref("camera.control.face_detection.enabled", false);
user_pref("javascript.use_us_english_locale", true);
user_pref("offline-apps.allow_by_default", false);
user_pref("intl.accept_languages", "en-US, en");
user_pref("device.sensors.enabled", false);
user_pref("signon.autofillForms", false);
user_pref("browser.search.region", "US");

/* Experimental */
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.dns.use_https_rr_as_altsvc", true);

/* For custom CSS */
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
user_pref("layout.css.backdrop-filter.enabled", true);
user_pref("svg.context-properties.content.enabled", true);
user_pref("mozilla.widget.use-argb-visuals", true);

/* Disable default JSON viewer (use https://addons.mozilla.org/en-US/firefox/addon/jsondiscovery/) */
user_pref("devtools.jsonview.enabled", false);

/* Extensions */
user_pref("extensions.pocket.enabled", false);
