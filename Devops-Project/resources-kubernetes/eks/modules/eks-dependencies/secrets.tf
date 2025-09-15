resource "random_string" "django_secret_key" {
  length  = 50
  special = true
  upper   = true
  lower   = true
  numeric  = true
}


resource "kubernetes_secret" "django" {
  metadata {
    name      = "django-secrets"
    namespace = "deployments"
  }

  data = {
    DJANGO_SECRET_KEY = base64encode(random_string.django_secret_key.result)
    DB_NAME           = base64encode(data.tfe_outputs.secrets.values.RDS_NAME)
    DB_USER           = base64encode(data.tfe_outputs.secrets.values.RDS_USERNAME)
    DB_PASSWORD       = base64encode(data.tfe_outputs.secrets.values.RDS_PASSWORD)
    DB_HOST           = base64encode(data.tfe_outputs.secrets.values.RDS_HOST)
    DB_PORT           = base64encode(data.tfe_outputs.secrets.values.RDS_PORT)
  }

  type = "Opaque"
}

resource "kubernetes_secret" "grafana" {
  metadata {
    name      = "grafana-admin"
    namespace = "monitoring"
  }

  data = {
    admin-user     = base64encode(var.grafana-username)
    admin-password = base64encode(var.grafana-password)
  }

  type = "Opaque"
}