#!/bin/bash

set -e

echo "🚀 Starting Kubernetes cluster setup..."

# Check prerequisites
command -v terraform >/dev/null 2>&1 || { echo "❌ Terraform is required but not installed."; exit 1; }
command -v kubectl >/dev/null 2>&1 || { echo "❌ kubectl is required but not installed."; exit 1; }
command -v helm >/dev/null 2>&1 || { echo "❌ Helm is required but not installed."; exit 1; }
command -v aws >/dev/null 2>&1 || { echo "❌ AWS CLI is required but not installed."; exit 1; }

echo "✅ Prerequisites check passed"

# Deploy infrastructure
echo "🏗️  Deploying infrastructure with Terraform..."
cd terraform
terraform init
terraform plan
terraform apply -auto-approve

# Get cluster credentials
echo "🔑 Configuring kubectl..."
CLUSTER_NAME=$(terraform output -raw cluster_name)
REGION=$(terraform output -raw region || echo "us-west-2")
aws eks update-kubeconfig --region $REGION --name $CLUSTER_NAME

# Wait for cluster to be ready
echo "⏳ Waiting for cluster to be ready..."
kubectl wait --for=condition=Ready nodes --all --timeout=300s

echo "✅ Infrastructure deployment completed!"
echo "🎯 Cluster endpoint: $(terraform output -raw cluster_endpoint)"
echo "📝 Run './deploy-helm.sh' to deploy applications"