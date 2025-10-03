provider "aws" {
  region = var.region
}

provider "kubernetes" {
  # Configuration will be set via kubeconfig after cluster creation
}

provider "helm" {
  # Configuration will be set via kubeconfig after cluster creation
}