# gitops-k3s-demo-manifests-

This repo contains the Helm chart, ArgoCD Application manifest, and deployment scripts for the demo app.

## Readme order

This is step 3 of 3.

1. `gitops-k3s-demo-infra`: create k3s cluster and ArgoCD
2. `gitops-k3s-demo-app`: build/push/import app images
3. `gitops-k3s-demo-manifests-` (this repo): deploy app with Helm/ArgoCD

## What this repo is for

The client clones this repo to deploy the app onto the k3s cluster created by the infra repo.

## Supported environments

- Linux: supported directly
- Windows: use a Linux VM for the deploy commands
- macOS: use a Linux VM for the deploy commands

The deployment commands are Bash-based and require access to the kubeconfig created by the infra repo. The kubeconfig should live inside the Linux VM workflow.



Use the Linux VM for `kubectl`, `helm`, and `KUBECONFIG`-based deploy commands.


## What must exist before deploying

Before you deploy this repo, make sure one of these is true:

- the app images exist in DockerHub with the same tags used in `charts/app/values.yaml`
- or the images have already been loaded into the local k3s container runtime

The default values file points at:

- `ashmehroz1/gitops-demo-backend:latest`
- `ashmehroz1/gitops-demo-frontend:latest`

Hint: keep DockerHub username as `ashmehroz1` in image tags unless you also update `charts/app/values.yaml`.

## Deploy with Helm

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
chmod +x scripts/*.sh
export KUBECONFIG="../gitops-k3s-demo-infra/infra/kubeconfig.yaml"
./scripts/deploy.sh
```

## Bootstrap ArgoCD to watch this repo

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
export KUBECONFIG="../gitops-k3s-demo-infra/infra/kubeconfig.yaml"
export REPO_URL="https://github.com/ashmehroz91-cloud/gitops-k3s-demo-manifests-"
./scripts/bootstrap-argocd-app.sh
```


Expected output:
- `The backend is up`

## Access the frontend

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
export KUBECONFIG="../gitops-k3s-demo-infra/infra/kubeconfig.yaml"
kubectl port-forward svc/frontend 8080:8080 -n default
```

Open:

- `http://localhost:8080`

## Access ArgoCD



```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
export KUBECONFIG="../gitops-k3s-demo-infra/infra/kubeconfig.yaml"

## Below command is to get password for argocd dashboard 
kubectl --kubeconfig="$KUBECONFIG" -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo 
```
Username: `admin`


```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
export KUBECONFIG="../gitops-k3s-demo-infra/infra/kubeconfig.yaml"
kubectl port-forward svc/argocd-server -n argocd 8081:443

Open:

- `https://localhost:8081`

Note: You must have to add your repo link into argocd application that you want to monitor through argocd 



Stop and Destroy steps of application

## Stop the app

If the app was deployed with Helm:

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
helm uninstall gitops-app -n default
```

If the app was managed by ArgoCD:

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
kubectl delete application gitops-demo-app -n argocd
```

Stop any port-forwards with `Ctrl+C` or:

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
pkill -f "kubectl port-forward" || true
```

If you see `couldn't get current server API group list`, check kubeconfig and cluster reachability first:

```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-manifests-
export KUBECONFIG="../gitops-k3s-demo-infra/infra/kubeconfig.yaml"
kubectl --kubeconfig="$KUBECONFIG" cluster-info
kubectl --kubeconfig="$KUBECONFIG" get ns
kubectl --kubeconfig="$KUBECONFIG" -n argocd get pods
```

## Notes

- The Helm chart uses the images defined in `charts/app/values.yaml`.
- If the client loads images locally into k3s, make sure the image tags in the values file match.
- If you are not on Linux, use WSL2 or a Linux VM for the deploy and smoke-test scripts.


## Destroy
##
```bash
## You have run these commands in your root directory :--> gitops-k3s-demo-infra
./scripts/down.sh
```