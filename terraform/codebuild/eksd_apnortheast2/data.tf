data "sops_file" "secret_values" {
  source_file = "secrets.sops.yaml"
}