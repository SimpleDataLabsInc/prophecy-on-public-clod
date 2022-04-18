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
  description = "aws provider needs it"
}
