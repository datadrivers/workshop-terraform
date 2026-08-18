provider "snowflake" {
  # The profile name is provided through SNOWFLAKE_PROFILE.
  preview_features_enabled      = ["snowflake_current_role_datasource"]
  experimental_features_enabled = ["PROVIDER_CONFIGURATION_ACCOUNT_FALLBACK"]
}
