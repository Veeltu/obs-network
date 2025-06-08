resource "kubernetes_deployment_v1" "test_mock" {
  metadata {
    name      = "test_mock"
    namespace = kubernetes_namespace.network.metadata.0.name
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "test_mock"
      }
    }
    template {
      metadata {
        labels = {
          app = "test_mock"
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
    name      = "test_mock"
    namespace = kubernetes_namespace.network.metadata.0.name
  }
  spec {
    selector = {
      app = "test_mock"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}
