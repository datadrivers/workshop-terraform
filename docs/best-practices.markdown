---
title: Best Practices
permalink: /best-practices/
nav_order: 7
---

# Best Practices

Terraform does not require particular filenames inside a module. The following layout is a recommended convention that keeps a root module easy to navigate:

- `versions.tf`: Terraform and provider requirements
- `backend.tf`: backend configuration, when the module uses a separate backend file
- `providers.tf`: provider configuration
- `main.tf`: primary resources and data sources
- `variables.tf`: input variables
- `outputs.tf`: outputs exposed by the module
- `README.md`: purpose, usage, inputs, outputs, and examples

The repository convention is `providers.tf`. Use this filename for every provider configuration, including root modules and Snowflake hands-on solutions.

Additional conventions:

1. Use `snake_case` for Terraform resource names.
2. Define variables with a type and a useful description.
3. Define outputs with a value and a useful description.
4. Use explicit Terraform and provider version constraints and review them regularly. Shared modules usually prefer compatible ranges such as `>=` or `~>`, while root modules can be pinned more tightly when needed.
