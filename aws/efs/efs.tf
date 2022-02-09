#
# EFS Resource
#  * EFS used in EKS cluster
#

resource "aws_efs_file_system" "efs" {
   creation_token = "efs-${var.customer-name}-${var.efs-name}"
   performance_mode = "generalPurpose"
   throughput_mode = "bursting"
   encrypted = "true"
   tags = {
     Name = "efs-${var.customer-name}-${var.efs-name}"
   }
 }
