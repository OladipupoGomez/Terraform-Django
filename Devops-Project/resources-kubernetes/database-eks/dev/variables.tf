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

variable "tfc-organization-name" {
  type = string
  description = "tfc-organization"
  nullable = false
}

variable "instance-size" {
  type     = string
  description = "db-instance-size"
  nullable = false
}

variable "storage-size" {
  type     = number
  nullable = false
}

variable "rds-name-eks" {
  type     = string
  description = "db-name"
  nullable = false
}

variable "backup-window" {
  type     = string
  default  = "17:00-17:30"
  nullable = false
}

variable "maintenance-window" {
  type     = string
  default  = "Sat:00:00-Sat:07:59"
  nullable = false
}

variable "db-engine-version" {
  type     = string
  nullable = false
}

variable "db-engine" {
  type     = string
  nullable = false
}

variable "rds-username" {
  type     = string
  description = "db-user-name"
  nullable = false
}