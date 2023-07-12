---
title: Terraform Workflow
permalink: /workflow/
nav_order: 3
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

4. `terraform output`(also included in apply)

    4.1. Show output of root module

![https://developer.hashicorp.com/terraform/intro](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dterraform%26version%3Dv1.5.2%26asset%3Dwebsite%252Fimg%252Fdocs%252Fintro-terraform-workflow.png%26width%3D2038%26height%3D1773&w=2048&q=75)
