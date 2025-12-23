resource "kubernetes_deployment_v1" "app" {
  metadata {
    name      = "s3-app"
    namespace = kubernetes_namespace_v1.this.metadata[0].name
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "s3-app"
      }
    }

    template {
      metadata {
        labels = {
          app = "s3-app"
        }
      }

      spec {
        service_account_name = kubernetes_service_account_v1.this.metadata[0].name

        container {
          name  = "app"
          image = var.image
        }
      }
    }
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations,
      metadata[0].labels
    ]
  }
}
