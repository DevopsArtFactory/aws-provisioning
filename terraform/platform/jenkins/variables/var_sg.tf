variable "sg_variables" {
  default = {

    ec2 = {
      tags = {
        dayonepapne2 = {
          Name    = "jenkins-dayonep_apnortheast2-ec2-sg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "dayonep_apnortheast2"
        }
      }
    }

    external_lb = {
      tags = {
        dayonepapne2 = {
          Name    = "jenkins-dayonep_apnortheast2-external-lb-sg"
          app     = "jenkins"
          project = "jenkins"
          env     = "prod"
          stack   = "dayonep_apnortheast2"
        }
      }
    }
  }
}
