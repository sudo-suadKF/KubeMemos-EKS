#!/bin/bash

set -euo pipefail

WORKING_DIR="$HOME/eks-project/kubernetes"
MONITORING_DIR="$WORKING_DIR/monitoring"
GRAFANA_DIR="$MONITORING_DIR/grafana"
PROMETHEUS_DIR="$MONITORING_DIR/prometheus"

REGION="eu-west-2"
CLUSTER_NAME="my-eks-cluster"

aws eks update-kubeconfig --region "$REGION" --name "$CLUSTER_NAME"

cd "$WORKING_DIR"

helmfile apply
echo ""
echo "Helmfile applied..."
helm upgrade --install local-app ./my-chart
echo ""
echo "Application installed with helm..."
kubectl apply -f cluster-issuer.yaml
echo ""
echo "Cluster issuer applied..."

kubectl apply -f "$GRAFANA_DIR/ingress-http.yaml"
kubectl apply -f "$GRAFANA_DIR/ingress-https.yaml"
kubectl apply -f "$PROMETHEUS_DIR/ingress-http.yaml"
kubectl apply -f "$PROMETHEUS_DIR/ingress-https.yaml"
kubectl apply -f "$MONITORING_DIR/middleware.yaml"
echo ""
echo "Monitoring applied and the setup is done..."
