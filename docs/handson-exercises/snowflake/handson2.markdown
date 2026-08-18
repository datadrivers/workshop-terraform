---
title: "Hands-on 2: Snowflake objects"
permalink: /handson/snowflake/2
parent: Snowflake
nav_order: 2
---

# Hands-on 2: Snowflake objects

This exercise builds on [Hands-on 1: Snowflake provider]({{ '/handson/snowflake/1' | relative_url }}). Use the same Terraform project and the same `SNOWFLAKE_PROFILE` environment variable.

## Goal

Create the first Snowflake objects with Terraform:

- Database `TF_WORKSHOP_<USER_SUFFIX>`
- Schema `TF_WORKSHOP_<USER_SUFFIX>.LAB`

Hands-on 1 established the provider and displayed the current role. This exercise adds the first managed resources.

## Step 1: Create `terraform.tfvars`

Each participant must choose a short, unique suffix based on their username. This prevents participants from creating objects with the same Snowflake names.

Create `terraform.tfvars` in the project folder:

```hcl
user_suffix = "<your-username>"
```

Use only letters, numbers, and underscores. Do not commit `terraform.tfvars` if it contains personal or environment-specific values.

## Step 2: Add the variable

Create `variables.tf`:

```hcl
variable "user_suffix" {
  description = "Short user-specific suffix used to make Snowflake object names unique."
  type        = string

  validation {
    condition     = can(regex("^[A-Za-z0-9_]+$", var.user_suffix))
    error_message = "user_suffix may contain only letters, numbers, and underscores."
  }
}
```

## Step 3: Add the resources

Keep the provider, preview feature, current-role data source, and output from Hands-on 1. Add the following resources to `main.tf`:

```hcl
resource "snowflake_database" "workshop" {
  name    = "TF_WORKSHOP_${upper(var.user_suffix)}"
  comment = "Database created during the Terraform workshop"
}

resource "snowflake_schema" "lab" {
  database = snowflake_database.workshop.name
  name     = "LAB"
  comment  = "Schema created during the Terraform workshop"
}
```

The reference `snowflake_database.workshop.name` creates an implicit dependency. Terraform creates the schema only after the database exists. The unique database separates each participant's resources, so the schema can use the shared name `LAB`.

## Step 4: Review the plan

```bash
terraform fmt
terraform validate
terraform plan
```

Expect two resources to be created. Review the plan before continuing. `plan` does not change Snowflake.

## Step 5: Apply the configuration

```bash
terraform apply
```

Review the displayed plan and confirm with `yes`. Verify the result with the Snowflake CLI or Snowsight:

```sql
SHOW DATABASES LIKE 'TF_WORKSHOP_<USER_SUFFIX>';
SHOW SCHEMAS IN DATABASE TF_WORKSHOP_<USER_SUFFIX>;
```

Run the plan again:

```bash
terraform plan
```

The plan should report that no changes are required.

## Common pitfalls

### The database or schema already exists

Terraform does not initially know about manually created objects. Check that `terraform.tfvars` contains your unique suffix. Do not run `terraform import` without first discussing its purpose.

### `insufficient privileges`

The provider login works, but the current role cannot create databases or schemas. Check the role from Hands-on 1 with `terraform output current_role` and verify that it has the privileges required for this exercise.

### The schema is created in the wrong database

Check that the schema uses `snowflake_database.workshop.name`, not a duplicated or misspelled database name.

## Checkpoint

- Keep Hands-on 1 as the known-good authentication baseline.
- Confirm that `terraform.tfvars` contains your unique suffix before `apply` to prevent name collisions.
- Predict the resource order before running `apply`.
- Use a short username or initials as the database suffix; the configuration uppercases it for the database name. Resources inside the database can use shared names.
