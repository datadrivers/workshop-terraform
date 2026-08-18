---
title: "Hands-on 1: Snowflake provider"
permalink: /handson/snowflake/1
parent: Snowflake
nav_order: 1
---

# Hands-on 1: Snowflake provider

## Goal

Configure the Snowflake provider and read the current Snowflake role. Along the way, learn the basic Terraform workflow:

`init` downloads providers, `plan` shows the proposed changes, and `apply` executes them.

At the end, Terraform displays the role used by the provider. This exercise does not create Snowflake objects.

## Preparation

Snowflake CLI and Terraform must be available in the terminal. Use the Snowflake CLI to test the login and connection. Terraform receives the profile name through `SNOWFLAKE_PROFILE` and uses that profile to configure authentication.

First, check the configured CLI connection:

```bash
snow connection list
snow connection test --connection <connection-name>
```

Replace `<connection-name>` with the connection name shown by `snow connection list`. The test must succeed before starting Terraform.

Set the Terraform profile name in the terminal:

```bash
export SNOWFLAKE_PROFILE="default"
```

Terraform reads the selected profile from `~/.snowflake/config`. The profile contains the account, user, role, and authentication settings, for example:

```toml
[default]
organization_name = "<organization-name>"
account_name      = "<account-name>"
user              = "<username>"
role              = "<role>"
authenticator     = "EXTERNALBROWSER"
```

Change `default` in the export to use another profile. No account, user, role, or password values are required in the Terraform configuration or in the shell environment. The first Terraform command may open a browser for Snowflake authentication.

For a non-interactive environment, use the Terraform-compatible authentication method prepared for the workshop, such as key pair or OAuth. Do not put passwords in `main.tf`, the shell history, or the course chat.

The selected Terraform profile must authenticate successfully. Database and schema privileges are checked in Hands-on 2.

## Step 1: Create a project folder

Open Visual Studio Code and select **File > Open Folder...**. Create or open a new folder, for example `terraform-snowflake-handson1`.

Then open **Terminal > New Terminal** in VS Code. Check that the terminal is in the project folder:

```bash
pwd
```

## Step 2: Create `main.tf`

Create `main.tf` in the Explorer and add the following content:

```hcl
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
```

The preview data source reads the primary role of the current Snowflake session. It does not create or change any Snowflake object. It is a provider preview feature, so its name and behavior may change between provider versions; the workshop pins a tested version for this exercise.

## Step 3: Format and initialize

Save the file with `Cmd+S` and run:

```bash
terraform fmt
terraform init
```

`terraform init` downloads the provider and creates `.terraform.lock.hcl`. The lock file keeps provider versions reproducible during the workshop, but it is local-only here and must not be committed.

## Step 4: Review the plan

```bash
terraform validate
terraform plan
```

There should be no resources to create. The plan should contain the `current_role` output.

Review the plan before applying. Look for:

- The provider initializes successfully.
- The current role is read through the preview data source.
- No database or schema is created in this hands-on.

## Step 5: Apply the configuration

```bash
terraform apply
```

Review the displayed plan and confirm with `yes`. Then display the current role:

```bash
terraform output current_role
```

This output is the success criterion for Hands-on 1. Continue with [Hands-on 2: Snowflake objects]({{ '/handson/snowflake/2' | relative_url }}) only after the role is displayed successfully.

## Step 6: Inspect the Terraform files

The project folder now contains, among other files:

- `main.tf`: desired target state
- `.terraform.lock.hcl`: locally selected provider version; do not commit it
- `terraform.tfstate`: Terraform state, including the data source result
- `.terraform/`: locally installed provider files

`terraform.tfstate` contains state information and may contain sensitive metadata. This workshop uses local state; do not commit it to Git.

## Common pitfalls

### `terraform init` cannot load the provider

Check the internet connection, the provider source address `snowflakedb/snowflake`, and that the terminal is open in the folder containing `main.tf`.

### Authentication fails

First check the CLI connection with `snow connection test --connection <connection-name>`. Then verify that `SNOWFLAKE_PROFILE` contains the intended Terraform profile name and that the selected profile exists in `~/.snowflake/config`. The Snowflake CLI connection and Terraform provider profile are separate configuration formats; the CLI test confirms access, while the profile provides Terraform authentication.

### The account identifier is incorrect

A Snowflake account identifier is not always identical to the visible account name or a complete browser URL. Use the account identifier from the workshop connection setup.

### `insufficient privileges`

The provider connection works, but the current role may not have the privileges required for Hands-on 2. Record the value from `terraform output current_role` and verify the required privileges before continuing.

### The current-role data source is unavailable

Check that the provider block contains:

```hcl
preview_features_enabled = ["snowflake_current_role_datasource"]
```

Run `terraform init` again if the provider configuration or version changed.

If the preview data source is unavailable in the tested provider version, continue the authentication lesson by checking the active role with `snow connection test` or Snowsight, then compare the provider's current role data source documentation with the pinned version. Do not silently upgrade the provider during the exercise.

## Checkpoint

- Keep this exercise data-only: no database, schema, table, or warehouse yet.
- Treat a successful `terraform output current_role` as the gate for Hands-on 2.
- Be able to distinguish a provider, a data source, and a resource.
- Confirm the flow: `snow connection test` checks the CLI connection, then `SNOWFLAKE_PROFILE` selects the Terraform authentication profile.
- Remember that the Snowflake CLI configuration and Terraform provider profile use separate files or configuration paths.
- The learning objective is verifying the provider and reading the role, not creating infrastructure yet.
