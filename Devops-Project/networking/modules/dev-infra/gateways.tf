#SERVER GATEWAY
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc-servers.id

  tags = {
    Name        = "igw-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_eip" "nat-eip" {
  provider   = aws
  depends_on = [aws_internet_gateway.igw]

  tags = {
    Name        = "nat-eip-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = aws_subnet.public[keys(local.public-subnets)[0]].id

  tags = {
    Name        = "ngw-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

#KUBERNETES GATEWAY

resource "aws_internet_gateway" "igw-eks" {
  vpc_id = aws_vpc.vpc-eks.id

  tags = {
    Name        = "igw-eks-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_eip" "nat-eip-eks" {
  provider   = aws
  depends_on = [aws_internet_gateway.igw-eks]

  tags = {
    Name        = "nat-eip-eks-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_nat_gateway" "ngw-eks" {
  allocation_id = aws_eip.nat-eip-eks.id
  subnet_id     = aws_subnet.public-eks[keys(local.public-subnets-eks)[0]].id

  tags = {
    Name        = "ngw-eks-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

