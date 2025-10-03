terraform {
  backend "s3" {
    bucket         = "terraform-state-k8s-12345"
    key            = "k8s-cluster/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}