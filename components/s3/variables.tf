variable "bucket_name" {
  description = "The name of the S3 bucket (if provided, bucket_prefix will be ignored)"
  type        = string
  default     = null
}

variable "bucket_prefix" {
  description = "Prefix for the bucket name (Terraform will generate a unique suffix)"
  type        = string
  default     = null
}

variable "force_destroy" {
  description = "Boolean flag to allow force deletion of the bucket"
  type        = bool
  default     = false
}

variable "sse_kms_encrypted_objects" {
  description = "Enable KMS encryption for objects in the bucket"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags for the S3 bucket"
  type        = map(string)
  default     = {}
}
