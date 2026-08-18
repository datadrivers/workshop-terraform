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

output "current_role" {
  description = "The Snowflake role used by the Terraform provider."
  value       = data.snowflake_current_role.this.name
}

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

output "database_name" {
  description = "The participant-specific Snowflake database."
  value       = snowflake_database.workshop.name
}

output "schema_name" {
  description = "The Snowflake schema managed by this workshop."
  value       = snowflake_schema.lab.name
}

output "table_name" {
  description = "The Snowflake table managed by this workshop."
  value       = snowflake_table.orders.name
}

output "warehouse_name" {
  description = "The Snowflake warehouse managed by this workshop."
  value       = snowflake_warehouse.workshop.name
}