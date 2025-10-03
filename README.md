# Kubernetes Cluster with Terraform and Helm

This project provisions a managed Kubernetes cluster using Terraform and deploys applications using Helm charts.

## Architecture

- **Infrastructure**: Terraform manages cloud resources (EKS/AKS/GKE)
- **Applications**: Helm charts for application deployment
- **Monitoring**: Prometheus/Grafana stack
- **CI/CD**: Jenkins deployment

## Quick Start

1. **Setup Infrastructure**:
   ```bash
   cd terraform
   terraform init
   terraform plan
   terraform apply
   ```

2. **Deploy Applications**:
   ```bash
   ./scripts/deploy-helm.sh
   ```

3. **Access Services**:
   - Get kubeconfig from Terraform outputs
   - Access applications via LoadBalancer/Ingress

## Directory Structure

- `terraform/` - Infrastructure as Code
- `helm-charts/` - Application deployments
- `scripts/` - Automation scripts
- `docs/` - Documentation

## Prerequisites

- Terraform >= 1.0
- kubectl
- Helm >= 3.0
- Cloud provider CLI (aws/gcloud/az)

## Cleanup

```bash
./scripts/destroy.sh
```