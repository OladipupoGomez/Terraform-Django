resource "aws_security_group" "acl-allow-internal-ssh-traffic" {
  name        = "acl-allow-internal-ssh-traffic"
  description = "Allow internal-originating SSH traffic"
  vpc_id      = aws_vpc.vpc-servers.id

  tags = {
    "Name"        = "acl-allow-internal-ssh-traffic-${var.environment}"
    "Environment" = var.environment
    "Project"     = var.project
    "Application" = var.application
  }
}

resource "aws_vpc_security_group_ingress_rule" "acl-allow-internal-ssh-traffic-tcp" {
  security_group_id = aws_security_group.acl-allow-internal-ssh-traffic.id

  description = "Ingress SSH traffic"
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  to_port     = 22
}

resource "aws_security_group" "acl-allow-all-outbound-traffic" {
  name        = "acl-allow-all-outbound-traffic"
  description = "Allow outbound traffic"
  vpc_id      = aws_vpc.vpc-servers.id

  tags = {
    "Name"        = "acl-allow-all-outbound-traffic-${var.environment}"
    "Environment" = var.environment
    "Project"     = var.project
    "Application" = var.application
  }
}

resource "aws_vpc_security_group_egress_rule" "acl-allow-all-outbound-traffic" {
  security_group_id = aws_security_group.acl-allow-all-outbound-traffic.id

  description = "Any egress traffic"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}


resource "aws_security_group" "acl-allow-http-https-traffic" {
  name        = "acl-allow-http/https-traffic"
  description = "Allow all HTTP/HTTPS traffic"
  vpc_id      = aws_vpc.vpc-servers.id

  tags = {
    "Name"            = "acl-allow-http/https-traffic-${var.environment}"
    "Environment" = var.environment
    "Project"     = var.project
    "Application" = var.application
  }
}

resource "aws_vpc_security_group_ingress_rule" "acl-allow-http-traffic-port" {
  security_group_id = aws_security_group.acl-allow-http-https-traffic.id

  description = "Ingress HTTP traffic"
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 80
  to_port     = 80
}

resource "aws_vpc_security_group_ingress_rule" "acl-allow-https-traffic-port" {
  security_group_id = aws_security_group.acl-allow-http-https-traffic.id

  description = "Ingress HTTPS traffic"
  ip_protocol = "tcp"
  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 443
  to_port     = 443
}

resource "aws_security_group" "acl-allow-internal-tcp" {
  name        = "acl-allow-tcp-traffic"
  description = "Allow internal tcp traffic"
  vpc_id      = aws_vpc.vpc-servers.id

  tags = {
    "Name"        = "acl-allow-tcp-traffic-${var.environment}"
    "Environment" = var.environment
    "Project"     = var.project
    "Application" = var.application
  }
}

resource "aws_vpc_security_group_ingress_rule" "acl-allows-ec2-to-rds" {
  security_group_id = aws_security_group.acl-allow-internal-tcp.id
  description       = "Allow PostgreSQL from app EC2"
  cidr_ipv4         = var.cidr-block
  ip_protocol       = "tcp"
  from_port         = var.postgres-port
  to_port           = var.postgres-port
}

resource "aws_security_group" "acl-allow-alb-traffic" {
  name        = "allow-alb-traffic"
  description = "Allow alb traffic"
  vpc_id      = aws_vpc.vpc-servers.id

  tags = {
    "Name"            = "acl-allow-app-traffic-${var.environment}"
    "Environment" = var.environment
    "Project"     = var.project
    "Application" = var.application
  }
}

resource "aws_security_group_rule" "acl-allow-alb-traffic" {
  type                     = "ingress"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.acl-allow-http-https-traffic.id
  security_group_id        = aws_security_group.acl-allow-alb-traffic.id
  description              = "Allow HTTP from ALB"
}

resource "aws_security_group" "acl-allow-eks-cluster-traffic" {
  name        = "allow-eks-cluster-traffic"
  description = "Allow-eks-cluster-traffic"
  vpc_id      = aws_vpc.vpc-eks.id

  tags = {
    "Name"        = "acl-eks-cluster-traffic-${var.environment}"
    "Environment" = var.environment
    "Project"     = var.project
    "Application" = var.application
  }
}

resource aws_vpc_security_group_egress_rule "acl-allow-eks-outbound-traffic" {
  security_group_id = aws_security_group.acl-allow-eks-cluster-traffic.id

  description = "Any egress traffic"
  ip_protocol = "-1"
  cidr_ipv4   = "0.0.0.0/0"
}

resource "aws_security_group" "acl-allow-eks-node-traffic" {
  name        = "allow-eks-node-traffic"
  description = "Allow-eks-node-traffic"
  vpc_id      = aws_vpc.vpc-eks.id

  tags = {
    "Name"        = "acl-eks-node-traffic-${var.environment}"
    "Environment" = var.environment
    "Project"     = var.project
    "Application" = var.application
  }
}

resource "aws_vpc_security_group_ingress_rule" "acl-allow-node-to-cluster" {
  security_group_id            = aws_security_group.acl-allow-eks-cluster-traffic.id
  description                  = "Allow worker nodes to talk to cluster"
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.acl-allow-eks-node-traffic.id
}

resource "aws_vpc_security_group_ingress_rule" "acl-allow-cluster-to-node" {
  security_group_id            = aws_security_group.acl-allow-eks-node-traffic.id
  description                  = "Allow cluster control plane to talk to worker nodes"
  ip_protocol                  = "-1"
  referenced_security_group_id = aws_security_group.acl-allow-eks-cluster-traffic.id
}

resource "aws_security_group" "acl-allow-internal-tcp-eks" {
  name        = "acl-allow-tcp-traffic"
  description = "Allow internal tcp traffic"
  vpc_id      = aws_vpc.vpc-eks.id

  tags = {
    "Name"        = "acl-allow-tcp-traffic-${var.environment}"
    "Environment" = var.environment
    "Project"     = var.project
    "Application" = var.application
  }
}

resource "aws_vpc_security_group_ingress_rule" "acl-allows-eks-to-rds" {
  security_group_id = aws_security_group.acl-allow-internal-tcp-eks.id
  description       = "Allow PostgreSQL from eks"
  cidr_ipv4         = var.cidr-block-eks
  ip_protocol       = "tcp"
  from_port         = var.postgres-port
  to_port           = var.postgres-port
}