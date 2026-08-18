# Snowflake Hands-on 3

Adds the participant-scoped `ORDERS` table and warehouse, then supports state inspection and drift exercises.

## Usage

Provide `user_suffix` through `terraform.tfvars`, then run `terraform init`, `terraform validate`, `terraform plan`, and `terraform apply`. Use `terraform state list` to inspect state and make one controlled Snowflake change before running `terraform plan` to observe drift.

## Inputs

- `user_suffix`: Short participant-specific suffix for the database name.

## Outputs

- `current_role`, `database_name`, `schema_name`, `table_name`, and `warehouse_name`.
