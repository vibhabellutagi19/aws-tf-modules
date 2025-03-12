resource "aws_s3_bucket" "this" {
  bucket = "${var.project_key}-${var.bucket_name}"
  force_destroy       = var.force_destroy
  object_lock_enabled = var.object_lock_enabled
  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.bucket_name}" }
  )
}

resource "aws_iam_role" "s3_role" {
  name = "${var.project_key}-${var.iam_role_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Effect": "Allow",
      "Principal": { "Service": "s3.amazonaws.com" }
    }
  ]
}
EOF
}

resource "aws_iam_policy" "custom_policy" {
  name   = "${var.project_key}-${var.policy_name}"
  policy = var.custom_policy_json
}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.s3_role.name
  policy_arn = aws_iam_policy.custom_policy.arn
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
