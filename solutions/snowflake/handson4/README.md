# Snowflake hands-on 4

Refines the cumulative Snowflake configuration with typed variables, validation, outputs, and explicit dependency examples.

## Usage

Provide `user_suffix` through `terraform.tfvars`. Optional variables include `warehouse_size`, `warehouse_auto_suspend`, and `table_comment`. Run `terraform init`, `terraform validate`, `terraform plan`, `terraform apply`, and `terraform output` to inspect the resulting configuration.

## Inputs

- `user_suffix`: Short participant-specific suffix for the database name.
- `warehouse_size`: Validated warehouse size with default `XSMALL`.
- `warehouse_auto_suspend`: Suspension delay in seconds with default `60`.
- `table_comment`: Configurable table metadata.

## Outputs

- `current_role`, `database_name`, `schema_name`, `qualified_table_name`, and `warehouse_name`.
