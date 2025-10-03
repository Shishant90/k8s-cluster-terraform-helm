# Workflow Guide

## Step-by-Step Deployment

### 1. Prerequisites
- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- kubectl
- Helm >= 3.0

### 2. Infrastructure Setup
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 3. Configure kubectl
```bash
aws eks update-kubeconfig --region us-west-2 --name k8s-cluster
```

### 4. Deploy Applications
```bash
./scripts/deploy-helm.sh
```

### 5. Access Services
- **Nginx**: `kubectl get svc nginx`
- **Grafana**: `kubectl get svc monitoring-grafana -n monitoring`
- **Jenkins**: `kubectl get svc jenkins -n jenkins`

## Customization

### Terraform Variables
Edit `terraform/terraform.tfvars`:
```hcl
cluster_name = "my-cluster"
region = "us-east-1"
node_groups = {
  main = {
    instance_types = ["t3.large"]
    min_size = 2
    max_size = 5
    desired_size = 3
  }
}
```

### Helm Values
Customize application deployments by editing values files in `helm-charts/*/values.yaml`

## Troubleshooting

### Common Issues
1. **IAM Permissions**: Ensure AWS credentials have EKS, EC2, and VPC permissions
2. **Node Group Scaling**: Check EC2 service limits
3. **LoadBalancer**: Verify AWS Load Balancer Controller is installed

### Useful Commands
```bash
# Check cluster status
kubectl get nodes

# View pod logs
kubectl logs -f deployment/nginx

# Port forward for local access
kubectl port-forward svc/grafana 3000:80 -n monitoring
```