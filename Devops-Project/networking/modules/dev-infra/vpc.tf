resource "aws_vpc" "vpc-servers" {
  cidr_block = var.cidr-block
  tags = merge(var.additional-tags,
    tomap({
      "Name"        = var.vpc-name
      "Environment" = var.environment
      "Project"     = var.project
      "Application" = var.application
    })
  )
}

resource "aws_vpc" "vpc-eks" {
  cidr_block = var.cidr-block-eks
  tags = merge(var.additional-tags,
    tomap({
      "Name"        = var.vpc-name-eks
      "Environment" = var.environment
      "Project"     = var.project
      "Application" = var.application
    })
  )
}

