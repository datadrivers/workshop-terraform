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

output "table_name" {
  description = "The Snowflake table managed by this workshop."
  value       = snowflake_table.orders.name
}

output "warehouse_name" {
  description = "The Snowflake warehouse managed by this workshop."
  value       = snowflake_warehouse.workshop.name
}
