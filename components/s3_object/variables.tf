variable "bucket" {
  type        = string
  description = "S3 bucket name"
}

variable "key" {
  type        = string
  description = "S3 object key (path)"
}

variable "source_path" {
  type        = string
  description = "Path to local file to upload"
}

variable "content_type" {
  type        = string
  default     = "binary/octet-stream"
}

variable "kms_key_id" {
  type        = string
  default     = null
}

variable "acl" {
  type        = string
  default     = "private"
}

variable "tags" {
  type        = map(string)
  default     = {}
}
