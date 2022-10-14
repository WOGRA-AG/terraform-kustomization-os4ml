# terraform-kustomization-os4ml

This Terraform module installs Os4ML on a k3d Kubernetes cluster using argocd.

`k3d cluster create os4ml-cluster --k3s-node-label 'cloud.google.com/gke-nodepool=highcpu-pool@server:0'`

`cd ./examples/kubernetes`

`terraform init`

`terraform apply --auto-approve`

