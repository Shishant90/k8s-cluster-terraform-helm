#!/bin/bash

echo "Setting up local Kubernetes cluster..."

# Check if kind is installed
if ! command -v kind &> /dev/null; then
    echo "Installing kind..."
    # For Windows, download kind binary
    curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-windows-amd64
    chmod +x ./kind
    mv ./kind /usr/local/bin/kind
fi

# Create kind cluster
echo "Creating kind cluster..."
kind create cluster --name k8s-cluster

# Set kubectl context
kubectl cluster-info --context kind-k8s-cluster

echo "Local Kubernetes cluster is ready!"
echo "Run: kubectl get nodes"