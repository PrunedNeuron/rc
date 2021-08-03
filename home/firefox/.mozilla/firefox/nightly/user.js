/*
 * User configuration for firefox nightly
 * Modified: 03/08/2021
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
user_pref("media.autoplay.default", 0);
user_pref("media.autoplay.allow-muted", false);
user_pref("media.autoplay.block-webaudio", false);
user_pref("media.autoplay.blocking_policy", 2);


/* Behavior */
user_pref("general.autoScroll", true); // Enable middle mouse autoscrolling
user_pref("widget.use-xdg-desktop-portal", true); // Use KDE native file picker
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.quitShortcut.disabled", true); // Don't quit on CTRL+Q
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("layout.word_select.eat_space_to_next_word", true);


/* Privacy */
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.trackingprotection.enabled", true);
user_pref("privacy.trackingprotection.socialtracking.enabled", true);
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);

// Disable OS geolocation
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
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false);
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
user_pref("security.mixed_content.block_display_content", true);
user_pref("security.insecure_connection_text.enabled", true);
user_pref("security.insecure_connection_text.pbmode.enabled", true);
user_pref("security.ssl.treat_unsafe_negotiation_as_broken", true);

// Disable safebrowsing (sends information to third party upstream servers)
user_pref("browser.safebrowsing.downloads.remote.enabled", false);
user_pref("browser.safebrowsing.downloads.remote.url", "");
user_pref("browser.safebrowsing.downloads.remote.block_potentially_unwanted", false);
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
user_pref("network.dns.disablePrefetch", true);
user_pref("network.predictor.enabled", false);
user_pref("network.http.speculative-parallel-limit", 0);
user_pref("network.dns.disableIPv6", true);
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


/* Other */
user_pref("signon.autofillForms", false);
user_pref("browser.search.region", "US");
user_pref("intl.accept_languages", "en-US, en");
user_pref("javascript.use_us_english_locale", true);

// PDF.js


/* Experimental */
user_pref("network.dns.echconfig.enabled", true);
user_pref("network.dns.use_https_rr_as_altsvc", true);
