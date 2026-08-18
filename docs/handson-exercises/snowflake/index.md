---
layout: default
title: Snowflake
permalink: /handson/snowflake/
parent: Hands-on exercises
nav_order: 5
has_children: true
---

# Snowflake hands-on exercises

Choose this track at the beginning of the workshop. It reuses the existing Core Components, Workflow, Configuration Language, and `local_file` demonstration chapters before opening the Snowflake-specific handouts.

## Workshop agenda

| Module | Scope | Duration | Focus |
| --- | --- | ---: | --- |
| 1 | Shared | 60 min | Core Components, workflow, HCL, and the guided First Apply demonstration |
| 2 | Snowflake | 90 min | Provider setup, current role, database, and schema |
| 3 | Snowflake | 90 min | State, table, warehouse, and drift |
| 4 | Snowflake | 70 min | Variables, outputs, and dependencies |
| 5 | Snowflake | 50 min | Cleanup with `destroy`, remote state, and CI/CD outlook |

## Follow the workshop in this order

### Part 1: Shared Terraform foundations (Module 1)

Complete the shared chapters first:

1. [Core Components]({{ '/components/' | relative_url }})
2. [Typical Terraform workflow]({{ '/workflow/' | relative_url }})
3. [Configuration Language]({{ '/language/' | relative_url }})
4. [Guided demonstration: First Apply]({{ '/handson/1' | relative_url }})

### Part 2: Snowflake-specific modules (Modules 2-5)

Use one cumulative Terraform project and keep its state throughout the Snowflake track.

#### Module 2

- Introduction and provider setup
- [Hands-on 1: Snowflake provider]({{ '/handson/snowflake/1' | relative_url }}), which reads the current role
- [Hands-on 2: Snowflake objects]({{ '/handson/snowflake/2' | relative_url }}), which creates the database and schema

#### Module 3

- [Hands-on 3: State and drift]({{ '/handson/snowflake/3' | relative_url }})

#### Module 4

- [Hands-on 4: Variables and outputs]({{ '/handson/snowflake/4' | relative_url }})

#### Module 5

- [Hands-on 5: Cleanup and next steps]({{ '/handson/snowflake/5' | relative_url }})
