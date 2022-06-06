locals {
  filename = format("%s/foo.bar", path.module)
}

resource "local_file" "foo" {
  content         = var.file_content
  filename        = local.filename
  file_permission = "0644"
}
