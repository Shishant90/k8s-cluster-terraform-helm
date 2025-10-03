#!/bin/bash

set -e

echo "📦 Deploying applications with Helm..."

# Add Helm repositories
echo "📚 Adding Helm repositories..."
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add jenkins https://charts.jenkins.io
helm repo update

# Deploy nginx
echo "🌐 Deploying Nginx..."
helm upgrade --install nginx ./helm-charts/nginx --namespace default --create-namespace

# Deploy monitoring stack
echo "📊 Deploying Prometheus/Grafana monitoring stack..."
helm upgrade --install monitoring prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --create-namespace \
  --values ./helm-charts/monitoring/values.yaml

# Deploy Jenkins
echo "🔧 Deploying Jenkins..."
helm upgrade --install jenkins jenkins/jenkins \
  --namespace jenkins \
  --create-namespace \
  --values ./helm-charts/jenkins/values.yaml

echo "✅ All applications deployed successfully!"
echo ""
echo "🔗 Access your services:"
echo "   Nginx: kubectl get svc nginx -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
echo "   Grafana: kubectl get svc monitoring-grafana -n monitoring -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"
echo "   Jenkins: kubectl get svc jenkins -n jenkins -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'"