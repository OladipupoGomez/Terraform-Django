terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.13.0"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.20.0"
      }
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
     }
  }
}

data "aws_eks_cluster" "cluster_name" {
  name = var.cluster-name
  depends_on = [var.cluster-name]
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.cluster-name
  depends_on = [var.cluster-name]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster_name.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_name.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster_name.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_name.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
  load_config_file       = false
}

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.cluster_name.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster_name.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.cluster_auth.token
  }
}