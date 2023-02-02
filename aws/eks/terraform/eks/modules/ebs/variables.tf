#
# Variables Configuration
#

variable "cluster_id" {
  description = "EKS Cluster ID"
  type    = string
}

variable "iam_role_node" {
  description = "IAM Role for Node"
  type    = string
}
