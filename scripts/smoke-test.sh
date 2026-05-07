#!/usr/bin/env bash
set -euo pipefail
kubectl run --rm -i --restart=Never curlpod --image=radial/busyboxplus:curl -- sh -c 'curl -sS http://backend.default.svc.cluster.local:8080/health'
