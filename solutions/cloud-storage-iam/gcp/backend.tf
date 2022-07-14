terraform {
  backend "gcs" {
    bucket = "workshop-terraform-state-am"
  }
}
