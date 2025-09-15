data "aws_security_group" "acl-allow-internal-ssh-traffic" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "acl-allow-internal-ssh-traffic"
  tags   = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
  }
}
 
data "aws_security_group" "acl-allow-all-outbound-traffic" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "acl-allow-all-outbound-traffic"
  tags   = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
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

data "aws_security_group" "acl-allow-alb-traffic" {  
  vpc_id = data.aws_vpc.vpc.id
  name   = "allow-alb-traffic"
  tags = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
  }
}

