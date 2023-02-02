output "iam_role_policy_attachment_id" {
  description = "IAM role policy attachment id"
  value = "${aws_iam_role_policy_attachment.node-AmazonEBSCSIDriverPolicy}"
}
