data "tfe_workspace" "secrets" {
  organization = var.tfc-organization-name
  name         = "infra-secrets-${var.environment}"
}

data "tfe_outputs" "secrets" {
  organization = var.tfc-organization-name
  workspace    = data.tfe_workspace.secrets.name
}
