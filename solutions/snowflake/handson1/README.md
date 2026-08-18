# Snowflake Hands-on 1

Configures the Snowflake provider through `SNOWFLAKE_PROFILE` and reads the current role. This data-only root module does not create Snowflake resources.

## Usage

Set `SNOWFLAKE_PROFILE` to a Terraform-compatible profile, then run:

```bash
terraform init
terraform validate
terraform plan
terraform apply
terraform output current_role
```

The expected behavior is a successful provider connection and a current-role output with no managed resources.
