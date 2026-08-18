---
layout: minimal
title: Presentation Mode
permalink: /presentation/
nav_exclude: true
---

<div class="presentation-launcher">

<h1>Workshop Presentation Mode</h1>

<p>This is a lightweight presenter layer on top of the existing workshop pages. It keeps the normal documentation intact and opens each chapter in a cleaner workshop view with keyboard navigation.</p>

<div class="presentation-launcher__actions">
  <a class="btn btn-primary" href="{{ '/track-selection/' | relative_url }}?presentation=1">Choose workshop track</a>
  <a class="btn" href="{{ '/track-selection/' | relative_url }}?presentation=1&amp;sections=1">Choose track in section mode</a>
  <a class="btn" href="{{ '/' | relative_url }}">Open normal docs</a>
</div>

<h2>How it works</h2>

<ul>
  <li>The existing workshop pages stay unchanged as the source material.</li>
  <li>Appending <code>?presentation=1</code> opens a chapter in presenter mode.</li>
  <li>Appending <code>?presentation=1&amp;sections=1</code> turns each <code>##</code> section into its own slide.</li>
  <li>Left and right arrow keys move between chapters or sections, depending on the selected mode.</li>
  <li>The bottom toolbar lets you jump back to the overview or open the normal docs view.</li>
</ul>

<h2>Workshop flow</h2>

<p>The track selection is the first presentation chapter. After choosing a track, both paths reuse the shared Terraform foundation chapters before continuing with their respective exercises.</p>

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
    <h3>3. Configuration Language</h3>
    <p>Resources, variables, outputs, functions, and Terraform language building blocks.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/language/' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/language/' | relative_url }}">Docs</a>
    </div>
  </section>
  <section class="presentation-launcher__card">
    <h3>4. Trainer demo: First apply</h3>
    <p>Short local resource demonstration of the basic Terraform command loop.</p>
    <div class="presentation-launcher__links">
      <a href="{{ '/handson/1' | relative_url }}?presentation=1">Present</a>
      <a href="{{ '/handson/1' | relative_url }}">Docs</a>
    </div>
  </section>

  </div>

  <div class="presentation-launcher__grid">
  <section class="presentation-launcher__card">
    <h3>5. Standard track: Cloud Storage</h3>
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
    <h3>7. Standard track: Cloud Storage with upload</h3>
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
    <h3>9. Standard track: Modules</h3>
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
