---
title: Typical Terraform workflow
permalink: /workflow/
nav_order: 3
---

# Typical Terraform workflow

The following steps are executed in a typical Terraform workflow:

1. `terraform init` (to initialize the working directory)
    1. Initializes the backend<br>
       (optional, where state is stored (local, remote, ...) and how it is accessed (credentials, ...))
    2. Downloads and installs provider plugins
    3. Downloads submodules (optional)

2. `terraform plan` (included in `terraform apply` or separated with `.plan` file)
    1. Locks current state
    2. Downloads current state into memory
    3. Refreshes state in memory
    4. Plans and outputs changes

3. `terraform apply`
    1. Applies changes, if any
    2. Updates state, if necessary
    3. Unlocks current state

4. `terraform output` (also included in `terraform apply`)
    1. Shows output of root module

---

![https://developer.hashicorp.com/terraform/intro](https://developer.hashicorp.com/_next/image?url=https%3A%2F%2Fcontent.hashicorp.com%2Fapi%2Fassets%3Fproduct%3Dterraform%26version%3Dv1.5.2%26asset%3Dwebsite%252Fimg%252Fdocs%252Fintro-terraform-workflow.png%26width%3D2038%26height%3D1773&w=2048&q=75)
