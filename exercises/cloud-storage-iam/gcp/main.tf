locals {
  files = fileset(path.module, "*")
}

resource "google_storage_bucket" "store" {
  name     = "workshop-terraform-store-am"
  location = "EU"
}

resource "google_storage_bucket_object" "files" {
  for_each = local.files
  name     = each.value
  source   = each.value
  bucket   = google_storage_bucket.store.name
}

resource "google_storage_bucket_iam_member" "viewer" {
  bucket = google_storage_bucket.store.name
  role   = "roles/storage.viewer"
  member = "user:jens.walter@datadrivers.de"
}
