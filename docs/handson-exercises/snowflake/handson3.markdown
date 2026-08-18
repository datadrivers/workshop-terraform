---
title: Hands-on 3: State and drift
permalink: /handson/snowflake/3
parent: Snowflake
nav_order: 3
---

# Hands-on 3: State and drift

This exercise builds on Hands-on 2. Continue in the same cumulative Terraform project and keep the same `SNOWFLAKE_PROFILE` and `terraform.tfvars`.

## Goal

Add a table and warehouse, inspect local Terraform state, and observe drift:

- Table `TF_WORKSHOP_<USER_SUFFIX>.LAB.ORDERS`
- Warehouse `WORKSHOP_WH`

## Step 1: Add the table and warehouse

Add the following resources to `main.tf`:

```hcl
resource "snowflake_table" "orders" {
  database = snowflake_database.workshop.name
  schema   = snowflake_schema.lab.name
  name     = "ORDERS"
  comment  = "Table created during the Terraform workshop"

  column {
    name     = "ORDER_ID"
    type     = "NUMBER"
    nullable = false
  }

  column {
    name = "CUSTOMER_NAME"
    type = "VARCHAR"
  }
}

resource "snowflake_warehouse" "workshop" {
  name                = "WORKSHOP_WH"
  warehouse_size      = "XSMALL"
  auto_suspend        = 60
  auto_resume         = true
  initially_suspended = true
  comment             = "Warehouse created during the Terraform workshop"
}
```

Resource references connect the table to the database and schema. The warehouse is independent of the database dependency.

## Step 2: Review state and apply

```bash
terraform fmt
terraform validate
terraform plan
terraform apply
terraform output
terraform state list
```

Review the plan before confirming `apply`. The state list should contain the database, schema, table, and warehouse.

## Step 3: Create controlled drift

Change the warehouse size manually in Snowflake, for example in Snowsight, from `XSMALL` to `SMALL`. Do not change the Terraform configuration.

Run:

```bash
terraform plan
```

Terraform should report the difference between the configured size and the remote size. This is drift: the remote object no longer matches the configuration and state.

Restore the declared state:

```bash
terraform apply
terraform plan
```

The final plan should report no changes.

## Common pitfalls

### The table has no columns

The Snowflake provider requires at least one `column` block. Keep the two columns from the example.

### The warehouse is running unexpectedly

The example uses `initially_suspended = true` and `auto_suspend = 60`. Avoid leaving a warehouse running during exercises.

### Drift is not visible

Run `terraform plan` after the manual Snowflake change. Do not edit the Terraform configuration while demonstrating drift.

## Trainer notes

- Explain that state is a record of Terraform's last known relationship with remote objects.
- Ask participants to compare configuration, state, and Snowflake after each command.
- Make only one controlled remote change so the plan remains easy to read.