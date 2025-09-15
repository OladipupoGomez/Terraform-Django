resource "kubernetes_config_map" "django-config" {
  metadata {
    name = "django-config"
    namespace = "deployments"
    labels = {
      app = "django-app"
    }
  }

  data = {
    ALLOWED_HOSTS = "a54aa921316a546d293ba2c4b31fc417-1479647575.us-east-1.elb.amazonaws.com"
    DEBUG         = "False"
  }
}