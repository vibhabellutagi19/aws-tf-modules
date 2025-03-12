data "archive_file" "lambda" {
  type        = "zip"
  source_file = var.lambda_source_file
  output_path = "${var.lambda_name}.zip"
}

resource "aws_lambda_function" "lambda_function" {
  filename         = data.archive_file.lambda.output_path
  function_name    = "${var.project_key}-${var.lambda_name}"
  role             = aws_iam_role.iam_for_lambda.arn
  handler          = var.handler
  runtime          = var.runtime
  timeout          = var.timeout
  memory_size      = var.memory

  source_code_hash = data.archive_file.lambda.output_base64sha256

  environment {
    variables = var.environment_variables
  }

  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.lambda_name}" }
  )
}
