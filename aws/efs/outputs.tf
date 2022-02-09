#
# Outputs
#

output "efs-filesystem-id" {
  description = "Address of the mount target provisioned."
  value       = "${aws_efs_file_system.efs.id}"
}
