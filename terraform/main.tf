module "network" {
  source = "./modules/network"
  
  cluster_name = var.cluster_name
  region       = var.region
}

module "eks_cluster" {
  source = "./modules/eks-cluster"
  
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = module.network.vpc_id
  subnet_ids      = module.network.private_subnet_ids
  node_groups     = var.node_groups
  
  depends_on = [module.network]
}