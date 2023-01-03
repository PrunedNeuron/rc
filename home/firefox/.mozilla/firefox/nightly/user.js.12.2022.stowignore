/*
 * user.js
 * Firefox user configuration
 *
 */

/*
 * ********
 * Behavior
 * ********
 */

/* General */
user_pref("general.autoScroll", true);
user_pref("browser.quitShortcut.disabled", true); // Don't quit on CTRL+Q
user_pref("browser.shell.checkDefaultBrowser", false);
user_pref("browser.bookmarks.openInTabClosesMenu", false);
user_pref("browser.tabs.loadBookmarksInBackground", true);
user_pref("browser.search.context.loadInBackground", true);
user_pref("browser.toolbars.bookmarks.visibility", 'always');
user_pref("security.dialog_enable_delay", 100); // Reduce delay when installing add-ons
user_pref("browser.download.alwaysOpenPanel", false); // DEFAULT: true, since Firefox 98
user_pref("browser.region.update.region", "US");


/* Disable crash report submission */
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit", false);
user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false);
user_pref("browser.crashReports.unsubmittedCheck.enabled", false);


/* Use Google US */
user_pref("browser.startup.homepage", 'https://google.com/?gl=us');
user_pref("browser.search.region", 'US');

/* Disable sponsored quick suggestions */
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false); // DEFAULT: true

/* Enable offline (Disk) cache */
// user_pref("browser.cache.offline.enable", true); // DEFAULT: false

/*
 * ********
 * Graphics
 * ********
 */

/* WebGPU */
// user_pref("dom.webgpu.enabled", true); // DEFAULT: false
// user_pref("gfx.webgpu.force-enabled", true); // DEFAULT: false

/* Display density */
user_pref("browser.uidensity", 1); // (0=default, 1=compact, 2=touch)

/* Enable JPEG XL */
user_pref("image.jxl.enabled", true);


/*
 * *****
 * Media
 * *****
 */

user_pref("media.hardwaremediakeys.enabled", false); // fix for duplicate firefox mpris player bug
user_pref("media.hardware-video-decoding.force-enabled", true); // Force enable HW video decode

/*
 * *******   ********
 * Privacy & Security
 * *******   ********
 */

/* Privacy */
user_pref("privacy.donottrackheader.enabled", true);
user_pref("privacy.donottrackheader.value", 1);

/* Tracking */
user_pref("privacy.trackingprotection.enabled", true); // DEFAULT: false
user_pref("privacy.trackingprotection.socialtracking.enabled", true); // DEFAULT: false
user_pref("privacy.trackingprotection.cryptomining.enabled", true);
user_pref("privacy.trackingprotection.fingerprinting.enabled", true);
user_pref("privacy.trackingprotection.pbmode.enabled", true);
// user_pref("browser.contentblocking.category", "strict"); // DEFAULT: standard

/* Disallow sensor data */
user_pref("device.sensors.ambientLight.enabled", false);
user_pref("device.sensors.enabled", false);
user_pref("device.sensors.motion.enabled", false);
user_pref("device.sensors.orientation.enabled", false);
user_pref("device.sensors.proximity.enabled", false);
user_pref("geo.enabled", false);

/* Prevent clipboard modification */
user_pref("dom.event.clipboardevents.enabled", false);

/* Prevent WebRTC LAN IP detection */
user_pref("media.peerconnection.ice.default_address_only", true);
user_pref("media.peerconnection.enabled", false);

/*
 * **********
 * Networking
 * **********
 */

/* Disable IPv6 */
user_pref("network.dns.disableIPv6", true); // DEFAULT: false

/* Disable captive portal check */
user_pref("network.captive-portal-service.enabled", false);

/* Disable offline DNS lookup */
// user_pref("network.dns.offline-localhost", false);

/*
 * *********
 * Telemetry
 * *********
 */

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

/* Disable addon related telemetry and cache */
// user_pref("extensions.getAddons.cache.enabled", false);
user_pref("extensions.getAddons.showPane", false);
user_pref("extensions.shield-recipe-client.api_url", "");
user_pref("extensions.shield-recipe-client.enabled", false);
user_pref("extensions.webservice.discoverURL", "");

/* Disable normandy (stats collection) telemetry */
user_pref("app.normandy.api_url", "");
user_pref("app.normandy.enabled", false);
user_pref("app.shield.optoutstudies.enabled", false);
user_pref("beacon.enabled", false);
user_pref("breakpad.reportURL", "");


/*
 * *************
 * Accessibility
 * *************
 */

/* Disable accessibility for memory savings */
user_pref("accessibility.force_disabled", 1); // DEFAULT: 0


/*
 * ************
 * Experimental
 * ************
 */

/* Enable experimental IndexedDB features */
user_pref("dom.indexedDB.experimental", true); // DEFAULT: false



// imgur workaround
user_pref("layout.css.resizeobserver.enabled", true);



/* Other */

// user_pref("browser.disableResetPrompt", true);
// user_pref("browser.newtab.preload", false);
// user_pref("browser.newtabpage.enabled", false);
// user_pref("browser.newtabpage.enhanced", false);
// user_pref("browser.newtabpage.introShown", true);
//
// user_pref("browser.safebrowsing.appRepURL", "");
// user_pref("browser.safebrowsing.blockedURIs.enabled", false);
// user_pref("browser.safebrowsing.downloads.enabled", false);
// user_pref("browser.safebrowsing.downloads.remote.enabled", false);
// user_pref("browser.safebrowsing.downloads.remote.url", "");
// user_pref("browser.safebrowsing.enabled", false);
// user_pref("browser.safebrowsing.malware.enabled", false);
// user_pref("browser.safebrowsing.phishing.enabled", false);
// user_pref("browser.selfsupport.url", "");
// user_pref("browser.send_pings", false);
// user_pref("browser.sessionstore.privacy_level", 2);
// user_pref("browser.shell.checkDefaultBrowser", false);
// user_pref("browser.startup.homepage_override.mstone", "ignore");
// user_pref("browser.tabs.crashReporting.sendReport", false);
// user_pref("browser.toolbarbuttons.introduced.pocket-button", true);
// user_pref("browser.urlbar.groupLabels.enabled", false);
// user_pref("browser.urlbar.quicksuggest.enabled", false);
// user_pref("browser.urlbar.speculativeConnect.enabled", false);
// user_pref("browser.urlbar.trimURLs", false);
// user_pref("datareporting.healthreport.service.enabled", false);
// user_pref("datareporting.healthreport.uploadEnabled", false);
// user_pref("datareporting.policy.dataSubmissionEnabled", false);
// user_pref("device.sensors.ambientLight.enabled", false);
// user_pref("device.sensors.enabled", false);
// user_pref("dom.webaudio.enabled", false);
// user_pref("experiments.activeExperiment", false);
// user_pref("experiments.enabled", false);
// user_pref("experiments.manifest.uri", "");
// user_pref("experiments.supported", false);
//
// user_pref("extensions.blocklist.enabled", false);
// user_pref("extensions.getAddons.cache.enabled", false);
// user_pref("extensions.getAddons.showPane", false);
// user_pref("extensions.greasemonkey.stats.optedin", false);
// user_pref("extensions.greasemonkey.stats.url", "");
// user_pref("extensions.shield-recipe-client.api_url", "");
// user_pref("extensions.shield-recipe-client.enabled", false);
// user_pref("extensions.webservice.discoverURL", "");
//
// user_pref("media.eme.enabled", false);
// user_pref("media.navigator.enabled", false);
// user_pref("media.peerconnection.enabled", false);
// user_pref("media.video_stats.enabled", false);
user_pref("network.IDN_show_punycode", true);
user_pref("network.allow-experiments", false);
user_pref("network.captive-portal-service.enabled", false);
// user_pref("network.cookie.cookieBehavior", 5);
// user_pref("network.dns.disablePrefetch", true);
// user_pref("network.dns.disablePrefetchFromHTTPS", true);
// user_pref("network.http.referer.spoofSource", true);
// user_pref("network.http.speculative-parallel-limit", 0);
// user_pref("network.predictor.enable-prefetch", false);
// user_pref("network.predictor.enabled", false);
// user_pref("network.prefetch-next", false);
// user_pref("network.trr.mode", 5);
// user_pref("privacy.query_stripping", true);
// user_pref("privacy.usercontext.about_newtab_segregation.enabled", true);
// user_pref("security.ssl.disable_session_identifiers", true);
// user_pref("services.sync.prefs.sync.browser.newtabpage.activity-stream.showSponsoredTopSite", false);
// user_pref("signon.autofillForms", false);
// user_pref("webgl.disabled", true);
// user_pref("webgl.renderer-string-override", " ");
// user_pref("webgl.vendor-string-override", " ");
