locals {
  encrypted_values = data.sops_file.secrets_value.data
}