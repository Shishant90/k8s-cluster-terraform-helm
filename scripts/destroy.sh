#!/bin/bash

set -e

echo "🗑️  Starting cleanup process..."

# Remove Helm releases
echo "📦 Removing Helm releases..."
helm uninstall nginx --namespace default || true
helm uninstall monitoring --namespace monitoring || true
helm uninstall jenkins --namespace jenkins || true

# Wait for LoadBalancers to be deleted
echo "⏳ Waiting for LoadBalancers to be cleaned up..."
sleep 30

# Destroy Terraform infrastructure
echo "🏗️  Destroying Terraform infrastructure..."
cd terraform
terraform destroy -auto-approve

echo "✅ Cleanup completed!"