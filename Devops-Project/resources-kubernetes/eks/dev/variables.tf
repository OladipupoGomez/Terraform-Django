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

variable "instance-type" {
  type         = string    
  description  = "instance-type"
  nullable     = false
}

variable "namespaces" {
  type    = list(string)
  description = "list of namespaces"
  default = ["deployments", "monitoring"]
}

variable "tfc-organization-name" {
  type = string
  description = "tfc-organization"
  nullable = false
}

variable "grafana-username" {
  type = string
  description = "garafana-username"
  nullable = false
}

variable "grafana-password" {
  type = string
  description = "password"
  nullable = false
}