resource "tfe_workspace" "workspace" {
  name         = "${var.project}-${var.application}-${var.environment}"
  organization = data.tfe_organization.organization.name

  tag_names = [
    var.project,
    var.application,
    var.environment,
  ]
}

resource "tfe_variable" "project_workspace" {
  key          = "project"
  value        = var.project
  category     = "terraform"
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "environment_workspace" {
  key          = "environment"
  value        = var.environment
  category     = "terraform"
  workspace_id = tfe_workspace.workspace.id
}

resource "tfe_variable" "application_workspace" {
  key          = "application"
  value        = var.application
  category     = "terraform"
  workspace_id = tfe_workspace.workspace.id
}

data "tfe_variable_set" "shared" {
  name         = "${var.environment}-shared"
  organization = data.tfe_organization.organization.name
}

resource "tfe_workspace_variable_set" "shared-variable-set" {
  variable_set_id = data.tfe_variable_set.shared.id
  workspace_id    = tfe_workspace.workspace.id
}
