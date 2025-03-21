data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "${var.project_key}-${var.lambda_name}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role.json

  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.lambda_name}-role" }
  )
}

resource "aws_iam_policy" "custom_lambda_policy" {
  name   = "${var.project_key}-${var.lambda_name}-policy"
  policy = var.iam_policy

  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.lambda_name}-policy" }
  )
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = aws_iam_policy.custom_lambda_policy.arn
}