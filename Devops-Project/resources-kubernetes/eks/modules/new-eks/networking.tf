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

data "aws_subnets" "public-eks" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.vpc-eks.id]
  }

  filter {
    name   = "tag:SubnetType"
    values = ["Public-eks"]
  }
}

data "aws_security_group" "acl-allow-eks-cluster-traffic" {
  vpc_id = data.aws_vpc.vpc-eks.id
  name   = "allow-eks-cluster-traffic"
  tags   = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
  }
}

#incase it is needed in future
data "aws_security_group" "acl-allow-eks-node-traffic" { 
  vpc_id = data.aws_vpc.vpc-eks.id
  name   = "allow-eks-node-traffic"
  tags   = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
  }
}  


