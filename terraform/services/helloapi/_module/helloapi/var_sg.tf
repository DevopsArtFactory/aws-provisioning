variable "sg_variables" {
  default = {

    ec2 = {
      tags = {}
    }

    internal_lb = {
      tags = {}
    }

    external_lb = {
      tags = {}
    }

  }
}
