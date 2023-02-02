#
# Outputs
#

output "cluster_id" {
  description = "Cluster ID"
  value =  module.eks_cluster.cluster_id
}

output "config_map_aws_auth" {
  description = "Configmap for AWS Auth"
  value = module.eks_cluster.config_map_aws_auth
}

output "iam_role_node" {
  description = "IAM role for node"
  value = module.eks_cluster.iam_role_node
}

output "ebs_iam_role_policy_attachment" {
  description = "IAM role policy attachment details"
  value = module.ebs.iam_role_policy_attachment_id
}

output "kubeconfig" {
  description = "Kubeconfig"
  value = module.eks_cluster.kubeconfig
}

output "oidc_provider" {
  description = "OIDC Provider"
  value = module.eks_cluster.oidc_provider
}

output "subnets" {
  description = "List of IDs of subnets with this cluster"
  value       = module.eks_cluster.subnets
}

output "vpc_id" {
  description = "VPC ID"
  value       = module.eks_cluster.vpc_id
}

output "vpc_cidr" {
  description = "VPC CIDR"
  value       = module.eks_cluster.vpc_cidr
}
