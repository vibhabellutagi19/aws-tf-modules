resource "aws_s3_bucket" "this" {
  bucket        = var.bucket_name
  bucket_prefix = var.bucket_prefix
  force_destroy = var.force_destroy

  tags = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count  = var.sse_kms_encrypted_objects ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "aws:kms"
    }
  }
}
