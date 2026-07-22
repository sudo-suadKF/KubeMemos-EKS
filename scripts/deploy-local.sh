#!/bin/bash

set -euo pipefail

WORKING_DIR="$HOME/eks-project/kubernetes"
MONITORING_DIR="$WORKING_DIR/monitoring"
GRAFANA_DIR="$MONITORING_DIR/grafana"
PROMETHEUS_DIR="$MONITORING_DIR/prometheus"

REGION="eu-west-2"
CLUSTER_NAME="my-eks-cluster"

aws eks update-kubeconfig --region "$REGION" --name "$CLUSTER_NAME"
echo ""

cd "$WORKING_DIR"

helmfile apply
echo ""
echo "Helmfile applied..."
echo ""
helm upgrade --install local-app ./my-chart
echo ""
echo "Application installed with helm..."
echo ""

kubectl apply -f "$GRAFANA_DIR/ingress-http.yaml"
kubectl apply -f "$GRAFANA_DIR/ingress-https.yaml"
kubectl apply -f "$PROMETHEUS_DIR/ingress-http.yaml"
kubectl apply -f "$PROMETHEUS_DIR/ingress-https.yaml"
kubectl apply -f "$MONITORING_DIR/middleware.yaml"
echo ""
echo "Monitoring applied..."
echo ""

kubectl apply -f cluster-issuer.yaml
echo ""
echo "Cluster issuer applied and waiting for TLS certificates to become ready..."
echo ""

kubectl wait --for=condition=ready certificate --all --all-namespaces
echo ""
echo "TLS certificates are ready and the setup is done..."
