resource "kubernetes_namespace" "network" {
  metadata {
    name = "network"
    labels = {
      shared-gateway-access = "true"
    }
  }

  lifecycle {
    ignore_changes = [
      metadata[0].annotations["cattle.io/status"],
      metadata[0].annotations["lifecycle.cattle.io/create.namespace-auth"],
    ]
  }
}