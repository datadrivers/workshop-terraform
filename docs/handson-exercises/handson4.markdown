---
title: Modules
permalink: /handson/4
parent: Hands-on exercises
nav_order: 4
---

# Hands-on exercises "Modules"

## Goal

Refactor the bucket and upload configuration into a reusable child module. The module interface should hide provider-specific resource details while exposing the inputs and outputs a caller needs.

## Preparation

- Continue with the provider and state setup from Hands-on 3.
- Review the [module documentation]({{ '/modules/' | relative_url }}) and the matching provider module examples in the repository.
- Keep provider configuration in the root module unless the module has a deliberate reason to accept an aliased provider.

## Steps

1. Create a child module with inputs for the bucket name, location, and any provider-specific settings that are genuinely required.
2. Move the bucket and upload resources into the child module.
3. Expose the bucket name and uploaded object information as module outputs.
4. Call the module from the root module and pass values through variables rather than hard-coding environment-specific settings.
5. Run `terraform fmt`, `terraform validate`, and `terraform plan`. The refactor should preserve the existing resources instead of destroying and recreating them.
6. If resource addresses change, add `moved` blocks or use a reviewed state migration so Terraform keeps tracking the existing objects.

The success criterion is a reusable module with a small interface and a plan that contains no accidental replacement.
