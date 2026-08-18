---
---
(function () {
  const pages = [
    { path: "{{ '/presentation/' | relative_url }}", title: "Workshop Overview" },
    { path: "{{ '/components/' | relative_url }}", title: "Core Components" },
    { path: "{{ '/workflow/' | relative_url }}", title: "Typical Terraform workflow" },
    { path: "{{ '/language/' | relative_url }}", title: "Configuration Language" },
    { path: "{{ '/handson/1' | relative_url }}", title: "Trainer demo: First apply" },
    { path: "{{ '/handson/2' | relative_url }}", title: "HandsOn: Cloud Storage" },
    { path: "{{ '/dependencies/' | relative_url }}", title: "Dependencies" },
    { path: "{{ '/handson/3' | relative_url }}", title: "HandsOn: Cloud Storage with upload" },
    { path: "{{ '/modules/' | relative_url }}", title: "Modules" },
    { path: "{{ '/handson/4' | relative_url }}", title: "HandsOn: Modules" },
    { path: "{{ '/best-practices/' | relative_url }}", title: "Best Practices" },
    { path: "{{ '/next/' | relative_url }}", title: "What's next" }
  ];

  function normalize(path) {
    return path.replace(/index\.html$/, "").replace(/\/$/, "") || "/";
  }

  function buildPresentationPath(path, useSections, hash) {
    const url = new URL(path, window.location.origin);
    url.searchParams.set("presentation", "1");

    if (useSections) {
      url.searchParams.set("sections", "1");
    } else {
      url.searchParams.delete("sections");
    }

    return url.pathname + url.search + (hash || "");
  }

  function currentPathWithoutQuery() {
    return normalize(window.location.pathname);
  }

  function withoutPresentationParam() {
    const url = new URL(window.location.href);
    url.searchParams.delete("presentation");
    url.searchParams.delete("sections");
    const search = url.searchParams.toString();
    return url.pathname + (search ? "?" + search : "") + url.hash;
  }

  function shouldHandleKeys(event) {
    const tagName = event.target && event.target.tagName ? event.target.tagName.toLowerCase() : "";
    return !event.metaKey && !event.ctrlKey && !event.altKey && !["input", "textarea", "select"].includes(tagName);
  }

  const params = new URLSearchParams(window.location.search);
  if (params.get("presentation") !== "1") {
    return;
  }

  const sectionMode = params.get("sections") === "1";

  const currentPath = currentPathWithoutQuery();
  const currentIndex = pages.findIndex(function (page) {
    return normalize(page.path) === currentPath;
  });

  const toolbar = document.createElement("div");
  toolbar.className = "presentation-toolbar";

  document.body.classList.add("presentation-mode");
  if (sectionMode) {
    document.body.classList.add("presentation-mode--sections");
  }

  const logo = document.createElement("img");
  logo.className = "presentation-logo";
  logo.src = "{{ '/assets/images/Synvert Logo_GL_02.png' | relative_url }}";
  logo.alt = "synvert — a GlobalLogic company";
  document.body.appendChild(logo);

  const previousPage = currentIndex > 0 ? pages[currentIndex - 1] : null;
  const currentPage = currentIndex >= 0 ? pages[currentIndex] : null;
  const nextPage = currentIndex >= 0 && currentIndex < pages.length - 1 ? pages[currentIndex + 1] : null;

  function parseRequestedSlide(count) {
    const hash = window.location.hash.replace(/^#/, "");
    if (!hash) {
      return 0;
    }

    if (hash === "slide-last") {
      return Math.max(count - 1, 0);
    }

    const match = hash.match(/^slide-(\d+)$/);
    if (!match) {
      return 0;
    }

    const index = Number(match[1]);
    if (Number.isNaN(index)) {
      return 0;
    }

    return Math.min(Math.max(index, 0), Math.max(count - 1, 0));
  }

  function createSectionSlides() {
    if (!sectionMode || !currentPage || currentPage.path === pages[0].path) {
      return null;
    }

    const mainContent = document.querySelector(".main-content");
    if (!mainContent) {
      return null;
    }

    const children = Array.from(mainContent.children);
    if (children.length === 0) {
      return null;
    }

    const wrapper = document.createElement("div");
    wrapper.className = "presentation-slides";

    const slides = [];
    let currentSlide = null;
    let currentSectionTitle = currentPage.title || document.title || "Introduction";
    let currentSubsectionTitle = "";
    let currentSlideBodyNodes = 0;

    const titleSlide = document.createElement("section");
    titleSlide.className = "presentation-slide presentation-slide--title";
    titleSlide.dataset.title = currentPage.title || document.title || "Chapter";
    const titleHeading = document.createElement("h1");
    titleHeading.className = "presentation-slide__chapter-title";
    titleHeading.textContent = titleSlide.dataset.title;
    titleSlide.appendChild(titleHeading);
    wrapper.appendChild(titleSlide);
    slides.push(titleSlide);

    function composedTitle(baseTitle, detailTitle, continuation) {
      let title = baseTitle || currentPage.title || "Section";

      if (detailTitle) {
        title += " · " + detailTitle;
      }

      if (continuation) {
        title += " (cont.)";
      }

      return title;
    }

    function contextLabel(sectionTitle, subTitle) {
      if (subTitle && sectionTitle && subTitle !== sectionTitle) {
        return sectionTitle + " · " + subTitle;
      }
      return subTitle || sectionTitle;
    }

    function isSlideBreak(node) {
      return !!(node && node.classList && node.classList.contains("slide-break"));
    }

    function isCommandMarker(node) {
      if (!node || !node.tagName || node.tagName.toLowerCase() !== "p") {
        return false;
      }

      const firstElement = node.firstElementChild;
      if (!firstElement || firstElement.tagName.toLowerCase() !== "strong") {
        return false;
      }

      if (node.children.length !== 1) {
        return false;
      }

      const marker = firstElement.textContent.trim();
      return marker.length > 0 && marker === node.textContent.trim();
    }

    function commandMarkerTitle(node) {
      const firstElement = node && node.firstElementChild;
      return firstElement ? firstElement.textContent.trim() : "Details";
    }

    function startSlide(title, sectionLabel) {
      const slide = document.createElement("section");
      slide.className = "presentation-slide";
      slide.dataset.title = title;

      if (sectionLabel) {
        const context = document.createElement("p");
        context.className = "presentation-slide__context";
        context.textContent = sectionLabel;
        slide.appendChild(context);
      }

      wrapper.appendChild(slide);
      slides.push(slide);
      currentSlide = slide;
      currentSlideBodyNodes = 0;
    }

    children.forEach(function (node) {
      const tagName = node.tagName ? node.tagName.toLowerCase() : "";

      if (isSlideBreak(node)) {
        if (currentSlide && currentSlideBodyNodes > 0) {
          startSlide(composedTitle(currentSectionTitle, currentSubsectionTitle, true), contextLabel(currentSectionTitle, currentSubsectionTitle));
        }
        return;
      } else if (tagName === "h2") {
        currentSectionTitle = node.textContent.trim() || "Section";
        currentSubsectionTitle = "";
        startSlide(currentSectionTitle, currentSectionTitle);
      } else if (tagName === "h3") {
        currentSubsectionTitle = node.textContent.trim() || "Details";
        startSlide(composedTitle(currentSectionTitle, currentSubsectionTitle, false), contextLabel(currentSectionTitle, currentSubsectionTitle));
      } else if (isCommandMarker(node)) {
        const commandTitle = commandMarkerTitle(node);
        startSlide(composedTitle(currentSectionTitle, commandTitle, false), contextLabel(currentSectionTitle, commandTitle));
        currentSubsectionTitle = commandTitle;
        return;
      }

      if (!currentSlide) {
        startSlide(currentPage.title || document.title || "Introduction", currentSectionTitle);
      }

      currentSlide.appendChild(node);

      if (tagName !== "h2" && tagName !== "h3") {
        currentSlideBodyNodes += 1;
      }
    });

    const nonEmptySlides = slides.filter(function (slide) {
      if (slide.classList.contains("presentation-slide--title")) {
        return true;
      }
      const meaningfulNodes = Array.from(slide.children).filter(function (child) {
        if (!child.tagName) {
          return false;
        }

        const tag = child.tagName.toLowerCase();
        if (tag === "h1" || tag === "h2" || tag === "h3") {
          return false;
        }

        if (child.classList && child.classList.contains("presentation-slide__context")) {
          return false;
        }

        if (tag === "hr") {
          return false;
        }

        const text = (child.textContent || "").trim();
        const hasMedia = !!child.querySelector("img, pre, code, table, ul, ol, blockquote");
        return hasMedia || text.length > 0;
      });

      return meaningfulNodes.length > 0;
    });

    slides.forEach(function (slide) {
      if (!nonEmptySlides.includes(slide)) {
        slide.remove();
      }
    });

    if (nonEmptySlides.length === 0) {
      return null;
    }

    mainContent.innerHTML = "";
    mainContent.appendChild(wrapper);

    const slideState = {
      slides: nonEmptySlides,
      index: 0,
      set: function (nextIndex) {
        this.index = Math.min(Math.max(nextIndex, 0), this.slides.length - 1);

        this.slides.forEach(function (slide, slideIndex) {
          slide.classList.toggle("is-active", slideIndex === slideState.index);
        });

        const url = new URL(window.location.href);
        url.hash = "slide-" + this.index;
        history.replaceState(null, "", url.pathname + url.search + url.hash);
        if (toolbar.isConnected) {
          renderToolbar();
        }
      },
      title: function () {
        return this.slides[this.index].dataset.title || currentPage.title;
      },
      count: function () {
        return this.slides.length;
      }
    };

    slideState.set(parseRequestedSlide(slides.length));
    return slideState;
  }

  const slideState = createSectionSlides();

  function navigationTargets() {
    if (slideState && slideState.count() > 1) {
      const previousSlideHref = slideState.index > 0
        ? buildPresentationPath(currentPage.path, true, "#slide-" + (slideState.index - 1))
        : previousPage
          ? buildPresentationPath(previousPage.path, true, "#slide-last")
          : null;

      const nextSlideHref = slideState.index < slideState.count() - 1
        ? buildPresentationPath(currentPage.path, true, "#slide-" + (slideState.index + 1))
        : nextPage
          ? buildPresentationPath(nextPage.path, true, "#slide-0")
          : null;

      return {
        previousLabel: "Previous section",
        previousHref: previousSlideHref,
        nextLabel: "Next section",
        nextHref: nextSlideHref
      };
    }

    return {
      previousLabel: "Previous chapter",
      previousHref: previousPage ? buildPresentationPath(previousPage.path, sectionMode, sectionMode ? "#slide-last" : "") : null,
      nextLabel: "Next chapter",
      nextHref: nextPage ? buildPresentationPath(nextPage.path, sectionMode, sectionMode ? "#slide-0" : "") : null
    };
  }

  function toolbarMarkup() {
    const targets = navigationTargets();
    const toggleHref = currentPage && currentPage.path !== pages[0].path
      ? buildPresentationPath(currentPage.path, !sectionMode)
      : null;
    const toggleLabel = sectionMode ? "Chapter view" : "Section slides";
    const title = slideState
      ? currentPage.title + " · " + slideState.title()
      : currentPage
        ? currentPage.title
        : "Presentation";
    const progress = slideState
      ? "Slide " + (slideState.index + 1) + " / " + slideState.count() + " · Chapter " + (currentIndex + 1) + " / " + pages.length
      : currentPage
        ? "Chapter " + (currentIndex + 1) + " / " + pages.length
        : "";

    const safeTitle = title
      ? String(title).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
      : "";
    const safeProgress = progress
      ? String(progress).replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;")
      : "";

    return [
      '<div class="presentation-toolbar__group">',
      '  <a class="presentation-toolbar__link" href="' + buildPresentationPath(pages[0].path, false) + '">Overview</a>',
      targets.previousHref ? '  <a class="presentation-toolbar__link" href="' + targets.previousHref + '">' + targets.previousLabel + '</a>' : '',
      targets.nextHref ? '  <a class="presentation-toolbar__link presentation-toolbar__link--primary" href="' + targets.nextHref + '">' + targets.nextLabel + '</a>' : '',
      '</div>',
      '<div class="presentation-toolbar__status">',
      safeTitle ? '  <span class="presentation-toolbar__title">' + safeTitle + '</span>' : '',
      safeProgress ? '  <span class="presentation-toolbar__progress">' + safeProgress + '</span>' : '',
      '</div>',
      '<div class="presentation-toolbar__group">',
      toggleHref ? '  <a class="presentation-toolbar__link" href="' + toggleHref + '">' + toggleLabel + '</a>' : '',
      '  <a class="presentation-toolbar__link" href="' + withoutPresentationParam() + '">Open docs view</a>',
      '</div>'
    ].join("");
  }

  function renderToolbar() {
    toolbar.innerHTML = toolbarMarkup();
  }

  renderToolbar();

  document.body.appendChild(toolbar);

  document.addEventListener("keydown", function (event) {
    if (!shouldHandleKeys(event)) {
      return;
    }

    const targets = navigationTargets();

    if (event.key === "ArrowRight" && targets.nextHref) {
      event.preventDefault();
      if (slideState && slideState.index < slideState.count() - 1) {
        slideState.set(slideState.index + 1);
      } else {
        window.location.href = targets.nextHref;
      }
    }

    if (event.key === "ArrowLeft" && targets.previousHref) {
      event.preventDefault();
      if (slideState && slideState.index > 0) {
        slideState.set(slideState.index - 1);
      } else {
        window.location.href = targets.previousHref;
      }
    }
  });

  if (slideState) {
    window.addEventListener("hashchange", function () {
      slideState.set(parseRequestedSlide(slideState.count()));
    });
  }
})();
