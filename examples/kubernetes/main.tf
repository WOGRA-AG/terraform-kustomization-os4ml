terraform {
  backend "kubernetes" {
    secret_suffix = "state"
    config_path   = "~/.kube/config"
  }
}

module "os4ml" {
  source = "WOGRA-AG/os4ml/kustomization"
}
