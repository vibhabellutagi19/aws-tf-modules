output "bucket_name" {
  description = "The name of the created S3 bucket."
  value       = aws_s3_bucket.s3_bucket.bucket
}

output "bucket_arn" {
  description = "The ARN of the created S3 bucket."
  value       = aws_s3_bucket.s3_bucket.arn
}

output "bucket_policy_arn" {
  description = "The ARN of the S3 Bucket Policy (if created)."
  value       = length(aws_s3_bucket_policy.bucket_policy) > 0 ? aws_s3_bucket_policy.bucket_policy[0].id : null
}
