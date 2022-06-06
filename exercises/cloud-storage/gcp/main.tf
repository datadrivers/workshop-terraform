resource "google_storage_bucket" "tf_state" {
  name     = "workshop-terraform-state-am"
  location = "EU"
}
