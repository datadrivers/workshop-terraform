---
title: Hands on exercise "First apply"
permalink: /handson1/
---

## Goal

You should get to know the Terraform workflow with a simple module

## Steps

1. Create new folder
2. Switch to the new folder
3. Create file `main.tf` with following content

   ```hcl
   resource "local_file" "foo" {
      content         = "foo!"
      filename        = "${path.module}/foo.bar"
      file_permission = "0644"
   }
   ```

3. Run terraform workflow commands
   - init
   - plan
   - apply
   - output
   - plan

## [Back](index.markdown)
