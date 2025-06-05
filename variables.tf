variable "project" {
  type    = string
  default = "my-default-project"
}

variable "cluster" {
  type = object({
    name     = string
    location = string
  })
  default = {
    name     = "my-default-cluster"
    location = "europe-west1"
  }
}

variable "docker_repositories" {
  type = object({
    quay_io    = string
    edp_docker = string
    docker_hub = string
    ghcr_io    = string
  })
  default = {
    quay_io    = "quay.io/myorg"
    edp_docker = "edp-docker.mycompany.com"
    docker_hub = "docker.io/myuser"
    ghcr_io    = "ghcr.io/myorg"
  }
}
