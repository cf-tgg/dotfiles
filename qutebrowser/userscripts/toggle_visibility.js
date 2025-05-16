/* toggle_visibility --- Client side WebUI toggles
 *
 * Add selectors as they annoy you. 
 *
 *   A small button `[+]' spawns in the right bottom corner to toggle
 * elements of the `toggleable' list; elements in `blacklist' won't
 * come back until you reload the website. Elements in blacklist are
 * to be merged to permanent stylesheet once tested not to break 
 * functionality. Call the script again and the button will disappear.
 * if you don't want the button, just remove it from the script.
 * 
 */

(() => {
    // Utility function to hide elements
    function hideElements(selectors) {
        selectors.forEach(selector => {
            const elements = document.querySelectorAll(selector);
            elements.forEach(element => {
                element.style.display = "none";
            });
        });
    }

    // Utility function to toggle visibility of elements
    function toggleVisibility(selectors) {
        selectors.forEach(selector => {
            const elements = document.querySelectorAll(selector);
            elements.forEach(element => {
                if (!element.dataset.originalDisplay) {
                    const computedStyle = getComputedStyle(element);
                    element.dataset.originalDisplay = computedStyle.display === "none" ? "" : computedStyle.display;
                }
                element.style.display = (element.style.display === "none")
                    ? element.dataset.originalDisplay
                    : "none";
            });
        });
    }

    const blacklist = [
        "::-webkit-scrollbar",
        "::-webkit-scrollbar-thumb",
        "::-webkit-scrollbar-track",
        "#WIX_ADS",
        ".text-token-text-secondary", /* ChatGPT limit warning */
        ".block.z-20",
        "#truste-consent-track",      /* RedHat Cookie Consent */
        ".YtwTopBannerImageTextIconButtonedLayoutViewModelHost",
        ".YtwAdImageViewModelHostImage",
        ".YtwSquareImageViewModelHostImage",
        ".YtwAdImageViewModelHostContainer",
        ".ytp-ad-persistent-progress-bar",
        ".ytp-ad-progress",
        ".ytp-ad-progress-list",
        ".ytd-in-feed-ad-layout-renderer",
        ".ytd-in-feed-ad-slot-renderer",
        ".ytd-watch-next-secondary-results-renderer",
        ".yt-core-image",
        ".frb-nag-link",
        ".RPL9esU9f8nMDBntEfZQ",
        ".a2a_kit",
        ".a2a.a2a_kit_size_36.a2a_floating_style.a2a_default_style",
        ".OINTechPromoRightBarBanner",
        ".widget",
        ".ot-sdk-row",
        "#launcher",                             /* Discogs Chat Button */
        ".ad_container",                         /* discogs overlay crap */
        ".ad_bottom",
        ".ot-floating-button",
        ".sc-1w3tvxe-0",
        "#ot-sdk-btn-floating",
        ".sc-1q9fwvy-0",
        ".cookie-notifications",               /* Cookie notifications */
        ".cookie-bar",
        ".glue-cookie-notification-bar",
        "#sliding-popup",
        ".gnav.CookiePrivacyNoticeBanner",
        ".gHHEeh",
        ".sc-1k07fow-1",
        ".cbnSms",
        ".wvqEb",
        "#CookiePrivacyNotice",
        "#owaadbar1",
        ".StyledButton-sc-qe3ace-0",
        ".js-focus-visible",                     /* RedHat Chat-popup */
        ".drift-widget-controller.drift-widget-controller--align-right.square.drift-widget-controller--custom-icon.drift-widget-controller--avatar",
        ".drift-widget-message-preview-wrapper",
        ".drift-widget-controller-icon.square",
        ".draggable.sticky.top-0",               /* ChatGPT limitcap popup */
        ".draggable.no-draggable-children.sticky.top-0",
        "#nav-ad",
        "#onetrust-banner-sdk",                  /* SuperUser Cookie Banner */
        "#onetrust-consent-sdk",
        ".cc-window",                            /* Dell Cookie Consent */ 
        ".spr-lc-light",                         /* Dell Floating Chat */
        ".CookiePrivacyNotice",
        ".td-header-wrap",
        ".td-scroll-up",
        ".scroll-up-visible",
    ];

    const toggleable = [
        "#vector-page-titlebar-toc-label",      /* Wikipedia TOC sticky widget */
        ".dJnomT",                              /* GitHub README Header */
        ".gOHzTT",                              /* gh issue sticky header */
        "#secondary-nav-component",             /* RedHatSecondary Nav */
        "#partial-discussion-sidebar",
        ".Layout-sidebar",
        ".gh-header-shadow",
        ".js-sticky",
        "span .flex",                           /* GPT prompts */
        ".no-draggable",
        ".relative w-full",
        ".md\\:pt-0",
        ".flex.w-full.items-start",
        ".draggable",
        ".draggable.sticky.top-0",
        ".cursor-pointer.absolute.z-10",
        ".header-main__slider",                  /* GeeksForGeeks */
        ".header-main",
        ".top-banner.fallback",	                 /* MDNs Headers */
        ".sticky-header-container",
        "ytd-masthead",
        ".style-scope.ytd-masthead",
        ".site-header",
        "#secondary",
        "#below",
        "#background",
        "#pagetop",
        "#top",
        "#header",
        "#subtopnav",
        "#right",
        "#spacemyfooter",
        "#sidebar",
        "#archnavbar",                            /* archwiki */
        ".footer",
        ".header",
        "#left-sidebar",
        "#mw-panel",
        "#mw-head",
        "#masthead",
        ".text-token-secondary",
        ".navbar",
        "footer",
        "header",
        ".s-top-bar",
        ".top-bar-container",                     /* GitLab */
        ".l.m.n.o.c",                             /* medium */
        ".p.q.r.s.t.u.v.w.x.i.d.y.z",
        ".p.q.r.ab.ac",
        ".bh.ww.ab.c.q.ic.wx.lq.wy",
    ];
    hideElements(blacklist);
    toggleVisibility(toggleable);
    let toggleButton = document.querySelector(".toggleButton");
    if (toggleButton === null) {
        toggleButton = document.createElement("button");
        toggleButton.innerText = "[+]";
        toggleButton.className = "toggleButton";
        toggleButton.style.position = "fixed";
        toggleButton.style.bottom = "1px";
        toggleButton.style.right = "1px";
        toggleButton.style.zIndex = "9999";
        toggleButton.style.padding = "2px";
        toggleButton.style.backgroundColor = "rgba(0, 0, 0, 0.8)";
        toggleButton.style.color = "#484848";
        toggleButton.style.border = "none";
        toggleButton.style.borderRadius = "5px";
        toggleButton.style.cursor = "pointer";
        toggleButton.draggable = "both";

        toggleButton.addEventListener("click", () => {
            toggleVisibility(toggleable);
            if (toggleButton.innerText == "[+]") {
               toggleButton.innerText = "[-]";
            } else {
                toggleButton.innerText = "[+]";
            }
        });
        document.body.appendChild(toggleButton);
    } else {
        toggleButton.remove();
    }

    let isDragging = false;
    let offsetX, offsetY;

    toggleButton.addEventListener('mousedown', (e) => {
        isDragging = true;
        offsetX = e.clientX - toggleButton.getBoundingClientRect().left;
        offsetY = e.clientY - toggleButton.getBoundingClientRect().top;
        e.preventDefault();
    });

    document.addEventListener('mousemove', (e) => {
        if (isDragging) {
            toggleButton.style.left = `${e.clientX - offsetX}px`;
            toggleButton.style.top = `${e.clientY - offsetY}px`;
            toggleButton.style.bottom = 'auto';
            toggleButton.style.right = 'auto';
        }
    });

    document.addEventListener('mouseup', () => { isDragging = false; });

})();
