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

variable "aws-region" {
  type        = string
  description = "Aws-region"
  nullable    = false
}

variable "tfc-organization-name" {
  type = string
  description = "tfc-organization"
  nullable = false
}