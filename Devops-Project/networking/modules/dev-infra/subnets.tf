resource "aws_subnet" "public" {
  for_each                = local.public-subnets
  vpc_id                  = aws_vpc.vpc-servers.id
  cidr_block              = each.value.cidr-block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-${var.subnet-name}-${each.key}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
    SubnetType  = "Public"
  }
}

resource "aws_subnet" "private" {
  for_each                = local.private-subnets
  vpc_id                  = aws_vpc.vpc-servers.id
  cidr_block              = each.value.cidr-block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = {
    Name        = "private-${var.subnet-name}-${each.key}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
    SubnetType  = "private"
  }
}

resource "aws_subnet" "public-eks" {
  for_each                = local.public-subnets-eks
  vpc_id                  = aws_vpc.vpc-eks.id
  cidr_block              = each.value.cidr-block
  availability_zone       = each.value.az
  map_public_ip_on_launch = true

  tags = {
    Name        = "public-eks-${var.subnet-name}-${each.key}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
    SubnetType  = "Public-eks"
  }
}

resource "aws_subnet" "private-eks" {
  for_each                = local.private-subnets-eks
  vpc_id                  = aws_vpc.vpc-eks.id
  cidr_block              = each.value.cidr-block
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = {
    Name        = "private-eks-${var.subnet-name}-${each.key}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
    SubnetType  = "private-eks"
  }
}