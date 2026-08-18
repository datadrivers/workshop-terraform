---
title: Home
permalink: /
nav_order: 1
---

# Terraform Workshop for beginners

This workshop is designed for beginners and gives an introduction to the basic concepts of Terraform.

[Open presentation mode]({{ '/presentation/' | relative_url }}) for a workshop-friendly launcher that reuses the existing chapter pages.

After the shared Terraform foundations and the trainer's `local_file` demonstration, choose a track:

- [Continue with the standard Terraform track]({{ '/handson/2' | relative_url }})
- [Switch to the Snowflake workshop]({{ '/handson/snowflake/' | relative_url }})

## Requirements

In order to participate in the workshop, the following requirements should be met:

- Basic knowledge about Cloud Services and IaC
- Basic git and cli experiences
- AWS account, Google project or Azure subscription as Playground
- `terraform` cli, `tfswitch` or `tfenv` is installed
- cli tool for selected cloud environment like `gcloud` is installed

## Workshop content

1. [Core Components]({{ '/components/' | relative_url }}) (approx. 15 min)
2. [Typical Terraform workflow]({{ '/workflow/' | relative_url }}) (approx. 15 min)
3. [HashiCorp Configuration Language (HCL)]({{ '/language/' | relative_url }}) Part 1 (approx. 45 min)
4. Break (approx. 10 min)
5. [HashiCorp Configuration Language (HCL)]({{ '/language/' | relative_url }}) Part 2 (approx. 45 min)
6. Trainer demonstration: [First Apply]({{ '/handson/1' | relative_url }}) (approx. 15 min)
7. Choose a track:
  - [Continue with the standard Terraform track]({{ '/handson/2' | relative_url }})
  - [Switch to the Snowflake workshop]({{ '/handson/snowflake/' | relative_url }})
8. [HandsOn: "Cloud Storage"]({{ '/handson/2' | relative_url }}) (standard track, approx. 30 min)
9. Break (approx. 40 min)
10. [Dependencies]({{ '/dependencies/' | relative_url }}) (approx. 15 min)
11. [HandsOn: "Cloud Storage with upload"]({{ '/handson/3' | relative_url }}) (standard track, approx. 30 min)
12. [Modules]({{ '/modules/' | relative_url }}) (approx. 15 min)
13. Break (approx. 10 min)
14. [HandsOn: "Modules"]({{ '/handson/4' | relative_url }}) (standard track, approx. 30 min)
15. [Best Practices]({{ '/best-practices/' | relative_url }}) (approx. 15 min)
16. Questions (approx. 15 min)
17. [What's next]({{ '/next/' | relative_url }}) (approx. end of life ;-D)

(Total: 5h + 1h Break)

**Optional**:

- `terraform test`
- `check {}` blocks
- Terraform Workspaces
- Tflint
- terraform-docs
- Terragrunt (with the usual caveat that OpenTofu now covers part of its old value proposition)

## Sources and links

- <https://www.terraform.io/>
- <https://registry.terraform.io/>
- Used tools and their installation docs
  - `terraform`: <https://learn.hashicorp.com/tutorials/terraform/install-cli>
  - `tfswitch`: <https://tfswitch.warrensbox.com/Install/>
  - `tfenv`: <https://github.com/tfutils/tfenv#installation>
  - `aws`: <https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html>
  - `gcloud`: <https://cloud.google.com/sdk/docs/install>
  - `az`: <https://learn.microsoft.com/en-us/cli/azure/install-azure-cli>
  - `git`: <https://git-scm.com/book/en/v2/Getting-Started-Installing-Git>
