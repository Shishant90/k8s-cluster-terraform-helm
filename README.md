# 🚀 Kubernetes Cluster with Terraform & Helm

[![Terraform](https://img.shields.io/badge/Terraform-1.0+-623CE4?logo=terraform&logoColor=white)](https://terraform.io)
[![Kubernetes](https://img.shields.io/badge/Kubernetes-1.28+-326CE5?logo=kubernetes&logoColor=white)](https://kubernetes.io)
[![Helm](https://img.shields.io/badge/Helm-3.0+-0F1689?logo=helm&logoColor=white)](https://helm.sh)
[![AWS](https://img.shields.io/badge/AWS-EKS-FF9900?logo=amazon-aws&logoColor=white)](https://aws.amazon.com/eks/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

A production-ready Kubernetes cluster setup using **Terraform** for infrastructure provisioning and **Helm** for application deployment. Supports AWS EKS with automated CI/CD, monitoring, and best practices.

## 🏗️ Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                        AWS Cloud                           │
├─────────────────────────────────────────────────────────────┤
│  VPC (10.0.0.0/16)                                        │
│  ├── Public Subnets (2 AZs)    ├── Private Subnets (2 AZs)│
│  │   ├── NAT Gateway            │   ├── EKS Worker Nodes    │
│  │   └── Load Balancers         │   └── Application Pods    │
│  └── Internet Gateway          └── EKS Control Plane       │
└─────────────────────────────────────────────────────────────┘
```

## ✨ Features

- 🏗️ **Infrastructure as Code** - Complete AWS EKS setup with Terraform
- 🔒 **Security First** - Private worker nodes, IAM roles, VPC isolation
- 📊 **Built-in Monitoring** - Prometheus & Grafana stack
- 🚀 **CI/CD Ready** - Jenkins deployment included
- 🌐 **Production Ready** - Load balancers, auto-scaling, multi-AZ
- 📦 **Helm Charts** - Pre-configured application deployments
- 🔄 **GitOps Compatible** - Easy integration with ArgoCD/Flux

## 📁 Project Structure

```
k8s-cluster-terraform-helm/
├── 📄 README.md                  # This file
├── 🚫 .gitignore                 # Git ignore rules
├── 🏗️ terraform/                 # Infrastructure code
│   ├── 📝 main.tf                # Main Terraform config
│   ├── 📋 variables.tf           # Input variables
│   ├── 📤 outputs.tf             # Output values
│   ├── 🔧 provider.tf            # Provider configuration
│   ├── 📌 versions.tf            # Version constraints
│   ├── 💾 backend.tf             # Remote state config
│   └── 📂 modules/               # Reusable modules
│       ├── 🌐 network/           # VPC, subnets, routing
│       └── ☸️ eks-cluster/        # EKS cluster setup
├── ⛵ helm-charts/               # Application charts
│   ├── 🌐 nginx/                 # Web server
│   ├── 📊 monitoring/            # Prometheus/Grafana
│   └── 🔧 jenkins/               # CI/CD pipeline
├── 🔧 scripts/                   # Automation scripts
│   ├── ⚡ setup.sh               # Complete setup
│   ├── 🚀 deploy-helm.sh         # Deploy applications
│   └── 💥 destroy.sh             # Cleanup resources
└── 📚 docs/                      # Documentation
    ├── 🏗️ architecture.md        # System architecture
    └── 📋 workflow.md            # Step-by-step guide
```

## 🚀 Quick Start

### Prerequisites

- ✅ **Terraform** >= 1.0 ([Install](https://terraform.io/downloads))
- ✅ **kubectl** ([Install](https://kubernetes.io/docs/tasks/tools/))
- ✅ **Helm** >= 3.0 ([Install](https://helm.sh/docs/intro/install/))
- ✅ **AWS CLI** configured ([Setup](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html))
- ✅ **Docker** (for local development)

### 🎯 One-Command Setup

```bash
# Clone the repository
git clone https://github.com/Shishant90/k8s-cluster-terraform-helm.git
cd k8s-cluster-terraform-helm

# Run complete setup
./scripts/setup.sh
```

### 📋 Step-by-Step Setup

#### 1️⃣ **Infrastructure Deployment**

```bash
cd terraform

# Initialize Terraform
terraform init

# Review the plan
terraform plan

# Deploy infrastructure
terraform apply
```

#### 2️⃣ **Configure kubectl**

```bash
# Get cluster credentials
aws eks update-kubeconfig --region us-east-1 --name k8s-cluster

# Verify connection
kubectl get nodes
```

#### 3️⃣ **Deploy Applications**

```bash
# Deploy all applications
./scripts/deploy-helm.sh

# Or deploy individually
helm install nginx ./helm-charts/nginx
helm install monitoring prometheus-community/kube-prometheus-stack -f ./helm-charts/monitoring/values.yaml
helm install jenkins jenkins/jenkins -f ./helm-charts/jenkins/values.yaml
```

## 🔧 Configuration

### 🎛️ Terraform Variables

Customize your deployment by editing `terraform/terraform.tfvars`:

```hcl
cluster_name = "my-k8s-cluster"
region       = "us-west-2"
cluster_version = "1.28"

node_groups = {
  main = {
    instance_types = ["t3.large"]
    min_size      = 2
    max_size      = 10
    desired_size  = 3
  }
  spot = {
    instance_types = ["t3.medium", "t3.large"]
    min_size      = 0
    max_size      = 5
    desired_size  = 2
  }
}
```

### ⛵ Helm Customization

Modify application settings in `helm-charts/*/values.yaml` files:

```yaml
# nginx/values.yaml
replicaCount: 3
image:
  repository: nginx
  tag: "1.21"
service:
  type: LoadBalancer
  port: 80
```

## 📊 Monitoring & Observability

### 📈 **Prometheus Metrics**
- Cluster resource utilization
- Application performance metrics
- Custom business metrics

### 📊 **Grafana Dashboards**
- Kubernetes cluster overview
- Node and pod monitoring
- Application-specific dashboards

### 🔍 **Access Monitoring**

```bash
# Get Grafana admin password
kubectl get secret monitoring-grafana -o jsonpath="{.data.admin-password}" | base64 --decode

# Port forward to access locally
kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring
# Access: http://localhost:3000
```

## 🔄 CI/CD with Jenkins

### 🚀 **Jenkins Setup**

```bash
# Get Jenkins admin password
kubectl get secret jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode

# Access Jenkins
kubectl port-forward svc/jenkins 8080:8080 -n jenkins
# Access: http://localhost:8080
```

### 📋 **Pipeline Examples**

- **Build & Deploy**: Automated Docker builds
- **GitOps**: Integration with ArgoCD
- **Testing**: Automated testing pipelines
- **Security**: Container scanning

## 🌐 Networking & Security

### 🔒 **Security Features**
- Private worker nodes (no direct internet access)
- IAM roles for service accounts (IRSA)
- Network policies for pod-to-pod communication
- Encrypted EBS volumes
- VPC Flow Logs

### 🌐 **Load Balancing**
- Application Load Balancer (ALB)
- Network Load Balancer (NLB)
- Ingress controllers
- Service mesh ready

## 🔧 Troubleshooting

### ❗ **Common Issues**

#### IAM Permissions
```bash
# Check current user
aws sts get-caller-identity

# Required policies:
# - AmazonEKSClusterPolicy
# - AmazonEKSWorkerNodePolicy
# - AmazonEKS_CNI_Policy
# - AmazonEC2ContainerRegistryReadOnly
```

#### Cluster Access
```bash
# Update kubeconfig
aws eks update-kubeconfig --region us-east-1 --name k8s-cluster

# Check cluster status
kubectl cluster-info
kubectl get nodes
```

#### Application Issues
```bash
# Check pod status
kubectl get pods --all-namespaces

# View logs
kubectl logs -f deployment/nginx

# Describe resources
kubectl describe pod <pod-name>
```

## 🧹 Cleanup

### 🗑️ **Remove Applications**
```bash
# Remove Helm releases
helm uninstall nginx
helm uninstall monitoring
helm uninstall jenkins
```

### 💥 **Destroy Infrastructure**
```bash
# Complete cleanup
./scripts/destroy.sh

# Or manually
cd terraform
terraform destroy
```

## 🤝 Contributing

1. 🍴 Fork the repository
2. 🌿 Create a feature branch (`git checkout -b feature/amazing-feature`)
3. 💾 Commit changes (`git commit -m 'Add amazing feature'`)
4. 📤 Push to branch (`git push origin feature/amazing-feature`)
5. 🔄 Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest)
- [Kubernetes](https://kubernetes.io/)
- [Helm Charts](https://helm.sh/)
- [Prometheus Community](https://prometheus-community.github.io/helm-charts/)
- [Jenkins Helm Chart](https://github.com/jenkinsci/helm-charts)

## 📞 Support

- 📧 **Email**: [your-email@example.com](mailto:your-email@example.com)
- 🐛 **Issues**: [GitHub Issues](https://github.com/Shishant90/k8s-cluster-terraform-helm/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/Shishant90/k8s-cluster-terraform-helm/discussions)

---

⭐ **Star this repository if it helped you!** ⭐