variable "description" {
  type        = string
  default     = "KMS key managed by Terraform"
}

variable "deletion_window_in_days" {
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
}

variable "policy" {
  type        = string
  default     = null
}

variable "tags" {
  type        = map(string)
  default     = {}
}

variable "project_key" {
    type        = string
    default     = "default"
}