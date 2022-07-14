resource "local_file" "foo" {
  content         = "foo!"
  filename        = "${path.module}/foo.bar"
  file_permission = "0644"
}
