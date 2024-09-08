locals {
  codebuild_environment_variables = distinct(flatten([
    for entry in var.environment_variables : {
        name = entry.env_name
        value = entry.env_value
    }
  ]))
}