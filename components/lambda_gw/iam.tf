resource "aws_iam_role" "api_gateway_role" {
  name = "${var.project_key}-${var.api_name}-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "apigateway.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.api_name}-role" }
  )
}

resource "aws_iam_policy" "api_gateway_lambda_policy" {
  name   = "${var.project_key}-${var.api_name}-policy"
  policy = var.custom_api_gateway_policy_json

  tags = merge(
    var.default_tags,
    { "Name" = "${var.project_key}-${var.api_name}-policy" }
  )
}

resource "aws_iam_role_policy_attachment" "api_gateway_lambda_attach" {
  role       = aws_iam_role.api_gateway_role.name
  policy_arn = aws_iam_policy.api_gateway_lambda_policy.arn
}