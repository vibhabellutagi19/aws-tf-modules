variable "project_key" {
  description = "Unique project key prefix for resources"
  type        = string
}

variable "lambda_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "lambda_source_file" {
  description = "Path to the source file of the Lambda function"
  type        = string
  default = null
}

variable "lambda_object_path" {
  description = "Path to the object file of the Lambda function"
  type        = string
  default = null
}

variable "runtime" {
  description = "Lambda runtime environment (e.g., python3.8, nodejs14.x)"
  type        = string
}

variable "handler" {
  description = "Handler for the Lambda function (e.g., index.handler)"
  type        = string
}

variable "memory" {
  description = "Memory size (MB) for the Lambda function"
  type        = number
  default     = 128
}

variable "timeout" {
  description = "Execution timeout for the Lambda function (seconds)"
  type        = number
  default     = 10
}

variable "environment_variables" {
  description = "Environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "iam_policy" {
  description = "Custom IAM policy JSON for Lambda"
  type        = Any
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "s3_bucket" {
  type        = string
  description = "S3 bucket for Lambda package"
  default     = null
}

variable "s3_key" {
  type        = string
  description = "S3 key for Lambda package"
  default     = null
}

variable "s3_object_version" {
  type        = string
  description = "S3 object version for Lambda package"
  default     = null
}

variable "image_uri" {
  type        = string
  description = "Optional container image URI for Lambda"
  default     = null
}

variable "vpc_config" {
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
  default = null
}

variable "logging_config" {
  type = object({
    log_format = string
    log_group = string
  })
  default = null
}

