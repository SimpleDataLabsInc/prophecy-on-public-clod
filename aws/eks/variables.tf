#
# Variables Configuration
#

variable "customer-name" {
  description = "Customer name"
}
variable "cluster-name" {
  default = "prophecy-eks-cluster"
  type    = string
}
variable "region" {
  description = "AWS region to launch servers."
}
variable "instance_class" {
  description = "machine type to be used"
}
