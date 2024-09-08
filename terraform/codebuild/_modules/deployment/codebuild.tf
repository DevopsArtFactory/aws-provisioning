resource "aws_codebuild_project" "deployment" {
  name          = "${var.service_name}-${var.shard_id}"
  description   = "To deploy service"
  build_timeout = var.build_timeout
  service_role  = var.service_role

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = var.compute_type
    image                       = var.build_image
    privileged_mode             = var.privileged_mode
    type                        = var.os_type
    image_pull_credentials_type = var.image_credentials_type

    dynamic "environment_variable" {
      for_each = local.codebuild_environment_variables
      content {
        name = environment_variable.value.name
        value = environment_variable.value.value
      }
    }
  }

  source {
    type            = "GITHUB"
    location        = var.github_repo
    git_clone_depth = 1
    buildspec       = var.buildspec
  }

  vpc_config {
    vpc_id = var.target_vpc

    subnets = var.private_subnets

    security_group_ids = [
      var.deployment_default_sg,
    ]
  }
  cache {
    type = var.cache_type
  }

  tags = {
    "Name"       = var.service_name
    "billing"    = var.billing_tag
    "env"        = var.billing_tag
    "stack_name" = var.vpc_name
  }
}