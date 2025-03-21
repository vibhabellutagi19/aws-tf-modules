output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.lambda.function_name
}

output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.lambda.arn
}

output "iam_role_arn" {
  description = "IAM Role ARN assigned to Lambda"
  value       = aws_iam_role.iam_for_lambda.arn
}
