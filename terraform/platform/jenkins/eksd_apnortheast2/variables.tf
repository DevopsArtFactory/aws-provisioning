variable "aws_region" {
  default = "ap-northeast-2"
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default = {
    Project = "jenkins-preprod"
  }
}

