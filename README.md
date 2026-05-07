# gitops-k3s-demo-manifests-

Contains Helm chart (`charts/app`) for the demo app, an ArgoCD `Application` manifest, and deployment/test scripts.

Deploy with Helm (local):

```bash
cd /home/usman/Desktop/gitops-k3s-demo-manifests-
chmod +x scripts/*.sh
./scripts/deploy.sh
```

Or bootstrap ArgoCD to watch this repo:

```bash
export REPO_URL="https://github.com/YOUR_USER/gitops-k3s-demo-manifests"
./scripts/bootstrap-argocd-app.sh
```

Verify networking with the smoke test:

```bash
./scripts/smoke-test.sh
# expected: The backend is up
```
# gitops-k3s-demo-manifests-
Helm chart and/or raw Kubernetes manifests and ArgoCD Application manifests (what ArgoCD watches).
