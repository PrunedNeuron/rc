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
user_pref("general.autoScroll", true);
user_pref("browser.quitShortcut.disabled", true); // Don't quit on CTRL+Q
user_pref("browser.download.alwaysOpenPanel", false); // DEFAULT: true, since Firefox 98
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("browser.search.context.loadInBackground", true);
user_pref("media.hardwaremediakeys.enabled", false); // fix for duplicate firefox mpris player bug
user_pref("security.dialog_enable_delay", 100); // Reduce delay when installing add-ons

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


/** Enable JPEG XL **/
user_pref("image.jxl.enabled", true);

/* Disable accessibility for memory savings */
user_pref("accessibility.force_disabled", 1); // DEFAULT: 0


/**********************
 * SECTION: Telemetry *
 **********************/

/* Telemetry toolkit */
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.bhrPing.enabled", false);
user_pref("toolkit.telemetry.cachedClientID", "");
user_pref("toolkit.telemetry.enabled", false);
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false);
user_pref("toolkit.telemetry.hybridContent.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false);
user_pref("toolkit.telemetry.prompted", 2);
user_pref("toolkit.telemetry.rejected", true);
user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
user_pref("toolkit.telemetry.server", "");
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.unifiedIsOptIn", false);
user_pref("toolkit.telemetry.updatePing.enabled", false);

/* Disallow health reporting and data submission */
user_pref("datareporting.healthreport.service.enabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.policy.dataSubmissionEnabled", false);

/* Disable crash report submission */
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);

/* Disable normandy (stats collection) telemetry */
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("beacon.enabled", false);
user_pref("breakpad.reportURL", "");

/* Disable sponsored quick suggestions */
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false); // DEFAULT: true

/*************************
 * SECTION: Experimental *
 *************************/

/* Enable experimental IndexedDB features */
user_pref("dom.indexedDB.experimental", true); // DEFAULT: false
