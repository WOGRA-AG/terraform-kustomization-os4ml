# terraform-kustomization-os4ml

This [Terraform] module installs Open Space for Machine Learning, or short 
[Os4ML] on a [k3d] Kubernetes cluster using [Argo CD]. 

## Step 1: Create k3d cluster

Install k3d, follow the instruction on the k3d site, and create a local 
cluster using the provided configuration.

```bash
k3d cluster create --config ./k3d-default.yaml
```

## Step 2: Install Os4ML using Terraform
Install [Terraform] and clone this repository.  
Go to the 
`examples/kubernetes` folder and execute

```bash
terraform init
terraform apply --auto-approve
```

Now, relax and wait until the Os4ML namespace shows up and frontend service 
is running. In case there are problems, e.g. when argocd-server service is 
said to be not created, try one more time the last command.

The Argo CD server can be accessed at `localhost:8000` after you forward 
the correct port:

```bash
kubectl port-forward -n argocd services/argocd-server 8000:80
```

The username and password is `admin`, as specified in `/manifests/argocd/base/argocd-secret.yaml`

## Step 3: Connect to the Cluster
There are multiple ways to connect to your app, once it runs in your cluster.  
We use [Telepresence], so here is how you do it with this tool.  

First follow the recommended steps on the [Telepresence] Website to install the tool.  
Then run
```bash
telepresence helm install
```
After this, you are ready to connect to your cluster
```bash
telepresence connect
```

Now you can access the application from your browser with the following urls:

os4ml: `http://frontend.os4ml.svc.cluster.local`  
argocd: `http://argocd-server.argocd.svc.cluster.local`  
kubeflow-pipelines `http://ml-pipeline-ui.kubeflow.svc.cluster.local`  

Alternatively, you could just forward the respective ports and access the services directly.


[Os4ML]: https://github.com/WOGRA-AG/Os4ML
[Argo CD]: https://argo-cd.readthedocs.io
[Terraform]: https://www.terraform.io/
[k3d]: https://k3d.io
[Telepresence]: https://www.telepresence.io/