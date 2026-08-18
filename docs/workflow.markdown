---
title: Typical Terraform workflow
permalink: /workflow/
nav_order: 3
---

# Typical Terraform workflow

The workflow is a repeatable loop: initialize the project, preview the changes, apply the approved plan, and inspect the result.

![Terraform workflow overview]({{ site.baseurl }}/assets/images/intro-terraform-workflow.png)

## The workflow in detail

The following steps are executed in a typical Terraform workflow:

1. `terraform init` (to initialize the working directory)
    1. Initializes the backend<br>
       (optional, where state is stored (local, remote, ...) and how it is accessed (credentials, ...))
    2. Downloads and installs provider plugins
    3. Downloads submodules (optional)

2. `terraform plan` (also performed by `terraform apply`, or saved as a plan file)
    1. Locks current state
    2. Downloads current state into memory
    3. Refreshes state in memory
    4. Plans and outputs changes

3. `terraform apply`
    1. Applies changes, if any
    2. Updates state, if necessary
    3. Unlocks current state

4. `terraform output` (after `terraform apply`)
    1. Retrieves the outputs of the root module

## Terraform CLI reference

### Debugging commands

**terraform state list**

The command can list the resources being managed by the current working directory and workspace, providing a complete or filtered list.

**terraform state show**

The command can print all of the attributes of a given resource being managed by the current working directory and workspace, including generated read-only attributes like the unique ID assigned by the cloud provider.

### Working with state

The state commands and declarative state blocks below are advanced reference material. Prefer `import {}`, `moved {}`, and `removed {}` blocks when a state change is part of normal configuration evolution.

**terraform import**

Use config-driven `import {}` blocks so imports are reviewable and can be applied as part of normal plans and applies.

**Replace a resource**

Use `terraform apply -replace=aws_s3_bucket.example` when a resource should be replaced during the next apply.

**terraform state mv**

Use `moved {}` blocks for reviewed resource-address refactors.

**terraform state rm**

Use `removed {}` blocks when a resource should stop being managed without destroying the real object.

### Useful commands

**terraform show**: Render a human-readable or machine-readable representation of a state or plan file.

**terraform console**: Evaluate Terraform expressions interactively.

**terraform fmt**: Format Terraform configuration files.

**terraform validate**: Validate configuration syntax, arguments, and types before planning or applying.

