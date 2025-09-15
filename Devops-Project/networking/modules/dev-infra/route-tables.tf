#SERVER GATEWAY

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc-servers.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name        = "public-route-table-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc-servers.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw.id
  }

  tags = {
    Name        = "private-route-table-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_route_table_association" "public" {
  for_each       = local.public-subnets
  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  for_each       = local.private-subnets
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private.id
}

#KUBERNETES GATEWAY

resource "aws_route_table" "public-eks" {
  vpc_id = aws_vpc.vpc-eks.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-eks.id
  }

  tags = {
    Name        = "public-route-table-eks-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_route_table" "private-eks" {
  vpc_id = aws_vpc.vpc-eks.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ngw-eks.id
  }

  tags = {
    Name        = "private-route-table-eks-${var.environment}"
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_route_table_association" "public-eks" {
  for_each       = local.public-subnets-eks
  subnet_id      = aws_subnet.public-eks[each.key].id
  route_table_id = aws_route_table.public-eks.id
}

resource "aws_route_table_association" "private-eks" {
  for_each       = local.private-subnets-eks
  subnet_id      = aws_subnet.private-eks[each.key].id
  route_table_id = aws_route_table.private-eks.id
}