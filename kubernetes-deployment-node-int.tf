resource "kubernetes_deployment" "node-int-deployment-main" {
  metadata {
    name = "events-internal"
    labels = {
      App = "events-internal"
    }
    namespace = kubernetes_namespace.main.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-internal"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-internal"
        }
      }
      spec {
        container {
          image = "kcgjr/sample-internal:v0.2"
          name  = "events-internal"
          image_pull_policy = "Always"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}

resource "kubernetes_deployment" "node-int-deployment-dev" {
  metadata {
    name = "events-internal"
    labels = {
      App = "events-internal"
    }
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    replicas                  = 1
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-internal"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-internal"
        }
      }
      spec {
        container {
          image = "kcgjr/sample-internal:v0.2"
          name  = "events-internal"
          image_pull_policy = "Always"

          port {
            container_port = 8080
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
