variable "region" {
  default = "ap-northeast-2"
}
variable "common_alias" {
  description = "alias"
  type        = string
}

variable "secure_alias" {
  description = "alias"
  type        = string
}

variable "common_aliow_arns" {
  type = object({
    use    = list(string)
    manage = list(string)
    delete = list(string)
  })
  default = {
    use    = []
    manage = []
    delete = []
  }
}

variable "secure_aliow_arns" {
  type = object({
    use    = list(string)
    manage = list(string)
    delete = list(string)
  })
  default = {
    use    = []
    manage = []
    delete = []
  }
}
