output "role_arn" {
  description = "ARN of the IAM Role"
  value       = aws_iam_role.this.arn
}

output "policy_arn" {
  description = "ARN of the IAM Policy"
  value       = aws_iam_policy.this.arn
}

output "group_name" {
  description = "IAM Group Name (if created)"
  value       = var.create_group ? aws_iam_group.this[0].name : null
}
