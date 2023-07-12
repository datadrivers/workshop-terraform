locals {
  aws_account_id = data.aws_caller_identity.current.account_id
  aws_region     = data.aws_region.current.name
}

resource "aws_s3_bucket" "tf_state" {
  bucket = "${var.bucket_name}-${aws_region}-${local.aws_account_id}"

  tags = {
    Environment = "Dev"
  }
}
