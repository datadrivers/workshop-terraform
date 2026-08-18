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
