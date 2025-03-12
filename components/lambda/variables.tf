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

variable "custom_policy_json" {
  description = "Custom IAM policy JSON for Lambda"
  type        = string
  default     = ""
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default     = {}
}
