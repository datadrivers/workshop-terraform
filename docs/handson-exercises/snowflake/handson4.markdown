---
title: Hands-on 4: Variables and outputs
permalink: /handson/snowflake/4
parent: Snowflake
nav_order: 4
---

# Hands-on 4: Variables and outputs

This exercise builds on Hands-on 3 in the same cumulative Terraform project.

## Goal

Make the Snowflake configuration easier to reuse by introducing typed variables and useful outputs:

- `user_suffix` keeps the participant database unique.
- `warehouse_size` controls compute size.
- `warehouse_auto_suspend` controls automatic suspension.
- `table_comment` demonstrates configurable metadata.
- Outputs expose the current role, database, schema, fully qualified table, and warehouse.

## Step 1: Add variables

Move the existing `user_suffix` variable to `variables.tf` if it is not there already, then add:

```hcl
variable "warehouse_size" {
  description = "Snowflake warehouse size for the workshop."
  type        = string
  default     = "XSMALL"

  validation {
    condition     = contains(["XSMALL", "SMALL", "MEDIUM"], upper(var.warehouse_size))
    error_message = "warehouse_size must be XSMALL, SMALL, or MEDIUM."
  }
}

variable "warehouse_auto_suspend" {
  description = "Seconds of inactivity before the warehouse suspends."
  type        = number
  default     = 60
}

variable "table_comment" {
  description = "Comment stored on the workshop table."
  type        = string
  default     = "Table created during the Terraform workshop"
}
```

The existing `terraform.tfvars` continues to provide `user_suffix`. Optional values can be overridden there:

```hcl
user_suffix            = "<your-username>"
warehouse_size         = "XSMALL"
warehouse_auto_suspend = 60
```

## Step 2: Connect variables and outputs

Use the variables in the warehouse and table resources:

```hcl
resource "snowflake_warehouse" "workshop" {
  name                = "WORKSHOP_WH"
  warehouse_size      = var.warehouse_size
  auto_suspend        = var.warehouse_auto_suspend
  auto_resume         = true
  initially_suspended = true
}
```

Add an output for the fully qualified table name:

```hcl
output "qualified_table_name" {
  description = "The fully qualified name of the managed table."
  value       = "${snowflake_database.workshop.name}.${snowflake_schema.lab.name}.${snowflake_table.orders.name}"
}
```

The resource references are implicit dependencies. The table depends on the database and schema because it references their names; no `depends_on` is required.

## Step 3: Plan with defaults and an override

```bash
terraform fmt
terraform validate
terraform plan
terraform output
```

Try a plan with a variable override without editing files:

```bash
terraform plan -var='warehouse_size=SMALL'
```

Review how Terraform proposes the warehouse change. Do not apply the override unless the trainer requests it.

## Common pitfalls

### Terraform rejects a variable value

Read the validation error. Use an allowed warehouse size and a valid user suffix.

### An output is unknown during plan

Some Snowflake values are known only after the provider reads or creates the object. This is expected; inspect the value with `terraform output` after apply.

### `depends_on` is added unnecessarily

Prefer direct resource references when a dependency is expressed by a value such as a database or schema name.

## Trainer notes

- Show the precedence of defaults, `terraform.tfvars`, and `-var` command-line overrides.
- Ask participants to identify each implicit dependency from the HCL references.
- Keep warehouse defaults conservative to avoid unnecessary Snowflake compute cost.