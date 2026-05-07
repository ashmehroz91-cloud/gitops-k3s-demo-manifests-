# gitops-k3s-demo-manifests-

This repo contains the Helm chart, ArgoCD Application manifest, and deployment scripts for the demo app.

## What this repo is for

The client clones this repo to deploy the app onto the k3s cluster created by the infra repo.

## Tools to install

Required:
- Git
- kubectl
- Helm 3

Optional:
- ArgoCD CLI

## Deploy with Helm

```bash
cd /path/to/gitops-k3s-demo-manifests-
chmod +x scripts/*.sh
export KUBECONFIG="/path/to/gitops-k3s-demo-infra/infra/kubeconfig.yaml"
./scripts/deploy.sh
```

## Bootstrap ArgoCD to watch this repo

```bash
cd /path/to/gitops-k3s-demo-manifests-
export KUBECONFIG="/path/to/gitops-k3s-demo-infra/infra/kubeconfig.yaml"
export REPO_URL="https://github.com/YOUR_USER/gitops-k3s-demo-manifests-"
./scripts/bootstrap-argocd-app.sh
```

## Smoke test

```bash
cd /path/to/gitops-k3s-demo-manifests-
export KUBECONFIG="/path/to/gitops-k3s-demo-infra/infra/kubeconfig.yaml"
./scripts/smoke-test.sh
```

Expected output:
- `The backend is up`

## Notes

- The Helm chart uses the images defined in `charts/app/values.yaml`.
- If the client loads images locally into k3s, make sure the image tags in the values file match.
