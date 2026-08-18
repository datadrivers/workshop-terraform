terraform {
  required_version = ">= 1.5.0"

  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.0"
    }
  }
}

provider "snowflake" {
  # The profile name is provided through SNOWFLAKE_PROFILE.
  preview_features_enabled      = ["snowflake_current_role_datasource"]
  experimental_features_enabled = ["PROVIDER_CONFIGURATION_ACCOUNT_FALLBACK"]
}

data "snowflake_current_role" "this" {}

resource "snowflake_database" "workshop" {
  name    = "TF_WORKSHOP_${upper(var.user_suffix)}"
  comment = "Database created during the Terraform workshop"
}

resource "snowflake_schema" "lab" {
  database = snowflake_database.workshop.name
  name     = "LAB"
  comment  = "Schema created during the Terraform workshop"
}

resource "snowflake_table" "orders" {
  database = snowflake_database.workshop.name
  schema   = snowflake_schema.lab.name
  name     = "ORDERS"
  comment  = var.table_comment

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
  warehouse_size      = upper(var.warehouse_size)
  auto_suspend        = var.warehouse_auto_suspend
  auto_resume         = true
  initially_suspended = true
  comment             = "Warehouse created during the Terraform workshop"
}

output "current_role" {
  description = "The Snowflake role used by the Terraform provider."
  value       = data.snowflake_current_role.this.name
}

output "database_name" {
  description = "The participant-specific Snowflake database."
  value       = snowflake_database.workshop.name
}

output "schema_name" {
  description = "The Snowflake schema managed by this workshop."
  value       = snowflake_schema.lab.name
}

output "qualified_table_name" {
  description = "The fully qualified name of the managed table."
  value       = "${snowflake_database.workshop.name}.${snowflake_schema.lab.name}.${snowflake_table.orders.name}"
}

output "warehouse_name" {
  description = "The Snowflake warehouse managed by this workshop."
  value       = snowflake_warehouse.workshop.name
}

output "warehouse_size" {
  description = "The configured warehouse size."
  value       = snowflake_warehouse.workshop.warehouse_size
}