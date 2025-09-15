data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Environment"
    values = [var.environment]
  }

  filter {
    name   = "tag:Name"
    values = ["vpc-dev"]
  }
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc.id]
  }

  filter {
    name   = "tag:SubnetType"
    values = ["private"]
  }
}

resource "aws_db_subnet_group" "private" {
  name       = "${var.project}-${var.application}-${var.environment}-subnet-group"
  subnet_ids = data.aws_subnets.private.ids

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

data "aws_security_group" "acl-allow-internal-tcp" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "acl-allow-tcp-traffic"
  tags = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
  }
}