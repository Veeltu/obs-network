variable "project" {
  type = string
}

variable "cluster" {
  type = object({
    name     = string
    location = string
  })

}

variable "docker_repositories" {
  type = object({
    quay_io    = string
    edp_docker = string
    docker_hub = string
    ghcr_io    = string
  })

}


variable "new_secret_suffix" {
  description = "Unique suffix for suffix_secret"
  type        = string
}
variable "secret_suffix" {
  description = "Unique suffix for suffix_secret"
  type        = string
}
