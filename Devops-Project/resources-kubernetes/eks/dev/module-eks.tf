module "dev-kubernetes" {
  source = "./modules/new-eks"

  providers = {
    aws = aws.us-east-1
  }

  environment  = var.environment
  application  = var.application
  project      = var.project
  aws-region = var.aws-region
  instance-type = var.instance-type
  grafana-password = var.grafana-password
  grafana-username = var.grafana-username
}
output "cluster-name" {
  value = module.dev-kubernetes.cluster-name
}

module "dev-kubernetes-dependencies" {
  source = "./modules/eks-dependencies"

  providers = {
    aws = aws.us-east-1
  }

  environment  = var.environment
  application  = var.application
  project      = var.project
  aws-region = var.aws-region
  instance-type = var.instance-type
  cluster-name = module.dev-kubernetes.cluster-name
  namespaces = var.namespaces
  tfc-organization-name = var.tfc-organization-name
  grafana-password = var.grafana-password
  grafana-username = var.grafana-username
}

