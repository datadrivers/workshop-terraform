---
title: Core Components
permalink: /components/
nav_order: 2
---

# Core Components

## What is Terraform?

HashiCorp Terraform is an *infrastructure as code* tool that lets you define both cloud and on-prem resources in *human-readable configuration* files that you can *version*, *reuse*, and *share*.

You can then use a *consistent workflow* to provision and manage all of your infrastructure throughout its lifecycle.

Terraform can manage low-level components like compute, storage, and networking resources, as well as high-level components like DNS entries and SaaS features.

Terraform takes an **immutable** approach to infrastructure, reducing the complexity of upgrading or modifying your services and infrastructure.

Terraform is **declarative**, which means you can describe your desired state of infrastructure, and Terraform will build that infrastructure for you.

![Terraform components overview]({{ site.baseurl }}/assets/images/intro-terraform-apis.png)

## Terraform and OpenTofu in 2026

- Terraform 1.5.x and earlier remain under MPL 2.0, but Terraform 1.6 and later use BUSL-1.1. For customer environments, especially regulated or procurement-heavy ones, that licensing change is worth reviewing explicitly before standardizing on the toolchain.
- OpenTofu is an MPL-2.0 fork under Linux Foundation stewardship and is designed as a near drop-in replacement for many Terraform beginner and intermediate workflows.
- HashiCorp is now part of IBM, so Terraform should be evaluated as an IBM product when discussing vendor posture, support, and procurement.
- In practice, teams should decide early whether they want HashiCorp Terraform plus HCP Terraform, or an OpenTofu-based workflow, and then keep examples, CI, and policy tooling consistent.

Useful starting points:

- [Terraform documentation](https://developer.hashicorp.com/terraform){:target="_blank"}
- [OpenTofu project and docs](https://opentofu.org/){:target="_blank"}
- [HashiCorp, an IBM company](https://www.ibm.com/products/hashicorp){:target="_blank"}

## Components

- Configuration code
- Terraform state
- Providers / plugins
- Terraform CLI

## Configuration code

Code in the Terraform language is stored in plain text files with the .tf file extension.
Terraform always runs in the context of a single root module. A complete Terraform configuration consists of a root module and the tree of child modules (which includes the modules called by the root module, any modules called by those modules, etc.).

## Terraform state

Terraform keeps track of resources it manages and thus must store a state about your managed infrastructure and configuration. This state is used by Terraform to map real world resources to your configuration, keep track of metadata, and to improve performance for large infrastructures. With the state file TF can *determine the changes to make to the infrastructure so that it will match your configuration*.

It can be stored in different backends <https://www.terraform.io/language/settings/backends>

## Providers / plugins

Each provider adds a set of resource types and/or data sources that Terraform can manage.

Every resource type is implemented by a provider; without providers, Terraform can't manage any kind of infrastructure.

Most providers configure a specific infrastructure platform (either cloud or self-hosted). Providers can also offer local utilities for tasks like generating random numbers for unique resource names.

Each provider has its own documentation, describing its resource types and their arguments.

The [Terraform Registry](https://registry.terraform.io/browse/providers){:target="_blank"} includes documentation for a wide range of providers developed by HashiCorp, third-party vendors, and our Terraform community. Use the "Documentation" link in a provider's header to browse its documentation.

## Terraform CLI

The command line interface to Terraform is via the `terraform` command, which accepts a variety of subcommands such as *terraform init* or *terraform plan*.

### Important commands

---

**terraform init**

The command performs several different initialization steps in order to prepare the current working directory for use with Terraform.

**terraform plan**

The command evaluates a Terraform configuration to determine the desired state of all the resources it declares, then compares that desired state to the real infrastructure objects being managed with the current working directory and workspace. It uses state data to determine which real objects correspond to which declared resources, and checks the current state of each resource using the relevant infrastructure provider's API.

Plans are usually run to validate configuration changes and confirm that the resulting actions are as expected. However, `terraform plan` can also save its plan as a runnable artifact, which `terraform apply` can use to carry out those exact changes.

**terraform apply**

The command performs a plan just like `terraform plan` does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, unless it was explicitly told to skip approval.

By default, `terraform apply` performs a fresh plan right before applying changes, and displays the plan to the user when asking for confirmation. However, it can also accept a plan file produced by `terraform plan` in lieu of running a new plan. You can use this to reliably perform an exact set of pre-approved changes, even if the configuration or the state of the real infrastructure has changed in the minutes since the original plan was created.

**terraform destroy**

The command destroys all of the resources being managed by the current working directory and workspace, using state data to determine which real world objects correspond to managed resources. Like `terraform apply`, it asks for confirmation before proceeding.

---

### Debugging commands

---

**terraform output**

The command can get the values for the top-level output values of a configuration, which are often helpful when making use of the infrastructure Terraform has provisioned.

**terraform state list**

The command can list the resources being managed by the current working directory and workspace, providing a complete or filtered list.

**terraform state show**

The command can print all of the attributes of a given resource being managed by the current working directory and workspace, including generated read-only attributes like the unique ID assigned by the cloud provider.

---

### Working with state

---

**terraform import**

The command is used to import existing resources into Terraform. For current workflows, prefer config-driven `import {}` blocks in your configuration so imports are reviewable and can be applied as part of normal plans and applies.

```hcl
resource "aws_s3_bucket" "logs" {
	bucket = "company-logs-prod"
}

import {
	to = aws_s3_bucket.logs
	id = "company-logs-prod"
}
```

**Replace a resource**

The old `terraform taint` and `terraform untaint` commands are deprecated. The current workflow is to tell Terraform exactly which object should be replaced during the next apply, for example with `terraform apply -replace=aws_s3_bucket.example`.

This keeps replacement intent explicit in the plan, instead of mutating state ahead of time.

**terraform state mv**

The command changes which resource address in your configuration is associated with a particular real-world object. For refactors, prefer `moved {}` blocks in configuration so address changes are tracked declaratively and reviewed with the rest of the change.

```hcl
resource "aws_s3_bucket" "application_logs" {
	bucket = "company-logs-prod"
}

moved {
	from = aws_s3_bucket.logs
	to   = aws_s3_bucket.application_logs
}
```

**terraform state rm**

The command tells Terraform to stop managing a resource as part of the current working directory and workspace, without destroying the corresponding real-world object. For planned removals from state, prefer `removed {}` blocks where available so the change is captured in configuration instead of being performed as one-off state surgery.

```hcl
removed {
	from = aws_s3_bucket.application_logs

	lifecycle {
		destroy = false
	}
}
```

In general, the imperative state commands still exist, but current best practice is to prefer declarative `import {}`, `moved {}`, and `removed {}` blocks whenever the change is part of normal configuration evolution.

---

### Useful commands

---

**terraform show**

The command can generate human-readable versions of a state file or plan file, or generate machine-readable versions that can be integrated with other tools.

**terraform console**

The command starts an interactive shell for evaluating Terraform expressions, which can be a faster way to verify that a particular resource argument results in the value you expect.

**terraform fmt**

The command rewrites Terraform configuration files to a canonical format and style, so you don't have to waste time making minor adjustments for readability and consistency. It works well as a pre-commit hook in your version control system.

**terraform validate**

The command validates the syntax and arguments of the Terraform configuration files in a directory, including argument and attribute names and types for resources and modules. The plan and apply commands automatically validate a conf
