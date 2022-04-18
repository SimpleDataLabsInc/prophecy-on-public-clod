#
# EFS Mount target
#  * EFS Mount target used in EKS cluster
#


# Allow both ingress and egress for port 2049 (NFS)
# such that our instances are able to get to the mount
# target in the AZ.
#
# Additionaly, we set the `cidr_blocks` that are allowed
# such that we restrict the traffic to machines that are
# within the VPC (and not outside).

resource "aws_security_group" "efs-sg" {
  name        = "efs-sg-${var.customer-name}-${var.cluster-name}"
  description = "Allows NFS traffic from instances within the VPC."
  vpc_id      = data.terraform_remote_state.eks.outputs.eks-vpc-id
  ingress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    cidr_blocks = [
      "${data.terraform_remote_state.eks.outputs.eks-vpc-cidr}",
    ]
  }

  egress {
    from_port = 2049
    to_port   = 2049
    protocol  = "tcp"

    cidr_blocks = [
      "${data.terraform_remote_state.eks.outputs.eks-vpc-cidr}",
    ]
  }

  tags = {
    Name = "efs-sg-${var.customer-name}-${var.cluster-name}"
  }
}

# Creates a mount target of EFS in a specified subnet
# such that our eks instances can connect to it, and the containers
# running on it, ofcourse.
#
# Here we iterate over `subnets-count` which indicates
# the length of the `var.subnets` list.
#
# This way we're able to create a mount target for each
# of the subnets, making it available to instances in all
# of the desired subnets.

resource "aws_efs_mount_target" "efs-mount" {
  count = length("${data.terraform_remote_state.eks.outputs.eks-subnets}")

  file_system_id = data.terraform_remote_state.efs.outputs.efs-filesystem-id
  subnet_id      = element(data.terraform_remote_state.eks.outputs.eks-subnets, count.index)

  security_groups = [
    "${aws_security_group.efs-sg.id}",
  ]
}
