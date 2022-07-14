locals {
  files = fileset(path.module, "*")
}

resource "google_storage_bucket" "store" {
  project  = var.project_id
  name     = "workshop-terraform-store-am"
  location = "EU"
}

resource "google_storage_bucket_object" "files" {
  for_each = local.files
  name     = each.value
  source   = each.value
  bucket   = google_storage_bucket.store.name
}
