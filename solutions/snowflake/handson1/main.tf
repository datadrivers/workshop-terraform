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
