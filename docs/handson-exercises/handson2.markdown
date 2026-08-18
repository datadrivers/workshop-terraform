---
title: Cloud Storage
permalink: /handson/2
parent: Hands-on exercises
nav_order: 2
---

# Hands-on exercises "Cloud Storage"

## Goal

Create the first cloud object-storage bucket and expose its provider-computed attributes. This exercise is provider-neutral: choose AWS, Azure, or GCP before starting and use the matching provider documentation and solution directory.

## Preparation

- Choose one provider for the standard track and keep that provider for Hands-on 3 and 4.
- Authenticate with the provider's CLI or environment variables before running Terraform.
- Check the matching example in [AWS](../../solutions/cloud-storage/aws/), [Azure](../../solutions/cloud-storage/azure/), or [GCP](../../solutions/cloud-storage/gcp/).
- Read the provider's bucket resource documentation before writing the resource. The relevant links are listed in [Core Components]({{ '/components/' | relative_url }}#how-to-find-provider-documentation).

The examples use a unique bucket name. Cloud object-storage names are often globally unique, so do not copy a shared example name unchanged.

## Steps

1. Search the selected provider's bucket resource in the [Terraform Registry](https://registry.terraform.io/).
2. Add the provider requirement, provider configuration, and a variable for the project, account, or region values required by your provider.
3. Write a root module with one object-storage bucket resource. Use a unique name and enable the provider's recommended safety settings for a workshop resource.
4. Add an output for the bucket name and at least one computed attribute, such as its region or self-link.
5. Run `terraform fmt`, `terraform init`, `terraform validate`, and `terraform plan`.
6. Apply after reviewing the plan, then run `terraform output` and verify the bucket in the provider console or CLI.

The success criterion is one bucket created by Terraform, a readable output, and a clean second plan. Do not configure remote state in this first exercise; bootstrap resources must exist before a remote backend can use them.
