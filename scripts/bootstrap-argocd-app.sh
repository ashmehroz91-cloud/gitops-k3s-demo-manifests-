#!/usr/bin/env bash
set -euo pipefail
: "${REPO_URL:?set REPO_URL (git repo URL for manifests)}"
cat <<EOF | kubectl apply -n argocd -f -
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: gitops-demo-app
  namespace: argocd
spec:
  project: default
  source:
    repoURL: "${REPO_URL}"
    targetRevision: HEAD
    path: "charts/app"
  destination:
    server: https://kubernetes.default.svc
    namespace: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
EOF

echo "ArgoCD Application created pointing to ${REPO_URL}"
