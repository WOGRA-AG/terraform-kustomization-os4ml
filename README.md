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

## Step 3: Connect to the Cluster
There are multiple ways to connect to your app, once it runs in your cluster.  
The two mentioned here are the methods we mainly use. So feel free to connect to your services however you feel comfortable.  

### Step 3.1 Port-Forward

#### Argocd
You can track the progress of your deployment easily in a sophisticated way, using the ArgoCD Frontend.
This can be made available on any free port on your local device, in this example it's 8000, using the following command.
```bash
kubectl port-forward -n argocd services/argocd-server 8000:80
```
Then access it at [http://localhost:8000](http://localhost:8000).  

The initial username and password is `admin`, as specified in `/manifests/argocd/base/argocd-secret.yaml`  

#### Kubeflow-pipelines
When the Kubeflow-pipeline servers are up and running, forward the required port to an available port on your local device.
```bash
kubectl port-forward -n kubeflow services/kserve-models-web-app 8001:80
```
Then access it at the forwarded port [http://localhost:8001](http://localhost:8001).

#### Os4ML
Lastly, if the application is readily deployed, you can access the Os4ML frontend in a similar way. Here is the command to forward the frontend on your local port 8002 as an example.
```bash
kubectl port-forward -n os4ml svc/frontend 8002:80
```
Then access it at [http://localhost:8002](http://localhost:8002)

### Step 3.2 Telepresence
Alternatively to forwarding each port manually, we use [Telepresence]. So here is how you do it with this tool.  

First follow the recommended steps on the [Telepresence] Website to install it locally.  
Then run:
```bash
telepresence helm install
```
After this, you are ready to connect to your cluster
```bash
telepresence connect
```

Now you can access the application from your browser using the cluster-internal dns names:

os4ml: [http://frontend.os4ml.svc.cluster.local](http://frontend.os4ml.svc.cluster.local)  

argocd: [http://argocd-server.argocd.svc.cluster.local](http://argocd-server.argocd.svc.cluster.local)  

kubeflow-pipelines [http://ml-pipeline-ui.kubeflow.svc.cluster.local](http://ml-pipeline-ui.kubeflow.svc.cluster.local)

## Step 4: Start using Os4ML
For more information and examples on how to use the plattform please refer to the [Documentation](https://wogra-ag.github.io/os4ml-docs/).

[Os4ML]: https://github.com/WOGRA-AG/Os4ML
[Argo CD]: https://argo-cd.readthedocs.io
[Terraform]: https://www.terraform.io/
[k3d]: https://k3d.io
[Telepresence]: https://www.telepresence.io/