variable "sg_variables" {
  default = {

    ec2 = {
      tags = {
        dayonepapne2 = {
          Name    = "hello-dayonep_apnortheast2-ec2-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "dayonep_apnortheast2"
        }
      }
    }

    external_lb = {
      tags = {
        dayonepapne2 = {
          Name    = "hello-dayonep_apnortheast2-external-lb-sg"
          app     = "hello"
          project = "hello"
          env     = "prod"
          stack   = "dayonep_apnortheast2"
        }
      }
    }
  }
}
