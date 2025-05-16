/* toggle_visibility */
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
        ".ytp-ad-avatar-lockup-card",
        ".ytp-ad-component",
        /* ".video-ads", */
        ".ytp-ad-image-overlay",
        /* ".ytp-ad-module", */
        /* ".ytp-ad-overlay-container", */
        /* ".ytp-ad-persistent-progress-bar", */
        ".ytp-ad-text-overlay",
        ".ytp-ad-title",
        /* ".ytp-ad-video-overlay", */
        "::-webkit-scrollbar",
        "::-webkit-scrollbar-thumb",
        "::-webkit-scrollbar-track",
        "#WIX_ADS",
        ".text-token-text-secondary", /* ChatGPT limit warning */
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
        "#launcher",                     /* Discogs Chat Button */
        ".ad_container",                 /* discogs overlay crap */
        ".ad_bottom",
        ".ot-floating-button",
        ".sc-1w3tvxe-0",
        "#ot-sdk-btn-floating",
        ".sc-1q9fwvy-0",
        ".gHHEeh",
        ".sc-1k07fow-1",
        ".cbnSms",
        ".StyledButton-sc-qe3ace-0",
        ".draggable.sticky.top-0",        /* ChatGPT limitcap popup */
        ".draggable.no-draggable-children.sticky.top-0",
    ];

    const toggleable = [
        "#vector-page-titlebar-toc-label",      /* Wikipedia TOC sticky widget */
        ".dJnomT",                              /* GitHub README Header */
        "#partial-discussion-sidebar",
        ".Layout-sidebar",
        ".gh-header-shadow",
        ".js-sticky",
        "span .flex",                           /* GPT prompt */
        ".no-draggable",
        ".relative w-full",
        ".md\\:pt-0",
        ".flex.w-full.items-start",
        ".draggable",
        ".draggable.sticky.top-0",
        ".cursor-pointer.absolute.z-10",
        ".header-main__slider",                  /* GeeksForGeeks */
        ".top-banner.fallback",	                 /* MDNs Headers */
        ".sticky-header-container",
        ".header-main",
        "ytd-masthead",
        ".style-scope.ytd-masthead",
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
        "footer",
        ".top-bar-container",
        "header",
        "#left-sidebar",
        "#mw-panel",
        "#mw-head",
        ".l.m.n.o.c",                             /* medium */
        ".p.q.r.s.t.u.v.w.x.i.d.y.z",
        ".p.q.r.ab.ac",
        ".bh.ww.ab.c.q.ic.wx.lq.wy",
    ];
    hideElements(blacklist);
    toggleVisibility(toggleable);
    const RemoveButton = document.querySelector(".toggleButton").remove();
    if (document.querySelector(".toggleButton") === null) {
        const toggleButton = document.createElement("button");
        toggleButton.innerText = ".";
        toggleButton.className = "toggleButton";
        toggleButton.style.position = "fixed";
        toggleButton.style.bottom = "10px";
        toggleButton.style.right = "10px";
        toggleButton.style.zIndex = "9999";
        toggleButton.style.padding = "10px";
        toggleButton.style.backgroundColor = "rgba(0, 0, 0, 0.8)";
        toggleButton.style.color = "#fff";
        toggleButton.style.border = "none";
        toggleButton.style.borderRadius = "5px";
        toggleButton.style.cursor = "pointer";
        toggleButton.draggable = "both";

        toggleButton.addEventListener("click", () => {
            toggleVisibility(toggleable);
        });
        document.body.appendChild(toggleButton);
    } else { RemoveButton(); }

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
