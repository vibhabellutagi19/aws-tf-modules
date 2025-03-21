output "arn" {
  value = aws_s3_object.this.arn
}

output "key" {
  value = aws_s3_object.this.key
}

output "etag" {
  value = aws_s3_object.this.etag
}
