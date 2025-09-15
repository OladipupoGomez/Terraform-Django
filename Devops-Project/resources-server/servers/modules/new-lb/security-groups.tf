data "aws_security_group" "acl-allow-all-outbound-traffic" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "acl-allow-all-outbound-traffic"
  tags   = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
  }
}

data "aws_security_group" "acl-allow-http-https-traffic" {
  vpc_id = data.aws_vpc.vpc.id
  name   = "acl-allow-http/https-traffic"
  tags = {
    "Project"     = "infra"
    "Application" = "networking"
    "Environment" = var.environment
  }
}