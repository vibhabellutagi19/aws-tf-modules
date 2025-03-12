# Create S3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket_name != null ? var.bucket_name : "${var.project_key}-${var.bucket_prefix}"
  force_destroy = var.force_destroy

  tags = merge(
    var.additional_tags,
    { "project_key" = var.project_key }
  )
}

# Attach an S3 Bucket Policy (if provided)
resource "aws_s3_bucket_policy" "bucket_policy" {
  count  = var.custom_bucket_policy_json != "" ? 1 : 0
  bucket = aws_s3_bucket.s3_bucket.id
  policy = var.custom_bucket_policy_json
}
