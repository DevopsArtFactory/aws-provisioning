resource "aws_security_group" "efs" {
  name        = "${var.service_name}-efs-${var.vpc_name}"
  description = "${var.service_name} efs sg for ${var.vpc_name}"
  vpc_id      = var.target_vpc

  ingress {
    from_port = 2049 # for NFS

    to_port  = 2049
    protocol = "tcp"
    security_groups = [
      aws_security_group.jenkins.id,
    ]
  }

  tags = merge(
    {
      Name = "${var.service_name}-efs-${var.vpc_name}"
    },
    var.project_tags
  )
}

resource "aws_efs_file_system" "volume" {
  tags = merge(
    {
      Name = "${var.service_name}-efs-${var.vpc_name}"
    },
    var.project_tags
  )

  provisioned_throughput_in_mibps = var.efs_provisioned_throughput_in_mibps

  throughput_mode = var.efs_throughput_mode

}

resource "aws_efs_mount_target" "mount_target" {
  count          = length(var.private_subnets)
  file_system_id = aws_efs_file_system.volume.id
  subnet_id      = element(var.private_subnets, count.index)
  security_groups = [
    aws_security_group.efs.id,
  ]
}

