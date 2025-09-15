data "aws_vpc" "vpc-eks" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }

  filter {
    name   = "tag:Name"
    values = ["vpc-dev-eks"]
  }
}

data "aws_subnets" "private-eks" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc-eks.id]
  }

  filter {
    name   = "tag:SubnetType"
    values = ["private-eks"]
  }
}

resource "aws_db_subnet_group" "private-eks" {
  name       = "${var.project}-${var.application}-${var.environment}-subnet-group"
  subnet_ids = data.aws_subnets.private-eks.ids

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

data "aws_security_group" "acl-allow-internal-tcp-eks" {
  vpc_id = data.aws_vpc.vpc-eks.id
  name   = "acl-allow-tcp-traffic"
  tags = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
  }
}