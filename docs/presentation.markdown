---
layout: minimal
title: Presentation Mode
permalink: /presentation/
nav_exclude: true
---

<div class="presentation-launcher">

# Workshop Presentation Mode

This is a lightweight presenter layer on top of the existing workshop pages. It keeps the normal documentation intact and opens each chapter in a cleaner workshop view with keyboard navigation.

<div class="presentation-launcher__actions">
  <a class="btn btn-primary" href="{{ '/components/' | relative_url }}?presentation=1">Start chapter presentation</a>
  <a class="btn" href="{{ '/components/' | relative_url }}?presentation=1&amp;sections=1">Start section slides</a>
  <a class="btn" href="{{ '/' | relative_url }}">Open normal docs</a>
</div>

## How it works

- The existing workshop pages stay unchanged as the source material.
- Appending `?presentation=1` opens a chapter in presenter mode.
- Appending `?presentation=1&sections=1` turns each `##` section into its own slide.
- Left and right arrow keys move between chapters or sections, depending on the selected mode.
- The bottom toolbar lets you jump back to the overview or open the normal docs view.

## Workshop flow

<div class="presentation-launcher__grid">
  <section class="presentation-launcher__card">
    <h3>1. Core Components</h3>
    <p>Terraform basics, mental model, and current Terraform/OpenTofu context.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/components/' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/components/' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>2. Workflow</h3>
    <p>Initialization, planning, applying, and where state fits into the lifecycle.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/workflow/' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/workflow/' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>3. HandsOn: First apply</h3>
    <p>First local resource example and the basic Terraform command loop.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/handson/1' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/handson/1' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>4. Configuration Language</h3>
    <p>Resources, variables, outputs, functions, and Terraform language building blocks.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/language/' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/language/' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>5. HandsOn: Cloud Storage</h3>
    <p>First cloud resource example with a bucket as the foundation for later exercises.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/handson/2' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/handson/2' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>6. Dependencies</h3>
    <p>How Terraform determines resource order and how to model dependencies explicitly.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/dependencies/' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/dependencies/' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>7. HandsOn: Cloud Storage with upload</h3>
    <p>Remote state and file upload on top of the earlier storage exercise.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/handson/3' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/handson/3' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>8. Modules</h3>
    <p>Reuse, composition, and structuring Terraform code for real projects.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/modules/' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/modules/' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>9. HandsOn: Modules</h3>
    <p>Refactor the exercise code into reusable modules.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/handson/4' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/handson/4' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>10. Best Practices</h3>
    <p>Repository structure, version constraints, naming, and documentation habits.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/best-practices/' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/best-practices/' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>11. What's next</h3>
    <p>Testing, checks, tooling, and other next steps after the core workshop.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/next/' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/next/' | relative_url }}">Docs</a>
    </div>
  </section>
</div>

</div>
