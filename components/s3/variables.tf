variable "project_key" {
  description = "Unique project key prefix for resources"
  type        = string
}

variable "bucket_name" {
  description = "(Optional) Name of the S3 bucket. If not provided, `bucket_prefix` will be used."
  type        = string
  default     = null
}

variable "bucket_prefix" {
  description = "(Optional) Prefix for the bucket name if `bucket_name` is not provided."
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "If `true`, allows deletion of non-empty buckets."
  type        = bool
  default     = false
}

variable "custom_bucket_policy_json" {
  description = "(Optional) Custom JSON policy for the S3 bucket."
  type        = string
  default     = ""
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default     = {}
}