resource "google_storage_bucket" "tf_state" {
  project  = var.project_id
  name     = "workshop-terraform-state-am"
  location = "EU"
}
