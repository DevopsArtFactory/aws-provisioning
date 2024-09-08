module "codebuild_github_token" {
  source       = "../_modules//source_credential"
  github_token = local.encrypted_values.github_token
}