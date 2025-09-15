terraform {
  required_version = "~> 1"

  cloud {
    organization = "Devops-Project-Django101"

    workspaces {
      tags = [
        "project:devops",
        "environment:development",
        "environment:staging",
        "environment:production"
      ]
    }
  }
}
