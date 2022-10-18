# terraform-kustomization-os4ml

This [Terraform] module installs Open Space for Machine Learning, or short 
[Os4ML] on a [k3d] Kubernetes cluster using [Argo CD]. 

## Step 1: Create k3d cluster

Install k3d, follow the instruction on the k3d site, and create a local 
cluster.

```bash
$ k3d cluster create os4ml-cluster --k3s-node-label 'cloud.google.
com/gke-nodepool=highcpu-pool@server:0'
```

## Step 2: Install Os4ML using Terraform
Install [Terraform] and clone this repository. Got to the 
`examples/kubernetes` folder and execute

```bash
$ terraform init
$ terraform apply --auto-approve
```

Now, relax and wait until the Os4ML namespace shows up and frontend service 
is running. In case there are problems, e.g. when argocd-server service is 
said to be not created, try one more time the last command.

The Argo CD server can be accessed at `localhost:8000/argocd` using this 
comand:

```bash
$ kubectl -n argocd port-forward svc/argocd-server 8000:80
```

The username is `admin` and the password is given by
```bash
$ kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.
data.password}" | base64 -d
```
Remind to cut off the percentage symbol at the end.

## Step 2: Connect to the Cluster
When you want to access the frontend, install [Telepresence], connect to 
the cluster

```bash
$ telepresence connect
```

login at `http://istio-ingressgateway.istio-system.svc.cluster.local` with 
user `user@example.com` and password `12341234` and access the frontend at 
`http://istio-ingressgateway.istio-system.svc.cluster.local/os4ml`.


[Os4ML]: https://github.com/WOGRA-AG/Os4ML
[Argo CD]: https://argo-cd.readthedocs.io
[Terraform]: https://www.terraform.io/
[k3d]: https://k3d.io
[Telepresence]: https://www.telepresence.io/