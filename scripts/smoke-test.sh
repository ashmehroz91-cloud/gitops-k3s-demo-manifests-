#!/usr/bin/env bash
set -euo pipefail
kubectl run --rm -i --restart=Never curlpod --image=curlimages/curl:latest -- sh -c 'curl -fsS http://backend.default.svc.cluster.local:8080/health | grep -qx "The backend is up"'
