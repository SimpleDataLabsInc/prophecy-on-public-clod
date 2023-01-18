#
# Provider Configuration
#

provider "aws" {
  region  = var.region
}

#
# Module Configuration
#

module "eks_cluster" {
  source = "./modules/eks"

  customer_name   = var.customer_name
  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  instance_class  = var.instance_class
  region          = var.region

  autoscaling_options = {
    desired_size = var.autoscaling_options.desired_size
    min_size = var.autoscaling_options.min_size
    max_size = var.autoscaling_options.max_size
  }
}

module "ebs" {
  source = "./modules/ebs"

  cluster_id = module.eks_cluster.cluster_id
  iam_role_node = module.eks_cluster.iam_role_node
}
