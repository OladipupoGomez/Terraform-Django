locals {
  az-numbers = {
    for idx, az in var.availability-zones : az => idx
  }

  private-subnet-offset = 128

  all-subnets = flatten([
    for i in range(var.subnet-count) : [
      for az in var.availability-zones : [
        {
          az        = az
          idx       = i
          type      = "public"
          cidr-base = (i * 2) + (local.az-numbers[az] * 2)
        },
        {
          az        = az
          idx       = i
          type      = "private"
          cidr-base = (i * 2) + (local.az-numbers[az] * 2) + local.private-subnet-offset
        }
      ]
    ]
  ])

  public-subnets = {
    for subnet in local.all-subnets :
    "${subnet.az}-pub-${subnet.idx}" => {
      az         = subnet.az
      cidr-block = cidrsubnet(var.cidr-block, 8, subnet.cidr-base)
    }
    if subnet.type == "public"
  }

  private-subnets = {
    for subnet in local.all-subnets :
    "${subnet.az}-priv-${subnet.idx}" => {
      az         = subnet.az
      cidr-block = cidrsubnet(var.cidr-block, 8, subnet.cidr-base)
    }
    if subnet.type == "private"
  }
}

locals {
  az-numbers-eks = {
    for idx, az in var.availability-zones : az => idx
  }

  private-subnet-offset-eks = 128

  all-subnets-eks = flatten([
    for i in range(var.subnet-count) : [
      for az in var.availability-zones : [
        {
          az        = az
          idx       = i
          type      = "public-eks"
          cidr-base = (i * 2) + (local.az-numbers-eks[az] * 2)
        },
        {
          az        = az
          idx       = i
          type      = "private-eks"
          cidr-base = (i * 2) + (local.az-numbers-eks[az] * 2) + local.private-subnet-offset-eks
        }
      ]
    ]
  ])

  public-subnets-eks = {
    for subnet in local.all-subnets-eks :
    "${subnet.az}-pub-${subnet.idx}" => {
      az         = subnet.az
      cidr-block = cidrsubnet(var.cidr-block-eks, 8, subnet.cidr-base)
    }
    if subnet.type == "public-eks"
  }

  private-subnets-eks = {
    for subnet in local.all-subnets-eks :
    "${subnet.az}-priv-${subnet.idx}" => {
      az         = subnet.az
      cidr-block = cidrsubnet(var.cidr-block-eks, 8, subnet.cidr-base)
    }
    if subnet.type == "private-eks"
  }
}