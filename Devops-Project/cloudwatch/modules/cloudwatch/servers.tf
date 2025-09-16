data "tfe_workspace" "devops-servers" {
  organization = var.tfc-organization-name
  name         = "devops-servers-${var.environment}"
}

data "tfe_outputs" "devops-servers-development" {
  organization = var.tfc-organization-name
  workspace    = data.tfe_workspace.devops-servers.name
}