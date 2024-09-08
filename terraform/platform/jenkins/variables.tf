variable "aws_region" {
  default = "ap-northeast-2"
}

variable "tag_env" {
  description = ""
}

variable "tag_first_owner" {
  description = ""
}

variable "tag_second_owner" {
  description = ""
}

variable "tag_project" {
  description = ""
}

variable "project" {
  default = "sandbox"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default = {
    Project = "network"
  }
}

