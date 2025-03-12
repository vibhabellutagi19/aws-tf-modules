output "bucket_name" {
  value = aws_s3_bucket.this.id
}

output "bucket_arn" {
  value = aws_s3_bucket.this.arn
}

output "iam_role_arn" {
  description = "ARN of the IAM role"
  value       = aws_iam_role.s3_role.arn
}

output "policy_arn" {
  description = "ARN of the attached IAM policy"
  value       = aws_iam_policy.custom_policy.arn
}
