variable "project_key" {
  description = "Unique project key prefix for resources"
  type        = string
}

variable "custom_api_gateway_policy_json" {
  default = ""
  description = "Custom IAM policy JSON for API Gateway"
  type        = string
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "api_name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "authorizer_type" {
  default = "JWT"
  description = "The type of authorizer. Currently the only valid value is REQUEST, for a Lambda function using incoming request parameters."
}

variable "lambda_invoke_arn" {
    description = "ARN of the Lambda function to be invoked"
    type        = string
}

variable "integration_method" {
    description = "HTTP method for the integration"
    type        = string
    default     = "POST"
}

variable "jwt_audience" {
    description = "Audience for the JWT"
    type        = string
}

variable "jwt_issuer" {
    description = "Issuer for the JWT, you can use the Cognito User Pool ID"
    type        = string
}

variable "stage_name" {
  default = "dev"
  description = "Name of the API Gateway stage"
  type        = string
}