#!/bin/bash

set -euo pipefail

WORKING_DIR="$HOME/eks-project/kubernetes"

cd "$WORKING_DIR"

kubectl delete clusterissuer letsencrypt-https -n certmanager
echo ""
echo "Cluster issuer deleted..."
echo ""

kubectl delete middleware -n monitoring redirectscheme
kubectl delete ingress -n monitoring prometheus-ingress-https
kubectl delete ingress -n monitoring prometheus-ingress-http
kubectl delete ingress -n monitoring grafana-ingress-https
kubectl delete ingress -n monitoring grafana-ingress-http
echo ""
echo "Monitoring deleted..."
echo ""

helm uninstall local-app
echo ""
echo "Application deleted..."
echo ""

helmfile destroy
echo ""
echo "Helmfile destroyed and the setup is deleted..."
