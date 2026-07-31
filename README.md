# Terraform Workshop

This repository includes the documentation and the code examples for a terraform workshop.

## Development

### Run website locally

```bash
cd docs
bundle install
bundle exec jekyll serve
```

or if you do not have faith in your local ruby installation

```bash
docker run --rm -ti -p 4000:4000 -v "$(pwd)":/repo ruby:3.2.8-bookworm /repo/run.sh
```

## Presentation mode

The workshop pages double as a slide deck. Visit `/presentation/` for the launcher, or append query params to any chapter page:

- `?presentation=1` — chapter view: the whole page is one slide, arrow keys move between chapters.
- `?presentation=1&sections=1` — section view: the page is split into multiple slides, arrow keys move between slides (and cross chapter boundaries at the edges).

The bottom toolbar toggles between the two views, jumps to the overview, or returns to the normal docs view. Everything is URL-driven — no build step or separate export.

### How pages become slides

In section view, each chapter is split into slides automatically:

1. A **chapter title slide** is inserted first, showing the page's `title` front matter big and centered.
2. Every `##` heading starts a new slide.
3. Every `###` heading starts a new sub-slide (labelled `PARENT · CHILD` in the top-left).
4. A paragraph containing only a single bold marker (e.g. `**terraform init**`) also starts a new slide — used throughout the hands-on chapters to break long command walkthroughs.

Chapter view ignores all of this and shows the page as one continuous slide.

### Manual slide breaks

When the automatic splits produce a slide that's too long (long list plus a diagram, side-by-side command output, etc.), drop a marker where you want the split:

```markdown
Some content that fits on one slide.

<div class="slide-break"></div>

Content that should be on the next slide.
```

The marker is invisible in the normal docs view (hidden via CSS) and produces a continuation slide (labelled `(cont.)` in the toolbar title) in section view. Use it sparingly — prefer restructuring the markdown with a proper heading first.
