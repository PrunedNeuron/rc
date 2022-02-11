/*
 * User configuration for firefox nightly
 * Modified: 27/11/2021
 */

/* Graphics */
user_pref("gfx.webrender.enabled", true);
user_pref("gfx.webrender.all", true);
user_pref("gfx.webrender.compositor", true);
user_pref("gfx.webrender.compositor.force-enabled", true);

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
user_pref("media.navigator.enabled", false);

/* Behavior */
user_pref("general.autoScroll", true); // Enable middle mouse autoscrolling
user_pref("widget.use-xdg-desktop-portal", true); // Use KDE native file picker
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.quitShortcut.disabled", true); // Don't quit on CTRL+Q
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("layout.word_select.eat_space_to_next_word", false);
user_pref("browser.helperApps.showOpenOptionForPdfJS", true);

/* DOM */
// user_pref("dom.ipc.processCount", 4); // DEFAULT: 8
// user_pref("dom.event.clipboardevents.enabled", false);
// user_pref("dom.event.contextmenu.enabled", true); // Don't allow right click prevention'
// user_pref("dom.w3c_touch_events.enabled", 0); // prevents JS context menu from not appearing
user_pref("dom.battery.enabled", false);
user_pref("dom.netinfo.enabled", false); // disable connection info leak
user_pref("dom.telephony.enabled", false);
user_pref("dom.vr.oculus.enabled", false); // facebook-samsung VR off
user_pref("dom.vr.enabled", false);
user_pref("dom.security.https_only_mode", true);
user_pref("dom.security.https_only_mode_ever_enabled", true);

/* Privacy */
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);

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
user_pref("breakpad.reportURL", "https://crash-stats.mozilla.org/report/index/"); // Crash reports URL
user_pref("browser.tabs.crashReporting.sendReport", true); // Temporary
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");
user_pref("browser.ping-centre.telemetry", false);
user_pref("beacon.enabled", false);

/* Security */
user_pref("security.tls.enable_0rtt_data", false); // disable SSL session tracking
user_pref("security.pki.sha1_enforcement_level", 1); // all SHA1 certs are blocked
user_pref("security.pki.crlite_mode", 2);
user_pref("security.mixed_content.block_display_content", true);
user_pref("security.ssl.enable_false_start", false);

// Extensions
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.available", "off");
user_pref("extensions.formautofill.creditCards.available", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("extensions.formautofill.heuristics.enabled", false);

// Network
user_pref("network.dns.disableIPv6", true);
user_pref("network.IDN_show_punycode", true);

// Browser
user_pref("browser.formfill.enable", false); // disable form fill history
user_pref("browser.tabs.unloadOnLowMemory", true);
user_pref("browser.sessionstore.privacy_level", 2); // 2 = Never store session data
user_pref("browser.menu.showViewImageInfo", true);
user_pref("browser.menu.showCharacterEncoding", true);
user_pref("browser.tabs.loadInBackground", true);
user_pref("browser.toolbars.bookmarks.visibility", "always"); // DEF: 'newtab'
user_pref("browser.download.autohideButton", false); // don't hide download button
user_pref("browser.startup.homepage", "https://google.com/?gl=us"); // Set homepage to Google US

/* Other */
user_pref("camera.control.face_detection.enabled", false);
user_pref("javascript.use_us_english_locale", true);
user_pref("offline-apps.allow_by_default", false);
user_pref("intl.accept_languages", "en-US, en");
user_pref("device.sensors.enabled", false);
user_pref("signon.autofillForms", false);
user_pref("browser.search.region", "US");
user_pref("media.hardwaremediakeys.enabled", false);

/* Extensions */
// user_pref("extensions.webextensions.restrictedDomains", ""); // DEFAULT: "accounts-static.cdn.mozilla.net,accounts.firefox.com,addons.cdn.mozilla.net,addons.mozilla.org,api.accounts.firefox.com,content.cdn.mozilla.net,discovery.addons.mozilla.org,install.mozilla.org,oauth.accounts.firefox.com,profile.accounts.firefox.com,support.mozilla.org,sync.services.mozilla.com"
// user_pref("privacy.resistFingerprinting.block_mozAddonManager", true);

/* Experimental */
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.dns.use_https_rr_as_altsvc", true);

/* Development */
user_pref("xpinstall.signatures.required", false); // allow unverified addons

/* Disable default JSON viewer (use https://addons.mozilla.org/en-US/firefox/addon/jsondiscovery/) */
// user_pref("devtools.jsonview.enabled", false);

/* Custom CSS */


