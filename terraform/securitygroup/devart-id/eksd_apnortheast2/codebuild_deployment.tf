resource "aws_security_group" "codebuild_deployment" {
  name        = "codebuild-deployment-${data.terraform_remote_state.vpc.outputs.vpc_name}"
  description = "codebuild-deployment secrutiy group for ${data.terraform_remote_state.vpc.outputs.vpc_name}"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "any outbound"
  }
}