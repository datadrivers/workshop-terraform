---
title: Modules
permalink: /modules/
nav_order: 6
---

# Modules

## The Root Module

Every Terraform configuration has at least one module, known as its root module, which consists of the resources defined in the `.tf` files in the main working directory.

## Child Modules

A Terraform module (usually the root module of a configuration) can call other modules to include their resources into the configuration. A module that has been called by another module is often referred to as a child module.

Child modules can be called multiple times within the same configuration, and multiple configurations can use the same child module.

```hcl
module "consul" {
  source  = "hashicorp/consul/aws"
  version = "0.0.5"

  servers = 3
}
```

## Published Modules

In addition to modules from the local filesystem, Terraform can load modules from a public or private registry. This makes it possible to publish modules for others to use, and to use modules that others have published.

The [Terraform Registry](https://registry.terraform.io/){:target="_blank"} hosts a broad collection of publicly available Terraform modules for configuring many kinds of common infrastructure. These modules are free to use, and Terraform can download them automatically if you specify the appropriate source and version in a module call block.

## Module arguments

Within the block body (between `{` and `}`) are the arguments for the module. Module calls use the following kinds of arguments:

* The `source` argument is mandatory for all modules.
* The `version` argument is recommended for modules from a registry.
* Most other arguments correspond to input variables defined by the module.
* Terraform defines a few other meta-arguments that can be used with all modules:
  * `count` - Creates multiple instances of a module from a single module block. See the count page for details.
  * `for_each` - Creates multiple instances of a module from a single module block.
  * `providers` - Passes provider configurations to a child module. If not specified, the child module inherits all of the default (un-aliased) provider configurations from the calling module.
  * `depends_on` - Creates explicit dependencies between the entire module and the listed targets.

## Module Sources

The source argument in a module block tells Terraform where to find the source code for the desired child module.

Terraform uses this during the module installation step of terraform init to download the source code to a directory on local disk so that it can be used by other Terraform commands.
The module installer supports installation from a number of different source types, as listed below.

* local paths - `source = "./consul"`
* Terraform Registry - `source = "hashicorp/consul/aws"`
* GitHub - `source = "github.com/hashicorp/example"`, `source = "git@github.com:hashicorp/example.git"`
* Bitbucket - `source = "bitbucket.org/hashicorp/terraform-consul-aws"`
* Generic Git, Mercurial repositories - `source = "git::https://example.com/vpc.git""`, `source = "git::ssh://username@example.com/storage.git"`
  * Selecting a Revision  `source = "git::https://example.com/vpc.git?ref=v1.2.0"`
* HTTP URLs - `source = "https://example.com/vpc-module.zip"`
  The extensions that Terraform recognizes for this special behavior are:
  * zip
  * tar.bz2 and tbz2
  * tar.gz and tgz
  * tar.xz and txz

* S3 buckets - `source = "s3::https://s3-eu-west-1.amazonaws.com/examplecorp-terraform-modules/vpc.zip"`
* GCS buckets - `source = "gcs::https://www.googleapis.com/storage/v1/modules/foomodule.zip"`
* Modules in Package Sub-directories - `source = hashicorp/consul/aws//modules/consul-cluster`, `source = "git::https://example.com/network.git//modules/vpc"`
