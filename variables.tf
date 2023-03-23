variable "kubernetes_config_path" {
  description = "Path of Kubernetes configuration file"
  default     = "~/.kube/config"
}

variable "deploy_shepard" {
  description = "Deploy shepard additionally to os4ml"
  type        = bool
  default     = false
}