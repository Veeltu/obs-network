locals {
  # Load Shared/Common Variables that can be used in all terraform configurations. 
  # Can be override via Terragrunt.hcl
  namespace = "network"
  common_vars      = read_terragrunt_config("../common.hcl")
  impersonate_vars = read_terragrunt_config("../impersonate.hcl")
  working_dir_fullpath = get_terragrunt_dir()
  working_dir_parts = split("/", local.working_dir_fullpath)
  secret_suffix = "${element(local.working_dir_parts, length(local.working_dir_parts)-1)}-${element(local.working_dir_parts, length(local.working_dir_parts)-2)}"
  new_secret_suffix = "${local.namespace}-${replace(path_relative_to_include(), "/", "-")}"
  config_path = "~/.kube/config"
  config_context = "microk8s"
  # config_context = "pndrs-observability"
  #config_context = "gke_smanke-dev-test-5mkmp_europe-west3_autopilot-cluster-1"
}

generate "provider" {
  path = "main.provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<-EOF

provider "kubernetes" {
  config_path = "${local.config_path}"
  config_context = "${local.config_context}"
}

provider "helm" {
  kubernetes {
  config_path = "${local.config_path}"
  config_context = "${local.config_context}"
  }  
}

terraform {
  required_version = ">=1.4.6"

  required_providers {
    kubectl = {
      source  = "registry.terraform.io/gavinbunney/kubectl"
      version = "= 1.19.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = "= 2.16.1"
    }
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "= 2.33.0"
    }
    kustomization = {
      source  = "kbst/kustomization"
      version = "= 0.9.6"
    }
    grafana = {
      source = "grafana/grafana"
      version = "= 3.19.0"
    }
  }
}
EOF
}

# output "secret-suffix" {
#   value = local.secret_suffix
# }

# output "new-secret_suffix" {
#   value = "${local.namespace}-${replace(path_relative_to_include(), "/", "-")}"
# }

remote_state {
  backend = "kubernetes"
  config = {
    secret_suffix = local.secret_suffix
    config_path = local.config_path
    config_context = local.config_context
  }
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

# Merge locals from common.hcl & make it usable in terragrunt.hcl file.
# These Variables can be overwritten in the terragrunt.hcl file.
# Important: The Input order has to match the inputs in the terragrunt.hcl file.
# inputs = merge(
#   local.common_vars.locals,
# )


inputs = merge(
  local.common_vars.locals,
  {
    secret_suffix = local.secret_suffix,  # stary suffix, jeśli jest potrzebny
    new_secret_suffix = local.new_secret_suffix
  }
)
