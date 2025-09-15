resource "aws_eks_cluster" "eks" {
  name = "eks-${var.environment}"

  access_config {
    authentication_mode = "API"
  }

  role_arn = aws_iam_role.cluster.arn
  version  = "1.33"

  vpc_config {
    endpoint_private_access = true
    endpoint_public_access  = true
    subnet_ids = data.aws_subnets.private-eks.ids
    security_group_ids = [ data.aws_security_group.acl-allow-eks-cluster-traffic.id ]
  }

  compute_config {
    enabled       = false
  }

  bootstrap_self_managed_addons = true

  storage_config {
    block_storage {
      enabled = false
    }
  }

  kubernetes_network_config {
    elastic_load_balancing {
      enabled = false
    }
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}

resource "aws_eks_node_group" "eks-node-group" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "${var.environment}-node-group"
  node_role_arn   = aws_iam_role.node-group.arn
  subnet_ids =  data.aws_subnets.private-eks.ids

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 8
    max_size     = 10
    min_size     = 7
  }

  ami_type       = "AL2023_x86_64_STANDARD"
  instance_types = [var.instance-type]

  update_config {
    max_unavailable = 1
  }

#uncomment to use ssh-access
  # remote_access {
  #    source_security_group_ids = [ data.aws_security_group.acl-allow-eks-node-traffic.id ]
  #   #  ec2_ssh_key = ""
  # }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.node-group-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-group-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-group-AmazonEC2ContainerRegistryReadOnly,
  ]
tags = {
    Name = "${var.environment}-node-group"
    Environment = var.environment
  }
}