# Create S3 Bucket
resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name != null ? var.bucket_name : "${var.project_key}-${var.bucket_prefix}"
  force_destroy = var.force_destroy

  tags = merge(
    var.default_tags,
    { "Name" = var.bucket_name != null ? var.bucket_name : "${var.project_key}-${var.bucket_prefix}" }
  )
}

# Attach an S3 Bucket Policy (if provided)
resource "aws_s3_bucket_policy" "this" {
  count  = var.custom_bucket_policy_json != "" ? 1 : 0
  bucket = aws_s3_bucket.this.id
  policy = var.custom_bucket_policy_json
}
