output "bucket_arn" {
  description = "ARN of bucket"
  value       = aws_s3_bucket.tf_state.arn
}

output "bucket" {
  description = "Objects of bucket"
  value       = aws_s3_bucket.tf_state
}
