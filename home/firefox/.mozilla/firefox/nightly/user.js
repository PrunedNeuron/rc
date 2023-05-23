/*
 * Mozilla Firefox (Nightly)
 * USER PREFERENCES
 */

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

/** Cookies **/
user_pref("cookiebanners.service.mode", 1) // DEFAULT: 0
