data "sops_file" "secrets_value" {
  source_file = "secrets.sops.yaml"
}