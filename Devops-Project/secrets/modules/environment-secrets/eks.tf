data "tfe_workspace" "eks" {
  organization = var.tfc-organization-name
  name         = "devops-kubernetes-${var.environment}"
}

data "tfe_outputs" "devops-kubernetes-development" {
  organization = var.tfc-organization-name
  workspace    = data.tfe_workspace.eks.name
}