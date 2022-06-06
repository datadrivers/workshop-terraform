locals {
  files = fileset(path.module, "*")
}

module "gcs" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "3.2.0"

  project_id       = var.project_id
  names            = ["module"]
  prefix           = "tf-workshop"
  location         = var.region
  randomize_suffix = true
  labels           = var.labels
  set_viewer_roles = true

  versioning = {
    "module" = true
  }
  bucket_policy_only = {
    "module" = true
  }
  viewers = ["allUsers"]
}

resource "google_storage_bucket_object" "files" {
  for_each = local.files
  name     = each.value
  source   = each.value
  bucket   = google_storage_bucket.store.name
}
