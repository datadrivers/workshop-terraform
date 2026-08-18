---
title: First Apply
permalink: /handson/1
parent: Hands-on exercises
nav_order: 1
---

# Hands-on exercises "First Apply"

## Exercise

**Goal:** Learn the Terraform workflow by creating and inspecting a local file resource.

**Steps:** Follow these steps:

1. Create a new folder.
2. Switch to the new folder.
3. Create `main.tf` with the following content:

   ```hcl
   resource "local_file" "foo" {
     content         = "foo!"
     filename        = "${path.module}/foo.bar"
     file_permission = "0644"
   }
   ```

4. Run the Terraform workflow:

   ```bash
   terraform init
   terraform plan
   terraform apply
   terraform output
   terraform plan
   ```

The final plan should report no changes. The resource is already in the desired state.
