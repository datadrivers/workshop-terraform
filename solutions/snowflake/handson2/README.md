# Snowflake hands-on 2

Creates the participant-specific database and the `LAB` schema using the `user_suffix` variable.

## Usage

Create a local `terraform.tfvars` containing `user_suffix`, then run `terraform init`, `terraform validate`, `terraform plan`, and `terraform apply`. The database name is `TF_WORKSHOP_<SUFFIX>` and the schema name is `LAB`.

## Inputs

- `user_suffix`: Short participant-specific suffix for the database name.

## Outputs

- `current_role`: The primary Snowflake role used by the provider session.
