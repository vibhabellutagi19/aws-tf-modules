resource "aws_s3_object" "this" {
  bucket       = var.bucket
  key          = var.key
  source       = var.source_path
  etag         = filemd5(var.source_path)
  content_type = var.content_type
  kms_key_id   = var.kms_key_id
  acl          = var.acl
  tags         = var.tags
}