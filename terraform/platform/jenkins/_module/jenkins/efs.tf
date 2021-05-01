# Security Group for EFS
## Should allow Jenkins Instance ONLY!!!
resource "aws_security_group" "efs" {
  name        = "${var.service_name}-efs-${var.vpc_name}"
  description = "${var.service_name} efs sg for ${var.vpc_name}"
  vpc_id      = var.target_vpc

  ingress {
    from_port = 2049 # for NFS

    to_port  = 2049
    protocol = "tcp"
    security_groups = [
      # EC2 Instance Security Group
      aws_security_group.ec2.id,
    ]
  }

  tags = {
    Name = "${var.service_name}-efs-${var.vpc_name}"
  }
}

resource "aws_efs_file_system" "file_system" {
  tags = {
    Name = "${var.service_name}-efs-${var.vpc_name}"
  }

  #You can control this value through variable
  provisioned_throughput_in_mibps = var.efs_provisioned_throughput_in_mibps

  #You can control this mode through variable
  throughput_mode = var.efs_throughput_mode

}

resource "aws_efs_mount_target" "mount_target" {
  # If you do not have NAT gateway  or NAT instance in private subnets,
  # You should deploy jenkins to public subnet!
  #count          = length(var.private_subnets)
  count          = length(var.public_subnets)
  file_system_id = aws_efs_file_system.file_system.id

  #subnet_id      = element(var.private_subnets, count.index)
  subnet_id = element(var.public_subnets, count.index)
  security_groups = [
    aws_security_group.efs.id,
  ]
}

