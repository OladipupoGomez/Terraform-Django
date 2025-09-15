resource "kubernetes_namespace" "eks-namespace" {
  for_each = toset(var.namespaces) 

  metadata {
    name = each.value

    annotations = {
      Environment = var.environment
    }

    labels = {
      Environment = var.environment
      Application = var.application
    }
  }
}