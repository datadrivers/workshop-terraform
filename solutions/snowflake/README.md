# Snowflake Terraform helpers

This directory contains the reference solutions and an optional helper for preparing a Terraform Snowflake profile.

## `migrate-snow-config.py`

Use this helper only when a Snowflake CLI connection exists but the Terraform provider profile does not exist yet.

The helper reads a Snowflake CLI `config.toml` connection and writes a Terraform-compatible profile to `~/.snowflake/config`. It also copies the password, so treat the destination as a secret. The helper creates the destination directory with owner-only permissions and writes the file with mode `0600`.

After migration, select the profile for Terraform:

```text
SNOWFLAKE_PROFILE=<connection-name>
```

## macOS

The default Snowflake CLI configuration is usually located at:

```text
~/Library/Application Support/snowflake/config.toml
```

Example:

```bash
python3 migrate-snow-config.py \
  "$HOME/Library/Application Support/snowflake/config.toml" \
  --profile MYCON \
  --output "$HOME/.snowflake/config"

export SNOWFLAKE_PROFILE="MYCON"
```

Test the connection before running Terraform:

```bash
snow connection test --connection MYCON
terraform plan
```

## Windows PowerShell

The Snowflake CLI configuration is commonly located at:

```text
$env:USERPROFILE\AppData\Local\snowflake\config.toml
```

Example:

```powershell
python .\migrate-snow-config.py `
  "$env:USERPROFILE\AppData\Local\snowflake\config.toml" `
  --profile MYCON `
  --output "$env:USERPROFILE\.snowflake\config"

$env:SNOWFLAKE_PROFILE = "MYCON"
```

Test the connection before running Terraform:

```powershell
snow connection test --connection MYCON
terraform plan
```

Use an explicit source path if the Snowflake CLI uses a different configuration location. Do not commit the generated Terraform profile or share its contents.
