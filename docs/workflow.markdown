---
title: Terraform Workflow
permalink: /workflow/
---

# Terraform Workflow

1. `terraform init`
1.1. Initializing the backend
1.2. Downloading and installing provider plugins
1.3. Downloading submodules (optional)
2. `terraform plan`(included in apply or seperated with planfile)
2.1. Lock state
2.2. Downloading state into memory
2.3. Refreshing state in memory
2.4. Plan and output changes
3. `terraform apply`
3.1. Do changes
3.2. Updating state
3.3. Unlock state

## [Back](index.markdown)
