output "bucket_objects" {
  description = "the generated bucket object urls"
  value       = [for k, v in google_storage_bucket_object.files : v.self_link]
}
