---
layout: default
title: Snowflake
permalink: /handson/snowflake/
parent: HandsOn exercises
nav_order: 5
has_children: true
---

# Snowflake hands-on exercises

These optional hands-on exercises extend the Terraform workshop with Snowflake examples.

Choose this track at the beginning of the workshop. It reuses the existing Core Components, Workflow, Configuration Language, and trainer `local_file` demonstration chapters before opening the Snowflake-specific handouts.

## Shared chapters

Use these existing chapters first:

1. [Core Components]({{ '/components/' | relative_url }})
2. [Typical Terraform workflow]({{ '/workflow/' | relative_url }})
3. [Configuration Language]({{ '/language/' | relative_url }})
4. [Trainer demonstration: First Apply]({{ '/handson/1' | relative_url }})

Then continue with the Snowflake-specific hands-on exercises below.

## Workshop agenda

The Snowflake track follows the agreed six-hour workshop structure:

| Module | Duration | Focus |
| --- | ---: | --- |
| 1 | 60 min | Introduction, HCL anatomy, `init`, `plan`, and `apply` |
| 2 | 90 min | Provider setup, current role, database, and schema |
| 3 | 90 min | State, table, warehouse, and drift |
| 4 | 70 min | Variables, outputs, and dependencies |
| 5 | 50 min | Cleanup with `destroy`, remote state, and CI/CD outlook |

Module 2 is split into two small consecutive exercises:

- 20 min: introduction and provider setup
- 25 min: [Hands-on 1: Snowflake provider]({{ '/handson/snowflake/1' | relative_url }}), which reads the current role
- 45 min: [Hands-on 2: Snowflake objects]({{ '/handson/snowflake/2' | relative_url }}), which creates the database and schema

Use one cumulative Terraform project for the Snowflake track. Later exercises build on the provider, state, and database created here.

The remaining modules are:

- [Hands-on 3: State and drift]({{ '/handson/snowflake/3' | relative_url }})
- [Hands-on 4: Variables and outputs]({{ '/handson/snowflake/4' | relative_url }})
- [Hands-on 5: Cleanup and next steps]({{ '/handson/snowflake/5' | relative_url }})
