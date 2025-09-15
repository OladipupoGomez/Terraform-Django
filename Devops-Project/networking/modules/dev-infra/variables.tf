variable "vpc-name" {
  type        = string
  description = "Name for this VPC"
  nullable    = false
}

variable "vpc-name-eks" {
  type        = string
  description = "Name for this VPC"
  nullable    = false
}

variable "subnet-name" {
  type        = string
  description = "Name for Subnets"
  nullable    = false
}

variable "cidr-block" {
  type        = string
  description = "Assigned network block for this VPC (CIDR notation)"
  nullable    = false
}

variable "cidr-block-eks" {
  type        = string
  description = "Assigned network block for this VPC-EKS (CIDR notation)"
  nullable    = false
}

variable "region-code" {
  type        = string
  description = "Code for AWS region this VPC is being provisioned in"
}

variable "additional-tags" {
  type        = map
  description = "Additional tags to apply to this VPC and its associated resources"
  nullable    = false
  default     = {}
}

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

variable "subnet-count" {
  type        = number
  description = "The number of subnets to create"
  nullable    = false
}

variable "availability-zones" {
  type        = list(string)
  description = "A list of availability zones for the subnets."
  nullable    = false
}

variable "postgres-port" {
  type        = number
  description = "postgres connection port"
  nullable    = false
}

variable "Django-port" {
  type        = number
  description = "Django-app-port"
  nullable    = false
}