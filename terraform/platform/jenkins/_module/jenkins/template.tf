data "template_file" "init" {
  template = "${file("${path.module}/scripts/userdata.sh.tpl")}"
  vars = {
    efs_dns_name = aws_efs_file_system.file_system.dns_name
  }
}
