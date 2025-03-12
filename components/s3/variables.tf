variable "project_key" {
  description = "Unique project key prefix for resources"
  type        = string
}

variable "bucket_name" {
  description = "S3 Bucket name"
  type        = string
}

variable "force_destroy" {
  description = "(Optional, Default:false ) A boolean that indicates all objects should be deleted from the bucket so that the bucket can be destroyed without error. These objects are not recoverable."
  type        = bool
  default     = false
}

variable "object_lock_enabled" {
  description = "Whether S3 bucket should have an Object Lock configuration enabled."
  type        = bool
  default     = false
}

variable "iam_role_name" {
  description = "IAM Role name for S3"
  type        = string
}

variable "policy_name" {
  description = "IAM Policy name"
  type        = string
}

variable "custom_policy_json" {
  description = "Custom IAM policy in JSON format"
  type        = string
}

variable "default_tags" {
  description = "Default tags applied to all resources"
  type        = map(string)
  default     = {}
}

variable "sse_kms_encrypted_objects" {
  description = "Enable KMS encryption for objects in the bucket"
  type        = bool
  default     = false
}