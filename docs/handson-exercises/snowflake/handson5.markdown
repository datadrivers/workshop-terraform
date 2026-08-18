---
title: Hands-on 5: Cleanup and next steps
permalink: /handson/snowflake/5
parent: Snowflake
nav_order: 5
---

# Hands-on 5: Cleanup and next steps

This final exercise cleans up the participant's Snowflake resources and connects the local workshop workflow to production practices.

## Goal

- Destroy only the resources managed by this participant's Terraform state.
- Confirm that the participant-specific database and its objects are removed.
- Understand why teams use remote state and CI/CD after the workshop.

## Step 1: Review the destroy plan

Confirm that `terraform.tfvars` still contains your own suffix, then run:

```bash
terraform plan -destroy
```

Read the plan carefully. It must target only the database with your suffix, its `LAB` schema, the `ORDERS` table, and `WORKSHOP_WH`.

## Step 2: Destroy the resources

```bash
terraform destroy
```

Review the plan and confirm with `yes`. Verify the participant database is gone in Snowflake:

```sql
SHOW DATABASES LIKE 'TF_WORKSHOP_<USER_SUFFIX>';
```

Run a final plan:

```bash
terraform plan
```

With the configuration still present, Terraform will propose the resources again. This is expected after destroy. Do not apply again after cleanup.

## What comes next

### Remote state

Local `terraform.tfstate` is useful for a workshop, but a team needs shared, locked, access-controlled state. A remote backend also makes collaboration and recovery easier.

### CI/CD

A production workflow commonly runs formatting and validation on pull requests, creates a reviewed plan artifact, and applies only from a protected deployment workflow.

### Security

Production authentication should use short-lived or non-interactive credentials such as key pair or OAuth, with least-privilege roles and protected state.

## Trainer notes

- Treat `terraform plan -destroy` as a safety review, not a formality.
- Confirm the suffix before allowing `destroy` in a shared Snowflake account.
- Make clear that `destroy` removes resources tracked in the current state; it does not remove unrelated Snowflake objects.