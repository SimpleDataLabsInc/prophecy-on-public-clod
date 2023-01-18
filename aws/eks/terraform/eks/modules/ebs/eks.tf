resource "aws_eks_addon" "csi_driver" {
  cluster_name = "${var.cluster_id}"
  addon_name   = "aws-ebs-csi-driver"
}

resource "aws_iam_role_policy_attachment" "node-AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = "${var.iam_role_node}"
}
