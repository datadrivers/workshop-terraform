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
  name                = "WORKSHOP_WH_${upper(var.user_suffix)}"
  warehouse_size      = upper(var.warehouse_size)
  auto_suspend        = var.warehouse_auto_suspend
  auto_resume         = true
  initially_suspended = true
  comment             = "Warehouse created during the Terraform workshop"
}
