---
title: Configuration Language
permalink: /language/
nav_order: 4
---

In this section, the configuration language for terraform is explained using [Version 2 of the first HandsOn solution](https://github.com/anmoel/workshop-terraform/tree/main/solutions/first-apply/v2).

## Resources

```hcl
resource "local_file" "foo" {
  content         = "Lorem Ipsum"
  filename        = "foo.txt"
  file_permission = "0644"
}
```

A resource block declares a resource of a given type ("local_file") with a given local name ("foo").
The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside that module's scope.
The resource type and name together serve as an identifier for a given resource and so must be unique within a module.
Within the block body (between { and }) are the configuration arguments for the resource itself. Most arguments in this section depend on the resource type.

## Data Sources

Data sources allow Terraform to use information defined outside of Terraform, defined by another separate Terraform configuration, or modified by functions.

## Variables

```hcl
variable "file_content" {
  type        = string
  description = "Content of generated file"
}
```

Input variables let you customize aspects of Terraform modules without altering the module's own source code. This allows you to share modules across different Terraform configurations, making your module composable and reusable.

When you declare variables in the root module of your configuration, you can set their values using CLI options and environment variables. When you declare them in child modules, the calling module should pass values in the module block.

### Variable Arguments

Terraform defines the following optional arguments for variable declarations:

* default - A default value which then makes the variable optional.
* type - This argument specifies what value types are accepted for the variable.
* description - This specifies the input variable's documentation.
* validation - A block to define validation rules, usually in addition to type constraints.
* sensitive - Limits Terraform UI output when the variable is used in configuration.
* nullable - Specify if the variable can be null within the module.

### Types

* string: a sequence of Unicode characters representing some text, like "hello".
* number: a numeric value. The number type can represent both whole numbers like 15 and fractional values like 6.283185.
* bool: a boolean value, either true or false. bool values can be used in conditional logic.
* list (or set): a sequence of values, like ["us-west-1a", "us-west-1c"]. Elements in a list or set are identified by consecutive whole numbers, starting with zero.
* map (or object): a group of values identified by named labels, like {name = "Mabel", age = 52}.

### Set variables in terraform cli

* Set option `-var <name>=<value>`
* Set option `-var-file <path>`
* Set env variable `export TF_VAR_<name>=<value>`

Terraform loads variables in the following order, with later sources taking precedence over earlier ones:

1. Environment variables
2. The terraform.tfvars file, if present.
3. The terraform.tfvars.json file, if present.
4. Any *.auto.tfvars or*.auto.tfvars.json files, processed in lexical order of their filenames.
5. Any -var and -var-file options on the command line, in the order they are provided.

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

* value - The required value argument takes an expression whose result is to be returned to the user
* description - The description should concisely explain the purpose of the output and what kind of value is expected. This description string might be included in documentation about the module, and so it should be written from the perspective of the user of the module rather than its maintainer. For commentary for module maintainers, use comments.
* sensitive - An output can be marked as containing sensitive material using the optional sensitive argument. Terraform will hide values marked as sensitive in the messages from *terraform plan* and *terraform apply*.
* depends_on - Since output values are just a means for passing data out of a module, it is usually not necessary to worry about their relationships with other nodes in the dependency graph. However, when a parent module accesses an output value exported by one of its child modules, the dependencies of that output value allow Terraform to correctly determine the dependencies between resources defined in different modules.

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
    required_version = "1.2.2"
    required_providers {
      local = {
        source  = "hashicorp/local"
        version = "2.2.3"
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
  * `path.cwd` is the filesystem path of the current working directory. In normal use of Terraform this is the same as path.root, but some advanced uses of Terraform run it from a directory other than the root module directory, causing these paths to be different.
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

The Terraform language has a number of [built-in functions](https://www.terraform.io/language/functions) that can be used in expressions to transform and combine values. These are similar to the operators but all follow a common syntax:

```hcl
<FUNCTION NAME>(<ARGUMENT 1>, <ARGUMENT 2>)
```

### Conditions

The condition can be any expression that resolves to a boolean value. This will usually be an expression that uses the equality, comparison, or logical operators.

The syntax of a conditional expression is as follows:

```hcl
condition ? true_val : false_val
```

### for Expressions

A for expression creates a complex type value by transforming another complex type value. Each element in the input value can correspond to either one or zero values in the result, and an arbitrary expression can be used to transform each input element into an output element.

some examples:

```hcl
[for s in var.list : upper(s)]
[for k, v in var.map : length(k) + length(v)]
[for i, v in var.list : "${i} is ${v}"]
{for s in var.list : s => upper(s)}
```

### Iteration over resources

By default, a resource block configures one real infrastructure object. Sometimes you want to manage several similar objects (like a fixed pool of compute instances) without writing a separate block for each one. Terraform has two ways to do this: count and for_each.

#### count

The `count` meta-argument accepts a whole number, and creates that many instances of the resource or module. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

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

#### for_each

The `for_each` meta-argument accepts a map or a set of strings, and creates an instance for each item in that map or set. Each instance has a distinct infrastructure object associated with it, and each is separately created, updated, or destroyed when the configuration is applied.

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

The keys of the map (or all the values in the case of a set of strings) must be known values, or you will get an error message that for_each has dependencies that cannot be determined before apply, and a -target may be needed.

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
* The `iterator` argument (optional) sets the name of a temporary variable that represents the current element of the complex value. If omitted, the name of the variable defaults to the label of the dynamic block ("setting" in the example above).
* The labels argument (optional) is a list of strings that specifies the block labels, in order, to use for each generated block. You can use the temporary iterator variable in this value.
* The nested *content* block defines the body of each generated block. You can use the temporary iterator variable inside this block.

Since the *for_each* argument accepts any collection or structural value, you can use a for expression or splat expression to transform an existing collection.

The iterator object (*setting* in the example above) has two attributes:

* `key` is the map key or list element index for the current element. If the for_each expression produces a set value then key is identical to value and should not be used.
* `value` is the value of the current element.
