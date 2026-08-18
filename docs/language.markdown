---
title: Configuration Language
permalink: /language/
nav_order: 4
---

# HashiCorp Configuration Language (HCL)

In this section, the configuration language for Terraform is explained using [Version 2 of the first hands-on solution](https://github.com/datadrivers/workshop-terraform/tree/main/solutions/first-apply/v2){:target="_blank"}.

The configuration language is used to describe the desired state of your infrastructure in a human-readable format. It is used to define the resources you want to create and configure.

## Resources

```hcl
resource "local_file" "foo" {
  content         = "Lorem Ipsum"
  filename        = "foo.txt"
  file_permission = "0644"
}
```

A resource block declares a resource of a given type (`"local_file"`) with a local name (`"foo"`).

The name lets other expressions refer to the resource inside the same module. It has no significance outside that module's scope.

The resource type and name together identify the resource and must be unique within a module.

The block body contains the resource arguments. Most arguments depend on the selected resource type.

## Data Sources

```hcl
data "aws_ami" "example" {
  most_recent = true
  owners = ["self"]
  tags = {
    Name   = "app-server"
    Tested = "true"
  }
}
```

Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

## Variables

```hcl
variable "file_content" {
  type        = string
  description = "Content of generated file"
}
```

Input variables customize a module without changing its source code. This makes a module reusable across different Terraform configurations.

In a root module, variable values can come from CLI options and environment variables. In a child module, the calling module passes values in the module block.

### Variable Arguments

Terraform defines the following optional arguments for variable declarations:

* `default` - A default value which then makes the variable optional.
* `type` - This argument specifies what value types are accepted for the variable.
* `description` - This specifies the input variable's documentation.
* `validation` - A block to define validation rules, usually in addition to type constraints.
* `sensitive` - Limits Terraform UI output when the variable is used in configuration.
* `nullable` - Specify if the variable can be null within the module.

### Types

* `string`: a sequence of Unicode characters representing some text, like "hello".
* `number`: a numeric value. The number type can represent both whole numbers like 15 and fractional values like 6.283185.
* `bool`: a boolean value, either true or false. bool values can be used in conditional logic.
* `list`: an ordered sequence of values that can be accessed by consecutive indexes, like `["us-west-1a", "us-west-1c"]`.
* `set`: an unordered collection of unique values. Sets do not provide stable index-based access.
* `map`: a collection of values of one type addressed by string keys, like `{primary = "eu-west-1", backup = "us-east-1"}`.
* `object`: a structure with named attributes whose names and types are declared in the type constraint, like `{name = string, age = number}`.

### Set variables in terraform cli

* Set option `-var <name>=<value>`
* Set option `-var-file <path>`
* Set env variable `export TF_VAR_<name>=<value>`

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

1. Environment variables
2. The `terraform.tfvars` file, if present.
3. The `terraform.tfvars.json` file, if present.
4. Any `*.auto.tfvars` or `*.auto.tfvars.json` files, processed in lexical order of their filenames.
5. Any `-var` and `-var-file` options on the command line, in the order they are provided.

## Outputs

```hcl
output "filename" {
  value       = local_file.foo.filename
  description = "Filename of generated file"
}
```

Output values make information about your infrastructure available on the command line, and can expose information for other Terraform configurations to use. Output values are similar to return values in programming languages.

### Output Arguments

Terraform defines the following optional arguments for output declarations:

* `value` - The required value argument takes an expression whose result is to be returned to the user
* `description` - Explain the output's purpose and expected value from the perspective of the module user. Use comments for maintainer-only notes.
* `sensitive` - An output can be marked as containing sensitive material using the optional sensitive argument. Terraform will hide values marked as sensitive in the messages from `terraform plan` and `terraform apply`.
* `depends_on` - Usually unnecessary for outputs because resource references already create dependencies. Use it only when a parent module needs an output to wait for an indirect dependency in a child module.

## Local Values

```hcl
locals {
  filename = format("%s/foo.bar", path.module)
}
```

A local value assigns a name to an expression, so you can use the name multiple times within a module instead of repeating the expression.
The expressions in local values are not limited to literal constants; they can also reference other values in the module in order to transform or combine them, including variables, resource attributes, or other local values.

## Terraform Settings

The special `terraform` configuration block type is used to configure some behaviors of Terraform itself, such as requiring a minimum Terraform version to apply your configuration.

* The `required_version` setting accepts a version constraint string, which specifies which versions of Terraform can be used with your configuration.
* The `required_providers` block specifies all of the providers required by the current module, mapping each local provider name to a source address and a version constraint.

  ```hcl
  terraform {
    required_version = ">= 1.15.0"
    required_providers {
      local = {
        source  = "hashicorp/local"
        version = "~> 2.0"
      }
    }
  }
  ```

* Backend Configuration documents the form of a `backend` block, which selects and configures a backend for a Terraform configuration.

  ```hcl
  terraform {
    backend "local" {}
  }
  ```

## Expressions

### References to Named Values

Terraform makes several kinds of named values available. Each of these names is an expression that references the associated value; you can use them as standalone expressions, or combine them with other expressions to compute new values.

The main kinds of named values available in Terraform are:

* Resources - `<RESOURCE TYPE>.<NAME>`
* Input variables - `var.<NAME>`
* Local values - `local.<NAME>`
* Child module outputs - `module.<MODULE NAME>.<OUTPUT NAME>`
* Data sources - `data.<DATA TYPE>.<NAME>`
* Filesystem and workspace info
  * `path.module` is the filesystem path of the module where the expression is placed.
  * `path.root` is the filesystem path of the root module of the configuration.
  * `path.cwd` is the filesystem path from which Terraform was started. It normally matches `path.root`, but advanced workflows can run Terraform from another directory.
  * `terraform.workspace` is the name of the currently selected workspace.
* Block-local values
  * `count.index`, in resources that use the count meta-argument.
  * `each.key` / `each.value`, in resources that use the for_each meta-argument.
  * `self`, in *provisioner* and *connection* blocks.

### Operators

* `!`, `-` (multiplication by -1)
* `*`, `/`, `%`, `+`, `-` (subtraction)
* `>`, `>=`, `<`, `<=`
* `==`, `!=`
* `&&`
* `||`

### Functions

The Terraform language provides [built-in functions](https://developer.hashicorp.com/terraform/language/functions){:target="_blank"} for transforming and combining values.

All functions use the same syntax:

```
<FUNCTION NAME>(<ARGUMENT 1>, <ARGUMENT 2>, ...)
```

These functions cover common workshop and production tasks:

| Function | Typical use | Example |
| --- | --- | --- |
| `upper` / `lower` | Normalize names or labels. | `upper(var.user_suffix)` |
| `trimspace` | Remove accidental whitespace from input. | `trimspace(var.name)` |
| `format` | Build a formatted string. | `format("%s-%s", var.prefix, var.name)` |
| `join` / `split` | Convert between lists and delimited strings. | `join(",", var.tags)` |
| `length` | Count characters or collection elements. | `length(var.users)` |
| `contains` | Validate whether a list or set has a value. | `contains(["small", "medium"], var.size)` |
| `merge` | Combine maps, with later values taking precedence. | `merge(var.common_tags, var.extra_tags)` |
| `coalesce` | Select the first non-null, non-empty value. | `coalesce(var.name, "default")` |
| `try` | Provide a fallback when an expression can fail. | `try(var.settings["name"], "default")` |

Prefer simple expressions when a direct reference is enough. Use `try` and similar fallbacks deliberately, so configuration errors are not hidden accidentally.

### Conditions

The condition can be any expression that resolves to a boolean value. This will usually be an expression that uses the equality, comparison, or logical operators.

The syntax of a conditional expression is as follows:

```
condition ? true_val : false_val
```

### for Expressions (loops)

A `for` expression transforms one complex value into another. Each input element can produce one value or no value in the result.

The expression inside the loop can transform each input element into the desired output value.

some examples:

```hcl
[for s in var.list : upper(s)]
[for k, v in var.map : length(k) + length(v)]
[for i, v in var.list : "${i} is ${v}"]
{for s in var.list : s => upper(s)}
```

### Iteration over resources

By default, a resource block configures one real infrastructure object.

To manage several similar objects without writing a separate block for each one, Terraform provides two repetition patterns:

* `count` creates a fixed number of instances.
* `for_each` creates one instance for each item in a map or set.

#### count

The `count` meta-argument accepts a whole number and creates that many instances of a resource or module.

Each instance has a distinct infrastructure object and is created, updated, or destroyed separately when the configuration is applied.

```hcl
resource "local_file" "foo" {
  count = 3

  content         = "Lorem Ipsum"
  filename        = format("foo-%s.txt", count.index)
  file_permission = "0644"
}
```

This object has one attribute:

* `count.index` — The distinct index number (starting with 0) corresponding to this instance.

When count is set, Terraform distinguishes between the block itself and the multiple resource or module instances associated with it. Instances are identified by an index number, starting with 0.

* `<TYPE>.<NAME>` or module. `<NAME>` (for example, aws_instance.server) refers to the resource block.
* `<TYPE>.<NAME>[<INDEX>]` or module. `<NAME>[<INDEX>]` (for example, local_file.foo[0], local_file.foo[1], etc.) refers to individual instances.

<div class="slide-break"></div>

#### for_each

The `for_each` meta-argument accepts a map or a set of strings and creates one instance for each item.

Each instance has a distinct infrastructure object and is created, updated, or destroyed separately when the configuration is applied.

```hcl
locals {
  files = {
    "foo.txt" = "Lorem Ipsum"
  }
}

resource "local_file" "foo" {
  for_each = local.files

  content         = each.value
  filename        = each.key
  file_permission = "0644"
}
```

In blocks where for_each is set, an additional each object is available in expressions, so you can modify the configuration of each instance. This object has two attributes:

* `each.key` — The map key (or set member) corresponding to this instance.
* `each.value` — The map value corresponding to this instance. (If a set was provided, this is the same as each.key.)

The map keys, or all values in a set of strings, must be known before Terraform can plan the instances.

If they depend on values known only after apply, redesign the expression or apply the prerequisite configuration first. `-target` is an exceptional recovery tool, not the normal solution.

### Dynamic blocks

```hcl
resource "aws_elastic_beanstalk_environment" "tfenvtest" {
  name                = "tf-test-name"
  application         = "${aws_elastic_beanstalk_application.tftest.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.11.4 running Go 1.12.6"

  dynamic "setting" {
    for_each = var.settings
    # iterator = "set"
    content {
      namespace = setting.value["namespace"]
      name = setting.value["name"]
      value = setting.value["value"]
    }
  }
}
```

A dynamic block acts much like a for expression, but produces nested blocks instead of a complex typed value. It iterates over a given complex value, and generates a nested block for each element of that complex value.

* The label of the dynamic block (`"setting"` in the example above) specifies what kind of nested block to generate.
* The `for_each` argument provides the complex value to iterate over.
* The `iterator` argument is optional. It names the temporary variable for the current element. If omitted, it defaults to the dynamic block label, `setting` in the example above.
* The labels argument (optional) is a list of strings that specifies the block labels, in order, to use for each generated block. You can use the temporary iterator variable in this value.
* The nested *content* block defines the body of each generated block. You can use the temporary iterator variable inside this block.

<div class="slide-break"></div>

Since the *for_each* argument accepts any collection or structural value, you can use a for expression or splat expression to transform an existing collection.

The iterator object (*setting* in the example above) has two attributes:

* `key` is the map key or list element index for the current element. If the for_each expression produces a set value then key is identical to value and should not be used.
* `value` is the value of the current element.
