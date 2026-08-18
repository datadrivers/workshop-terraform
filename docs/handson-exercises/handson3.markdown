---
title: Cloud Storage with upload
permalink: /handson/3
parent: Hands-on exercises
nav_order: 3
---

# Hands-on exercises "Cloud Storage with upload"

## Goal

Build on the first bucket, upload a local file, and optionally migrate Terraform state to a remote backend. The upload resource and backend syntax are provider-specific, so continue with the provider selected in Hands-on 2.

## Preparation

- Keep the same provider, credentials, and project folder from Hands-on 2.
- Add a small local file such as `hello.txt` to the project directory.
- Read the selected provider's object-upload resource and backend documentation.
- Confirm that the state bucket is separate from the bucket used for workshop files when the provider requires a dedicated state container.

## Steps

1. Copy the bucket configuration and give the second bucket a unique name, or extend the existing bucket only if the provider supports the intended upload workflow.
2. Add the provider-specific object-upload resource and upload `hello.txt`.
3. Run `terraform fmt`, `terraform validate`, and `terraform plan`. Confirm that Terraform proposes the bucket object and does not replace the bucket unexpectedly.
4. Apply and verify the uploaded object in the provider console or CLI.
5. If the workshop environment supports remote state, create or select a dedicated state bucket first. Add the backend configuration with literal, provider-specific settings; backend blocks cannot use Terraform variables.
6. Run `terraform init -migrate-state`, review the migration prompt, and verify that a new plan still reports no unexpected changes.

Remote state is an optional extension, not a prerequisite for the upload exercise. Never store the state bucket inside the state that it is meant to hold.
