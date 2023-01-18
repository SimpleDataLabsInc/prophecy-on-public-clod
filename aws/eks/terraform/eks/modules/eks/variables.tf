#
# Variables Configuration
#

variable "customer_name" {
  description = "Customer name or cluster prefix"
  type    = string
}

variable "cluster_name" {
  description = "Cluster name or cluster suffix"
  type    = string
}

variable "cluster_version" {
  description = "Kubernetes version to deploy"
  default = "1.21"
  type    = string
}

variable "region" {
  description = "AWS region to launch servers"
  type    = string
}

variable "instance_class" {
  description = "Machine type to be used"
  type    = string
}

variable "autoscaling_options" {
  description = "Range for autoscaling of worker nodes"
  type        = map(string)
  default     = {
    desired_size = 2
    min_size = 2
    max_size = 4
  }
}
