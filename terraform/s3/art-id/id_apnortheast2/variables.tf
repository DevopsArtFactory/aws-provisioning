variable "assume_role_arn" {
  description = "The role to assume when accessing the AWS API."
  default     = ""
}

variable "account_namespace" {
  description = "The common namespace for s3 buckets, account-level (e.g. 'dayone' or 'dayone-prod')"
}

variable "region_namespace" {
  description = "region space for s3 location"
}

variable "shard_id" {
  description = "Shard ID for distinguish the service"
}

# Atlantis
variable "atlantis_user" {
  description = "The username that will be triggering atlantis commands. This will be used to name the session when assuming a role. More information - https://github.com/runatlantis/atlantis#assume-role-session-names"
  default     = "atlantis_user"
}

variable "public_dayone_cdn_domain_name" {
  description = "dayone cdn domain."
}
