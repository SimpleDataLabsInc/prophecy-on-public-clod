#
# Variables Configuration
#

variable "customer-name" {
  description = "Customer name"
}
variable "efs-name" {
  default = "prophecy-efs"
  type    = string
}
variable "region" {
  description = "aws provider needs it"
}
