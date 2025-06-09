# envs for testing

resource "kubernetes_secret_v1" "kafka_credentials" {
  metadata {
    name      = "kafka-credentials"
    namespace = kubernetes_namespace.network.metadata[0].name
  }

  data = {
    username = "test-kafka-user"
    password = "test-kafka-password"
  }

  type = "Opaque"
}

resource "kubernetes_secret_v1" "snmp_credentials" {
  metadata {
    name      = "snmp-credentials"
    namespace = kubernetes_namespace.network.metadata[0].name
  }

  data = {
    "auth-password"    = "test-snmp-auth-password"
    "privacy-password" = "test-snmp-privacy-password"
  }

  type = "Opaque"
}

# resource "kubernetes_config_map_v1" "env_config" {
#   metadata {
#     name      = "env-config"
#     namespace = kubernetes_namespace.network.metadata[0].name
#   }

#   data = {
#     ENVIRONMENT      = "test"
#     LOG_LEVEL        = "debug"
#     METRICS_ENDPOINT = "http://prometheus:9090"
#     TRACING_ENDPOINT = "http://tempo:4317"
#     LOGGING_ENDPOINT = "http://loki:3100"
#     CLUSTER_NAME     = var.cluster.name
#     CLUSTER_LOCATION = var.cluster.location
#     PROJECT_ID       = var.project
#   }
# }