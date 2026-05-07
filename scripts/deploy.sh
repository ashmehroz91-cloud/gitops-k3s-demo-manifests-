#!/usr/bin/env bash
set -euo pipefail
RELEASE="${RELEASE:-gitops-app}"
NAMESPACE="${NAMESPACE:-default}"
CHART_DIR="charts/app"

helm upgrade --install "$RELEASE" "$CHART_DIR" -n "$NAMESPACE" --create-namespace -f "$CHART_DIR/values.yaml"
echo "Helm deploy complete"
