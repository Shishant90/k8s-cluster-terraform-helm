# Architecture Overview

## Infrastructure Components

### Network Layer
- **VPC**: 10.0.0.0/16 CIDR block
- **Public Subnets**: 2 subnets across AZs for LoadBalancers
- **Private Subnets**: 2 subnets across AZs for worker nodes
- **NAT Gateways**: High availability with 2 NAT gateways
- **Internet Gateway**: Public internet access

### Kubernetes Cluster
- **EKS Control Plane**: Managed by AWS
- **Worker Nodes**: Auto Scaling Groups in private subnets
- **Node Groups**: Configurable instance types and scaling
- **Security Groups**: Least privilege access

### Applications
- **Nginx**: Web server with LoadBalancer service
- **Prometheus**: Metrics collection and alerting
- **Grafana**: Monitoring dashboards
- **Jenkins**: CI/CD pipeline automation

## Security Features
- Private worker nodes (no direct internet access)
- IAM roles for service accounts (IRSA)
- Network policies for pod-to-pod communication
- Encrypted EBS volumes
- VPC Flow Logs for network monitoring

## High Availability
- Multi-AZ deployment
- Auto Scaling Groups for worker nodes
- Load balancing across availability zones
- Persistent volumes for stateful applications

## Monitoring & Observability
- Prometheus for metrics collection
- Grafana for visualization
- CloudWatch integration
- Application and infrastructure logs