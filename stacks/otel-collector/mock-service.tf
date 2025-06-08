resource "kubernetes_deployment_v1" "test_mock" {
  metadata {
    name      = "test-mock"
    namespace = kubernetes_namespace.network.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "test-mock"
      }
    }
    template {
      metadata {
        labels = {
          app = "test-mock"
        }
      }
      spec {
        container {
          name  = "nginx"
          image = "nginx"
          port {
            container_port = 80
          }
        }
      }
    }
  }
}

resource "kubernetes_service_v1" "test_mock" {
  metadata {
    name      = "test-mock"
    namespace = kubernetes_namespace.network.metadata.0.name
  }
  spec {
    selector = {
      app = "test-mock"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
