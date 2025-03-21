data "archive_file" "lambda" {
  count       = var.s3_bucket == null && var.image_uri == null ? 1 : 0
  type        = "zip"
  source_file = var.lambda_source_file
  output_path = var.lambda_object_path
}

resource "aws_lambda_function" "lambda" {
  function_name = "${var.project_key}-${var.lambda_name}"
  role          = aws_iam_role.iam_for_lambda.arn
  handler       = var.handler
  runtime       = var.runtime
  timeout       = var.timeout
  memory_size   = var.memory

  # Deployment package - Either local file or S3-based
  filename             = var.s3_bucket == null && var.image_uri == null ? data.archive_file.lambda[0].output_path : null
  source_code_hash     = var.s3_bucket == null && var.image_uri == null ? data.archive_file.lambda[0].output_base64sha256 : null

  s3_bucket            = var.s3_bucket
  s3_key               = var.s3_key
  s3_object_version    = var.s3_object_version

  image_uri            = var.image_uri # Optional, for container-based lambda

  environment {
    variables = var.environment_variables
  }

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? [1] : []
    content {
      subnet_ids         = var.vpc_config.subnet_ids
      security_group_ids = var.vpc_config.security_group_ids
    }
  }

  dynamic "logging_config" {
    for_each = var.logging_config != null ? [1] : []
    content {
      log_format            = var.logging_config.log_format
      log_group             = var.logging_config.log_group
    }
  }

  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.lambda_name}" }
  )
}
