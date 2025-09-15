variable "environment" {
  type        = string
  description = "The environment category that these resources fall under."
  nullable    = false

  validation {
    condition     = contains([ "development", "staging", "production"], var.environment)
    error_message = "Valid values for environment: development, staging, or production."
  }
}

variable "application" {
  type        = string
  description = "The specific code for the application component being provisioned."
  nullable    = false
}

variable "project" {
  type        = string
  description = "The specific code for the project being provisioned."
  nullable    = false
}

variable "region-code" {
  type = string
  description = "Region-code"
  nullable = false 
}

variable "iam_role_name" {
  description = "The name of the IAM role for the servers."
  type        = string
}