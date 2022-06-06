---
title: Configuration Language
permalink: /language/
---

# Configuration Language

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
