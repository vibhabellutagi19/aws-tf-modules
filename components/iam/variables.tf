variable "project_key" {
  description = "Unique project key prefix for resources"
  type        = string
}

variable "role_name" {
  description = "IAM Role name"
  type        = string
}

variable "policy_name" {
  description = "IAM Policy name"
  type        = string
}

variable "policy_json" {
  description = "JSON policy for IAM role"
  type        = string
}

variable "assume_role_policy" {
  description = "JSON assume role policy document"
  type        = string
}

variable "create_group" {
  description = "Whether to create an IAM group"
  type        = bool
  default     = false
}

variable "group_name" {
  description = "IAM Group name (if created)"
  type        = string
  default     = ""
}
